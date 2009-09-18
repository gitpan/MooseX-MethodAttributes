package OtherRoleWithAttributes;
our $VERSION = '0.16_01';

use MooseX::MethodAttributes::Role;
use namespace::clean -except => 'meta';

sub bar : AnAttr { 'bar' }

1;

