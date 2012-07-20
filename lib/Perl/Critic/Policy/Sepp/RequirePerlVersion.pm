package Perl::Critic::Policy::Sepp::RequirePerlVersion;
use v5.14;
use strict;
use warnings;

use Readonly;
use Perl::Critic::Utils qw/:severities/;
use base 'Perl::Critic::Policy';
use version;

Readonly::Scalar my $DESC => 'Missing minimum version';
Readonly::Scalar my $EXPL => 'State the required version of perl';

sub supported_parameters {
    return {
        name => 'version',
        behavior => 'string',
        description => 'required perl version',
        default_string => 'v5.12',
    };
}

sub default_severity { return $SEVERITY_LOW }
sub default_themes { return qw/sepp maintainance/; }
sub applies_to { return qw/PPI::Token::Number::Version PPI::Token::Number::Float/; }
sub violates {
    my ($self, $elem, undef) = @_;

    my $prev = $elem->sprevious_sibling;
    return unless $prev->isa('PPI::Token::Word') && $prev->content eq 'use';

    my $wanted = version->parse($self->{_version});
    my $stated = version->parse($elem->content);

    return if $stated >= $wanted;
    return $self->violation($DESC, $EXPL, $elem);
}

1;
__END__

=head1 NAME

Perl::Critic::Policy::Sepp::RequirePerlVersion - Minimum version via L<version>.

=head1 DESCRIPTION

If there is a required version in the code, make sure it is at least I<use v5.12>.
If there is no version, simply continue.

=head1 CONFIGURATION

You can tweak the version number in your I<.perlcritirc> like this:

  [Sepp::RequirePerlVersion]
  version = v5.12

This policy uses the L<version> extension for all comparisons. Have a look at 
L<version> for more information on the input format.

=head1 AFFILIATION

This policy is part of L<Perl::Critic::Policy::Sepp>.

=head1 AUTHOR

Sebastian Stumpf E<lt>sepp@perlhacker.orgE<gt>

=head1 COPYRIGHT & LICENSE

Copyright 2011-2012 Sebastian Stumpf.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
