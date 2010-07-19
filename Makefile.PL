
use strict;
use warnings;



use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'code attribute introspection',
  'AUTHOR' => 'Florian Ragwitz <rafl@debian.org>, Tomas Doran <bobtfish@bobtfish.net>',
  'BUILD_REQUIRES' => {
    'Test::Exception' => '0',
    'Test::More' => '0.88',
    'namespace::autoclean' => '0'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.31'
  },
  'DISTNAME' => 'MooseX-MethodAttributes',
  'EXE_FILES' => [],
  'LICENSE' => 'perl',
  'NAME' => 'MooseX::MethodAttributes',
  'PREREQ_PM' => {
    'Moose' => '0.98',
    'MooseX::Types::Moose' => '0.21',
    'namespace::clean' => '0.10'
  },
  'VERSION' => '0.24',
  'test' => {
    'TESTS' => 't/*.t'
  }
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



