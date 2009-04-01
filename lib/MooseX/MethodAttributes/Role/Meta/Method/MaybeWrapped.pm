package MooseX::MethodAttributes::Role::Meta::Method::MaybeWrapped;
our $VERSION = '0.05';

# ABSTRACT: proxy attributes of wrapped methods if their metaclass supports it

use Moose::Role;
use Moose::Util qw/does_role/;
use MooseX::MethodAttributes::Role::Meta::Method::Wrapped;

use namespace::clean -except => 'meta';

override wrap => sub {
    my $self = super;
    if (does_role($self->get_original_method, 'MooseX::MethodAttributes::Role::Meta::Method')) {
        MooseX::MethodAttributes::Role::Meta::Method::Wrapped->meta->apply($self);
    }
    return $self;
};

1;

__END__
=head1 NAME

MooseX::MethodAttributes::Role::Meta::Method::MaybeWrapped - proxy attributes of wrapped methods if their metaclass supports it

=head1 VERSION

version 0.05

=head1 AUTHOR

  Florian Ragwitz <rafl@debian.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Florian Ragwitz.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

