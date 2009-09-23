package TestClass;
our $VERSION = '0.17';


use Moose;
use MooseX::MethodAttributes;

sub foo : SomeAttribute AnotherAttribute('with argument') {}

sub bar : SomeAttribute {}

after foo => sub {};

package SubClass;
our $VERSION = '0.17';


use Moose;
use MooseX::MethodAttributes;

extends qw/TestClass/;

sub foo : Attributes Attributes Attributes {}

sub bar {}  # no attribute!

1;
