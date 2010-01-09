package RoleWithAttributes;
our $VERSION = '0.19';
use MooseX::MethodAttributes::Role;
use namespace::clean -except => 'meta';

sub foo : AnAttr { 'foo' }

sub fnord {}

after 'fnord' => sub {}; # Just test we get the Moose::Role sugar

1;

