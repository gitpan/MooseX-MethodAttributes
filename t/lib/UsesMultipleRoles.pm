package UsesMultipleRoles;
our $VERSION = '0.14_01';

use Moose;
use namespace::clean -except => 'meta';

with qw/
    RoleWithAttributes
    OtherRoleWithAttributes
/;

__PACKAGE__->meta->make_immutable;

