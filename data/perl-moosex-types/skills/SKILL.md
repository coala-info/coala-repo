---
name: perl-moosex-types
description: This tool facilitates the creation and management of modular, package-scoped type libraries in Perl using MooseX::Types. Use when user asks to define custom type constraints, create namespaced type libraries, implement type coercions, or use bareword type names for compile-time validation.
homepage: https://github.com/moose/MooseX-Types
metadata:
  docker_image: "quay.io/biocontainers/perl-moosex-types:0.51--pl5321hdfd78af_0"
---

# perl-moosex-types

## Overview
The `perl-moosex-types` skill facilitates the creation and management of modular type libraries in Perl. While standard Moose types are global and string-based, `MooseX::Types` allows you to scope types to specific packages and use them as barewords (subroutine calls). This approach provides two major benefits: it prevents naming collisions between different parts of a codebase and ensures that misspelled type names are caught during compilation rather than at runtime.

## Library Definition
To create a type library, define a package that uses `MooseX::Types` with the `-declare` setup.

```perl
package MyApp::Types;
use strict;
use warnings;
use MooseX::Types -declare => [
    'PositiveInt',
    'UserObject',
    'ArrayRefOfInts'
];

# Import standard Moose types for subtyping
use MooseX::Types::Moose qw( Int ArrayRef );

# Define a subtype
subtype PositiveInt,
    as Int,
    where { $_ > 0 },
    message { "The value $_ is not a positive integer" };

# Define a class type
class_type UserObject, { class => 'MyApp::Model::User' };

# Parameterized types
subtype ArrayRefOfInts, as ArrayRef[Int];

1;
```

## Type Coercion
Coercions must be defined within the library to enable the automatic generation of coercion helpers.

```perl
use MooseX::Types::Moose qw( Str Int );

subtype PositiveInt, as Int, where { $_ > 0 };

# Define how to turn a string into a PositiveInt
coerce PositiveInt,
    from Str,
    via { my $val = int($_); return $val > 0 ? $val : undef };
```

## Usage in Moose Classes
Import the types as barewords to use them in attribute definitions.

```perl
package MyApp::User;
use Moose;
use MyApp::Types qw( PositiveInt UserObject );

has 'age',
    is  => 'ro',
    isa => PositiveInt,
    coerce => 1;

has 'friend',
    is  => 'rw',
    isa => UserObject;
```

## Functional Helpers
Every declared type automatically provides helper functions for validation and coercion.

- `is_$Type($value)`: Returns true if the value passes the type constraint.
- `to_$Type($value)`: Attempts to coerce the value. Returns the coerced value or false/undef if coercion fails. Note: This helper is only exported if the type has defined coercions.

```perl
use MyApp::Types qw( PositiveInt is_PositiveInt to_PositiveInt );

my $val = "42";
if (is_PositiveInt($val)) {
    print "It's already a positive int\n";
} else {
    my $coerced = to_PositiveInt($val);
}
```

## Expert Tips
- **Avoid Strings**: Always prefer the bareword constant (e.g., `Int`) over the string version (`'Int'`) to ensure compile-time checking.
- **Namespacing**: Use libraries to group related types (e.g., `MyApp::Types::Network`, `MyApp::Types::Database`) to keep the global type namespace clean.
- **MooseX::Types::Moose**: Always use this module to import standard Moose types when building a library, rather than using the string names.
- **Circular Dependencies**: If two type libraries depend on each other, use the `class_type` or `role_type` declarations early in the file to "forward declare" the types.

## Installation
Install the package via Bioconda for environment-managed Perl setups:
```bash
conda install bioconda::perl-moosex-types
```

## Reference documentation
- [MooseX::Types Overview](./references/anaconda_org_channels_bioconda_packages_perl-moosex-types_overview.md)
- [MooseX::Types GitHub Documentation](./references/github_com_moose_MooseX-Types.md)