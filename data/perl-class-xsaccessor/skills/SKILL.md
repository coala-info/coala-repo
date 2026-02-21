---
name: perl-class-xsaccessor
description: Class::XSAccessor is a Perl module designed to accelerate object-oriented code by implementing accessors in XS (C code) rather than pure Perl.
homepage: http://metacpan.org/pod/Class::XSAccessor
---

# perl-class-xsaccessor

## Overview
Class::XSAccessor is a Perl module designed to accelerate object-oriented code by implementing accessors in XS (C code) rather than pure Perl. This skill should be applied when a Perl class needs to handle a high volume of attribute access or when benchmarking reveals that standard sub-based accessors are a performance bottleneck. It allows for the automated generation of constructors, predicates, and mutators that are typically 3 to 4 times faster than their pure-Perl equivalents.

## Implementation Patterns

### Basic Accessor Generation
To generate standard getters and setters for a hash-based object, use the following syntax within the package:

```perl
package MyClass;
use Class::XSAccessor
  getters => {
    get_name => 'name',
    get_id   => 'id',
  },
  setters => {
    set_name => 'name',
    set_id   => 'id',
  },
  accessors => {
    name => 'name', # Combined read/write
  };
```

### Fast Constructors
Instead of writing a manual `new` method, let the module generate a fast XS constructor that blesses a hash of arguments:

```perl
use Class::XSAccessor
  constructor => 'new';
```

### Predicates and Boolean Methods
Use predicates to check for the existence or definition of attributes without triggering autovivification or manual hash checks:

- **defined_predicates**: Checks if the value is defined.
- **exists_predicates**: Checks if the key exists in the hash.
- **true / false**: Generates methods that always return 1 or 0 (useful for interface consistency).

```perl
use Class::XSAccessor
  defined_predicates => { has_data => 'data' },
  exists_predicates  => { exists_key => 'key' },
  true               => [ 'is_active' ],
  false              => [ 'is_deprecated' ];
```

## Expert Tips and Best Practices

### Method Chaining
By default, setters return the new value. To enable a fluent interface where setters return the object itself, use the `chained` option:

```perl
use Class::XSAccessor
  setters => { set_status => 'status' },
  chained => 1;
```

### Handling Method Collisions
If you are injecting accessors into a class that might already have methods defined (e.g., during refactoring), use the `replace` option to suppress warnings:

```perl
use Class::XSAccessor
  replace   => 1,
  accessors => { foo => 'foo' };
```

### Array-Based Objects
If your objects are implemented as arrays rather than hashes for even tighter memory/speed constraints, use the companion module:

```perl
use Class::XSAccessor::Array
  getters => { get_first_name => 0 }; # 0 is the array index
```

### Performance Considerations
- **Hash-based only**: Standard `Class::XSAccessor` only works with objects implemented as ordinary hashes.
- **Runtime Compilation**: Unlike some other accessor generators, this does not require a C compiler at runtime; it uses pre-compiled XS code.
- **Lvalues**: If you require `my_sub($obj) = $val` syntax, use `lvalue_accessors`, but be aware of the specific caveats regarding lvalue subroutines in Perl.

## Reference documentation
- [Class::XSAccessor - Generate fast XS accessors without runtime compilation](./references/metacpan_org_pod_Class__XSAccessor.md)