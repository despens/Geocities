#!/bin/bash

# Change the absolute symlinks in www.geocities.com to relative symlinks so
# that work with different file system setups.

cd $GEO_WORK/geocities/www.geocities.com

#                                                                                                                                                             example:  rm Athens ; ln -sv ../YAHOOIDS/A/t/Athens Athens
find . -maxdepth 1 -type l -print0 | xargs -0 -n1 -I filename bash -c 'echo filename ; readlink filename' | xargs -L 2 -n2 echo | sed 's|^\./\(.\+\) /geocities\(.\+\)$|rm -v \1 ; ln -sv ..\2 \1|g' | tr '\n' '\0' | xargs -0 -n1 bash -c 
# find the symlinks, only            Output the original filename and the link target, via readlink.        Get these two params       Get the       Get the symlink's  Delete ori-  Create a new      Replace new-   Give this commandline
# on the first directory level.                                                                             and hand them over         symlink's     target but leave   ginal sym-   relative link     lines with     to the shell for
#                                                                                                           to sed for creating        name          the leading        link.        with the same     NULL-bytes.    execution
#                                                                                                           a commandline.                           '/geocities' out.               name as before.
#
