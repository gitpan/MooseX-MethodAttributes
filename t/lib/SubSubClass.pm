use strict;
use warnings;

package SubSubClass;
our $VERSION = '0.06';


use base qw/OtherSubClass/;

sub bar : Quux {}

1;
