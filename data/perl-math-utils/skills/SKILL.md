---
name: perl-math-utils
description: The `Math::Utils` module provides a collection of frequently needed mathematical functions that are missing from the standard Perl distribution.
homepage: http://metacpan.org/pod/Math::Utils
---

# perl-math-utils

## Overview
The `Math::Utils` module provides a collection of frequently needed mathematical functions that are missing from the standard Perl distribution. It is particularly useful for scientific computing, data processing, and financial calculations where precise rounding, robust floating-point comparisons, and sequence generation are required.

## Usage Guidelines

### Importing Functions
Functions are not exported by default. Import specific functions or use tags:
- `use Math::Utils qw(:round :generate :compare);`
- `:round` - `round`, `round_even`, `round_odd`, `round_prec`
- `:generate` - `uniform_range`, `log_range`
- `:compare` - `fcmprel`, `fltcmp`
- `:arithmetic` - `gcd`, `lcm`

### Key Operations

#### 1. Range Generation
Generate sequences of numbers with specific spacing:
- `uniform_range($start, $stop, $n)`: Returns $n$ points from $start$ to $stop$.
- `log_range($start, $stop, $n)`: Returns $n$ points distributed logarithmically.

#### 2. Precision Rounding
- `round_prec($number, $precision)`: Rounds to a specific decimal place (e.g., `$precision = 0.01` rounds to two decimals).
- `round_even($number)` / `round_odd($number)`: Rounds to the nearest even or odd integer.

#### 3. Floating Point Comparison
Avoid direct `==` with floats. Use relative epsilon comparisons:
- `fcmprel($a, $b)`: Returns -1, 0, or 1 based on relative difference.

#### 4. Integer Math
- `gcd(@list)`: Returns the greatest common divisor of a list of integers.
- `lcm(@list)`: Returns the least common multiple.

## Best Practices
- **Context Awareness**: Most generation functions return a list in list context and the number of elements in scalar context.
- **Input Validation**: Ensure inputs to `gcd` and `lcm` are integers to avoid unexpected floating-point behavior.
- **Precision**: When using `round_prec`, define the precision as a power of 10 (0.1, 0.01, etc.) for predictable results.

## Reference documentation
- [Math::Utils Documentation](./references/metacpan_org_pod_Math__Utils.md)