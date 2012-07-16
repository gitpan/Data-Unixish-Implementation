package Data::Unixish::tail;

use 5.010;
use strict;
use warnings;
use Log::Any '$log';

our $VERSION = '0.02'; # VERSION

our %SPEC;

$SPEC{tail} = {
    v => 1.1,
    summary => 'Output the last items of data',
    args => {
        in  => {schema=>'any'},
        out => {schema=>'any'},
        items => {
            summary => 'Number of items to output',
            schema=>['int*' => {default=>10}],
            tags => ['main'],
            cmdline_aliases => { n=>{} },
        },
    },
    tags => [qw/filtering/],
};
sub tail {
    my %args = @_;
    my ($in, $out) = ($args{in}, $args{out});
    my $n = $args{items} // 10;

    # maintain temporary buffer first
    my @buf;

    while (my ($index, $item) = each @$in) {
        push @buf, $item;
        shift @buf if @buf > $n;
    }

    # push buffer to out
    push @$out, $_ for @buf;

    [200, "OK"];
}

1;
# ABSTRACT: Output the last items of data

__END__
=pod

=head1 NAME

Data::Unixish::tail - Output the last items of data

=head1 VERSION

version 0.02

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

