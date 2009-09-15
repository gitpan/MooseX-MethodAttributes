package OtherRoleWithAttributes;
our $VERSION = '0.16';

use Moose::Role -traits => 'MethodAttributes';
use namespace::clean -except => 'meta';

sub bar : AnAttr { 'bar' }

1;

