use strict;
use warnings;

package BaseClass;
our $VERSION = '0.02';


use Moose;
BEGIN { extends qw/MooseX::MethodAttributes::Inheritable/; }

sub foo : Foo {}

1;
