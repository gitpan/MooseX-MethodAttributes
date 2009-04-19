
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'MooseX-MethodAttributes',
  NAME      => 'MooseX::MethodAttributes',
  AUTHOR    => 'Florian\ Ragwitz\ \<rafl\@debian\.org\>\,\ Tomas\ Doran\ \<bobtfish\@bobtfish\.net\>',
  ABSTRACT  => 'code attribute introspection',
  VERSION   => '0.06',
  EXE_FILES => [ qw() ],
  (eval { ExtUtils::MakeMaker->VERSION(6.21) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM    => {
    "namespace::clean" => '0',
    "MooseX::Types" => '0.06',
    "Moose" => '0.70',
  },
);
