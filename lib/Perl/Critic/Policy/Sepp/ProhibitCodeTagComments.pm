package Perl::Critic::Policy::Sepp::ProhibitCodeTagComments;
use strict;
use warnings;

use Readonly;
use Perl::Critic::Utils qw/:severities/;
use base 'Perl::Critic::Policy';

Readonly::Scalar my $DESC => 'Found code tag comment';
Readonly::Scalar my $EXPL => 'Dont permit code tag comments';

sub supported_parameters {
    return {
        name => 'codetags',
        behavior => 'string list',
        description => 'Prohibited code tag comments',
        default_string => 'TODO XXX FIXME HACK BUG',
    };
}

sub default_severity { return $SEVERITY_LOW }
sub default_themes { return qw/sepp cosmetic/; }
sub applies_to { return qw/PPI::Token::Comment/; }
sub violates {
    my ($self, $elem, undef) = @_;

    foreach my $tag (keys %{ $self->{'_codetags'} }) {
        return $self->violation($DESC, $EXPL, $elem)
            if index( $elem->content(), $tag ) != -1;
    }
    return;
}

1;
__END__

=head1 NAME

Perl::Critic::Policy::Sepp::ProhibitCodeTagComments - Don't permit code tag comments.

=head1 DESCRIPTION

Taken from L<http://www.python.org/dev/peps/pep-0350/>:

  Programmers widely use ad-hoc code comment markup conventions to serve as
  reminders of sections of code that need closer inspection or review. Examples
  of markup include FIXME, TODO, XXX, BUG, but there many more in wide use in
  existing software. Such markup will henceforth be referred to as codetags.

=head1 CONFIGURATION

This policy looks for the following tags: TODO, XXX, FIXME, HACK, BUG

These default tags can be changed in your F<.perlcriticrc> file:

  [Sepp::ProhibitCodeTagComments]
  codetags = FOO BAR BAZ

=head1 AFFILIATION

This policy is part of L<Perl::Critic::Policy::Sepp>.

=head1 AUTHOR

Sebastian Stumpf E<lt>sepp@perlhacker.orgE<gt>

=head1 COPYRIGHT & LICENSE

Copyright 2011-2012 Sebastian Stumpf.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<http://fxr.watson.org/fxr/search?string=XXX>

=cut
