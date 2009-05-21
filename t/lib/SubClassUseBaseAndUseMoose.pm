use strict;
use warnings;

package SubClassUseBaseAndUseMoose;
our $VERSION = '0.11_02';


use base qw/BaseClass/;

use Moose;

sub bar : Bar {}

before affe => sub {};
no Moose;

1;
