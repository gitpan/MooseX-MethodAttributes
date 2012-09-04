# NAME

MooseX::MethodAttributes - code attribute introspection

# SYNOPSIS

    package MyClass;

    use Moose;
    use MooseX::MethodAttributes;

    sub foo : Bar Baz('corge') { ... }

    my $attrs = MyClass->meta->get_method('foo')->attributes; # ["Bar", "Baz('corge')"]

# DESCRIPTION

This module allows code attributes of methods to be introspected using Moose
meta method objects.

# AUTHORS

- Florian Ragwitz <rafl@debian.org>
- Tomas Doran <bobtfish@bobtfish.net>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Florian Ragwitz.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
