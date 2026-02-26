---
name: perl-math-bigint
description: This tool provides libraries for arbitrary-precision integer and floating-point arithmetic in Perl. Use when user asks to perform calculations with very large numbers, handle high-precision decimals, or avoid overflow and precision loss in mathematical operations.
homepage: http://metacpan.org/pod/Math::BigInt
---


# perl-math-bigint

## Overview
The `perl-math-bigint` package provides the `Math::BigInt` and `Math::BigFloat` libraries, which allow for arbitrary-precision integer and floating-point arithmetic. Standard Perl scalars are limited by the underlying architecture's word size (typically 64-bit), leading to overflow or precision loss with very large numbers. This skill enables the handling of numbers of any size, limited only by available memory, ensuring exact results for operations like addition, multiplication, and modular exponentiation.

## Usage Patterns and Best Practices

### Basic Initialization
Always initialize objects using strings to prevent Perl from truncating the number before it reaches the library.
```perl
use Math::BigInt;

# Correct: Initializing from a string
my $huge_int = Math::BigInt->new("123456789012345678901234567890");

# Avoid: Initializing from a literal (may lose precision immediately)
my $bad_int = Math::BigInt->new(123456789012345678901234567890);
```

### Method Chaining vs. In-Place Modification
Most `Math::BigInt` methods modify the object in place for performance. If you need to preserve the original value, use the `copy()` method.
```perl
my $a = Math::BigInt->new(10);
my $b = $a->copy()->badd(5); # $a remains 10, $b is 15

$a->badd(5); # $a is now 15
```

### Common Arithmetic Methods
Note that methods often start with 'b' (e.g., `badd`, `bsub`, `bmul`, `bdiv`).
- `badd($n)`: Addition
- `bsub($n)`: Subtraction
- `bmul($n)`: Multiplication
- `bdiv($n)`: Division (returns object in scalar context, list of (quotient, remainder) in list context)
- `bmod($n)`: Modulus
- `bpow($n)`: Power/Exponentiation

### High-Precision Comparisons
Standard comparison operators (`==`, `>`, `<`) are overloaded and work correctly with `Math::BigInt` objects, but using the functional `bcmp` method is more explicit in complex logic.
```perl
if ($huge_int->bcmp($other_int) == 0) {
    print "Numbers are equal";
}
```

### Performance Optimization (Backends)
For intensive calculations, ensure a fast backend like `Math::BigInt::GMP` or `Math::BigInt::Pari` is installed. The library will automatically use them if available, significantly speeding up operations.
```perl
# Check which backend is active
print Math::BigInt->config()->{lib};
```

## Reference documentation
- [Math::BigInt - arbitrary size integer math package](./references/metacpan_org_pod_Math__BigInt.md)
- [perl-math-bigint - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-math-bigint_overview.md)