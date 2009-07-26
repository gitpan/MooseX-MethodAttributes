package ClassUsingRoleWithAttributes;
our $VERSION = '0.15';

use Moose;
# FIXME - This should not have to be here.
use MooseX::MethodAttributes;

use namespace::clean -except => 'meta';

with 'RoleWithAttributes';

__PACKAGE__->meta->make_immutable;

