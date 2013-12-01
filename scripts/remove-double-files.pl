#!/usr/bin/perl

# find files with similar lowercased names


use feature ':5.14';
use strict;
use warnings;
use diagnostics;

use Data::Dumper;

use Encode;
use Try::Tiny;

use IO::All;
use File::stat;

use Digest;

$|=1;

open(INPUT, "< $ENV{GEO_LOGS}/doubles-file-sorted.txt");

my @set;

my $last_lowname;

while(<INPUT>) {
    chomp;

    my $file_path = $ENV{'GEO_WORK'} .'/geocities'. decode_utf8($_);
    
    my $current_lowname = lc( $file_path ); # lowercase the file name ... is it the same as the file before?

    if ($current_lowname and $current_lowname eq $last_lowname) {

        next unless(-f $file_path);

        my $file_info = stat($file_path);

        push(@set, {
            name        => $file_path,
            digest      => Digest->new('SHA-1')->add( io($file_path)->binary->all )->hexdigest,
            mod_time    => $file_info->mtime,
            path        => parent($file_path),
        });
    }

    # a new set of files begins, so the last set has to be treated.

    else {

        # Find out if the files contain different data.
        my $digest_same = 1;
        my $digest = $set[0]->{digest};
        for (@set) {
            if ($digest ne $_->{digest}) {
                $digest_same = 0;
            }
        }        

        # Find out if mod_times differ.
        my $mod_time_same = 1;
        my $mod_time = $set[0]->{mod_time};
        for (@set) {
            if ($mod_time ne $_->{mod_time}) {
                $mod_time_same = 0;
            }
        }

        if($digest_same) {                          # If all files with similar names contain the same data ...

            my @best_filename = sort {              # ... the more likely filename has more uppercase letters 
                $a->{name} cmp $b->{name}           # than the sloppy ones. So let's sort!
            } @set;      

            my $winning_filename = shift(@best_filename)->{name};

            for my $del (@best_filename) {          # Remove files that have worse file names.
                system(('rm', '-v', $del->{name}));
                my $dir = parent($del->{name});     # Check if this was the last file in this directory.
                if(dir_is_empty($dir)) {            # In that case
                    system(('rmdir', '-v', $dir));               # remove the directory.
                }

            }

            unless($mod_time_same) {                # If the mod times differ, the most likely mod time is
                                                    # the oldest. So let's sort.
                my @best_mod_time = sort {
                    $a->{mod_time} <=> $b->{mod_time}
                } @set;

                my $winning_mod_time = shift(@best_mod_time)->{mod_time};

                utime(time, $winning_mod_time, $winning_filename);
                                        
            }
        }

        else {                                      # The files do not contain the same data,
                                                    # let's at least move them into the same dir.
            my @best_path = sort {                  # The most likely pathname has more uppercase
                $a->{path} cmp $b->{path}           # than the sloppy ones. So let's sort!
            } @set;

            my $winning_path = shift(@best_path)->{path};

            for my $mv (@best_path) {
                my ($file) = $mv->{name} =~ m|([^/]+)$|;        # Just the file name portion of the name plz.
                unless("$winning_path/$file" eq $mv->{name}) {  # If the file is not already where it should be
                    system(('mv', '-v', $mv->{name}, "$winning_path/$file"));
                
                    my $dir = parent($mv->{name});              # Check if this was the last file in its directory.
                    if(dir_is_empty($dir)) {                    # In that case
                        system(('rmdir', '-v', '$dir'));        # remove the directory.
                    }
                }
            }
        }


        # done!
        # start a new set:

        @set = (); # clear the list

        my $file_info = stat($file_path);

        push(@set, {
            name        => $file_path,
            digest      => Digest->new('SHA-1')->add( io($file_path)->binary->all )->hexdigest,
            mod_time    => $file_info->mtime,
            # size        => $file_info->size
            path        => parent($file_path),
        });
    }



    $last_lowname = $current_lowname;


}

# checking if a directory is empty by looking at its entries
sub dir_is_empty {
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

# return a file's containing directory
sub parent {
    my($path) = @_;
    $path =~ s|^(.+)/[^/]+$|$1|;
    return $path;
}