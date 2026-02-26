---
name: perl-type-tiny
description: perl-type-tiny provides a lightweight and efficient type constraint system for Perl that works across Moo, Moose, and Mouse frameworks. Use when user asks to define type constraints, validate data structures, or implement type coercions in Perl applications.
homepage: https://metacpan.org/release/Type-Tiny
---


# perl-type-tiny

yaml
name: perl-type-tiny
description: Use this skill when developing Perl applications that require robust type constraints, data validation, or type coercion. It is particularly useful for defining attributes in Moo, Moose, or Mouse classes, ensuring variable integrity in functional Perl, and creating reusable type libraries.
```

## Overview
Type::Tiny is a highly efficient, lightweight type constraint system for Perl. It provides a unified interface that works seamlessly across different object-oriented frameworks (Moo, Moose, and Mouse) while remaining compatible with plain Perl. It allows developers to define complex validation logic, including nested data structures and value coercions, with minimal performance overhead and no mandatory dependencies on heavy frameworks.

## Best Practices and Usage Patterns

### 1. Using Standard Types
Always prefer `Types::Standard` for common validations to ensure compatibility and high performance.
```perl
use Types::Standard qw( Int Str ArrayRef HashRef Maybe );

# Basic validation
my $type = Int;
$type->assert_valid(42);
```

### 2. Integration with Moo/Moose
Type::Tiny objects are designed to be used directly in attribute definitions.
```perl
has username => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

has tags => (
    is      => 'rw',
    isa     => ArrayRef[Str],
    default => sub { [] },
);
```

### 3. Defining Custom Types
Use `Type::Tiny` to create custom constraints. Keep the `constraint` logic simple to maintain execution speed.
```perl
use Type::Tiny;

my $PositiveInt = Type::Tiny->new(
    name       => "PositiveInt",
    parent     => Int,
    constraint => sub { $_ > 0 },
    message    => sub { "$_ is not a positive integer" },
);
```

### 4. Type Coercion
Enable coercions to automatically transform data (e.g., converting a string to an object or an integer to a boolean).
```perl
my $TypeWithCoercion = $SomeType->plus_coercions(
    Int, sub { return create_object_from_int($_) }
);

# In an attribute
has object => (
    is     => 'ro',
    isa    => $TypeWithCoercion,
    coerce => 1,
);
```

### 5. Performance Optimization
- **Type::Params**: Use this for validating subroutine arguments; it is significantly faster than manual `die` or `warn` checks.
- **Inlining**: Type::Tiny is excellent at inlining code. Avoid using `where { ... }` blocks if a standard type can achieve the same result, as standard types inline more efficiently.
- **Exporting**: Use the `:is` and `:assert` tags from `Types::Standard` to get fast validation functions like `is_Int($val)` or `assert_Int($val)`.

## Reference documentation
- [Type::Tiny MetaCPAN](./references/metacpan_org_release_Type-Tiny.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-type-tiny_overview.md)