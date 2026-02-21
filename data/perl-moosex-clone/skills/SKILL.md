---
name: perl-moosex-clone
description: MooseX::Clone provides a flexible mechanism for duplicating Moose-based objects.
homepage: https://github.com/moose/MooseX-Clone
---

# perl-moosex-clone

## Overview

MooseX::Clone provides a flexible mechanism for duplicating Moose-based objects. Unlike the default shallow copy behavior in Moose, this module allows you to define how specific attributes should behave during a clone operation. It is particularly useful for complex object graphs where some components should be shared, some should be deeply copied, and others should be reset or ignored entirely.

## Implementation Patterns

### Basic Role Application
To enable cloning, compose the `MooseX::Clone` role into your class. This adds a `clone` method to your instances.

```perl
package My::Class;
use Moose;
with 'MooseX::Clone';

# Basic usage
my $new_obj = $old_obj->clone();
```

### Attribute Control with Traits
The power of this module lies in its attribute traits, which dictate cloning behavior during introspection.

- **Clone Trait**: Use this for attributes containing objects that also implement a `clone` method. It triggers a recursive deep copy.
- **NoClone Trait**: Use this for attributes that should not be copied to the new instance (e.g., unique identifiers, file handles, or temporary state).

```perl
has 'data_model' => (
    is     => 'rw',
    isa    => 'Data::Model',
    traits => ['Clone'], # Recursively clones the Data::Model object
);

has 'session_id' => (
    is     => 'rw',
    isa    => 'Str',
    traits => ['NoClone'], # This attribute will be undefined in the clone
);
```

### Overriding Values During Clone
The `clone` method accepts a hash of parameters. These parameters can either provide new values for attributes or pass arguments to the `clone` method of sub-objects.

```perl
# Overriding a simple attribute
my $copy = $original->clone( status => 'new' );

# Passing arguments to an attribute's own clone method
# If 'metadata' has the Clone trait, the arrayref is passed to metadata->clone
my $copy = $original->clone(
    metadata => [ version => '2.0', author => 'System' ]
);
```

## Expert Tips

- **Custom Clone Methods**: If you have non-Moose objects or specialized needs, ensure your sub-objects implement a `sub clone { ... }` method. MooseX::Clone will automatically detect and use this method if the attribute is marked with the `Clone` trait.
- **Init Args**: Attributes without the `Clone` trait are copied using the low-level `Class::MOP::Class::clone_object` logic. If you pass a parameter to `clone` for an attribute that does not self-clone, it simply shadows the previous value.
- **Storable Integration**: For legacy support or specific serialization needs, check for the `StorableClone` trait which leverages the `Storable` module for the duplication process.

## Reference documentation
- [MooseX::Clone GitHub README](./references/github_com_moose_MooseX-Clone.md)
- [Bioconda perl-moosex-clone Overview](./references/anaconda_org_channels_bioconda_packages_perl-moosex-clone_overview.md)