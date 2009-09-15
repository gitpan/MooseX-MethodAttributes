use strict;
use warnings;

package OtherSubClass;
our $VERSION = '0.16';

use base qw/BaseClass/;

# Must stay empty so that neither this class,
# nor SubSubClass has a metaclass when we invoke
# the attribute code.

1;

