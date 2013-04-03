# Find everything that could be an index file,
# like "index.html", "index.htm", "INDEX.HTM", etc

psql -d $GEO_DB_DB --no-align --tuples-only -f  $GEO_SCRIPTS/sql/do/find-indexes.sql -o $GEO_LOGS/indexes-list.txt

# real    3m34.571s
# user    0m0.056s
# sys 0m0.024s

# Delete unneeded index files from disk and database,
# mark the right ones as "homepage".

$GEO_SCRIPTS/filer-indexes.pl