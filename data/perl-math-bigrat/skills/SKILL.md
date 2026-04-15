---
name: perl-math-bigrat
description: This Perl module enables the handling and calculation of arbitrary-precision rational numbers as exact fractions. Use when user asks to perform exact arithmetic with large fractions, represent numbers without rounding errors, or manipulate numerators and denominators of big rational values.
homepage: http://metacpan.org/pod/Math::BigRat
metadata:
  docker_image: "quay.io/biocontainers/perl-math-bigrat:0.2624--pl5321hdfd78af_0"
---

# perl-math-bigrat

## Overview

Math::BigRat is a Perl module designed for handling arbitrary big rational numbers. While standard floating-point variables often suffer from rounding errors and precision limits, Math::BigRat maintains numbers as fractions (numerator/denominator). This allows for exact representation of values like 1/3 or 1/7 and ensures that operations like addition, multiplication, and division remain mathematically perfect regardless of the number of digits involved.

## Usage Instructions

### Perl One-Liners (CLI Patterns)

For quick calculations from the command line, use the `-M` flag to load the module:

*   **Basic Addition:**
    `perl -MMath::BigRat -E 'say Math::BigRat->new("1/3") + Math::BigRat->new("1/6")'`
    *Output: 1/2*

*   **Complex Expressions:**
    `perl -MMath::BigRat -E '$r = Math::BigRat->new("2/7"); say $r->add("3/5")->bstr()'`
    *Output: 31/35*

*   **Converting to Float (Approximation):**
    `perl -MMath::BigRat -E 'say Math::BigRat->new("22/7")->pstr()'`

### Core Methods

*   **Constructor:** Always pass values as strings to `Math::BigRat->new()` to prevent the Perl interpreter from converting them to floats before the module can process them.
*   **Arithmetic:** Supports standard operators (`+`, `-`, `*`, `/`, `**`) via operator overloading, or explicit methods like `badd()`, `bsub()`, `bmul()`, and `bdiv()`.
*   **Comparison:** Use `bcmp()` for three-way comparison (-1, 0, 1) or standard overloaded operators (`==`, `!=`, `<`, `>`).

### Extracting Components

To access the numerator and denominator separately:
```perl
my ($numerator, $denominator) = $rat->parts();
```

## Expert Tips

*   **String Input is Critical:** When initializing a BigRat, use `Math::BigRat->new("0.1")` instead of `Math::BigRat->new(0.1)`. The latter passes a standard Perl float to the constructor, which already contains binary rounding errors.
*   **Normalization:** By default, Math::BigRat reduces fractions to their simplest form (e.g., 4/8 becomes 1/2). If you need to control this, check the `bnorm()` method.
*   **Performance:** Arbitrary precision math is significantly slower than native floating-point math. Use this module only when precision is more important than execution speed.
*   **Integration with BigInt:** Math::BigRat uses Math::BigInt internally for the numerator and denominator. You can pass BigInt objects directly into BigRat constructors.

## Reference documentation
- [Math::BigRat - Arbitrary big rational numbers](./references/metacpan_org_pod_Math__BigRat.md)
- [perl-math-bigrat Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-math-bigrat_overview.md)