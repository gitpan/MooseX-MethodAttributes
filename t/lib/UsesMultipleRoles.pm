package UsesMultipleRoles;
our $VERSION = '0.16';

use Moose;
use namespace::clean -except => 'meta';

with qw/
    RoleWithAttributes
    OtherRoleWithAttributes
/;

__PACKAGE__->meta->make_immutable;

