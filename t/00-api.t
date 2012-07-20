#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Perl::Critic::TestUtils qw/bundled_policy_names/;

Perl::Critic::TestUtils::block_perlcriticrc();
my @bundle = bundled_policy_names();

my @queue = (
    sub { use_ok(shift) },
    sub { can_ok(shift, 'supported_parameters') },
    sub { can_ok(shift, 'default_severity') },
    sub { can_ok(shift, 'default_themes') },
    sub { can_ok(shift, 'applies_to') },
    sub { can_ok(shift, 'violates') },
    sub { can_ok(shift, 'new') },

    sub { can_ok(shift, 'get_severity') },
    sub { can_ok(shift, 'set_severity') },
    sub { can_ok(shift, 'get_themes') },
    sub { can_ok(shift, 'set_themes') },
    sub { can_ok(shift, 'violation') },

    sub {
        my $pol = shift->new;
        isa_ok($pol, 'Perl::Critic::Policy');
    }
);

plan tests => scalar(@bundle) * scalar(@queue);

foreach my $mod (@bundle) {
    $_->($mod) for @queue;
}
