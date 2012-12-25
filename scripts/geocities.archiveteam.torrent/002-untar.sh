#!/bin/bash

# The torrent holds some 7zip archives that already contain
# real directories, most contain tarballs. They will be 
# untared and deleted after.

cd $GEO_WORK

ls -f -1 | tr '\n' '\0' | xargs -0 file -i | grep -i application/x-tar | sed 's/:.\+//' | tr '\n' '\0' | xargs -I filename -0 -n 1 bash -c 'tar xvf filename && rm -v filename'
# list all    Separate    Run the "file"     "grep" finds all the files  Throwing away    Convert new-   Run bash to execute the untar operation             ^^^^^^^^^^^^^^^^^
# files in    lines by    command on each    that are tarballs.          any output but   lines to       and delete the tarballs after successful            Remove this if you
# the dir,    NULL bytes  found file to                                  the file names.  NULL bytes     decrunching.                                        would like to keep
# just name   for xargs.  determine its                                                   so xargs can                                                       copies of the
# and one                 mime-type                                                       pass each                                                          decrunched files!
# column.                                                                                 filename as 
#                                                                                         an argument


#real    519m26.836s
#user    28m24.299s
#sys     39m41.297s
