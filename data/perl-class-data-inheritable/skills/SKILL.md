---
name: perl-class-data-inheritable
description: This tool enables the creation of inheritable class attributes in Perl that can be shared across hierarchies or overridden by subclasses. Use when user asks to implement class-level data accessors, create inheritable configuration settings, or manage shared metadata in Perl object-oriented programming.
homepage: http://metacpan.org/pod/Class-Data-Inheritable
---


# perl-class-data-inheritable

## Overview
This skill provides guidance on implementing inheritable class attributes in Perl using `Class::Data::Inheritable`. It allows for the creation of accessors that store data at the class level rather than the instance level. This is particularly useful for configuration settings, database handles, or metadata that should be shared across an inheritance hierarchy while remaining flexible enough for local overrides.

## Implementation Patterns

### Creating Inheritable Class Data
To define a new inheritable attribute, use the `mk_classdata` method. This should typically be done during class setup.

```perl
package My::Parent;
use base qw(Class::Data::Inheritable);

# Create the accessor
__PACKAGE__->mk_classdata('Config');

# Set a default value
My::Parent->Config({ api_key => '12345', debug => 0 });
```

### Inheriting and Overriding
Subclasses automatically inherit the data from the parent. If the subclass modifies the data using the accessor, it creates a local copy for itself and its own descendants.

```perl
package My::Child;
use base qw(My::Parent);

# Overriding for this class and its children only
My::Child->Config({ api_key => '67890', debug => 1 });

# My::Parent->Config remains { api_key => '12345', debug => 0 }
```

## Best Practices
- **Initialization**: Always initialize class data at the highest relevant level in the hierarchy to provide a fallback.
- **Naming**: Use clear, descriptive names for class data to avoid collisions in deep inheritance trees.
- **Reference Types**: Be cautious when storing references (hashes/arrays). Modifying the *contents* of a reference (e.g., `$class->Data->{key} = 'val'`) will affect the parent class because the reference itself hasn't changed. To override safely, assign a *new* reference.
- **Access via Instances**: While these are class methods, they can be called on instances. However, they still act on the class data, not instance-specific data.

## Reference documentation
- [Class::Data::Inheritable Documentation](./references/metacpan_org_pod_Class-Data-Inheritable.md)