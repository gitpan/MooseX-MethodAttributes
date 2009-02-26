use strict;
use warnings;

package BaseClass;
our $VERSION = '0.04';


use Moose;
BEGIN { extends qw/MooseX::MethodAttributes::Inheritable/; }

sub moo : Moo {}

sub affe : Birne {}

sub foo : Foo {}

sub bar : Baz {}

{
    no warnings 'redefine';
    sub moo : Moo {}
}

1;
