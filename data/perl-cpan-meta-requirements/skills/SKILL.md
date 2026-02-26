---
name: perl-cpan-meta-requirements
description: This library models and manipulates sets of version requirements for Perl distributions to ensure dependencies are correctly defined and validated. Use when user asks to manage Perl module dependencies, simplify version range constraints, or build and test Perl distributions using CPAN standards.
homepage: https://github.com/Perl-Toolchain-Gang/CPAN-Meta-Requirements
---


# perl-cpan-meta-requirements

## Overview
`perl-cpan-meta-requirements` is a library used to model and manipulate sets of version requirements for Perl distributions. It is essential for ensuring that module dependencies are correctly defined, simplified, and validated according to CPAN standards. This skill covers the installation, dependency management, and testing procedures required to work with this tool in both development and production environments.

## Installation and Environment Setup

### Conda (Bioconda)
Use the Conda package manager to install the tool in a bioinformatics or isolated environment:
```bash
conda install bioconda::perl-cpan-meta-requirements
```

### CPAN/Manual Installation
If working in a standard Perl environment, use `cpanm` to handle the library and its dependencies:
```bash
# Install the module from CPAN
cpanm CPAN::Meta::Requirements

# Install dependencies for the local source tree
cpanm --installdeps .
```

## Testing and Validation
The tool uses the standard Perl `prove` utility for testing. Always run tests after modifying requirement sets or environment configurations.

### Running Tests
```bash
# Run all tests in the t/ directory
prove -l

# Run tests with verbose output for a specific file
prove -lv t/some_test_file.t
```

## Development and Authoring Workflow
The distribution is managed with `Dist::Zilla`. Use these commands when contributing to the library or building it from source.

### Managing Author Dependencies
```bash
# Install Dist::Zilla
cpanm -n Dist::Zilla

# Install specific author dependencies for this distribution
cpan `dzil authordeps`
# OR
dzil authordeps | cpanm
```

### Build and Release Commands
```bash
# Build the distribution
dzil build

# Run standard tests
dzil test

# Run author/extended tests
dzil xtest
```

## Expert Tips
- **Version Range Simplification**: The tool is designed to simplify complex version ranges (e.g., removing unnecessary `>= 0` constraints). If you notice redundant version strings in `META` files, use this library to normalize them.
- **Vstring Handling**: When working with version strings (v-strings), ensure your environment supports them without the `B` module if you are targeting minimal Perl installations.
- **Coding Style**: Before submitting patches, use `perltidy` or `tidyall -a` to ensure the code matches the existing distribution style.

## Reference documentation
- [Anaconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-cpan-meta-requirements_overview.md)
- [GitHub Repository](./references/github_com_Perl-Toolchain-Gang_CPAN-Meta-Requirements.md)