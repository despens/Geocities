# Merge as much as possible from the leftover profiles in YAHOOIDS
# into www.geocities.com

cd $GEO_WORK/geocities/YAHOOIDS
find . -mindepth 2 -maxdepth 2 -type d -print0 | xargs -0 -I pathname bash -c 'merge_directories.pl pathname $GEO_WORK/geocities/www.geocities.com'


# real    646m25.345s
# user    26m21.331s
# sys 76m31.759s
