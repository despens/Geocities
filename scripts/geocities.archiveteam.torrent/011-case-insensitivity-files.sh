# Pick up the last few remaining case sensitivity related
# doubles, a process similar to finding correspondent directories
# as in '009-case-insensitivity-dirs.sh' is required.
# The difference is that it uses another algorithm to delete
# the offenders (see 'remove-double-files.pl') and it takes
# longer to ingest the huge amount of files in contrast
# to the just some 2 million directories.
#
# For the time it takes, the amount of results is quite
# meagre. But every removed file saves processing time 
# in hundreds of occasions in the future.

cd $GEO_WORK/geocities
find . -type f > $GEO_LOGS/file-index.txt

psql -d $GEO_DB_DB -f $GEO_SCRIPTS/sql/create/doubles.sql


# Put all this stuff into the database

$GEO_SCRIPTS/ingest-doubles.pl file-index.txt


psql -d $GEO_DB_DB -f $GEO_SCRIPTS/sql/create/doubles-indexes.sql

# Generate a sorted list of files.
psql --no-align --tuples-only -d $GEO_DB_DB -f $GEO_SCRIPTS/sql/do/find-doubles.sql -o $GEO_LOGS/doubles-file-sorted.txt

# real    261m8.978s
# user    57m27.591s
# sys 10m15.014s


# Feed the double dir list into the dir-compare script that
# will sort or dirnames and their contents.
$GEO_SCRIPTS/remove-double-files.pl

# real    10m49.846s
# user    0m23.697s
# sys     0m13.885s


# The lists are not needed any more.
rm $GEO_LOGS/file-index.txt
rm $GEO_LOGS/doubles-file-sorted.txt