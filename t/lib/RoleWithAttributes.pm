package RoleWithAttributes;
our $VERSION = '0.16_01';

use MooseX::MethodAttributes::Role;
use namespace::clean -except => 'meta';

sub foo : AnAttr { 'foo' }

1;

