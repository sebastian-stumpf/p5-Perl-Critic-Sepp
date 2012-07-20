package Perl::Critic::Policy::Sepp::ProhibitNoPlan;
use strict;
use warnings;

use Readonly;
use Perl::Critic::Utils qw/:severities/;
use base 'Perl::Critic::Policy';

Readonly::Scalar my $DESC => 'Found no_plan';
Readonly::Scalar my $EXPL => 'Write complete test cases';

sub supported_parameters { }
sub default_severity { return $SEVERITY_HIGH }
sub default_themes { return qw/sepp tests/; }
sub applies_to { return qw/PPI::Token::QuoteLike::Words PPI::Token::Quote::Single/; }

sub violates {
    my ($self, $elem, undef) = @_;
    return unless $elem->content =~ m#no_plan#;

    my $prev = $elem->sprevious_sibling || return;
    return unless $prev->isa('PPI::Token::Word');
    return unless $prev->content =~ m#^Test#;

    return $self->violation($DESC, $EXPL, $elem);
}


1;
__END__

=head1 NAME

Perl::Critic::Policy::Sepp::ProhibitNoPlan - Think ahead when writing tests.

=head1 DESCRIPTION

You need a testing plan which declares how many tests your script is going
to run to protect against premature failure. Have a look at L<Test::More>
for more information.

=head1 AFFILIATION

This policy is part of L<Perl::Critic::Policy::Sepp>.

=head1 AUTHOR

Sebastian Stumpf E<lt>sepp@perlhacker.orgE<gt>

=head1 COPYRIGHT & LICENSE

Copyright 2011-2012 Sebastian Stumpf.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
