#!/bin/bash

# This script decrunches the archiveteam's Geocities torrent.
# It is assumed that you kept the original structure and
# file names after finishing the download.

cd $GEO_SOURCE/geocities.archiveteam.torrent/


# Find all 7z archives and decrunch them. The option -P4 means
# "run 4 7zip decrunchers at the same time". Adjust the number to
# the numbe of cores your processor has.

find . -name *.7z.001 | xargs -P4 -I filename 7z x filename -o$GEO_WORK



