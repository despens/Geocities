# To get rid of all the files that have been downloaded multiple
# times due to filename case sensitivity issues, the help of a
# database server is required!

# First, directory names will be handled, since this will solve
# issues for most files contained inside of them. To speed things
# up, create a list of all directory names and save it in a file.

cd $GEO_WORK/geocities
find . -type d > $GEO_LOGS/dir-index.txt

# real    116m21.050s
# user    0m32.966s
# sys     4m7.619s


# Create a database table to hold directory names
# directory names converted to lower case.
# No indexes or constraints are present in the
# table to enable a swift ingest.

# Make sure your database server is prepared and that you have a 
# .pgpass file in case your db server asks for passwords each 
# time!

psql -d $GEO_DB_DB -f $GEO_SCRIPTS/sql/create/doubles.sql


# Put all this stuff into the database

$GEO_SCRIPTS/ingest-doubles.pl dir-index.txt

# real    8m11.323s
# user    4m28.981s
# sys     0m28.762s


# Create indexes in the database to speed up sorting.

psql -d $GEO_DB_DB -f $GEO_SCRIPTS/sql/create/doubles-indexes.sql

# real    3m22.510s
# user    0m0.012s
# sys     0m0.020s

# Generate a sorted list of directories.
psql --no-align --tuples-only -d $GEO_DB_DB -f $GEO_SCRIPTS/sql/do/find-doubles.sql -o $GEO_LOGS/doubles-dir-sorted.txt

# real    135m23.145s
# user    0m0.324s
# sys     0m0.288s

# Feed the double dir list into the dir-compare script that
# will sort or dirnames and their contents.
$GEO_SCRIPTS/remove-double-dirs.pl

# real    1006m39.783s
# user    558m57.844s
# sys 75m33.795s

# This is nerve griding, get a RAID5 if you can!!!1

# The lists are not needed any more.
rm -v $GEO_LOGS/dir-index.txt
rm -v $GEO_LOGS/doubles-dir-sorted.txt