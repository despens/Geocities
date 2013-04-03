# Merge as much as possible from the leftover profiles in YAHOOIDS
# into www.geocities.com

cd $GEO_WORK/geocities/YAHOOIDS
find . -mindepth 2 -maxdepth 2 -type d -print0 | xargs -0 -I pathname bash -c '$GEO_SCRIPTS/merge_directories.pl pathname $GEO_WORK/geocities/www.geocities.com'

find . -mindepth 2 -maxdepth 2 -type d -print0 | xargs -0 -I pathname bash -c '$GEO_SCRIPTS/merge_directories.pl pathname $GEO_WORK/geocities_conflicts_1/www.geocities.com'

mkdir -p $GEO_WORK/geocities_conflicts_2/www.geocities.com

find . -mindepth 2 -maxdepth 2 -type d -print0 | xargs -0 -I pathname bash -c '$GEO_SCRIPTS/merge_directories.pl pathname $GEO_WORK/geocities_conflicts_2/www.geocities.com'

rm -rv $GEO_WORK/geocities/YAHOOIDS


# real    1909m46.145s
# user    46m57.052s
# sys     141m25.910s
