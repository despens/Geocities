#!/usr/bin/perl

use 5.12.0;

use strict;
use warnings;
use diagnostics;
use utf8;

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


my $dbh = DBI->connect("dbi:Pg:dbname=$ENV{GEO_DB_DB}", $ENV{GEO_DB_USER}, $ENV{GEO_DB_PASSWD}, {RaiseError => 1, AutoCommit => 1});

#
# Preparing SQL-Statement
#

my $db_insert = $dbh->prepare(qq(
    INSERT INTO files (id, collection, path, last_modified,   size, checksum_sha1, agent) 
    VALUES            (?,  ?,          ?,    to_timestamp(?), ?,    ?,             ?);
));

find({wanted => \&ingest, no_chdir=>1}, $source_directory);

$dbh->disconnect;

sub ingest {
    return unless(-f $File::Find::name);

    my $path_absolute = $File::Find::name;

    my ($path_relative) = $_ =~ m|$source_directory/(.+)|;
    $path_relative = "$collection/$path_relative";

    my $file_info = stat($File::Find::name);

    my $sha1_file = Digest->new('SHA-1')->add( io($path_absolute)->binary->all );
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

    # ram stuff into database!
    $db_insert->execute(
        $record->{id},
        $record->{collection},
        $record->{path},
        $record->{last_modified}, 
        $record->{size},
        $record->{checksum_sha1},
        $record->{agent}
    );



}