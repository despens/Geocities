#!/usr/bin/perl

# Put all node names into a database to find 
# ones that are the same when regarded without
# case-sensitivity.

# takes one argument, name of the list file, to be
# loaded from the log directory. See 009-case-insensivity-dirs.sh
# for how this list file is created.

# Don't mess this up, there is no error-checking!


use feature ':5.14';
use strict;
use utf8;
use Encode;
use Try::Tiny;
use warnings;
use diagnostics;
use IO::All;
use DBI;

use Data::Dumper;

$| = 1; # turn on autoflush

my $listfile = $ARGV[0];

my $dbh = DBI->connect("dbi:Pg:dbname=$ENV{GEO_DB_DB}", $ENV{GEO_DB_USER}, $ENV{GEO_DB_PASSWD}, {RaiseError => 1, AutoCommit => 0});
my $db_insert = $dbh->prepare(qq(
    INSERT INTO doubles (name, lowname) 
    VALUES                  (?,    ?);
));

# The list needs to be ready at this point.
# This script is not doing more than going through
# a text file line by line.
my $list = io($ENV{GEO_LOGS}.'/'.$listfile);

# The counter is used to determine when to do a
# database commit operation. If a commit is executed
# after every inserted row, the insert process will
# take quite long.
my $counter = 0;

while(my $file_name = $list->getline) {
    $file_name =~ s|^\.(.+)\s*$|$1|;
    $file_name = decode_utf8($file_name);
    my $lowname = lc($file_name);
    my $record = {
        name            => $file_name,
        lowname         => $lowname,
    };

    # Ram stuff into database!
    try {
        $db_insert->execute(
            $record->{name},
            $record->{lowname}
        );
        print '.';
    };

    # If something goes wrong the offending record
    # is spit out.
    catch {
        say Dumper($record);
    };

    # Commit every 1024 rows.
    if ($counter == 1023) {
        $dbh->commit;
        $counter = 0;
        print '*';
    }
    $counter++;
}

# Do not forget to commit in the end!
$dbh->commit;
$dbh->disconnect;
