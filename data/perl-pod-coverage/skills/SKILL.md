---
name: perl-pod-coverage
description: This tool checks if the public API of a Perl module is documented by cross-referencing available subroutines with POD documentation. Use when user asks to check Perl module documentation coverage, identify undocumented subroutines, or verify that a library meets documentation standards.
homepage: https://github.com/richardc/perl-pod-coverage
---


# perl-pod-coverage

## Overview
The `perl-pod-coverage` tool (based on the `Pod::Coverage` module) provides a way to check if the public API of a Perl module is documented. It inspects the package's symbol table to find available subroutines and cross-references them with the POD documentation found in the source file. This ensures that developers maintain a high standard of documentation for their libraries.

## Core Usage and Patterns

### Basic Coverage Check
The primary way to use the tool is via the `pod_cover` command-line utility.
- To check a module's coverage: `pod_cover <Module::Name>`
- The tool will report which subroutines are "naked" (undocumented).

### Identifying Private Subroutines
The tool uses heuristics to determine which subroutines should be excluded from coverage requirements:
- **Underscore Prefix**: Subroutines starting with an underscore (e.g., `_internal_helper`) are treated as private and ignored by default.
- **Implied Private List**: Standard Perl internals and specific technical methods are automatically excluded from the coverage check, including:
  - `CLONE`
  - `CLONE_SKIP`
  - `SCALAR`
  - `TIE` methods (e.g., `TIEHANDLE`, `FETCH`, `STORE`)

### Advanced Configuration
- **Non-whitespace Option**: Use this to ensure that POD sections actually contain descriptive text. This prevents "cheating" the coverage check with empty `=item` entries or whitespace-only documentation.
- **Fully Qualified Methods**: The tool supports analyzing `Fully::Qualified::methods`, allowing for accurate coverage reporting even when methods are defined or referenced using their full package paths.

## Expert Tips
- **Compilation Checks**: The tool will explicitly fail if the module fails to compile. Ensure your environment has all dependencies installed before running coverage checks.
- **Stoplist Management**: If you have specific subroutines that should not be documented (e.g., `unimport`), ensure they are added to the stoplist or follow the private naming convention.
- **Testing Integration**: While the CLI is useful for manual checks, the most common workflow is integrating these checks into a project's test suite (typically via `t/*.t` files) to catch undocumented code during the CI/CD process.

## Reference documentation
- [github_com_richardc_perl-pod-coverage_commits_master.md](./references/github_com_richardc_perl-pod-coverage_commits_master.md)
- [github_com_richardc_perl-pod-coverage.md](./references/github_com_richardc_perl-pod-coverage.md)