---
name: perl-perl-version
description: This tool parses, normalizes, and compares different Perl version number formats. Use when user asks to normalize version strings, compare Perl versions, or increment version components.
homepage: http://metacpan.org/pod/Perl::Version
metadata:
  docker_image: "quay.io/biocontainers/perl-perl-version:1.018--pl5321hdfd78af_0"
---

# perl-perl-version

## Overview
The `perl-perl-version` tool (providing the `Perl::Version` module) simplifies the complex task of handling Perl versions. Perl versions can exist as floating-point numbers (5.008), v-strings (v5.8.1), or tuples (5.8.1). This skill provides the logic to normalize these formats, compare them reliably, and perform version math (like incrementing sub-versions) without manual string parsing errors.

## Usage Guidelines

### Parsing and Normalization
Always use the tool to normalize input before comparison. Perl versions are often ambiguous (e.g., 1.10 vs 1.1).
- **Stringification**: Convert any version object to a standard string format.
- **Numification**: Convert a version to a floating-point representation (e.g., v1.2.3 becomes 1.002003).

### Version Comparison
When comparing two versions, do not use standard string or numeric operators directly on the raw strings. Use the tool's internal comparison logic to ensure that `v1.2.0` is correctly identified as greater than `1.1`.

### Incrementing Versions
Use the `inc` method or equivalent CLI flags to bump versions.
- **Alpha Versions**: Be cautious with versions containing underscores (e.g., 1.01_01), as these are treated as "alpha" or developer releases and may sort differently depending on the target repository (CPAN).
- **Component Selection**: Specify whether you are incrementing the revision, version, or subversion component.

### Common Patterns
- **Validation**: Use the tool to check if a string is a "legal" Perl version before attempting to write it to a `Makefile.PL` or `dist.ini`.
- **Formatting**: Use the tool to enforce a consistent style (e.g., always using 3-digit subversions) across a project's metadata.

## Reference documentation
- [Perl::Version Documentation](./references/metacpan_org_pod_Perl__Version.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-perl-version_overview.md)