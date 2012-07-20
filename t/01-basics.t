#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

use Perl::Critic::TestUtils qw/pcritique/;
Perl::Critic::TestUtils::block_perlcriticrc();

my %tests = (
    'Perl::Critic::Policy::Sepp::ProhibitCodeTagComments' => [
        [ q{ # XXX:      }, 1 ],
        [ q{ #TODO       }, 1 ],
        [ q{ FIXME->() # }, 0 ],
        [ q{ "BUG" #     }, 0 ],
    ],
    'Perl::Critic::Policy::Sepp::ProhibitNoPlan' => [
        [ q{ use Test::More qw(no_plan) }, 1 ],
        [ q{ use Test::More 'no_plan'   }, 1 ],
        [ q{ no Guts qw(no_plan)        }, 0 ],
    ],
    'Perl::Critic::Policy::Sepp::ProhibitUselessAssignment' => [
        [ q{ my $x = undef;         }, 1 ],
        [ q{ my %x = ( ); my %y=(); }, 2 ],
        [ q{ my @x = ( ); my @y=(); }, 2 ],
    ],
    'Perl::Critic::Policy::Sepp::RequirePerlVersion' => [
        [ q{ use v5.10; use 5.010; }, 2 ],
        [ q{ use v5.12; use 5.012; }, 0 ],
        [ q{ use v5.14; use 5.014; }, 0 ],
    ]
);

while (my ($policy, $set) = each %tests) {
    foreach my $ref (@$set) {
        is( pcritique ($policy, \$ref->[0]), $ref->[1], $policy);
    }
}

done_testing;
