#!/bin/bash
# move conflicting files into seperate collections

cd $GEO_WORK ;
mkdir -p geocities_conflicts ;
cd geocities_conflicts
if [ ! -e www.geocities.com ]; then
    mv ../geocities/geocities.com . ;
    mv geocities.com www.geocities.com ;
fi

cd $GEO_WORK/geocities/YAHOOIDS ;
find . -mindepth 2 -maxdepth 2 -type d -print0 | xargs -0 -I pathname bash -c 'merge_directories.pl pathname $GEO_WORK/geocities_conflicts/www.geocities.com' ;

cd $GEO_WORK ;
mkdir -p geocities_conflicts_2 ;
cd geocities_conflicts_2
if [ ! -e www.geocities.com ]; then
    mkdir www.geocities.com ;
fi

cd $GEO_WORK/geocities/YAHOOIDS ;
find . -mindepth 2 -maxdepth 2 -type d -print0 | xargs -0 -I pathname bash -c 'merge_directories.pl pathname $GEO_WORK/geocities_conflicts_2/www.geocities.com' ;

rm -r $GEO_WORK/geocities/YAHOOIDS;