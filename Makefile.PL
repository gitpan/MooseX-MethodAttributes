
use strict;
use warnings;



use ExtUtils::MakeMaker 6.11;



my %WriteMakefileArgs = (
                       'test' => {
                                   'TESTS' => 't/*.t'
                                 },
                       'NAME' => 'MooseX::MethodAttributes',
                       'DISTNAME' => 'MooseX-MethodAttributes',
                       'AUTHOR' => 'Florian Ragwitz <rafl@debian.org>, Tomas Doran <bobtfish@bobtfish.net>',
                       'ABSTRACT' => 'code attribute introspection',
                       'EXE_FILES' => [],
                       'VERSION' => '0.20',
                       'LICENSE' => 'perl',
                       'PREREQ_PM' => {
                                        'namespace::clean' => '0.10',
                                        'Test::More' => '0.88',
                                        'namespace::autoclean' => '0',
                                        'Test::Exception' => '0',
                                        'MooseX::Types' => '0.20',
                                        'ExtUtils::MakeMaker' => '6.11',
                                        'Moose' => '0.97'
                                      }
                     );


delete $WriteMakefileArgs{LICENSE}
  unless eval { ExtUtils::MakeMaker->VERSION(6.31) };

WriteMakefile(%WriteMakefileArgs);



