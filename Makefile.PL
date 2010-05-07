
use strict;
use warnings;



use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
                       'test' => {
                                   'TESTS' => 't/*.t'
                                 },
                       'NAME' => 'MooseX::MethodAttributes',
                       'DISTNAME' => 'MooseX-MethodAttributes',
                       'CONFIGURE_REQUIRES' => {
                                                 'ExtUtils::MakeMaker' => '6.31'
                                               },
                       'AUTHOR' => 'Florian Ragwitz <rafl@debian.org>, Tomas Doran <bobtfish@bobtfish.net>',
                       'BUILD_REQUIRES' => {
                                             'Test::More' => '0.88',
                                             'Test::Exception' => '0',
                                             'namespace::autoclean' => '0'
                                           },
                       'ABSTRACT' => 'code attribute introspection',
                       'EXE_FILES' => [],
                       'VERSION' => '0.21',
                       'PREREQ_PM' => {
                                        'MooseX::Types::Moose' => '0.20',
                                        'namespace::clean' => '0.10',
                                        'Moose' => '0.98'
                                      },
                       'LICENSE' => 'perl'
                     );


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM}; 
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod}; 
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



