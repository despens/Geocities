#!/usr/bin/bash
# Merge geocities.com into www.geocities.com

cd $GEO_WORK/geocities/
$GEO_SCRIPTS/merge_directories.pl geocities.com www.geocities.com

# save conflicts
mkdir -p $GEO_WORK/geocities_conflicts_1/www.geocities.com
$GEO_SCRIPTS/merge_directories.pl geocities.com $GEO_WORK/geocities_conflicts_1/www.geocities.com


# real    4m39.263s
# user    0m8.661s
# sys 0m30.210s
