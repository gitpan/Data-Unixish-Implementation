package Data::Unixish::date;

use 5.010;
use strict;
use warnings;
use Log::Any '$log';
use POSIX qw(strftime);
use Scalar::Util qw(looks_like_number blessed);

our $VERSION = '0.03'; # VERSION

our %SPEC;

$SPEC{date} = {
    v => 1.1,
    summary => 'Format date',
    description => <<'_',

_
    args => {
        in  => {schema=>'any'},
        out => {schema=>'any'},
        format => {
            summary => 'Format',
            schema=>[str => {default=>0}],
            cmdline_aliases => { f=>{} },
        },
        # tz?
    },
    tags => [qw/sorting/],
};
sub date {
    my %args = @_;
    my ($in, $out) = ($args{in}, $args{out});
    my $format  = $args{format} // '%Y-%m-%d %H:%M:%S';

    my $required;

    while (my ($index, $item) = each @$in) {
        my @lt;
        if (looks_like_number($item) &&
                $item >= 0 && $item <= 2**31) { # XXX Y2038-bug
            @lt = localtime($item);
        } elsif (blessed($item) && $item->isa('DateTime')) {
            # XXX timezone!
            @lt = localtime($item->epoch);
        } else {
            goto OUT_ITEM;
        }

        $item = strftime $format, @lt;

      OUT_ITEM:
        push @$out, $item;
    }

    [200, "OK"];
}

1;
# ABSTRACT: Format date

__END__
=pod

=head1 NAME

Data::Unixish::date - Format date

=head1 VERSION

version 0.03

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

