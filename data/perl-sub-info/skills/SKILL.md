---
name: perl-sub-info
description: The perl-sub-info tool extracts detailed metadata and source location information for Perl subroutines. Use when user asks to inspect subroutine metadata, identify where a subroutine is defined, or differentiate between original and wrapped subroutines.
homepage: http://metacpan.org/pod/Sub::Info
metadata:
  docker_image: "quay.io/biocontainers/perl-sub-info:0.002--pl526_0"
---

# perl-sub-info

## Overview
The `perl-sub-info` tool (interfacing with the `Sub::Info` Perl module) provides a programmatic way to extract deep metadata about Perl subroutines. While often used as a library, it is essential for developers needing to identify exactly where a specific subroutine is defined or to differentiate between original subroutines and wrapped or exported versions.

## Core Usage Patterns

### Inspecting a Subroutine
To get information about a subroutine, you typically pass a code reference to the `inspect` function. This returns an object containing the following attributes:
- `package`: The package where the sub was defined.
- `name`: The name of the subroutine.
- `file`: The absolute path to the file containing the definition.
- `line`: The starting line number.
- `end_line`: The ending line number.
- `is_install`: Boolean indicating if the sub was installed into its current package from elsewhere.

### Handling Anonymous Subroutines
When inspecting anonymous subs (coderefs), the `name` attribute will typically return `__ANON__`. Use the `file` and `line` attributes to locate the source in these instances.

### Identifying Wrapped Subroutines
If a subroutine has been modified by tools like `Sub::Identify` or wrapped via `Method::Signatures`, `Sub::Info` helps trace back to the underlying implementation.

## Best Practices
- **Verify Code References**: Ensure you are passing a valid coderef (e.g., `\&My::Package::handler`) to avoid runtime errors during inspection.
- **Debugging Exports**: Use the `package` and `is_install` attributes to determine if a subroutine is native to the current namespace or if it was imported from a parent or utility class.
- **Performance**: Subroutine inspection involves overhead. Use this tool during initialization, logging, or error-handling phases rather than inside high-frequency loops.

## Reference documentation
- [Sub::Info Documentation](./references/metacpan_org_pod_Sub__Info.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-sub-info_overview.md)