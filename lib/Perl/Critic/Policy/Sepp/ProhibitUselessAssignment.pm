package Perl::Critic::Policy::Sepp::ProhibitUselessAssignment;
use v5.14;
use strict;
use warnings;

use Readonly;
use Perl::Critic::Utils qw/:severities/;
use base 'Perl::Critic::Policy';

Readonly::Scalar my $DESC => 'Useless assignment';
Readonly::Scalar my $EXPL => 'Redundant initialization of variable';

sub supported_parameters { }
sub default_severity { return $SEVERITY_HIGH }
sub default_themes { return qw/sepp maintainance/; }
sub applies_to { return qw/PPI::Statement::Variable/; }

sub violates {
    my ($self, $elem, undef) = @_;
    return unless $elem->type eq 'my';

    my (undef, $sym, $op, $what)  = $elem->schildren;
    return unless $op->content eq '=';

    # scalar
    if($sym->symbol_type eq '$') {
        return $self->violation($DESC, $EXPL, $elem) if $what->content eq 'undef';
    }
    # hash / array
    elsif($sym->symbol_type =~ m#^[@%]$#) {
        return $self->violation($DESC, $EXPL, $elem) if $what->content =~ m#^\(\s*\)$#;
    }

    # return $self->violation($DESC, $EXPL, $elem) if $next->content eq '()';
    return;
}

1;
__END__

=head1 NAME

Perl::Critic::Policy::Sepp::ProhibitUselessAssignment - Prevent redundant assignments.

=head1 DESCRIPTION

Don't assign variables with undef or ().

     my $scalar = undef;
     my %hash = ();
     my @array = ();

This is basically the same:

     my ($scalar, %hash, @array);

=head1 AFFILIATION

This policy is part of L<Perl::Critic::Policy::Sepp>.

=head1 AUTHOR

Sebastian Stumpf E<lt>sepp@perlhacker.orgE<gt>

=head1 COPYRIGHT & LICENSE

Copyright 2011-2012 Sebastian Stumpf.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
