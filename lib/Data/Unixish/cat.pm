package Data::Unixish::cat;

use 5.010;
use strict;
use warnings;
use Log::Any '$log';

our $VERSION = '0.03'; # VERSION

our %SPEC;

$SPEC{cat} = {
    v => 1.1,
    summary => 'Pass input unchanged',
    args => {
        in  => {schema=>'any'},
        out => {schema=>'any'},
    },
    tags => [qw/filtering/],
};
sub cat {
    my %args = @_;
    my ($in, $out) = ($args{in}, $args{out});

    while (my ($index, $item) = each @$in) {
        push @$out, $item;
    }

    [200, "OK"];
}

1;
# ABSTRACT: Pass input unchanged

__END__
=pod

=head1 NAME

Data::Unixish::cat - Pass input unchanged

=head1 VERSION

version 0.03

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

