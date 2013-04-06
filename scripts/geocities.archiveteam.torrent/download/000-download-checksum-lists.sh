#!/bin/bash

# Create the directory for the torrent, if it doesn't exist already.
# Uses the environment variable GEO_SOURCE!

mkdir -p $GEO_SOURCE/geocities.archiveteam.torrent
cd $GEO_SOURCE/geocities.archiveteam.torrent

# Download XML files containing checksums from archive.org
for i in {1..8};
do
    wget -cv http://www.archive.org/download/2009-archiveteam-geocities-part${i}/2009-archiveteam-geocities-part${i}_files.xml;
done