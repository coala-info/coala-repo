---
name: perl-math-complex
description: The `Math::Complex` module provides a robust framework for handling complex numbers in Perl as first-class objects.
homepage: http://metacpan.org/pod/Math::Complex
---

# perl-math-complex

## Overview

The `Math::Complex` module provides a robust framework for handling complex numbers in Perl as first-class objects. It overloads standard arithmetic operators, allowing you to perform calculations on complex numbers using familiar syntax. This skill is particularly useful for transitioning from simple real-number math to complex plane calculations without manually managing real and imaginary parts.

## Usage Guidelines

### Basic Implementation
To enable complex number support in a Perl script, include the module at the top of your file. This automatically overloads standard operators (+, -, *, /, **, etc.).

```perl
use Math::Complex;

# Create complex numbers using the 'i' constant or make_complex
my $z1 = 3 + 4*i;
my $z2 = Math::Complex->make(5, -2);

# Standard arithmetic works naturally
my $sum = $z1 + $z2;
my $product = $z1 * $z2;
```

### Polar and Cartesian Conversions
The module excels at switching between coordinate systems, which is critical for phase and magnitude calculations in engineering.

- **To Polar**: Use `rho` (magnitude) and `theta` (angle/phase).
- **To Cartesian**: Use `Re` (real) and `Im` (imaginary).

```perl
my $z = 1 + i;
my $rho   = $z->rho;   # Magnitude (sqrt(2))
my $theta = $z->theta; # Angle (pi/4)

# Create from polar coordinates [rho, theta]
my $z_polar = Math::Complex->emake(2, pi/2); # Result: 2i
```

### Advanced Trigonometry
`Math::Complex` provides versions of trigonometric functions that handle complex arguments, which the standard Perl `Math` library does not support.

- **Functions**: `sin`, `cos`, `tan`, `asin`, `acos`, `atan`, `exp`, `log`, `sqrt`.
- **Hyperbolics**: `sinh`, `cosh`, `tanh`, `asinh`, `acosh`, `atanh`.

### Best Practices
- **Stringification**: When printed, complex numbers are automatically formatted as `a+bi` or `a-bi`.
- **Precision**: Be aware that floating-point inaccuracies can result in very small non-zero values (e.g., `1.23e-16`) instead of absolute zero. Use `Re()` and `Im()` to extract parts for comparison.
- **Performance**: Overloading adds overhead. For extremely high-performance loops where only real numbers are used, stick to standard Perl math; use `Math::Complex` specifically when the domain involves the complex plane.

## Reference documentation

- [Math::Complex Documentation](./references/metacpan_org_pod_Math__Complex.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-math-complex_overview.md)