package MooseX::MethodAttributes::Role::Meta::Role::Application::Summation;
our $VERSION = '0.16_01';

use Moose::Role;
use Moose::Util qw/does_role/;
use namespace::clean -except => 'meta';

with 'MooseX::MethodAttributes::Role::Meta::Role::Application';

sub _copy_attributes {
    my ($self, $thing) = @_;
    for my $role (@{ $self->get_roles }) {
        $role->_copy_attributes($thing)
            if does_role($role, 'MooseX::MethodAttributes::Role::Meta::Role');
    }
}

1;

__END__

=pod

=head1 NAME

MooseX::MethodAttributes::Role::Meta::Role::Application::Summation

=head1 VERSION

version 0.16_01

=head1 AUTHORS

  Florian Ragwitz <rafl@debian.org>
  Tomas Doran <bobtfish@bobtfish.net>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Florian Ragwitz.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 


