use strict;
use warnings;

package SubClass;
our $VERSION = '0.04';


use base qw/BaseClass/;

sub bar : Bar {}

use Moose;
before affe => sub {};
no Moose;

1;
