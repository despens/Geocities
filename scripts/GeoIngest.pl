#!/usr/bin/perl

# This script ingests a collection of files into the
# database. It takes one argument: the base directory
# of a collection.
#
# There is no error-checking for input values, so
# don't mess this up!
#
# If you can, disable constraints and indexes during 
# an ingest, it will speed up the process dramatically.

use feature ':5.14';

use strict;
use warnings;
use diagnostics;

use Encode;
use Try::Tiny;

use IO::All;
use File::Find;
use File::stat;
use Cwd qw(abs_path);

use Digest;
use DBI;

use Data::Dumper;

my $AGENT = 'GeoIngest';
my $VERSION = '0.1-despens';

$| = 1; # turn on autoflush

# remove trailing slashes
map { chop if (substr($_, -1) eq '/') } @ARGV;

my $source_directory = abs_path($ARGV[0]);

# the last directory name is the collection name
my ($collection) = $source_directory =~ m|.*/(.+)$|;


my $dbh = DBI->connect("dbi:Pg:dbname=$ENV{GEO_DB_DB}", $ENV{GEO_DB_USER}, $ENV{GEO_DB_PASSWD}, {RaiseError => 1, AutoCommit => 0});

#
# Preparing SQL-Statement
#

my $db_insert = $dbh->prepare(qq(
    INSERT INTO files (id, collection, path, last_modified,   size, checksum_sha1, agent) 
    VALUES            (?,  ?,          ?,    to_timestamp(?), ?,    ?,             ?);
));

my $counter = 0;
open(LOGFILE, "> $ENV{GEO_LOGS}/db-files.txt");


find({wanted => \&ingest, no_chdir=>1}, $source_directory);

sub ingest {
    return unless(-f $File::Find::name);

    my $path_absolute =  decode_utf8($File::Find::name);

    my ($path_relative) = $_ =~ m|$source_directory/(.+)|;
    $path_relative = "$collection/$path_relative";

    my $file_info = stat($File::Find::name);

    my $sha1_file = Digest->new('SHA-1');
    my $file_contents = io($path_absolute)->binary->all;

    $sha1_file->add( $file_contents );

    my $sha1_id = Digest->new('SHA-1');

    my $record = {
        collection      => $collection,
        path            => $path_relative,
        last_modified   => $file_info->mtime,
        size            => $file_info->size,
        checksum_sha1   => $sha1_file->hexdigest,
        agent           => "$AGENT $VERSION",
    };

    map { $sha1_id->add($_) } (
        $record->{collection},
        $record->{path},
        $record->{last_modified}, 
        $record->{size},
        $record->{checksum_sha1},
        $record->{agent}
    );

    $record->{id} = $sha1_id->hexdigest;

    print Dumper($record);

    try {
        # Ram stuff into database!
        $db_insert->execute(
            $record->{id},
            $record->{collection},
            $record->{path},
            $record->{last_modified}, 
            $record->{size},
            $record->{checksum_sha1},
            $record->{agent}
        );
        say LOGFILE $record->{id}.'|'.$record->{path};
    } 

    catch {
        # should be writing something meaningful to STDERR.
        # The most likely case for the db refusing to ingest
        # a row is because of a double key.
        say 'SKIPPING';
    };

    $counter++;
    if($counter==1024) {
        $dbh->commit;
        $counter=0;
    }

}

# Since a commit only happens every 1024th rows inserted,
# it is important to commit in the end!

$dbh->commit;
$dbh->disconnect;
close LOGFILE;