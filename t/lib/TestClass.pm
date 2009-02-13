package TestClass;
our $VERSION = '0.01';


use Moose;
use MooseX::MethodAttributes;

sub foo : SomeAttribute AnotherAttribute('with argument') {}

package SubClass;
our $VERSION = '0.01';


use Moose;
use MooseX::MethodAttributes;

extends qw/TestClass/;

sub foo : Attributes Attributes Attributes {}

1;
