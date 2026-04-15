---
name: perl-number-witherror
description: This tool provides a container for numbers with associated uncertainties that automatically handles Gaussian error propagation during mathematical operations. Use when user asks to perform arithmetic on values with errors, track uncertainty in scientific calculations, or format numbers based on significant figures.
homepage: http://metacpan.org/pod/Number::WithError
metadata:
  docker_image: "quay.io/biocontainers/perl-number-witherror:1.01--pl526_0"
---

# perl-number-witherror

## Overview
The `Number::WithError` Perl module provides a container for numbers that have an associated uncertainty or error component. Instead of manually calculating how errors propagate through complex formulas, this skill allows you to treat these values as objects that automatically track their own precision. It is particularly useful for laboratory data processing, physical simulations, and any scenario where "significant figures" and error margins are critical for the validity of the result.

## Basic Usage Patterns

### Creating Objects
Initialize numbers with their associated errors. You can provide a single error or multiple independent error components.
```perl
use Number::WithError;

# Single error: 10 +/- 0.2
my $num = Number::WithError->new(10, 0.2);

# Multiple errors (e.g., systematic and statistical): 5.5 +/- 0.1 +/- 0.02
my $complex = Number::WithError->new(5.5, 0.1, 0.02);

# Parsing from string
my $parsed = Number::WithError->new("1.23(4)");
```

### Arithmetic and Propagation
Standard mathematical operators are overloaded. The module uses the Gaussian error propagation formula (square root of the sum of squares of partial derivatives) for independent variables.
```perl
my $a = Number::WithError->new(10, 1);
my $b = Number::WithError->new(20, 2);

my $sum = $a + $b;       # Result: 30 +/- 2.236
my $prod = $a * $b;      # Result: 200 +/- 28.28
my $power = $a ** 2;     # Result: 100 +/- 20
```

### Scientific Rounding and Stringification
The module automatically rounds the number based on the magnitude of the error when converted to a string.
```perl
my $val = Number::WithError->new(1.23456, 0.0123);
print $val; # Outputs rounded version based on significant error digits
```

## Expert Tips
- **Array Support**: You can create arrays of `Number::WithError` objects to perform batch calculations on datasets while maintaining individual error margins.
- **Accessing Components**: Use `$num->number` to get the raw value and `$num->error` (or `$num->errors` for an array ref) to retrieve the uncertainty components.
- **Precision Control**: While the module handles rounding automatically for display, internal calculations maintain higher precision to prevent rounding error accumulation.

## Reference documentation
- [Number::WithError Documentation](./references/metacpan_org_pod_Number__WithError.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-number-witherror_overview.md)