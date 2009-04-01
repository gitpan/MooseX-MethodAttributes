package MooseX::MethodAttributes::Inheritable;
our $VERSION = '0.05';

# ABSTRACT: inheritable code attribute introspection


use Moose;

use namespace::clean -except => 'meta';

with 'MooseX::MethodAttributes::Role::AttrContainer::Inheritable';

__PACKAGE__->meta->make_immutable;

1;

__END__
=head1 NAME

MooseX::MethodAttributes::Inheritable - inheritable code attribute introspection

=head1 VERSION

version 0.05

=head1 SYNOPSIS

    package BaseClass;
    use base qw/MooseX::MethodAttributes::Inheritable/;

    package SubClass;
    use base qw/SubClass/;

    sub foo : Bar {}

    my $attrs = SubClass->meta->get_method('foo')->attributes; # ["Bar"]

=head1 DESCRIPTION

This module does the same as C<MooseX::MethodAttributes>, except that classes
inheriting from other classes using it don't need to do anything special to get
their code attributes captured.

=head1 AUTHOR

  Florian Ragwitz <rafl@debian.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Florian Ragwitz.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

