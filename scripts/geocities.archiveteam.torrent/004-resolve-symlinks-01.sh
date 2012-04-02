#!/bin/bash

# Move profiles from YAHOOIDS into www.geocities.com
# by resolving the symlinks

cd $GEO_WORK/geocities/www.geocities.com

find . -type l -print0 | xargs -0 -I filename bash -c 'echo -n "filename "; readlink filename;' | sed 's|^\(.\+\) \(.\+\)|rm -v \1 ; mv -v \2 \1|g' | tr '\n' '\0' | xargs -0 -n 1 bash -c