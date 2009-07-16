
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'MooseX-MethodAttributes',
  NAME      => 'MooseX::MethodAttributes',
  AUTHOR    => 'Florian\ Ragwitz\ \<rafl\@debian\.org\>\,\ Tomas\ Doran\ \<bobtfish\@bobtfish\.net\>',
  ABSTRACT  => 'code attribute introspection',
  VERSION   => '0.14_01',
  EXE_FILES => [ qw() ],
  (eval { ExtUtils::MakeMaker->VERSION(6.21) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM    => {
    "Test::More" => '0',
    "namespace::clean" => '0',
    "Test::Exception" => '0',
    "MooseX::Types" => '0.06',
    "Moose" => '0.79',
  },
);
