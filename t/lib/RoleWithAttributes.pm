package RoleWithAttributes;
our $VERSION = '0.13';

use Moose::Role -traits => 'MethodAttributes';
use namespace::clean -except => 'meta';

sub foo : AnAttr { 'foo' }

1;

