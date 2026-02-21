---
name: perl-bignum
description: The perl-bignum skill enables transparent arbitrary-precision arithmetic in Perl environments.
homepage: http://metacpan.org/pod/bignum
---

# perl-bignum

## Overview

The perl-bignum skill enables transparent arbitrary-precision arithmetic in Perl environments. It is used to bypass the limitations of standard 64-bit integer and floating-point types, making it essential for tasks involving cryptography, scientific simulations, or financial calculations where precision is critical. By invoking this pragma, Perl automatically promotes numeric literals to big-number objects, ensuring that calculations like `2**512` return exact results rather than infinity or truncated values.

## Usage and Best Practices

### Basic Implementation
Enable transparent big number support by including the pragma at the start of a script or via the command line.

*   **In scripts**: Use `use bignum;` to make all literal integers `Math::BigInt` and all non-integers `Math::BigFloat`.
*   **Command line**: Use the `-M` flag for quick calculations:
    ```bash
    perl -Mbignum -e 'print 2**1024'
    ```

### Controlling Scope
The pragma is lexically scoped. Use `no bignum` to return to standard Perl numeric handling within a specific block.

```perl
use bignum;
$big = 2**512; 
{
    no bignum;
    $normal = 5 + 5; # Standard Perl scalar
}
```

### Handling Hexadecimal and Octal
By default, `hex()` and `oct()` are not overridden in older Perl versions. To handle large hex strings, import them explicitly:

```perl
use bignum qw/hex oct/;
print hex("0x12345678901234567890");
```

### Advanced Configuration
Fine-tune how numbers are handled using the `upgrade` and `downgrade` options.

*   **Rational Numbers**: To use fractions instead of floats for non-integers, upgrade to `Math::BigRat`:
    ```perl
    use bignum upgrade => "Math::BigRat";
    print 2 / 3; # Outputs 2/3 instead of 0.666...
    ```
*   **Disable Automatic Conversion**: To prevent integers from becoming floats during division, set `upgrade => undef`.

### Method Calls
Since literals become objects, you can call `Math::BigInt` or `Math::BigFloat` methods directly on them:

```perl
use bignum;
print 2->bstr();
print 42->is_odd();
```

## Expert Tips

*   **Integer Detection**: Note that `bignum` looks at the *value*, not the representation. `3.14e2` is treated as a `Math::BigInt` because its value is 314.
*   **Performance**: Big number arithmetic is significantly slower than native machine precision. Only use `bignum` in scopes where high precision is actually required.
*   **Accuracy vs. Precision**: Use `a` (accuracy) or `p` (precision) arguments to limit the number of digits:
    ```perl
    use bignum a => 50; # Set global accuracy to 50 digits
    ```

## Reference documentation

- [bignum - transparent big number support for Perl](./references/metacpan_org_pod_bignum.md)
- [perl-bignum - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-bignum_overview.md)