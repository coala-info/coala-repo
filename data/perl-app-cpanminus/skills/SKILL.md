---
name: perl-app-cpanminus
description: cpanminus (cpanm) is a lightweight, zero-configuration script designed to get, unpack, build, and install modules from the Comprehensive Perl Archive Network (CPAN).
homepage: https://github.com/miyagawa/cpanminus
---

# perl-app-cpanminus

## Overview

cpanminus (cpanm) is a lightweight, zero-configuration script designed to get, unpack, build, and install modules from the Comprehensive Perl Archive Network (CPAN). Unlike the traditional CPAN shell, cpanm is designed to be "fatpacked" (self-contained) and requires significantly less memory and configuration. It is the industry standard for modern Perl dependency management, providing a streamlined interface for both interactive use and automated scripts.

## Common CLI Patterns

### Basic Installation
Install a module by name, which automatically fetches the latest version from MetaCPAN:
```bash
cpanm Module::Name
```

Install a specific version or from a specific distribution:
```bash
cpanm MIYAGAWA/App-cpanminus-1.7044.tar.gz
```

### Dependency Management
Install all dependencies for a project based on a local `cpanfile`, `Makefile.PL`, or `Build.PL`:
```bash
cpanm --installdeps .
```

### Installation Targets
Install modules to a specific local library directory (useful for avoiding sudo or managing project-specific environments):
```bash
cpanm -l local/ Module::Name
```

Install to a specific base directory:
```bash
cpanm --install-base ~/perl5 Module::Name
```

### Mirror and Network Control
Force the use of a specific CPAN mirror and ignore the default MetaCPAN API:
```bash
cpanm --mirror http://cpan.cpantesters.org/ --mirror-only Module::Name
```

## Expert Tips and Best Practices

- **Skip Tests for Speed**: If you are in a trusted environment or a container build and want to speed up installation, use the `--notest` flag.
- **Metadata Inspection**: Use `cpanm --info Module::Name` to view the distribution's metadata and current version without actually downloading or installing it.
- **Security**: Use the `--verify` flag to verify the integrity of the distribution using CHECKSUMS and signatures (requires `Module::Signature`).
- **Automated Cleanup**: By default, cpanm cleans up temporary build directories. If a build fails and you need to inspect the logs, check the `~/.cpanm/work/` directory or use the `--verbose` flag to see real-time output.
- **Self-Upgrade**: You can easily upgrade cpanm itself by running `cpanm App::cpanminus`.
- **Packaging Support**: Use the `--save-dists <path>` option to archive the downloaded tarballs. This is highly useful for creating offline mirrors or reproducible builds for packaging.
- **Conditional Testing**: Use `--with-test` or `--without-test` to explicitly control the execution of test suites during the build process.

## Reference documentation
- [App::cpanminus - get, unpack, build and install modules from CPAN](./references/github_com_miyagawa_cpanminus.md)
- [perl-app-cpanminus - bioconda overview](./references/anaconda_org_channels_bioconda_packages_perl-app-cpanminus_overview.md)
- [cpanminus Wiki - Tips and Scanning Dependencies](./references/github_com_miyagawa_cpanminus_wiki.md)