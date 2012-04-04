#!/bin/bash

# The torrent holds some 7zip archives that already contain real directories,
# most contain tarballs. They will be unpacked and deleted after 
# successful unpacking.

cd $GEO_WORK

find . -type f  -print0 | xargs -0 file -i | grep -i application/x-tar | sed 's/:.\+//' | tr '\n' '\0' | xargs -I filename -0 -n 1 bash -c 'tar xvf filename && rm -v filename'
# find files              run the "file"     "grep" filters out all      Throwing away    Convert new-   Run bash to execute the untar operation             ^^^^^^^^^^^^^^^^^
# and send them to        command on each    files that are not          any output but   lines to       and delete the tarballs after successful            Remove this if you
# xargs separated by      found file to      tarballs.                   the file names.  NULL bytes     decrunching.                                        would like to keep
# NULL bytes              determine its                                                   so xargs can                                                       copies of the
#                         mime-type                                                       pass each                                                          decrunched files!
#                                                                                         filename as 
#                                                                                         an argument

#real    519m26.836s
#user    28m24.299s
#sys     39m41.297s
