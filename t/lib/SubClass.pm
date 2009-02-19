use strict;
use warnings;

package SubClass;
our $VERSION = '0.03';


use base qw/BaseClass/;

sub bar : Bar {}

1;
