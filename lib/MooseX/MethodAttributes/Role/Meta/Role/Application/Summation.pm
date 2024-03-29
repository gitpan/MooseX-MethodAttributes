package MooseX::MethodAttributes::Role::Meta::Role::Application::Summation;
{
  $MooseX::MethodAttributes::Role::Meta::Role::Application::Summation::VERSION = '0.29';
}
BEGIN {
  $MooseX::MethodAttributes::Role::Meta::Role::Application::Summation::AUTHORITY = 'cpan:FLORA';
}
# ABSTRACT: Role applied to the class responsible for role summation which ensures method attributes propagate from the roles being summed onto the combined role.

use Moose::Role;
use Moose::Util qw/does_role/;
use namespace::autoclean;

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

=encoding UTF-8

=for :stopwords Florian Ragwitz Tomas Doran Dave Karman (t0m) Rolsky David Steinbrunner
Karen Etheridge Marcus Ramberg Peter E

=head1 NAME

MooseX::MethodAttributes::Role::Meta::Role::Application::Summation - Role applied to the class responsible for role summation which ensures method attributes propagate from the roles being summed onto the combined role.

=head1 VERSION

version 0.29

=head1 AUTHORS

=over 4

=item *

Florian Ragwitz <rafl@debian.org>

=item *

Tomas Doran <bobtfish@bobtfish.net>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Florian Ragwitz.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
