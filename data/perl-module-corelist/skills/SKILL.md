---
name: perl-module-corelist
description: This tool queries the Module::CoreList database to determine which versions of Perl include specific modules or features. Use when user asks to check module availability in the Perl core, find the minimum Perl version required for a module, list all modules in a specific Perl release, or identify when features were introduced or deprecated.
homepage: http://dev.perl.org/
metadata:
  docker_image: "quay.io/biocontainers/perl-module-corelist:5.20260119--pl5321hdfd78af_0"
---

# perl-module-corelist

## Overview
The `perl-module-corelist` skill provides a command-line interface to the `Module::CoreList` database. It allows developers and system administrators to query the history of the Perl core distribution. By using this tool, you can verify if a specific module version is available in a target Perl installation without needing to install external dependencies from CPAN, which is critical for writing "fat-packed" scripts or maintaining legacy systems.

## Common CLI Patterns

### Querying Module Availability
To check which version of a module was first introduced or what version exists in a specific Perl release:
- `corelist Module::Name`: Shows the version of the module in all Perl releases that include it.
- `corelist -a Module::Name`: Provides a complete history of the module across all known Perl versions.

### Querying by Perl Version
To see every module included in a specific release of Perl:
- `corelist 5.38.0`: Lists all core modules for Perl 5.38.0.
- `corelist -v 5.24.1`: Lists modules specifically for the 5.24.1 revision.

### Finding Features and Deprecations
- `corelist -f FeatureName`: Find which Perl version introduced a specific feature (e.g., `signatures` or `say`).
- `corelist -d Module::Name`: Check if and when a module was deprecated from the core.

### Cross-Referencing
- `corelist Module::One Module::Two`: Compare multiple modules simultaneously.
- `corelist /Regex/`: Search for modules matching a specific pattern within the core list.

## Expert Tips
- **Portability Checks**: Before adding a `use` statement for a common module like `File::Spec` or `JSON::PP`, run `corelist` to find the minimum Perl version required to support that module without an external install.
- **Diffing Versions**: Use `corelist -diff 5.34.0 5.36.0` to quickly identify which modules were added, upgraded, or removed between two Perl releases.
- **Integration with Local Perl**: The tool uses its own internal database (updated via Bioconda or CPAN), so it can provide information about Perl versions other than the one currently running on your system.

## Reference documentation
- [Module::CoreList Overview](./references/anaconda_org_channels_bioconda_packages_perl-module-corelist_overview.md)