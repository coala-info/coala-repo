---
name: perl-file-copy-recursive-reduced
description: This skill provides guidance on using the `File::Copy::Recursive::Reduced` Perl module.
homepage: http://thenceforward.net/perl/modules/File-Copy-Recursive-Reduced/
---

# perl-file-copy-recursive-reduced

## Overview
This skill provides guidance on using the `File::Copy::Recursive::Reduced` Perl module. It is a specialized, "thinner" version of the classic `File::Copy::Recursive` module, designed to have fewer dependencies while maintaining the core functionality of recursive copying. It is particularly useful in constrained environments, CI/CD pipelines, or within the Bioconda toolchain where minimizing the dependency graph is critical.

## Usage Patterns

### Core Functions
The module provides three primary functions for recursive operations:

- `fcopy($source, $destination)`: Copies a single file to a destination.
- `dcopy($source_dir, $destination_dir)`: Recursively copies a directory and all its contents to a new location.
- `rcopy($source, $destination)`: A general-purpose function that detects if the source is a file or a directory and calls `fcopy` or `dcopy` accordingly.

### Perl One-Liner Examples
For quick CLI tasks, use the following patterns:

**Recursive Directory Copy:**
```bash
perl -MFile::Copy::Recursive::Reduced=dcopy -e 'dcopy("source_path", "target_path")'
```

**General Recursive Copy (File or Directory):**
```bash
perl -MFile::Copy::Recursive::Reduced=rcopy -e 'rcopy("source_item", "target_destination")'
```

## Best Practices
- **Dependency Management**: Prefer this "Reduced" version over the standard `File::Copy::Recursive` when working on Bioconda packages or Perl scripts where you want to avoid the `Config`, `File::Spec`, and `File::Copy` overhead associated with the full module.
- **Error Handling**: Always check the return value. These functions return the number of items copied on success, or `undef` on failure.
- **Pathing**: Use absolute paths when possible to avoid ambiguity during recursive descent, especially when executing via one-liners.

## Reference documentation
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-file-copy-recursive-reduced_overview.md)
- [Module Source Index](./references/thenceforward_net_perl_modules_File-Copy-Recursive-Reduced.md)