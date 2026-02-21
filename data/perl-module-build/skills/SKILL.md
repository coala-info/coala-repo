---
name: perl-module-build
description: This skill provides guidance for managing Perl software distributions using the `Module::Build` system.
homepage: http://metacpan.org/pod/Module-Build
---

# perl-module-build

## Overview
This skill provides guidance for managing Perl software distributions using the `Module::Build` system. Unlike traditional `make`-based installations, this tool uses a Perl script named `Build` to handle the entire lifecycle of a module, from configuration and compilation to testing and installation. It is particularly useful for cross-platform Perl development where a C compiler or `make` utility might not be available.

## Core Workflow
The standard lifecycle for a `Module::Build` project follows these four steps:

1.  **Configuration**: Generate the `Build` script.
    `perl Build.PL`
2.  **Build**: Compile and prepare files.
    `./Build`
3.  **Test**: Run the test suite.
    `./Build test`
4.  **Install**: Install to the system or a specified library path.
    `./Build install`

## Common CLI Patterns

### Custom Installation Paths
To install a module to a specific directory (e.g., a local library or home directory) without root privileges:
`perl Build.PL --install_base /path/to/dir`

### Handling Dependencies
To check for missing dependencies without proceeding to build:
`perl Build.PL --check_install`

### Testing Options
*   **Verbose testing**: See individual test results.
    `./Build test verbose=1`
*   **Run specific tests**:
    `./Build test --test_files t/specific_test.t`

### Cleaning the Environment
To remove temporary build files and the `Build` script:
`./Build realclean`

## Expert Tips
*   **Action Arguments**: You can pass arguments to specific actions. For example, to skip the manpage generation during installation:
    `./Build install --install_path libdoc= --install_path bindoc=`
*   **Batch Processing**: You can chain commands in a single line:
    `perl Build.PL && ./Build && ./Build test && ./Build install`
*   **Environment Variables**: `Module::Build` respects `PERL_MB_OPT` for default command-line arguments. If you frequently install to a local path, set this in your shell profile:
    `export PERL_MB_OPT="--install_base /home/user/perl5"`

## Reference documentation
- [Module::Build Documentation](./references/metacpan_org_pod_Module-Build.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-module-build_overview.md)