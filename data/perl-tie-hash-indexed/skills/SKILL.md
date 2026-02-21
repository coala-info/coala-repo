---
name: perl-tie-hash-indexed
description: This skill facilitates the management of ordered associative arrays in Perl using the `Tie::Hash::Indexed` module.
homepage: https://metacpan.org/pod/Tie::Hash::Indexed
---

# perl-tie-hash-indexed

## Overview
This skill facilitates the management of ordered associative arrays in Perl using the `Tie::Hash::Indexed` module. It is particularly useful when performance is critical, as the module is implemented in XS (C code) and significantly outperforms pure-Perl alternatives. You should use this skill to handle data structures where key-value pairs must maintain their sequence for iteration, serialization, or specific algorithmic requirements, while benefiting from optimized methods for arithmetic and logical assignments directly on hash elements.

## Usage Patterns

### Choosing the Interface
`Tie::Hash::Indexed` provides two ways to interact with ordered hashes. The Object-Oriented (OO) interface is generally faster and provides more utility methods.

#### Object-Oriented Interface (Recommended for Performance)
```perl
use Tie::Hash::Indexed;

# Initialization
my $node = Tie::Hash::Indexed->new(id => 101, status => 'active');

# Adding/Updating
$node->set(priority => 'high');
$node->merge(retries => 3, timeout => 30); # Appends new, updates existing in-place

# Reordering operations
$node->push(last_seen => 'now');    # Moves key to the end if it exists
$node->unshift(first_item => 0);    # Moves key to the start if it exists

# Extraction
my @all_data = $node->items;        # Returns flat list of (key, value, ...)
my $val = $node->pop;               # Removes and returns last value
```

#### Tied Interface (Recommended for Compatibility)
Use this when you want the ordered hash to behave like a standard Perl hash.
```perl
use Tie::Hash::Indexed;

tie my %config, 'Tie::Hash::Indexed';
%config = (port => 8080, host => 'localhost');
$config{secure} = 1;

print join(", ", keys %config); # Guarantees: port, host, secure
```

### Optimized In-Place Operations
Instead of fetching, modifying, and re-setting values, use the built-in XS methods for better performance:

| Task | Method | Equivalent to |
| :--- | :--- | :--- |
| **Concatenation** | `$obj->concat($k, $str)` | `$h{$k} .= $str` |
| **Arithmetic** | `$obj->add($k, $v)`, `subtract`, `multiply`, `divide`, `modulo` | `$h{$k} += $v`, etc. |
| **Increment** | `$obj->preinc($k)`, `$obj->postinc($k)` | `++$h{$k}`, `$h{$k}++` |
| **Logical** | `$obj->or_assign($k, $v)`, `$obj->dor_assign($k, $v)` | `$h{$k} ||= $v`, `$h{$k} //= $v` |

### Iteration
To iterate without loading the entire hash into memory:
```perl
my $it = $obj->iterator;
while (my ($k, $v) = $it->()) {
    # Process in order
}

# Reverse iteration
my $rev = $obj->reverse_iterator;
while (my ($k, $v) = $rev->()) { ... }
```

## Expert Tips
- **Boolean Context**: Unlike `Hash::Ordered`, a `Tie::Hash::Indexed` object always evaluates to true. To check if it's empty, use `if ($obj->keys == 0)` in scalar context.
- **Cloning**: There is no native `clone` method. Use `$clone = Tie::Hash::Indexed->new($orig->items);`.
- **Memory/Speed**: If you are migrating from `Hash::Ordered`, prefer `as_list` over `items` for better cross-module compatibility, though both work in this module.
- **Key Existence**: Use `$obj->has($key)` as a concise alias for `exists`.

## Reference documentation
- [Tie::Hash::Indexed - Ordered hashes for Perl](./references/metacpan_org_pod_Tie__Hash__Indexed.md)