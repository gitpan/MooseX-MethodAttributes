use strict;
use warnings;

package SubClass;
our $VERSION = '0.06';


use Moose;
BEGIN { extends 'BaseClass'; }

sub bar : Bar {}

before affe => sub {};
no Moose;

1;
