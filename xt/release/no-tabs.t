use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::NoTabs 0.05

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'lib/MooseX/MethodAttributes.pm',
    'lib/MooseX/MethodAttributes/Inheritable.pm',
    'lib/MooseX/MethodAttributes/Role.pm',
    'lib/MooseX/MethodAttributes/Role/AttrContainer.pm',
    'lib/MooseX/MethodAttributes/Role/AttrContainer/Inheritable.pm',
    'lib/MooseX/MethodAttributes/Role/Meta/Class.pm',
    'lib/MooseX/MethodAttributes/Role/Meta/Map.pm',
    'lib/MooseX/MethodAttributes/Role/Meta/Method.pm',
    'lib/MooseX/MethodAttributes/Role/Meta/Method/MaybeWrapped.pm',
    'lib/MooseX/MethodAttributes/Role/Meta/Method/Wrapped.pm',
    'lib/MooseX/MethodAttributes/Role/Meta/Role.pm',
    'lib/MooseX/MethodAttributes/Role/Meta/Role/Application.pm',
    'lib/MooseX/MethodAttributes/Role/Meta/Role/Application/Summation.pm'
);

notabs_ok($_) foreach @files;
done_testing;
