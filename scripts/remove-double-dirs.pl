#!/usr/bin/perl

# find dirs with similar lowercased names


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

$|=1; # turn on autoflush!!

open(INPUT, "< $ENV{GEO_LOGS}/doubles-dir-sorted.txt");

my @set;

my $last_lowname = "";

while(<INPUT>) {
    chomp;

    my $dir_path = decode_utf8($_);
    
    my $current_lowname = lc( $dir_path ); # lowercase the file name ... is it the same as the file before?

    if ($current_lowname and $current_lowname eq $last_lowname) {

        push(@set, $dir_path);
    }

    # a new set of files begins, so the last set has to be treated.

    else {
        my $winner = shift(@set);                                                   # the first directory name is the winner ...

        for my $loser (@set) {                                                      # every single loser should go there!
            my $loser_path = $ENV{GEO_WORK} . '/geocities' . $loser;                # Loser Path,
            my $winner_path = $ENV{GEO_WORK} . '/geocities' . $winner;              # Winner Path!

            system(('merge_directories.pl', $loser_path , $winner_path));           # MERGE!
            
            my $conflict_counter = 0;                                               # Conflicts that might arise need to be tracked.
            
            while(!dir_is_empty($loser_path)) {                                     # If there are still files in the loser directory
                $conflict_counter++;                                                # try moving them into the next conflict directory.
                my $conflict_path = $ENV{GEO_WORK} . "/geocities_conflicts_$conflict_counter" . $winner;    # Target dir.
                system(('mkdir', '-p', $conflict_path));                                                    # Create the path.
                system(('merge_directories.pl', $loser_path , $conflict_path));                             # MERGE!
            }
            system(('rmdir', '-v', $loser_path)) if (-d $loser_path);                # Delete loser dir if it didn't happen yet, coz now it is empty!
        }

       
        # done!
        # start a new set:

        @set = (); # clear the list

        push(@set, $dir_path);
    }



    $last_lowname = $current_lowname;


}

# checking if a directory is empty by looking at its entries
sub dir_is_empty {
    my ($path) = @_;
    if(-d $path) {
        opendir DIR, $path;
        while(my $entry = readdir DIR) {
            next if($entry =~ /^\.\.?$/);
            closedir DIR;
            return 0;
        }
        closedir DIR;
    }
    return 1;
}

# return a file's containing directory
sub parent {
    my($path) = @_;
    $path =~ s|^(.+)/[^/]+$|$1|;
    return $path;
}