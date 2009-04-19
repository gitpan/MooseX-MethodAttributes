use strict;
use warnings;

package SubClassMoosed;
our $VERSION = '0.06';


use base qw/BaseClass/;

use Moose;

sub bar : Bar {}

before affe => sub {};
no Moose;

1;
