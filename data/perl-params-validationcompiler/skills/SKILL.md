---
name: perl-params-validationcompiler
description: This skill facilitates the creation of highly efficient parameter validation routines in Perl.
homepage: http://metacpan.org/release/Params-ValidationCompiler
---

# perl-params-validationcompiler

## Overview
This skill facilitates the creation of highly efficient parameter validation routines in Perl. Unlike traditional validation modules that interpret rules at runtime, `Params::ValidationCompiler` generates a customized, optimized subroutine (often using `Eval::Closure`) that performs the specific checks required. This "compile once, use many" approach significantly reduces overhead in frequently called subroutines.

## Usage Patterns

### Basic Named Parameters
Use `validation_for` to create a validator. It is best practice to store the resulting code reference in a `state` variable or a lexical variable outside the sub to ensure it is only compiled once.

```perl
use Params::ValidationCompiler qw( validation_for );
use Types::Standard qw( Int Str );

sub set_user {
    state $validator = validation_for(
        params => {
            id   => { type => Int },
            name => { type => Str },
        },
    );
    my %args = $validator->(@_);
    # ...
}
```

### Positional Parameters
For positional arguments, set the `method` or `slurpy` options as needed.

```perl
sub add_point {
    state $validator = validation_for(
        params => [ { type => Int }, { type => Int } ],
    );
    my ($x, $y) = $validator->(@_);
}
```

### Handling Extra Arguments
By default, validators croak on unknown parameters. Control this behavior with `allow_extra`:

- `allow_extra => 1`: Unknown parameters are ignored and not returned.
- `allow_extra => 0`: (Default) Throws an exception if unknown parameters are passed.

### Integration with Type Systems
The compiler is designed to work seamlessly with:
- **Type::Tiny**: Use `Types::Standard`.
- **Specio**: Use `Specio::Library::Builtins`.
- **Moose**: Use `MooseX::Types`.

### Performance Optimization
- **Avoid Re-compilation**: Never call `validation_for` inside the body of a loop or a frequently called sub without caching it in a `state` variable.
- **Named vs. Positional**: Positional validation is generally faster than named validation.
- **Inlining**: The module automatically attempts to inline type checks if the type library supports it (like Type::Tiny), resulting in code that is as fast as manual `die` checks.

## Reference documentation
- [Params-ValidationCompiler on MetaCPAN](./references/metacpan_org_release_Params-ValidationCompiler.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-params-validationcompiler_overview.md)