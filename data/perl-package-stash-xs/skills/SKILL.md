---
name: perl-package-stash-xs
description: This tool provides a high-performance C-based interface for manipulating Perl package symbol tables. Use when user asks to manage package variables, add or remove subroutines dynamically, or perform meta-programming tasks within a specific namespace.
homepage: http://metacpan.org/release/Package-Stash-XS
metadata:
  docker_image: "quay.io/biocontainers/perl-package-stash-xs:0.29--pl5321h87f3376_1"
---

# perl-package-stash-xs

## Overview
This skill provides guidance on using the XS (C-based) implementation of the Package::Stash API. While standard Perl allows symbol table manipulation via typeglobs, `Package::Stash::XS` provides a more robust, faster, and "correct" interface that avoids common pitfalls like accidental glob creation. It is primarily used in meta-programming, plugin systems, or when dynamically modifying code at runtime.

## Implementation Patterns

### Initializing a Stash
To manipulate a package, create a stash object for the target namespace.
```perl
use Package::Stash;
# Package::Stash automatically uses Package::Stash::XS if installed
my $stash = Package::Stash->new('My::Module');
```

### Symbol Manipulation
Use these methods to manage package variables and subroutines without manual typeglob munging:

- **Add a symbol**: `$stash->add_symbol('&subname', sub { ... })`
- **Remove a symbol**: `$stash->remove_symbol('$scalar_name')`
- **Check existence**: `$stash->has_symbol('%hash_name')`
- **Get a symbol**: `$stash->get_symbol('@array_name')`

### Best Practices
- **Prefer XS over PP**: Always ensure `Package::Stash::XS` is installed in performance-critical environments, as the Pure Perl (PP) fallback is significantly slower and has edge-case behavior differences regarding "ghost" symbols.
- **Namespace Safety**: Use `$stash->list_all_symbols($type_filter)` to audit a namespace before injection to prevent overwriting existing logic.
- **Conda Installation**: In bioinformatics or managed environments, install via bioconda to ensure C dependencies are correctly linked:
  `conda install bioconda::perl-package-stash-xs`

## Reference documentation
- [Package::Stash::XS Overview](./references/metacpan_org_release_Package-Stash-XS.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_perl-package-stash-xs_overview.md)