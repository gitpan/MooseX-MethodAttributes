package RoleWithAttributes;
our $VERSION = '0.11_01';

use Moose::Role -traits => 'MooseX::MethodAttributes::Role::Meta::Role';
use namespace::clean -except => 'meta';

sub foo : AnAttr { 'foo' }

1;

