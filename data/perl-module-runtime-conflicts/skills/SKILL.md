---
name: perl-module-runtime-conflicts
description: The perl-module-runtime-conflicts skill provides guidance on managing a specialized Perl utility designed to detect incompatibilities introduced by specific versions of Module::Runtime.
homepage: https://github.com/karenetheridge/Module-Runtime-Conflicts
---

# perl-module-runtime-conflicts

## Overview
The perl-module-runtime-conflicts skill provides guidance on managing a specialized Perl utility designed to detect incompatibilities introduced by specific versions of Module::Runtime. This tool is primarily used to ensure that the Moose object system and its dependencies remain functional after library updates. It acts as a diagnostic layer that can be invoked via the command line or within Perl scripts to prevent runtime failures caused by known "breaks" in the Perl toolchain.

## Installation
Install the module via Bioconda to ensure all system dependencies are met:

```bash
conda install bioconda::perl-module-runtime-conflicts
```

## Usage Patterns

### Command Line Diagnostics
The most common way to utilize this skill is through the `moose-outdated` command. This utility uses the conflict data to check your current environment for modules that need upgrading due to Module::Runtime changes.

```bash
# Check for outdated modules and conflicts in the current environment
moose-outdated
```

### Programmatic Conflict Checking
If you are developing or maintaining a Perl application and suspect environment instability, you can force a conflict check within your code or via a one-liner:

```bash
# Run a check from the command line
perl -MModule::Runtime::Conflicts -e 'Module::Runtime::Conflicts->check_conflicts'
```

## Best Practices
- **Environment Audits**: Run `moose-outdated` immediately after updating `Module::Runtime` or `Moose` to catch regressions early.
- **Dependency Management**: If `check_conflicts` identifies an issue, prioritize updating the specific modules listed in the output rather than performing a blanket update of all Perl modules.
- **Troubleshooting Moose**: If a Moose-based application fails with cryptic errors after a system update, use this tool first to rule out the known `Module::Runtime` version 0.014 incompatibility.

## Reference documentation
- [github_com_karenetheridge_Module-Runtime-Conflicts.md](./references/github_com_karenetheridge_Module-Runtime-Conflicts.md)
- [anaconda_org_channels_bioconda_packages_perl-module-runtime-conflicts_overview.md](./references/anaconda_org_channels_bioconda_packages_perl-module-runtime-conflicts_overview.md)