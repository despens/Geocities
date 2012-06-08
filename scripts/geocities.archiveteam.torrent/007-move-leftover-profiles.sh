# YAHOOIDS is still full of profiles not symlinked anywhere.
# Let's put them all into www.geocities.com!
# If a users' directory already exists in www.geocities.com,
# it will be skipped.

cd $GEO_WORK/geocities/YAHOOIDS
find . -mindepth 3 -maxdepth 3 -type d -print0 | xargs -0 -I pathname bash -c 'mv -v pathname $GEO_WORK/geocities/www.geocities.com/'

# real    0m36.061s
# user    0m0.044s
# sys     0m0.468s