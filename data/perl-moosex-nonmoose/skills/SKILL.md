---
name: perl-moosex-nonmoose
description: MooseX::NonMoose is a Perl module designed to bridge the gap between modern Moose-based object orientation and legacy Perl classes.
homepage: https://github.com/moose/MooseX-NonMoose
---

# perl-moosex-nonmoose

## Overview

MooseX::NonMoose is a Perl module designed to bridge the gap between modern Moose-based object orientation and legacy Perl classes. Normally, Moose classes cannot easily inherit from non-Moose classes because of differences in how objects are constructed (Moose uses `new` and `BUILDARGS`, while legacy classes often have custom constructors). This tool automates the "foreign inheritance" process, ensuring that the base class's constructor is called correctly and that the resulting object is properly integrated into the Moose system.

## Usage Best Practices

### Basic Subclassing
To extend a non-Moose class, simply include the module in your Moose class definition. This handles the heavy lifting of constructor wrapping.

```perl
package My::Moose::Class;
use Moose;
use MooseX::NonMoose;
extends 'Plain::Old::Perl::Class';

has 'extra_attribute' => (
    is  => 'rw',
    isa => 'Str',
);

no Moose;
__PACKAGE__->meta->make_immutable;
```

### Handling Constructor Arguments
If the parent class requires specific arguments that differ from Moose's standard hash/hashref approach, override `FOREIGNBUILDARGS`.

*   **Purpose**: Converts Moose-style arguments into the format expected by the non-Moose parent.
*   **Implementation**:
    ```perl
    sub FOREIGNBUILDARGS {
        my ($class, %args) = @_;
        # Return the list of arguments for the parent's new() method
        return $args{parent_param_1}, $args{parent_param_2};
    }
    ```

### Performance and Immutability
Always call `__PACKAGE__->meta->make_immutable`. While MooseX::NonMoose does significant work at runtime to hook into the constructor, making the class immutable allows Moose to optimize the constructor wrapper, reducing the performance overhead of foreign inheritance.

### Common Pitfalls
*   **Multiple Inheritance**: MooseX::NonMoose is primarily designed for single inheritance from a non-Moose class. If you have complex multiple inheritance involving multiple non-Moose classes, consider using delegation (Moose "handles") instead.
*   **Manual `new` Overrides**: Avoid overriding `new` manually in your Moose class. Use `FOREIGNBUILDARGS` and Moose's `BUILD` or `BUILDARGS` instead to maintain compatibility with the wrapper.

## Reference documentation

- [MooseX::NonMoose Overview](./references/anaconda_org_channels_bioconda_packages_perl-moosex-nonmoose_overview.md)