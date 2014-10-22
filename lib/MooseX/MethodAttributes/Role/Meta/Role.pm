package MooseX::MethodAttributes::Role::Meta::Role;
our $VERSION = '0.16';

# ABSTRACT: metarole role for storing code attributes

use Moose::Util::MetaRole;
use Moose::Util qw/find_meta does_role ensure_all_roles/;
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

around 'apply' => sub {
    my ($orig, $self, $thing, %opts) = @_;
    die("MooseX::MethodAttributes does not currently support method exclusion or aliasing.")
        if ($opts{alias} or $opts{exclude});
    if ($thing->isa('Moose::Meta::Class')) {
        unless (
           does_role($thing, 'MooseX::MethodAttributes::Role::Meta::Class')
        && does_role($thing->method_metaclass, 'MooseX::MethodAttributes::Role::Meta::Method')
        && does_role($thing->wrapped_method_metaclass, 'MooseX::MethodAttributes::Role::Meta::Method::MaybeWrapped')) {
            $thing = Moose::Util::MetaRole::apply_metaclass_roles(
                for_class => $thing->name,
                metaclass_roles => ['MooseX::MethodAttributes::Role::Meta::Class'],
                method_metaclass_roles => ['MooseX::MethodAttributes::Role::Meta::Method'],
                wrapped_method_metaclass_roles => ['MooseX::MethodAttributes::Role::Meta::Method::MaybeWrapped'],
            );
        }
    }
    elsif ($thing->isa('Moose::Meta::Role')) {
        unless (
            does_role( $thing->meta->name, __PACKAGE__ )
        ) {
            $thing = Moose::Util::MetaRole::apply_metaclass_roles(
                for_class       => $thing->name,
                metaclass_roles => [ __PACKAGE__ ],
            );
        }
        ensure_all_roles($thing->name,
            'MooseX::MethodAttributes::Role::AttrContainer',
        );
    }
    else {
        croak("Composing " . __PACKAGE__ . " onto instances is unsupported");
    }

    # Note that the metaclass instance we started out with may have been turned
    # into lies by the metatrait role application process, so we explicitly
    # re-fetch it here.

    # Alternatively, for epic shits and giggles, the meta trait application
    # process (onto $thing) may have applied roles to our metaclass, but (if
    # $thing is an anon class, not correctly replaced it in the metaclass cache.
    # This results in the DESTROY method in Class::MOP::Class r(eap|ape)ing the
    # package, which is unfortunate, as it removes all your methods and superclasses.
    # Therefore, we avoid that by ramming the metaclass we've just been handed into
    # the cache without weakening it.

    # I'm fairly sure the 2nd part of that is a Moose bug, and should go away..
    # Unfortunately, the implication of that is that whenever you apply roles to a class,
    # the metaclass instance can change, and so needs to be re-retrieved or handed back
    # to the caller :/
    if ($thing->can('is_anon_class') and $thing->is_anon_class) {
        Class::MOP::store_metaclass_by_name($thing->name, $thing);
    }
    else {
        $thing = find_meta($thing->name);
    }

    my $ret = $self->$orig($thing, %opts);

    push @{ $thing->_method_attribute_list }, @{ $self->_method_attribute_list };
    @{ $thing->_method_attribute_map }{ (keys(%{ $self->_method_attribute_map }), keys(%{ $thing->_method_attribute_map })) }
        = (values(%{ $self->_method_attribute_map }), values(%{ $thing->_method_attribute_map }));

    return $ret;
};

package # Hide from PAUSE
    Moose::Meta::Role::Custom::Trait::MethodAttributes;

sub register_implementation { 'MooseX::MethodAttributes::Role::Meta::Role' }

1;


__END__

=pod

=head1 NAME

MooseX::MethodAttributes::Role::Meta::Role - metarole role for storing code attributes

=head1 VERSION

version 0.16

=head1 SYNOPSIS

    package MyRole;
    use Moose::Role -traits => 'MethodAttributes';

    sub foo : Bar Baz('corge') { ... }

    package MyClass
    use Moose;

    with 'MyRole';

    my $attrs = MyClass->meta->get_method('foo')->attributes; # ["Bar", "Baz('corge')"]

=head1 DESCRIPTION

This module allows you to add code attributes to methods in Moose roles.

These attributes can then be found later once the methods are composed
into a class.

=head1 CAVEATS

=over 

=item *

Currently roles with attributes cannot have methods excluded
or aliased, and will in turn confer this property onto any roles they
are composed onto.

=item *

Composing multiple roles with attributes onto a class at once will fail
to work as expected, therefore conflict resolution cannot be taken advantage
of.

=back 



=head1 AUTHORS

  Florian Ragwitz <rafl@debian.org>
  Tomas Doran <bobtfish@bobtfish.net>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Florian Ragwitz.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 


