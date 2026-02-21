---
name: perl-package-stash
description: The `Package::Stash` module provides a clean, high-level interface for interacting with Perl's symbol tables.
homepage: http://metacpan.org/release/Package-Stash
---

# perl-package-stash

## Overview
The `Package::Stash` module provides a clean, high-level interface for interacting with Perl's symbol tables. While Perl allows direct manipulation of typeglobs (e.g., `*Foo::bar = sub { ... }`), this approach is error-prone and varies across Perl versions. This skill facilitates the safe management of package variables and subroutines, ensuring that namespace modifications are handled consistently and correctly.

## Core Usage Patterns

### Initializing a Stash Object
To work with a package's namespace, first create a stash object for that specific package.
```perl
use Package::Stash;

my $stash = Package::Stash->new('My::Package');
```

### Symbol Introspection
Check for the existence of symbols or retrieve their values without triggering "used only once" warnings or autovivification.
```perl
# Check if a subroutine exists
if ($stash->has_symbol('&my_sub')) { ... }

# Get the code reference for a subroutine
my $coderef = $stash->get_symbol('&my_sub');

# List all symbols of a specific type (e.g., all subroutines)
my @subs = $stash->list_all_symbols('CODE');
```

### Dynamic Symbol Injection
Add new functionality to a package at runtime. This is particularly useful for plugin systems or mock objects in testing.
```perl
# Add a new subroutine
$stash->add_symbol('&new_method', sub { return "Hello World" });

# Add a package variable
$stash->add_symbol('$VERSION', '1.0.0');
```

### Symbol Removal
Cleanly remove symbols from a namespace.
```perl
# Remove a specific subroutine
$stash->remove_symbol('&old_method');

# Remove all symbols from the package (effectively clearing the namespace)
$stash->remove_package;
```

## Best Practices
- **Prefix Sigils**: Always use the appropriate sigil prefix (`&`, `$`, `@`, `%`) when calling `get_symbol`, `has_symbol`, or `add_symbol` to specify the slot you are targeting.
- **Implementation Selection**: `Package::Stash` will automatically use `Package::Stash::XS` if available for better performance. If XS is not an option, it falls back to a pure-Perl implementation.
- **Namespace Safety**: Use `Package::Stash` instead of direct typeglob manipulation to avoid common pitfalls like accidentally creating constants or failing to update the internal method cache in older Perl versions.

## Reference documentation
- [Package::Stash on MetaCPAN](./references/metacpan_org_release_Package-Stash.md)