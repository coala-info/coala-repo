---
name: perl-types-standard
description: "This tool provides a library of standard type constraints for Perl to ensure data integrity and type safety. Use when user asks to define variable constraints, validate subroutine arguments, or enforce object attribute types in Moo or Moose."
homepage: http://search.cpan.org/~tobyink/Type-Tiny-1.002001/lib/Types/Standard.pm
---


# perl-types-standard

## Overview
This skill facilitates the implementation of type safety in Perl applications using the `Types::Standard` library. It is the industry-standard way to define constraints for variables, subroutines, and object attributes. By using these types, you can catch data integrity issues at the boundaries of your code rather than deep within logic, leading to more maintainable and self-documenting Perl scripts.

## Core Usage Patterns

### Basic Type Checking
Import types directly into your namespace. It is best practice to use the `-types` export tag or list specific types to avoid namespace pollution.

```perl
use Types::Standard qw( Int Str ArrayRef );

# Manual check
my $value = "123";
if (Int->check($value)) {
    print "It is an integer\n";
}

# Asserting (throws error on failure)
Int->assert_valid($value);
```

### Function Signatures
Use with `Type::Params` to validate subroutine arguments efficiently.

```perl
use Types::Standard qw( Str Int );
use Type::Params qw( compile );

sub update_user {
    state $check = compile( Str, Int );
    my ($name, $age) = $check->(@_);
    # ... logic
}
```

### Object Attributes (Moo/Moose)
Integrate directly with object-oriented frameworks to enforce attribute types.

```perl
package User;
use Moo;
use Types::Standard qw( Str Int ArrayRef );

has name => ( is => 'ro', isa => Str, required => 1 );
has age  => ( is => 'rw', isa => Int );
has tags => ( is => 'ro', isa => ArrayRef[Str], default => sub { [] } );
```

## Expert Tips

### Parameterized Types
Many types in `Types::Standard` can be parameterized to provide deeper validation.
- `ArrayRef[Int]`: An array reference containing only integers.
- `HashRef[Str]`: A hash reference where all values are strings.
- `Dict[...]`: For fixed-structure hashes (e.g., `Dict[name => Str, id => Int]`).
- `Tuple[...]`: For fixed-length arrays (e.g., `Tuple[Int, Int]`).

### Performance Optimization
`Type::Tiny` (the engine behind these types) can generate optimized inlined code.
- Use `Type::Utils::dwim_type` if you need to parse type strings dynamically.
- For high-performance loops, use the `compiled_check` method to get a sub reference.

### Coercions
Types often come with built-in or custom coercions. Use the `plus_coercions` method to add logic that transforms data into the required type (e.g., converting a string to an array reference).

## Reference documentation
- [Types::Standard Manual](./references/metacpan_org_pod_release_TOBYINK_Type-Tiny-1.002001_lib_Types_Standard.pm.md)