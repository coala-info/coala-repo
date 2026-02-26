---
name: perl-moosex-types-stringlike
description: This tool provides Moose type constraints for values that are strings or objects with overloaded stringification. Use when user asks to install the library via Bioconda or CPAN, define string-like attribute constraints in Moose classes, or build and test the module using Dist::Zilla.
homepage: https://github.com/dagolden/MooseX-Types-Stringlike
---


# perl-moosex-types-stringlike

## Overview
This skill provides procedural knowledge for working with the `MooseX::Types::Stringlike` Perl module. This library is a specialized Moose extension that provides type constraints for "string-like" data—specifically, values that are either actual strings or objects that have been overloaded to behave like strings. It is a common dependency in bioinformatics software distributed via Bioconda. Use this skill to manage the library's lifecycle, from installation and testing to implementation within Moose classes.

## Installation and Environment Setup

### Bioconda (Recommended for Bioinformatics)
Install the package within a Conda environment to ensure compatibility with other genomic tools:
```bash
conda install bioconda::perl-moosex-types-stringlike
```

### Standard Perl Toolchain
For general Perl development, use `cpanm` to handle the installation and its dependencies:
```bash
cpanm MooseX::Types::Stringlike
```

## Implementation Patterns

### Using Stringlike Constraints
The primary use case is defining Moose attributes that are flexible enough to accept objects (like `Path::Tiny` or `URI` objects) as well as standard strings.

1.  **Import the types**: Use the `MooseX::Types` syntax to import the desired constraints.
2.  **Apply to attributes**: Use `Stringlike` for general string-compatible values or `Stringable` for objects specifically implementing stringification.
3.  **Array References**: Use `ArrayRefOfStringlike` or `ArrayRefOfStringable` for validating lists of string-like data.

### Development and Testing
When contributing to or debugging a project that uses this module, follow these standard Perl patterns:

*   **Install dependencies**: Use the `cpanfile` if present in the repository.
    ```bash
    cpanm --installdeps .
    ```
*   **Execute tests**: Use `prove` to run the test suite against the local `lib` directory.
    ```bash
    prove -l
    prove -lv t/some_test.t
    ```
*   **Code Tidying**: If a `.perltidyrc` or `tidyall.ini` exists, ensure code compliance before committing.
    ```bash
    perltidy some_file.pm
    # OR
    tidyall -a
    ```

## Dist::Zilla Workflow
This module is managed using `Dist::Zilla`. If you are building the module from source or creating a distribution:

*   **Install Author Dependencies**:
    ```bash
    dzil authordeps | cpanm
    ```
*   **Build and Test**:
    ```bash
    dzil build
    dzil test
    ```
*   **Local Installation**:
    ```bash
    dzil install
    ```

## Reference documentation
- [perl-moosex-types-stringlike - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-moosex-types-stringlike_overview.md)
- [GitHub - dagolden/MooseX-Types-Stringlike: Moose type constraints for strings or string-like objects](./references/github_com_dagolden_MooseX-Types-Stringlike.md)