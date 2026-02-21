---
name: perl-bundle-bioperl
description: This skill facilitates the deployment of the `Bundle::BioPerl` collection via the Bioconda ecosystem.
homepage: http://metacpan.org/pod/Bundle::BioPerl
---

# perl-bundle-bioperl

## Overview
This skill facilitates the deployment of the `Bundle::BioPerl` collection via the Bioconda ecosystem. It streamlines the process of satisfying complex Perl dependency chains that BioPerl requires for tasks like sequence alignment, database querying, and file format parsing. Use this when a system lacks the necessary CPAN modules to run BioPerl 1.5.2 or when you need a reproducible environment for legacy Perl scripts.

## Installation and Environment Setup
To ensure all dependencies are correctly linked within a BioPerl context, use the Bioconda channel:

```bash
# Create a dedicated environment for BioPerl tasks
conda create -n bioperl_env perl-bundle-bioperl bioperl

# Activate the environment
conda activate bioperl_env
```

## Usage Best Practices
- **Dependency Verification**: After installation, verify that the bundle has satisfied the core requirements by checking for key modules like `IO::String`, `Data::Stag`, and `XML::Parser`.
- **Module Pathing**: Ensure your `PERL5LIB` environment variable is correctly pointing to the Conda environment's site-perl directory if you are calling scripts from outside the active environment.
- **Legacy Compatibility**: Note that this bundle is specifically pinned for BioPerl 1.5.2. If using a more modern version of BioPerl (e.g., 1.7+), some modules in this bundle may be deprecated or superseded.
- **Conflict Resolution**: If you encounter "Can't locate ... in @INC" errors despite installation, use `perl -V` to inspect the library search path and confirm the Conda-installed Perl is the one being executed.

## Common CLI Patterns
To check if a specific module from the bundle is correctly installed and accessible:
```bash
perl -MModule::Name -e 'print "Installed\n"'
# Example for a common BioPerl dependency:
perl -MIO::String -e 'print "Success\n"'
```

## Reference documentation
- [BioPerl Bundle Overview](./references/anaconda_org_channels_bioconda_packages_perl-bundle-bioperl_overview.md)
- [Bundle::BioPerl CPAN Documentation](./references/metacpan_org_pod_Bundle__BioPerl.md)