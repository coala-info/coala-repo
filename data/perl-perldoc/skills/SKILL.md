---
name: perl-perldoc
description: The `perl-perldoc` skill provides a streamlined interface for interacting with Perl's extensive documentation system.
homepage: http://metacpan.org/pod/Perldoc
---

# perl-perldoc

## Overview
The `perl-perldoc` skill provides a streamlined interface for interacting with Perl's extensive documentation system. It allows for the retrieval of documentation for the Perl core, installed modules, and specific language features. This tool is essential for developers needing immediate access to API references, module usage examples, and deep-dives into Perl syntax without leaving the terminal environment.

## Core Usage Patterns

### Basic Documentation Retrieval
- **Module Docs**: `perldoc Module::Name` (e.g., `perldoc File::Spec`)
- **Built-in Functions**: `perldoc -f function_name` (e.g., `perldoc -f print`)
- **Language FAQs**: `perldoc -q keyword` (searches the Perl FAQ for the specified term)
- **Core Tutorials**: `perldoc perlreftut` (references), `perldoc perlretut` (regex), etc.

### Advanced Navigation and Output
- **View Source**: `perldoc -m Module::Name` (displays the raw code/module source instead of formatted POD)
- **Find File Path**: `perldoc -l Module::Name` (returns the absolute path to the module file)
- **Search Headers**: `perldoc -v '$VARIABLE'` (lookup predefined Perl variables like `perldoc -v '$.'`)
- **Plain Text Output**: `perldoc -t Module::Name` (outputs to STDOUT without using a pager)

### Expert Tips
- **Case Sensitivity**: By default, `perldoc` is case-sensitive for module names. Use `-i` for case-insensitive searching if the exact name is unknown.
- **Specific Sections**: Use `-v` to look up specific Perl configuration variables or predefined global variables.
- **Documentation Search**: If you are unsure of the exact module name, use `perldoc perl` to see a high-level table of contents for all core Perl documentation.

## Reference documentation
- [Perldoc CPAN Documentation](./references/metacpan_org_pod_Perldoc.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-perldoc_overview.md)