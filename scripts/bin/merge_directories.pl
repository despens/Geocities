#!/usr/bin/perl

=head1 NAME

merge_directories - recursively move the contents of source directory into
target directory. Source files are deleted.

=head1 USAGE

B<merge_directories> source_directory target_directory

=head1 DESCRIPTION

The all files from B<source_directory> are moved to B<target_directory>.

If a file does not exist in target_directory, it is moved there.

If target_directory contains the exactly same file (same las modified
date and same contents), the source file is deleted.

If target_directory contains the same file name, but last modified date or
contents do not match the one in source_directory, nothing happens.

The result is target_directory containing all non-conflicting files and
source_directory containing conflicting files.

=over 4

=item B<source_directory> (required)

A directory tree that contains any number of nested directories, but must 
be free of symlinks.

=item B<target_directory> (required)

The directory where the contents of B<source_directory> should be moved to.

=back

=cut


our $VERSION = 1.00;

use 5.12.0;
use warnings;
use diagnostics;
use strict;
use File::Find;
use File::stat;
use File::Path qw(make_path);
use Cwd qw(abs_path);

$| = 1; # turn on autoflush

# checking soundness of arguments
display_help() if ($#ARGV < 1 || $#ARGV > 2);

my $source_directory = $ARGV[0];
my $target_directory = $ARGV[1];
my $callback_command = $ARGV[2] || '';

check_arguments();

$source_directory = abs_path($source_directory);
$target_directory = abs_path($target_directory);

find({wanted => \&compare, bydepth => 1}, $source_directory);

sub display_help {
    # display help from the intergrated documentation!
    system('perldoc', '-F', $0);
    exit 1;
}

sub check_arguments {

    # remove trailing slashes
    map { chop if (substr($_, -1) eq '/') } ($source_directory, $target_directory);

    # Both source and target directories need to be read/writeable.
    # Same for the conflict directory, if defined.
    my $error = '';

    $error .= "$source_directory does not exist.\n" 
        unless (-d $source_directory);
    $error .= "$source_directory is not read/writeable.\n" 
        unless(-r $source_directory && -w $source_directory);
    
    $error .= "$target_directory does not exist.\n" 
        unless (-d $target_directory);
    $error .= "$target_directory is not read/writeable.\n" 
        unless(-r $target_directory && -w $source_directory);

    # Exit if error in arguments encountered.
    if($error) {
        say $error;
        exit 2;
    }
}

sub dir_is_empty {
    # checking if a directory is empty by looking at its entries
    my ($path) = @_;
    opendir DIR, $path;
    while(my $entry = readdir DIR) {
        next if($entry =~ /^\.\.?$/);
        closedir DIR;
        return 0;
    }
    closedir DIR;
    return 1;
}

sub compare {
    # Called for each node encounterd.

    # Dealing with a directory?
    if( -d $File::Find::name) {
        # If the directory is empty, it can savely be deleted
        if ( dir_is_empty( $File::Find::name ) ) {
            system(('rmdir', '-v', $File::Find::name));
        }
        return; # Not interested in directories otherwise
    }

    # Already reached the highest level, end!
    return if ($source_directory eq $File::Find::name);

    my ($relative_path) = $File::Find::name =~ m|$source_directory/(.+)$|;

    my $target_path = "$target_directory/$relative_path";

    # file exists in both places
    if( -e $target_path ) {
        # check last-modified date of both files
        my $timestamp_source = stat($File::Find::name)->mtime;
        my $timestamp_target = stat($target_path)->mtime;
        
        # both files have thesame timestamp
        if($timestamp_target == $timestamp_source) {

            my ($checksum_source) = `sha512sum -b $File::Find::name` =~ m|^(\S+)|;
            my ($checksum_target) = `sha512sum -b $target_path`      =~ m|^(\S+)|;
            
            # timestamp and checksum match: save to remove!
            if ($checksum_target eq $checksum_source) {
                system(('rm', '-v', $File::Find::name));
            }
        }

    # File does not exist in destination and needs to be moved there
    } else {
        say $relative_path;

        # Generate destination directory name
        my $destination_dir = '';
        if($relative_path =~ /\//) {
            ($destination_dir) = $relative_path =~ m|^(.+)/.+$|;
        }
        
        $destination_dir = "$target_directory/$destination_dir";

        # If destination name does not exist, create a directory entry
        unless( -e $destination_dir) {
            make_path($destination_dir, {verbose => 1, error => \my $error});
            if(@$error) {
                # If the beginning of the destination path exists, but
                # for example the leaf is not a directory but a file,
                # no more subdirectories can be created and make_path
                # will fail. This is the case when the directory
                # structure on source and destination is too different
                # to be merged.
                my ($file, $message) = %{$error->[0]};
                say 'Error creating directory: $file -- $message';
            }
        }

        # Check again if the destination directory exists, only then
        # move the file there.
        if( -d $destination_dir) {
            system(('mv', '-v', $File::Find::name, $target_path));
            if ($? == -1) {
                say "mv failed to execute: $!";
            }
            else {
                my $exit_code = $? >> 8;
                if ($exit_code != 0) {
                    # mv did not finish operation
                    say "mv error $exit_code";
                } elsif ($callback_command) {
                    # Execute optional callback command
                    system(($callback_command, "$target_path"))
                }
            }
        } 
    }
}