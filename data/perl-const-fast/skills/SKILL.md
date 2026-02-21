---
name: perl-const-fast
description: The `Const::Fast` module is a streamlined alternative to the built-in `constant` pragma and `Readonly` module.
homepage: http://metacpan.org/pod/Const-Fast
---

# perl-const-fast

## Overview
The `Const::Fast` module is a streamlined alternative to the built-in `constant` pragma and `Readonly` module. It allows you to tag variables as read-only at the point of declaration. This is particularly useful for defining global configuration, fixed lookup tables, or mathematical constants where performance and data integrity are priorities. Unlike standard constants, these variables behave like normal variables (including interpolation in strings) but throw an error if any code attempts to modify them.

## Usage Instructions

### Basic Implementation
Import the `const` function to begin defining immutable data structures.

```perl
use Const::Fast;

# Scalar constant
const my $DEBUG_LEVEL => 2;

# Array constant
const my @SUPPORTED_FORMATS => qw( fastq bam sam );

# Hash constant
const my %DEFAULT_CONFIG => (
    threads => 4,
    tmp_dir => '/tmp',
);
```

### Best Practices
- **Lexical Scoping**: Always use `my` with `const` to keep constants scoped to the smallest necessary block.
- **Deep Immutability**: `Const::Fast` makes the entire structure read-only. If you define a constant hash, all nested keys and values are also protected from modification.
- **Interpolation**: Use these constants in strings just like regular variables: `print "Current level: $DEBUG_LEVEL";`.
- **Error Handling**: Be aware that attempting to modify a `Const::Fast` variable will cause the Perl interpreter to `die`. Use this to catch logic errors during development.

### Comparison with `use constant`
- **Interpolation**: `Const::Fast` variables interpolate in double-quoted strings; `use constant` symbols do not.
- **Data Structures**: `Const::Fast` handles arrays and hashes naturally as variables; `use constant` often requires references for complex structures.
- **Timing**: `Const::Fast` assignments happen at runtime (when the line is executed), whereas `use constant` happens at compile time.

## Reference documentation
- [Const::Fast Documentation](./references/metacpan_org_pod_Const-Fast.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-const-fast_overview.md)