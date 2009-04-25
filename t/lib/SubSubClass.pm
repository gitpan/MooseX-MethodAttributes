use strict;
use warnings;

package SubSubClass;
our $VERSION = '0.08';


use base qw/OtherSubClass/;

sub bar : Quux {}

1;
