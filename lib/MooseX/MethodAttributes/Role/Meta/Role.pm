package MooseX::MethodAttributes::Role::Meta::Role;
our $VERSION = '0.11_01';

# ABSTRACT: metarole role for storing code attributes

use Moose::Util::MetaRole;
use Moose::Util qw/find_meta ensure_all_roles/;
use Carp qw/croak/;

use Moose::Role;

use namespace::clean -except => 'meta';


with qw/
    MooseX::MethodAttributes::Role::Meta::Map
/;

after 'initialize' => sub {
    my ($self, $class, %args) = @_;
    ensure_all_roles($class, 'MooseX::MethodAttributes::Role::AttrContainer');
};

around method_metaclass => sub {
    my $orig = shift;
    my $self = shift;
    return $self->$orig(@_) if scalar @_;
    Moose::Meta::Class->create_anon_class(
        superclasses => [ $self->$orig ],
        roles        => [qw/
            MooseX::MethodAttributes::Role::Meta::Method
        /],
        cache        => 1,
    )->name();
};

before 'apply' => sub {
    my ($self, $thing) = @_;
    if ($thing->isa('Moose::Meta::Class')) {
        Moose::Util::MetaRole::apply_metaclass_roles(
            for_class => $thing->name,
            metaclass_roles => ['MooseX::MethodAttributes::Role::Meta::Class'],
            method_metaclass_roles => ['MooseX::MethodAttributes::Role::Meta::Method'],
            wrapped_method_metaclass_roles => ['MooseX::MethodAttributes::Role::Meta::Method::MaybeWrapped'],
        );
    }
    elsif ($thing->isa('Moose::Meta::Role')) {
        # No need to interfere with normal composition?
    }
    else {
        croak("Composing " . __PACKAGE__ . " onto instances is unsupported");
    }
};

after 'apply' => sub {
    my ($self, $thing) = @_;
    # Note that the metaclass instance we started out with may have been turned
    # into lies by the role application process, so we explicitly re-fetch it
    # here.
    my $meta = find_meta($thing->name);
    push @{ $meta->_method_attribute_list }, @{ $self->_method_attribute_list };
    @{ $meta->_method_attribute_map }{ keys(%{ $self->_method_attribute_map }) }
        = values %{ $self->_method_attribute_map };
};

1;


__END__
=head1 NAME

MooseX::MethodAttributes::Role::Meta::Role - metarole role for storing code attributes

=head1 VERSION

version 0.11_01

=head1 SYNOPSIS

    package MyRole;
    use Moose::Role -traits => 'MooseX::MethodAttributes::Role::Meta::Role';

    sub foo : Bar Baz('corge') { ... }

    package MyClass
    use Moose;

    with 'MyRole';

    my $attrs = MyClass->meta->get_method('foo')->attributes; # ["Bar", "Baz('corge')"]

=head1 DESCRIPTION

This module allows you to add code attributes to methods in Moose roles.

These attributes can then be found later once the methods are composed
into a class.

=head1 AUTHORS

  Florian Ragwitz <rafl@debian.org>
  Tomas Doran <bobtfish@bobtfish.net>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Florian Ragwitz.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

