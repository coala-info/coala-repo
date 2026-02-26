---
name: perl-class-accessor
description: This tool automates the generation of getter and setter methods for Perl class attributes. Use when user asks to create object accessors, implement read-only or write-only fields, or use a declarative syntax for object-oriented Perl development.
homepage: http://metacpan.org/pod/Class::Accessor
---


# perl-class-accessor

## Overview
This skill enables the rapid creation of Perl class attributes without manual method writing. `Class::Accessor` automates the generation of getter/setter methods, providing a standardized way to handle object data. It supports traditional Perl inheritance patterns as well as a modern declarative syntax. Use this to ensure consistency across object-oriented Perl projects and to implement read-only or write-only constraints on object fields.

## Implementation Patterns

### Traditional Interface
Inherit from `Class::Accessor` to use the standard method-making tools.

```perl
package My::Module;
use base qw(Class::Accessor);

# Generate read-write accessors
__PACKAGE__->mk_accessors(qw(name age email));

# Generate read-only accessors
__PACKAGE__->mk_ro_accessors(qw(id created_at));

# Generate write-only accessors
__PACKAGE__->mk_wo_accessors(qw(password_buffer));
```

### Moose-like "Antlers" Interface
For a more modern, declarative style, use the "antlers" import.

```perl
package My::Module;
use Class::Accessor "antlers";

has name  => ( is => "rw" );
has id    => ( is => "ro" );
has secret => ( is => "wo" );

# Use extends instead of @ISA or base
extends qw(Parent::Class);
```

### Following Best Practices
To enforce the `get_field` and `set_field` naming convention (as recommended in Perl Best Practices), call `follow_best_practice` before defining accessors.

```perl
package My::Module;
use base qw(Class::Accessor);

__PACKAGE__->follow_best_practice;
__PACKAGE__->mk_accessors(qw(status)); 
# Generates get_status() and set_status()
```

## Usage in Code
The module provides a default `new()` constructor that accepts a hash reference to initialize attributes.

```perl
use My::Module;

# Initialization
my $obj = My::Module->new({ name => "Alice", age => 30 });

# Accessing data
print $obj->name;

# Mutating data
$obj->age(31);

# Bulk retrieval/update
my @data = $obj->get(qw(name age));
$obj->set(age => 32);
```

## Expert Tips
- **Constructor Flexibility**: The `new()` method can be called on both classes and existing instances (cloning the reference structure).
- **Customizing Logic**: If you need to add validation, override the `get()` or `set()` methods in your subclass. All generated accessors route through these two methods.
- **Naming Collisions**: Avoid naming fields `DESTROY`, as this is a reserved Perl keyword for object destruction and will cause issues if an accessor is generated for it.
- **Manual Overrides**: If you manually define a subroutine with the same name as an accessor *before* calling `mk_accessors`, `Class::Accessor` will not overwrite your custom implementation.

## Reference documentation
- [Class::Accessor - Automated accessor generation](./references/metacpan_org_pod_Class__Accessor.md)