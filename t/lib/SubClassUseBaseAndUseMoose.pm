use strict;
use warnings;

package SubClassUseBaseAndUseMoose;
our $VERSION = '0.08';


use base qw/BaseClass/;

use Moose;

sub bar : Bar {}

before affe => sub {};
no Moose;

1;