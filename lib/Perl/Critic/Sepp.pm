package Perl::Critic::Sepp;
use strict;
use warnings;

use version; our $VERSION = version->declare("v1.0.3");


1;

__END__

=head1 NAME

Perl::Critic::Sepp - Custom set of policies for Perl::Critic.

=head1 SYNOPSIS

Perl::Critic::Sepp provides a few custom policies for Perl::Critic

which aim to assist you in writing friendly perl code. :-)

=head1 DESCRIPTION

Perl::Critic::Sepp provides the following policies:

=over

=item L<Perl::Critic::Policy::Sepp::ProhibitCodeTagComments>

Don't permit code tags like FIXME, TODO... in your code. [Default severity: 4]

=item L<Perl::Critic::Policy::Sepp::ProhibitUselessAssignment>

Prevent redundant assignments/initializations. [Default severity: 2]

=item L<Perl::Critic::Policy::Sepp::RequirePerlVersion>

Require at least the specified version of perl. [Default severity: 1]

=item L<Perl::Critic::Policy::Sepp::ProhibitNoPlan>

Think ahead when writing tests. [Default severity: 4]

=back

=head1 AUTHOR

Sebastian Stumpf E<lt>sepp@perlhacker.orgE<gt>

=head1 COPYRIGHT & LICENSE

Copyright 2011-2012 Sebastian Stumpf.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
