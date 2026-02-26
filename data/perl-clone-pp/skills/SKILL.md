---
name: perl-clone-pp
description: This tool provides a Pure Perl implementation for recursively deep cloning complex nested data structures and objects. Use when user asks to deep copy Perl data types, perform shallow copies with depth limits, or implement custom cloning logic for objects.
homepage: http://metacpan.org/pod/Clone::PP
---


# perl-clone-pp

## Overview
The `perl-clone-pp` skill provides a Pure Perl implementation for recursively copying data types. Unlike a standard assignment which only copies references, this tool creates entirely new instances of the underlying data. It is particularly useful for duplicating complex nested structures, handling tied variables, and cloning objects while providing hooks for custom cloning logic.

## Usage Patterns

### Basic Deep Cloning
To clone a data structure, use the `clone` function. For arrays and hashes, always pass by reference.

```perl
use Clone::PP qw(clone);

# Clone a complex hash reference
my $original = { 
    user => 'admin', 
    roles => ['editor', 'author'],
    metadata => { id => 42 } 
};
my $copy = clone($original);

# Clone an array reference
my $array_ref = [1, 2, [3, 4]];
my $array_copy = clone($array_ref);
```

### Limiting Clone Depth
You can control how many levels deep the cloning process goes by providing a second integer argument.
- `0`: Returns the original value (no copy).
- `1`: Performs a shallow copy (top level only).
- `n`: Copies up to `n` levels deep.

```perl
# Create a shallow copy
my $shallow = clone($complex_structure, 1);
```

### Object-Oriented Integration
You can integrate `Clone::PP` directly into your classes to provide a `clone()` method for objects.

```perl
require Clone::PP;
push @MyPackage::ISA, 'Clone::PP';

my $obj = MyPackage->new();
my $copy = $obj->clone();
```

### Custom Object Cloning Hooks
Objects can influence the cloning process using two specific methods:
- `clone_self`: If defined, this method is called instead of the default cloning logic. The return value of this method becomes the clone.
- `clone_init`: If defined, this is called on the newly created clone before it is returned, allowing for post-copy initialization or adjustment.

## Expert Tips & Limitations
- **Shallow Copy Fallbacks**: Be aware that certain Perl types—specifically globs, regular expressions, and code references—are always copied shallowly.
- **Circular References**: While the module handles most recursive structures, references to specific hash elements (e.g., `\$hash->{key}`) may not be duplicated correctly in all versions.
- **Performance**: As a "Pure Perl" (PP) implementation, this module is highly portable and does not require a C compiler, but it may be slower than the XS-based `Clone` module for extremely large datasets.

## Reference documentation
- [Clone::PP - Recursively copy Perl datatypes](./references/metacpan_org_pod_Clone__PP.md)