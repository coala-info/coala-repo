---
name: perl-filedirutil
description: This tool provides a Moose role for simplifying and standardizing filesystem operations in Perl applications. Use when user asks to integrate FileDirUtil into a Perl class, manage directories and files, or handle path resolution using Moose.
homepage: http://metacpan.org/pod/FileDirUtil
metadata:
  docker_image: "quay.io/biocontainers/perl-filedirutil:v0.04--pl526_0"
---

# perl-filedirutil

## Overview
The `perl-filedirutil` skill provides guidance on integrating the `FileDirUtil` Moose role into Perl projects. This tool simplifies common filesystem tasks—such as reading/writing files, managing directories, and handling paths—by providing a reusable interface for Moose objects. It ensures that file operations are handled consistently across different modules of an application, reducing boilerplate code for basic I/O.

## Implementation Patterns

### Consuming the Role
To use these utilities within a Perl class, consume the role using Moose:

```perl
package My::FileProcessor;
use Moose;
with 'FileDirUtil';

# The class now has access to standardized I/O methods
```

### Common File Operations
Once the role is consumed, use the following patterns for reliable file handling:

- **Path Resolution**: Use the provided methods to resolve absolute paths and handle OS-specific delimiters automatically.
- **Directory Management**: Leverage the role to check for directory existence or create nested structures before performing write operations.
- **Atomic Writes**: When data integrity is critical, use the role's utilities to write to temporary files before renaming them to the target destination.

### Best Practices
- **Error Handling**: Always wrap `FileDirUtil` calls in `try/catch` blocks or check return values, as filesystem operations are prone to permission and capacity issues.
- **Moose Integration**: Use `FileDirUtil` methods within Moose `around` or `after` modifiers to trigger file logging or cleanup automatically after specific object actions.
- **Portability**: Rely on the role's internal path handling rather than hardcoding slashes to ensure the Perl code remains functional across Linux and macOS environments.

## Reference documentation
- [FileDirUtil Perl Documentation](./references/metacpan_org_pod_FileDirUtil.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-filedirutil_overview.md)