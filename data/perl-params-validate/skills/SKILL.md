---
name: perl-params-validate
description: This skill facilitates the implementation of strict parameter validation in Perl applications.
homepage: http://metacpan.org/pod/Params-Validate
---

# perl-params-validate

## Overview

This skill facilitates the implementation of strict parameter validation in Perl applications. `Params::Validate` allows developers to define schemas for subroutine arguments, ensuring that inputs match expected types (scalars, arrayrefs, hashrefs, etc.) or adhere to custom callback logic. It is particularly useful for catching API contract violations early and providing clear error messages when a function is called with incorrect arguments.

## Core Usage Patterns

### Basic Positional Validation
Use `validate_pos` for functions using standard `@_` arrays.
```perl
use Params::Validate qw(:all);

sub set_dimensions {
    my @args = validate_pos(@_, 
        { type => SCALAR },                 # Width
        { type => SCALAR },                 # Height
        { type => SCALAR, default => 0 }    # Depth (optional)
    );
    my ($w, $h, $d) = @args;
}
```

### Named Parameter Validation
Use `validate` for hashref-style arguments, which is the preferred pattern for functions with many parameters.
```perl
sub create_user {
    my %p = validate(@_, {
        username => { type => SCALAR },
        age      => { type => SCALAR, regex => qr/^\d+$/ },
        roles    => { type => ARRAYREF, optional => 1 },
    });
}
```

### Object-Oriented Validation
When validating method calls, use `validate_with` to handle the leading `$self` object efficiently.
```perl
sub update_record {
    my $self = shift;
    my %p = validate_with(
        params => \@_,
        spec   => {
            id   => { type => SCALAR },
            data => { type => HASHREF },
        },
        allow_extra => 0,
    );
}
```

## Validation Spec Constants
Use these constants to define expected types:
- `SCALAR`: Standard string or number.
- `ARRAYREF` / `HASHREF`: Reference types.
- `CODEREF`: Subroutine references.
- `GLOB` / `GLOBREF`: Filehandles.
- `HANDLE`: Any filehandle-like object.
- `UNDEF`: Explicitly allows `undef`.

## Expert Tips

### Custom Callbacks
For logic that cannot be expressed via types (e.g., range checking), use the `callbacks` key:
```perl
spec => {
    percentage => { 
        callbacks => {
            'between 0 and 100' => sub { $_[0] >= 0 && $_[0] <= 100 }
        }
    }
}
```

### Global Options
To change behavior globally (e.g., making all parameters optional by default or changing error reporting), use `validation_options`:
```perl
Params::Validate::validation_options(
    on_fail => sub { croak "Custom error: " . $_[0] },
    allow_extra => 1,
);
```

### Performance Optimization
Validation is computationally expensive. In performance-critical loops, consider wrapping the validation in a conditional that checks an environment variable (e.g., `if ($DEBUG)`) or using `Params::Validate` only at the public API boundaries of your modules.

## Reference documentation
- [Params::Validate Documentation](./references/metacpan_org_pod_Params-Validate.md)