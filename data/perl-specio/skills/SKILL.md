---
name: perl-specio
description: Specio provides a modern, object-oriented system for defining and enforcing Perl type constraints and data coercions. Use when user asks to define reusable type libraries, apply validation constraints to variables, or automate data transformations between types.
homepage: http://metacpan.org/release/Specio
metadata:
  docker_image: "quay.io/biocontainers/perl-specio:0.53--pl5321hdfd78af_0"
---

# perl-specio

## Overview
Specio provides a modern, object-oriented system for Perl type constraints and coercions. It serves as a more flexible and powerful alternative to older systems like `MooseX::Types` or `Type::Tiny`. This skill helps you implement type safety in Perl by defining reusable type libraries, applying constraints to variables, and automating the transformation of data from one type to another (coercion).

## Core Usage Patterns

### Defining Basic Constraints
Use `Specio::Declare` to create named types with specific validation logic.
```perl
use Specio::Declare;
use Specio::Library::Builtins;

declare(
    'PostiveInt',
    parent => t('Int'),
    where  => sub { $_[0] > 0 },
);
```

### Implementing Coercions
Coercions allow you to automatically convert data (e.g., a string to an object) when a type check fails but the input is transformable.
```perl
coerce(
    t('DateTime'),
    from => t('Str'),
    using => sub { DateTime::Format::ISO8601->parse_datetime($_[0]) },
);
```

### Using Types in Moo/Moose Classes
Specio types integrate seamlessly with Perl object systems to validate attributes.
```perl
has 'user_id' => (
    is       => 'ro',
    isa      => t('PositiveInt'),
    required => 1,
);
```

### Manual Validation
You can check values manually within procedural code using the `value_is_valid` or `validate_or_die` methods.
```perl
my $type = t('Int');
if ($type->value_is_valid($input)) {
    # Process valid input
}

# Or throw an exception on failure
$type->validate_or_die($input);
```

## Best Practices
- **Use Builtins**: Always start by importing `Specio::Library::Builtins` to access standard types like `Str`, `Int`, `ArrayRef`, and `HashRef`.
- **Type Libraries**: For large projects, create a dedicated type library module (inheriting from `Specio::Exporter`) to share constraints across your codebase.
- **Anonymous Types**: Use `anon_reify` for one-off constraints that don't need a global name, reducing namespace pollution.
- **Performance**: Specio optimizes constraints into highly efficient inlined Perl code. To ensure maximum performance, avoid using closures in `where` blocks when simple string-based inlining is possible.

## Reference documentation
- [Specio MetaCPAN Documentation](./references/metacpan_org_release_Specio.md)