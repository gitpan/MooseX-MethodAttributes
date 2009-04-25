package MooseX::MethodAttributes::Role::Meta::Class;
our $VERSION = '0.07';

# ABSTRACT: metaclass role for storing code attributes

use Moose::Role;
use Moose::Util qw/find_meta/;
use MooseX::Types::Moose qw/HashRef ArrayRef Str Int/;

use namespace::clean -except => 'meta';

has _method_attribute_map => (
    is        => 'ro',
    isa       => HashRef[ArrayRef[Str]],
    lazy      => 1,
    default   => sub { +{} },
);

has _method_attribute_list => (
    is      => 'ro',
    isa     => ArrayRef[Int],
    lazy    => 1,
    default => sub { [] },
);


sub register_method_attributes {
    my ($self, $code, $attrs) = @_;
    push @{ $self->_method_attribute_list }, 0 + $code;
    $self->_method_attribute_map->{ 0 + $code } = $attrs;
    return;
}


sub get_method_attributes {
    my ($self, $code) = @_;
    return $self->_method_attribute_map->{ 0 + $code } || [];
}


sub get_method_with_attributes_list {
    my ($self) = @_;
    my @methods = values %{ $self->get_method_map };
    my %order;

    {
        my $i = 0;
        $order{$_} = $i++ for @{ $self->_method_attribute_list };
    }

    return map {
        $_->[1]
    } sort {
        $order{ $a->[0] } <=> $order{ $b->[0] }
    } map {
        my $addr = 0 + $_->_get_attributed_coderef;
        exists $self->_method_attribute_map->{$addr}
            ? [$addr, $_]
            : ()
    } grep { $_->can('_get_attributed_coderef') } @methods;
}


sub get_all_methods_with_attributes {
    my ($self) = @_;
    my %seen;

    return reverse grep {
        !$seen{ $_->name }++
    } reverse map {
        my $meth;
        my $meta = find_meta($_);
        ($meta && ($meth = $meta->can('get_method_with_attributes_list')))
            ? $meta->$meth
            : ()
    } reverse $self->linearized_isa
}


sub get_nearest_methods_with_attributes {
    my ($self) = @_;
    
    grep { 
        scalar @{ $self->find_method_by_name($_->name)->attributes }
    } $self->get_all_methods_with_attributes;
}

1;


__END__
=head1 NAME

MooseX::MethodAttributes::Role::Meta::Class - metaclass role for storing code attributes

=head1 VERSION

version 0.07

=head1 METHODS

=head2 register_method_attributes ($code, $attrs)

Register a list of attributes for a code reference.



=head2 get_method_attributes ($code)

Get a list of attributes associated with a coderef.



=head2 get_method_with_attributes_list

Gets the list of meta methods for local methods of this class that have
attributes in the order they have been registered.



=head2 get_all_methods_with_attributes

Gets the list of meta methods of local and inherited methods of this class,
that have attributes. Baseclass methods come before subclass methods. Methods
of one class have the order they have been declared in.



=head2 get_nearest_methods_with_attributes

The same as get_all_methods_with_attributes, except that methods from parent classes
are not included if there is an attributeless method in a child class.

For example, given:

    package BaseClass;

    sub foo : Attr {}

    package SubClass;
    use base qw/BaseClass/;

    sub foo {}

C<< SubClass->meta->get_all_methods_with_attributes >> will return 
C<< BaseClass->meta->get_method('foo') >> for the above example, but
this method will not.

=head1 AUTHORS

  Florian Ragwitz <rafl@debian.org>
  Tomas Doran <bobtfish@bobtfish.net>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Florian Ragwitz.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

