---
name: perl-data-visitor
description: The `Data::Visitor` module provides a flexible API for recursive traversal of Perl data structures.
homepage: http://metacpan.org/release/Data-Visitor
---

# perl-data-visitor

## Overview
The `Data::Visitor` module provides a flexible API for recursive traversal of Perl data structures. Unlike simple recursive loops, it allows you to define specific behaviors for different data types (scalars, arrays, hashes, or blessed objects) by overriding "visit" methods. This skill helps in implementing clean, decoupled logic for data manipulation tasks that would otherwise require complex, error-prone recursive functions.

## Core Usage Patterns

### Basic Traversal
To perform a simple walk-through of a data structure, instantiate `Data::Visitor` and call the `visit` method.
```perl
use Data::Visitor;

my $v = Data::Visitor->new;
$v->visit($complex_data_structure);
```

### Transforming Data
To modify data during traversal, create a subclass or an anonymous instance that overrides specific entry points. The return value of the callback replaces the node in the structure.

```perl
my $v = Data::Visitor->new(
    hash => sub {
        my ($visitor, $hash) = @_;
        # Example: Remove keys starting with an underscore
        delete $hash->{$_} for grep { /^_/ } keys %$hash;
        return $hash;
    },
    value => sub {
        my ($visitor, $value) = @_;
        # Example: Uppercase all strings
        return uc($value) if defined $value && !ref $value;
        return $value;
    }
);

$v->visit($data);
```

### Handling Objects
By default, `Data::Visitor` treats blessed objects as their underlying data type (usually a hash). To handle objects specifically:
- Use `object => sub { ... }` to intercept any blessed reference.
- Use `plain_hash` or `plain_array` if you only want to target unblessed structures.

### Common Callback Methods
- `visit`: The entry point.
- `value`: Called for non-reference scalars.
- `array`: Called for array references.
- `hash`: Called for hash references.
- `glob`: Called for globs.
- `code`: Called for code references.

## Best Practices
- **Immutability**: If you need to keep the original structure intact, clone the data before visiting, as `Data::Visitor` often modifies the structure in-place depending on how callbacks are written.
- **Circular References**: `Data::Visitor` handles circular references automatically by tracking seen nodes to prevent infinite loops.
- **Context Awareness**: Use the visitor object itself to maintain state across different nodes (e.g., keeping a counter or a path stack).

## Reference documentation
- [Data::Visitor on MetaCPAN](./references/metacpan_org_release_Data-Visitor.md)