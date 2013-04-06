#!/usr/bin/perl

our $VERSION = 1.00;

=pod

This script compares checksums of local files belonging to the Archive Team's
Geocities Torrent with checksums published on archive.org. It can generate
shell scripts that complete an aborted torrent download by getting 
missing/broken parts from archive.org

Takes one argument: name of the XML file to process.

First you need to get eight file lists in XML format from archive.org:

http://www.archive.org/download/2009-archiveteam-geocities-part1/2009-archiveteam-geocities-part1_files.xml
http://www.archive.org/download/2009-archiveteam-geocities-part2/2009-archiveteam-geocities-part2_files.xml
http://www.archive.org/download/2009-archiveteam-geocities-part3/2009-archiveteam-geocities-part3_files.xml
http://www.archive.org/download/2009-archiveteam-geocities-part4/2009-archiveteam-geocities-part4_files.xml
http://www.archive.org/download/2009-archiveteam-geocities-part5/2009-archiveteam-geocities-part5_files.xml
http://www.archive.org/download/2009-archiveteam-geocities-part6/2009-archiveteam-geocities-part6_files.xml
http://www.archive.org/download/2009-archiveteam-geocities-part7/2009-archiveteam-geocities-part7_files.xml
http://www.archive.org/download/2009-archiveteam-geocities-part8/2009-archiveteam-geocities-part8_files.xml

Put them into a directory named

    geocities.archiveteam.torrent

This is the directory that will hold all the files, so it should
rest on a drive with ~700 GB free space. If you started downloading 
the original Geocities Torrent or the Patched Torrent, put these 
XML files into the existing directory.

cd into the directory and run geo-torrent-checksums.pl (this script).
Since the script's output can be executed as a shell script, forward 
it into a file:

    path/to/geo-torrent-checksums.pl 2009-archiveteam-geocities-part1_files.xml > download.sh

Examine the contents of download.sh. Files with good checksums are
mentioned in comments, others are showing up as wget commands.
If you like what you see, run the generated script:

    bash download.sh

Repeat with all XML files, enjoy Geocities!

=cut

$| = 1; # turn on autoflush, bitches love autoflush!

use 5.10.0;
use warnings;
use strict;
use XML::TreePP; # The package name in Debian/Ubuntu for this library is
                 # libxml-treepp-perl
                 # Or get it from CPAN:
                 # http://search.cpan.org/~kawasaki/XML-TreePP-0.41/lib/XML/TreePP.pm

my %created_directories; # To avoid creating the same directory multiple times,
                         # save created ones here.

my $XML_file = shift (@ARGV);

my $tpp = XML::TreePP->new();
my $tree = $tpp->parsefile( $XML_file );


for my $file (@{$tree->{'files'}{'file'}}) {
    my $filename_xml = $file->{'-name'};

    next if ($filename_xml eq $XML_file); # Prevent the file containing the
                                          # checksums from being checksum-checked.
                                          # Apparently, the published checksums
                                          # do not match for these files. (???)

    my $checksum  = $file->{'md5'};

    my ($target_directory) = $filename_xml =~ m|^(\w+)/|;
    my ($target_filename)  = $filename_xml =~ m|([^/]+)$|;

    # if no target directory is present
    unless($target_directory) {
        # check if filename hints towards a 7z archive
        if ($target_filename =~ /^geocities/) {
            # The orginal torrent was separated into different directories.
            # On archive.org directory information was sometimes omitted.
            # Diretories are restored according to the archive's file name.
            my ($order_char) = $target_filename =~ m|^geocities\-(\w)|;
            if( lc($order_char) eq $order_char) {
                $target_directory = 'LOWERCASE';
            } elsif ($order_char =~ /1\d$/) {
                $target_directory = 'NUMBER';
            } else {
                $target_directory = 'UPPERCASE';
            }
        }
    }
    
    my $local_filename = (($target_directory) ? "$target_directory/" : "") . $target_filename;

    my $expected = "$checksum *$local_filename\n";
    my $result = (-e $local_filename) ? `md5sum -b $local_filename` : '';
    
    # Problem?
    if ($expected ne $result) {
        say "# $local_filename damaged/incomplete";

        my ($remote_path) = $XML_file =~ m|^(.*)_files|;
        my $url = "http://www.archive.org/download/$remote_path/$filename_xml";
        
        if ($target_directory) {
            unless (exists $created_directories{$target_directory}) {
                say "mkdir -p $target_directory ;" if $target_directory;
                $created_directories{$target_directory} = 1;
            }
        }
        say "rm $local_filename ;" if (-e $local_filename); # HTTP is hopeless for damaged
                                                            # downloads, so let's start from
                                                            # the beginning.
        
        say "wget -O $local_filename -N $url ;";
    } 

    # Everything fine.
    else {
        say "# $local_filename ok";
        $created_directories{($target_directory || '.')} = 1; # directory can be considered existing!
    }
}