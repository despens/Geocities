#!/bin/bash

# Symlinks are a PITA, so remove them all.
# Anyway it is already known where belongs what:
# All the user directories from YAHOOIDS need to
# go to www.geocities.com ... the rest just tries
# to solve case issues that will be tackled
# in another way soon.

cd $GEO_WORK/geocities

find . -type l -print0  |  xargs -n 1 -P4 -0 rm -v
# "type l" means           Delete these 
# to look for symlinks.    bastards, fast!

# real    94m32.760s
# user    0m30.622s
# sys     4m15.080s