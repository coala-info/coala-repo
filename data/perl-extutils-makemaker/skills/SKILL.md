---
name: perl-extutils-makemaker
description: "ExtUtils::MakeMaker creates Makefiles to build, test, and install Perl modules from a Makefile.PL script. Use when user asks to create build scripts for Perl modules, generate Makefiles, manage Perl dependencies, or package Perl software for distribution."
homepage: https://metacpan.org/release/ExtUtils-MakeMaker
---


# perl-extutils-makemaker

## Overview

ExtUtils::MakeMaker (EUMM) is the standard framework for creating Makefiles used to build and install Perl modules. It transforms a `Makefile.PL` script into a standard `Makefile`, handling platform-specific configuration, dependency checking, and installation paths. Use this skill to architect robust build scripts that ensure Perl software is portable and maintainable across different environments.

## Core Workflow

The standard lifecycle for a module managed by ExtUtils::MakeMaker follows these steps:

1.  **Initialize**: Create a `Makefile.PL` script.
2.  **Configure**: Run `perl Makefile.PL` to generate the `Makefile`.
3.  **Build**: Run `make` to compile extensions and copy files to `blib/`.
4.  **Test**: Run `make test` to execute the test suite in `t/`.
5.  **Install**: Run `make install` to deploy the module to the system or local library paths.

## Makefile.PL Best Practices

A minimal, effective `Makefile.PL` should use the `WriteMakefile` function with essential metadata:

```perl
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'Your::Module::Name',
    AUTHOR           => 'Author Name <author@example.com>',
    VERSION_FROM     => 'lib/Your/Module/Name.pm',
    ABSTRACT_FROM    => 'lib/Your/Module/Name.pm',
    LICENSE          => 'perl_5',
    MIN_PERL_VERSION => '5.006',
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => '0',
    },
    TEST_REQUIRES => {
        'Test::More' => '0',
    },
    PREREQ_PM => {
        'Carp' => '0',
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Your-Module-Name-*' },
);
```

### Expert Tips

-   **Version Management**: Always use `VERSION_FROM` instead of hardcoding a version string in the `Makefile.PL`. This ensures the build system and the code stay in sync.
-   **Dependency Categories**: Distinguish between `PREREQ_PM` (runtime), `BUILD_REQUIRES` (build-time), and `TEST_REQUIRES` (testing) to allow installers like `cpanm` to optimize the environment.
-   **Conditional Metadata**: For compatibility with older versions of EUMM, wrap newer keys (like `LICENSE` or `META_MERGE`) in logic that checks `$ExtUtils::MakeMaker::VERSION`.
-   **Non-Standard Paths**: To install a module to a specific directory without root privileges, use the `PREFIX` or `INSTALL_BASE` arguments:
    `perl Makefile.PL INSTALL_BASE=/home/user/perl5`
-   **Cleaning Up**: Use the `clean` and `realclean` targets. `make clean` removes build artifacts, while `make realclean` also removes the generated `Makefile`.

## Common CLI Patterns

-   **Generate Makefile**: `perl Makefile.PL`
-   **Check for missing dependencies**: `perl Makefile.PL` (Output will list missing modules)
-   **Verbose Build**: `make VERBOSE=1`
-   **Run specific test**: `make test TEST_FILES=t/specific_test.t`
-   **Create distribution tarball**: `make dist`
-   **Manifest management**: Use `make manifest` to update the `MANIFEST` file based on the current directory contents.

## Reference documentation
- [ExtUtils::MakeMaker - Create a module Makefile](./references/metacpan_org_release_ExtUtils-MakeMaker.md)