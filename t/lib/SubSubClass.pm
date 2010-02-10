use strict;
use warnings;

package SubSubClass;
our $VERSION = '0.20';

use base qw/OtherSubClass/;

sub meta { 'foo' } # Test having a meta method..

sub bar : Quux {}

1;
