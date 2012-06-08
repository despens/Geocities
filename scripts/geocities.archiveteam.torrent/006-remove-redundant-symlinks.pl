#!/usr/bin/perl

# Removing symlinks that link to a similiar directory with a 
# mixed case name.

$| = 1; # turn on autoflush

use 5.10.0;
use warnings;
use strict;
use File::Find;

sub remove {
    # find only symlinks
    if(-l) {
        my $link_destination = `readlink -n $_`; # where symlink is pointing to, 
                                                 # without newline in the end

        my @path = split('/', $File::Find::name);
        
        # Convert symlink and its target to lowercase,
        # if they match, remove symlink.
        if ( lc($path[-1]) eq lc($link_destination) ) { 
            say `rm -v $path[-1]`;
        }
    } 
}

# Run through www.geocities.com
find(\&remove, $ENV{GEO_WORK}.'/geocities/www.geocities.com');

# This script is ridiculously inefficient! But still better
# than doing it manually :)
# real    181m22.134s
# user    1m47.071s
# sys     2m39.086s
