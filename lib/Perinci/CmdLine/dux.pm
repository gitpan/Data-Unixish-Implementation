package Perinci::CmdLine::dux;
use Moo;
extends 'Perinci::CmdLine';

sub run_subcommand {
    require Tie::Diamond;

    my $self = shift;

    tie my(@diamond), 'Tie::Diamond', {chomp=>1} or die;
    $self->{_args}{in}  = \@diamond;
    $self->{_args}{out} = [];

    $self->SUPER::run_subcommand(@_);
}

sub format_and_display_result {
    my $self = shift;
    if ($self->{_res} && $self->{_res}[0] == 200) {
        # insert out to result, so it can be displayed
        $self->{_res}[2] = $self->{_args}{out};
    }
    $self->SUPER::format_and_display_result(@_);
}

1;
# ABSTRACT: Perinci::CmdLine subclass for dux cli

__END__
=pod

=head1 NAME

Perinci::CmdLine::dux - Perinci::CmdLine subclass for dux cli

=head1 VERSION

version 0.02

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

