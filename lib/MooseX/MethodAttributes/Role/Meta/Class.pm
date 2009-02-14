package MooseX::MethodAttributes::Role::Meta::Class;
our $VERSION = '0.02';

# ABSTRACT: metaclass role for storing code attributes

use Moose::Role;
use MooseX::Types::Moose qw/HashRef/;

use namespace::clean -except => 'meta';

has _method_attribute_map => (
    is => 'ro',
    isa => HashRef,
    lazy => 1,
    default => sub { +{} },
);


sub register_method_attributes {
    my ($self, $code, $attrs) = @_;
    $self->_method_attribute_map->{ 0 + $code } = $attrs;
    return;
}


sub get_method_attributes {
    my ($self, $code) = @_;
    return $self->_method_attribute_map->{ 0 + $code };
}

1;

__END__
=head1 NAME

MooseX::MethodAttributes::Role::Meta::Class - metaclass role for storing code attributes

=head1 VERSION

version 0.02

=head1 METHODS

=head2 register_method_attributes ($code, $attrs)

Register a list of attributes for a code reference.



=head2 get_method_attributes ($code)

Get a list of attributes associated with a coderef.

=head1 AUTHOR

  Florian Ragwitz <rafl@debian.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Florian Ragwitz.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

