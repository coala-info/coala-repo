---
name: perl-file-sharedir-install
description: File::ShareDir::Install is a specialized Perl utility designed for module authors to manage the installation of "shared" files.
homepage: https://github.com/Perl-Toolchain-Gang/File-ShareDir-Install
---

# perl-file-sharedir-install

## Overview
File::ShareDir::Install is a specialized Perl utility designed for module authors to manage the installation of "shared" files. While Perl modules (.pm files) have standard installation paths, other assets like data files or templates require specific handling so that they can be located at runtime by the companion module, File::ShareDir. This skill covers the environment setup, testing procedures, and build-tool integration necessary to manage these shared directories within the Perl toolchain.

## Installation and Environment Setup
To use or develop with this tool, ensure the environment is properly configured:

- **Conda (Bioconda):** Install the package using `conda install bioconda::perl-file-sharedir-install`.
- **CPAN/App::cpanminus:** Install directly from CPAN using `cpanm File::ShareDir::Install`.
- **Dependency Resolution:** When working on a project that uses this module, install all required dependencies with `cpanm --installdeps .` or specifically for development: `cpanm --reinstall --installdeps --with-develop --with-recommends File::ShareDir::Install`.

## Development and Testing Workflow
When modifying a Perl distribution that utilizes File::ShareDir::Install, follow these command-line patterns:

- **Run Local Tests:** Use the `prove` tool to execute tests while including the local `lib` directory.
  - Run all tests: `prove -l`
  - Run a specific test file with verbose output: `prove -lv t/filename.t`
  - Run tests recursively: `prove -lvr t/`
- **Manage with Dist::Zilla:** If the distribution uses `Dist::Zilla` (indicated by a `dist.ini` file), use the following commands:
  - Build the distribution: `dzil build`
  - Run tests: `dzil test`
  - List missing dependencies: `dzil listdeps --missing`
  - Install author-specific dependencies: `dzil authordeps --missing | cpanm`

## Best Practices for Shared Files
- **Configure Requires:** Always ensure `File::ShareDir::Install` is listed in the `configure_requires` section of your metadata (e.g., in `META.json` or `Makefile.PL`), as it must be present before the build starts.
- **Directory Mapping:** By default, the tool looks for a directory named `share/`. If using a different directory, ensure the `install_share` directive in your build script explicitly points to the correct path.
- **Parallel Testing:** If tests fail during parallel execution (e.g., `make test -j4`), use a `testrules.yml` file or the `dzil test` command to manage test serialization, as shared file access can sometimes cause race conditions in test environments.
- **Clean Namespaces:** When writing tests for this module, avoid importing symbols directly to keep the namespace clean; call functions using the full package name if necessary.

## Reference documentation
- [File-ShareDir-Install GitHub Repository](./references/github_com_Perl-Toolchain-Gang_File-ShareDir-Install.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-file-sharedir-install_overview.md)