use strict;
use warnings;

package SubClass;
our $VERSION = '0.02';


use base qw/BaseClass/;

sub bar : Bar {}

1;
