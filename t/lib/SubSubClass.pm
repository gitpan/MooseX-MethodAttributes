use strict;
use warnings;

package SubSubClass;
our $VERSION = '0.11_03';


use base qw/OtherSubClass/;

sub meta { 'foo' } # Test having a meta method..

sub bar : Quux {}

1;
