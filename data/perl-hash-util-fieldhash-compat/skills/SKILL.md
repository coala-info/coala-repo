---
name: perl-hash-util-fieldhash-compat
description: This Perl module provides a compatibility layer for field hashes to ensure consistent behavior across different Perl versions. Use when user asks to implement field hashes, manage memory for inside-out objects, or associate metadata with object references without preventing garbage collection.
homepage: https://github.com/karenetheridge/Hash-Util-FieldHash-Compat
metadata:
  docker_image: "quay.io/biocontainers/perl-hash-util-fieldhash-compat:0.11--0"
---

# perl-hash-util-fieldhash-compat

## Overview
`Hash::Util::FieldHash::Compat` is a compatibility layer for the Perl core module `Hash::Util::FieldHash`. It provides a consistent API for field hashes—specialized hashes that use references as keys without preventing those references from being garbage collected. This module ensures that code relying on field hashes remains functional regardless of whether the environment supports the native C-based implementation (Perl 5.10+) or requires a slower tie-based fallback (`Tie::RefHash::Weak`) on older systems.

## Installation
To install the package using Conda/Bioconda:
```bash
conda install bioconda::perl-hash-util-fieldhash-compat
```

## Usage Patterns

### Transparent Compatibility
The primary use case is as a drop-in replacement for the core `Hash::Util::FieldHash`. By using the `Compat` version, you ensure your script is portable across different Perl versions.

```perl
use Hash::Util::FieldHash::Compat;

# Initialize a field hash
# On 5.10+, this uses the native implementation.
# On older perls, this transparently uses Tie::RefHash::Weak.
fieldhash my %registry;
```

### Command Line Verification
To verify the module is available in your current Perl @INC path:
```bash
perl -MHash::Util::FieldHash::Compat -e 'print "Module loaded successfully\n"'
```

## Expert Tips and Best Practices

### Memory Management
Field hashes are primarily used to prevent memory leaks in "inside-out" objects. When the object reference (the key) is destroyed, the corresponding entry in the field hash is automatically removed. Use this module whenever you need to associate metadata with an object without extending the object's lifetime.

### Performance Awareness
While this module provides a compatible API, the underlying mechanism changes based on the Perl version:
- **Perl 5.10 and newer**: Uses the native, fast, and robust `Hash::Util::FieldHash`.
- **Older Perl versions**: Falls back to `Tie::RefHash::Weak`. This is significantly slower due to the overhead of `perltie`. If performance is critical on legacy systems, minimize the frequency of hash lookups.

### API Reference
Because this is a compatibility wrapper, it does not define its own unique API. You should follow the standard documentation for `Hash::Util::FieldHash` for all functional details, including the use of:
- `fieldhash` / `fieldhashes`
- `idhash` / `idhashes`
- `register`

## Reference documentation
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-hash-util-fieldhash-compat_overview.md)
- [Hash-Util-FieldHash-Compat GitHub Repository](./references/github_com_karenetheridge_Hash-Util-FieldHash-Compat.md)