use strict;
use warnings;

package SubSubClass;
our $VERSION = '0.09';


use base qw/OtherSubClass/;

sub bar : Quux {}

1;
