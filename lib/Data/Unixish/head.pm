package Data::Unixish::head;

use 5.010;
use strict;
use warnings;
use Log::Any '$log';

our $VERSION = '0.01'; # VERSION

our %SPEC;

$SPEC{head} = {
    v => 1.1,
    summary => 'Output the first items of data',
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
sub head {
    my %args = @_;
    my ($in, $out) = ($args{in}, $args{out});
    my $n = $args{items} // 10;

    while (my ($index, $item) = each @$in) {
        last if $index >= $n;
        push @$out, $item;
    }

    [200, "OK", $out];
}

1;
# ABSTRACT: Output the first items of data

__END__
=pod

=head1 NAME

Data::Unixish::head - Output the first items of data

=head1 VERSION

version 0.01

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

