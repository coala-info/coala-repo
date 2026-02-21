---
name: perl-set-object
description: The `Set::Object` module provides a specialized data structure for Perl that handles sets of objects or strings.
homepage: http://metacpan.org/pod/Set-Object
---

# perl-set-object

## Overview
The `Set::Object` module provides a specialized data structure for Perl that handles sets of objects or strings. Unlike standard Perl hashes used as sets, this module allows for direct storage of object references without stringifying them, maintaining identity and providing a comprehensive suite of mathematical set operations. Use this skill to implement high-performance membership testing and set logic in Perl-based bioinformatics pipelines or general utility scripts.

## Core Usage Patterns

### Initializing Sets
```perl
use Set::Object;

# Create a new set
my $set = Set::Object->new(@items);

# Create a set specifically for scalars (strings/numbers)
my $scalar_set = Set::Object::Scalar->new("a", "b", "c");
```

### Membership and Modification
- **Add items**: `$set->insert($obj1, $obj2);`
- **Remove items**: `$set->remove($obj1);`
- **Check existence**: `if ($set->includes($obj)) { ... }`
- **Clear set**: `$set->clear();`
- **Size**: `my $count = $set->size();`

### Set Logic Operations
These methods return a new `Set::Object` containing the result:
- **Union**: `$set1 -> union($set2)` (Elements in either set)
- **Intersection**: `$set1 -> intersection($set2)` (Elements in both sets)
- **Difference**: `$set1 -> difference($set2)` (Elements in $set1 but not in $set2)
- **Symmetric Difference**: `$set1 -> symmetric_difference($set2)` (Elements in either set, but not both)

### Comparison and Subsets
- **Is Subset**: `$set1 -> is_subset($set2)` (True if all elements of $set1 are in $set2)
- **Is Proper Subset**: `$set1 -> is_proper_subset($set2)`
- **Equality**: `$set1 -> equal($set2)` (True if both sets contain the same elements)

## Expert Tips
- **Performance**: `Set::Object` is implemented in XS (C code), making it significantly faster than pure-Perl set implementations for large collections.
- **Object Identity**: When using `Set::Object`, two different objects with the same internal data are treated as distinct members. If you need to store unique strings or numbers, use `Set::Object::Scalar`.
- **Iteration**: Use the `members` method to get an array of all elements: `foreach my $item ($set->members) { ... }`.
- **Weak References**: Be cautious of memory leaks in long-running processes; `Set::Object` holds strong references to the objects it contains by default.

## Reference documentation
- [Set::Object Documentation](./references/metacpan_org_pod_Set-Object.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-set-object_overview.md)