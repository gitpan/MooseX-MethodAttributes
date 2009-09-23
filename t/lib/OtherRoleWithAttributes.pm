package OtherRoleWithAttributes;
our $VERSION = '0.17';

use MooseX::MethodAttributes::Role;
use namespace::clean -except => 'meta';

sub bar : AnAttr { 'bar' }

1;

