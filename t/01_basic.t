package Template_Basic;
use strict;
use warnings;
use Test::More;
use utf8;
use DBI;
use DBIx::UTF8Key;

use Test::More tests => 4;

{
    my $dbh = DBI->connect("DBI:SQLite:dbname=t/test.sqlite",
        undef, undef, {
            AutoCommit => 1,
            RaiseError => 1,
            sqlite_unicode => 1,
        }
    );
    my $ret = $dbh->selectrow_hashref('SELECT * FROM テーブル');
    for my $key (keys %$ret) {
        is(utf8::is_utf8($key), '');
    }
}

{
    my $dbh = DBIx::UTF8Key->connect("DBI:SQLite:dbname=t/test.sqlite",
        undef, undef, {
            AutoCommit => 1,
            RaiseError => 1,
            sqlite_unicode => 1,
        }
    );
    my $ret = $dbh->selectrow_hashref('SELECT * FROM テーブル');
    for my $key (keys %$ret) {
        is(utf8::is_utf8($key), 1);
    }
}
