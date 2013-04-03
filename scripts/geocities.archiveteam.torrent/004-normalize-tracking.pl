#!/usr/bin/perl

# Find tracking inserted into html files by the Geocities server
# and normalize all letters to 'a' and all digits to '0'

our $VERSION = 1.00;

use 5.12.0;
use warnings;
use diagnostics;
use strict;
use IO::All;
use File::Find;
use File::stat;

$| = 1; # turn on autoflush

# chdir("$ENV{GEO_WORK}/geocities");
chdir("$ENV{GEO_WORK}/");

find({wanted => \&normalize, no_chdir => 1}, '.');

sub normalize {
    # is it a file?
    # I will not only process files named *.html or something, because
    # there are some *.JPGs that are actually HTML!
    # If the pattern searched for is not found and replaces, the file will
    # stay unmodified anyway. This helps big time against the symlink cancer!
    if(-f) {
        my $filename = $_;
        my $file = io($filename)->binary->all;  # load it
        
        (my $newfile = $file) =~                # try changing the tracking GIF URL
           s|
                "http://visit.geocities.yahoo.com/visit.gif\?\w{2}(\d+)"
            |{
                '"http://visit.geocities.yahoo.com/visit.gif?aa' . ('0' x length($1)) . '"'
            }|gex;
        
        $newfile =~                             # try changing the Geotracking GIF URL
           s|
                "http://geo.yahoo.com/serv\?s=(\d+)&t=(\d+)&f=\w{2}-\w{2}"
            |{
                '"http://geo.yahoo.com/serv?s=' . ('0' x length($1)) . '&t=' . ('0' x length($2)) . '&f=aa-a0"'
            }|gex;
        
        # if something was indeed changed
        if($newfile ne $file) {
            my $mtime = stat($filename)->mtime; # save the file's original 'last-modified'
            $newfile > io($filename)->binary;   # write the modified file to disk
            utime(time, $mtime, $filename);     # restore the old 'last-modified' time
            say $filename;
        }
    }
}

# real    1717m42.893s
# user    152m35.896s
# sys 46m25.606s

