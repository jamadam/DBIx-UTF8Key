package DBIx::UTF8Key;
    
    use strict;
    use warnings;
    use base qw(DBI);
    our $VERSION = '0.03';

package DBIx::UTF8Key::db;
    
    use base qw(DBI::db);
    use Encode 'decode_utf8';
    
    sub errstr {
        return decode_utf8(shift->SUPER::errstr(@_));
    }

package DBIx::UTF8Key::st;
    
    use base qw(DBI::st);
    
    sub fetchrow_hashref {
        
        my ($sth, @args) = @_;
        my $hash_ref = $sth->SUPER::fetchrow_hashref(@args) or return;
        my $hash_fixed = {};
        while (my ($key, $val) = each(%$hash_ref)) {
            utf8::decode($key);
            utf8::decode($val);
            $hash_fixed->{$key} = $val;
        }
        return $hash_fixed;
    }

1;

__END__

=head1 NAME

DBIx::UTF8Key - 

=head1 SYNOPSIS

    use DBIx::UTF8Key;
    DBIx::UTF8Key->new;

=head1 DESCRIPTION

=head1 METHODS

=head2 new

=head1 AUTHOR

Sugama Keita, E<lt>sugama@jamadam.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011 by Sugama Keita.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
