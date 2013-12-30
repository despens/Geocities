#!/usr/bin/perl

# Slurping in a list with files that could be
# indexes for a directory from the database,
# then deleting ones that just exist because
# of wget automatically creating them as "index.html"
# while the user provided something like "index.htm"
# anyway.

# Pages that are starting pages of an account, aka
# 'home pages', will be tagged, also for their
# neighborhood, if any.


use feature ':5.14';
use strict;
use warnings;
use diagnostics;

use Data::Dumper;

use DBI;
use Digest;

use YAML qw(LoadFile);

my $AGENT = 'GEOindexes';
my $VERSION = '0.2-despens';

$|=1;



my $dbh = DBI->connect("dbi:Pg:dbname=$ENV{GEO_DB_DB}", $ENV{GEO_DB_USER}, $ENV{GEO_DB_PASSWD}, {RaiseError => 1, AutoCommit => 0});
my $db_insert_url = $dbh->prepare(qq(
    INSERT INTO urls (id, url, file_id, agent) 
    VALUES           (?,  ?,   ?,       ?);
));
my $db_insert_prop = $dbh->prepare(qq(
    INSERT INTO props (id, file_id, rel, obj, agent)
    VALUES            (?,  ?,       ?,   ?,   ?);
));
my $db_delete_files = $dbh->prepare(qq(
    DELETE FROM files WHERE id = ?
));
my $db_delete_urls = $dbh->prepare(qq(
    DELETE FROM urls WHERE file_id = ?
));
my $db_delete_props = $dbh->prepare(qq(
    DELETE FROM props WHERE file_id = ?
));

my $hoods = LoadFile("$ENV{GEO_SCRIPTS}/setup/neighborhoods.yaml");

open(INPUT, "< $ENV{GEO_LOGS}/indexes-list.txt");

my @set;
my @superset;

my $last_dir = '';

while(<INPUT>) {

    chomp;

    my ($id, $digest, $path) = $_ =~ m/^(.+?)\|(.+?)\|(.+)$/;

    my ($dir) = $path =~ m|^(.+/)|;

    my $entry = {
        path        => $path,
        dir         => $dir,
        digest      => $digest,
        id          => $id,
    };

    if ($dir eq $last_dir) {
        push(@set, $entry);
    }
    else {
        my @saveset = map { $_ } @set;
        push(@superset,@saveset);
        @set=();
        push(@set, $entry);
    }
    $last_dir = $dir;
}
# don't forget the last one!
my @saveset = map { $_ } @set;
push(@superset,@saveset);
@set=();

#print Dumper(\@superset);

for (@superset) {

    my @set = $_;

    if ($#set>0) {  # only if there is more than 1 file in the set

        # Find out if the files contain different data.
        my $digest_same = 1;
        my $digest_test = $set[0]->{digest};
        for (@set) {
            if ($digest_test ne $_->{digest}) {
                $digest_same = 0;
            }
        }        

        if($digest_same) {                          # If all files with similar names contain the same data ...

            my @best_filename = sort {              # ... the more likely filename has more uppercase letters 
                $a->{path} cmp $b->{path}           # than the sloppy ones. So let's sort!
            } @set;      

            my $winner = shift(@best_filename);

            db_insert_index($winner);
     
            # delete unneeded files and remove their database entries

            for my $del (@best_filename) {          # Remove files that have worse file names.
                system(('rm', '-v', "$ENV{GEO_ARCHIVE}/$del->{path}"));
                $db_delete_urls->execute($del->{id});
                $db_delete_props->execute($del->{id});
                $db_delete_files->execute($del->{id});
            }
        }
    }
    # only one file in the set
    elsif($#set==0) {
        my $winner = shift(@set);
        db_insert_index($winner);
    }

}


say 'COMMITTING ...';
$dbh->commit();


sub db_insert_index {

    say '---------------------------';

    my $winner = shift();
    

    my ($url) = $winner->{dir} =~ m|^.+?/(.+)|;

    my $record_url = {
        url => $url,
        file_id => $winner->{id},
        agent => "$AGENT $VERSION",
    };

    my $sha1_id = Digest->new('SHA-1');

    map { $sha1_id->add($_) } (
        $record_url->{url},
        $record_url->{file_id},
        $record_url->{agent}, 
    );

    $record_url->{id} = $sha1_id->hexdigest;

    print Dumper($record_url);

    $db_insert_url->execute(
        $record_url->{id},
        $record_url->{url},
        $record_url->{file_id},
        $record_url->{agent}, 
    );

    # is it a home page, the index page of a
    # user's directory?

    my @segments = split('/', $url);
    
    my $homepage = 0;
    my $neighborhood = 0;

    # need to check for neighborhoods if the server
    # is www.geocities.com
    if($segments[0] eq 'www.geocities.com') {
        if($hoods->{$segments[1]}) {
            $neighborhood = $segments[1];
            if($#segments == 2) {
                if($segments[2] =~ /\d{4}/) {
                    say "NUMBER";
                    $homepage = 1;
                }
            }
            # sub-neighborhood
            elsif($#segments == 3) {
                if($segments[2] ~~ @{$hoods->{$neighborhood}} and $segments[3] =~ /\d{4}/) {
                    
                    $homepage = 1;
                    $neighborhood = $segments[1];
                }
            }
        }
        else {
            if($#segments == 1) {
                $neighborhood = 'vanity';
                $homepage = 1;
            }
        }
    } 
    # another Geocities server
    else {
        if($#segments == 1) {
            $homepage = 1;
        }
    }

    # note that this is a homepage!
    if($homepage) {
        insert_prop({
            file_id   => $winner->{id},
            rel       => 'tag',
            obj       => 'homepage',
            agent     => "$AGENT $VERSION",
        });

        # if it belongs to a neighborhood, note that as well.
        # will be nice to select them later for browsing
        if($neighborhood) {
            insert_prop({
                file_id   => $winner->{id},
                rel       => 'tag',
                obj       => $neighborhood,
                agent     => "$AGENT $VERSION",
            });
        }
    }
}

sub insert_prop {

    my $record_prop = shift;

    my $sha1_id = Digest->new('SHA-1');

    map { $sha1_id->add($_) } (
        $record_prop->{file_id},
        $record_prop->{rel},
        $record_prop->{obj}, 
        $record_prop->{agent}, 
    );

    $record_prop->{id} = $sha1_id->hexdigest;

    print Dumper($record_prop);

    $db_insert_prop->execute(
        $record_prop->{id},
        $record_prop->{file_id},
        $record_prop->{rel},
        $record_prop->{obj},
        $record_prop->{agent}, 
    );
}