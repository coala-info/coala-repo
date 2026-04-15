---
name: perl-readonly
description: This module creates non-modifiable scalars, arrays, and hashes in Perl that support lexical scoping and deep immutability. Use when user asks to create read-only variables, define immutable nested data structures, or declare constants that retain standard sigils for string interpolation.
homepage: https://github.com/sanko/readonly
metadata:
  docker_image: "quay.io/biocontainers/perl-readonly:2.05--pl526_0"
---

# perl-readonly

## Overview
The `perl-readonly` module provides a facility for creating non-modifiable scalars, arrays, and hashes in Perl. Unlike the standard `constant` pragma, variables created with this module retain their sigils ($ , @ , % ), can be lexically scoped using `my`, and support deep immutability for complex nested data structures. This makes it a superior choice for configuration files, headers, and defensive programming.

## Installation
To install the package via Bioconda:
```bash
conda install bioconda::perl-readonly
```

## Core Usage Patterns

### Basic Declarations
The module supports both functional and shorthand syntax. For Perl 5.8 and later, the shorthand is preferred for readability.

```perl
use Readonly;

# Scalars
Readonly::Scalar my $CONF_DIR => '/etc/myapp';
Readonly my $VERSION => '1.0.1';

# Arrays
Readonly::Array my @COLORS => ('red', 'green', 'blue');
Readonly my @PORTS => (80, 443, 8080);

# Hashes
Readonly::Hash my %DEFAULTS => (timeout => 30, retries => 3);
Readonly my %MAP => (key1 => 'val1', key2 => 'val2');
```

### Deep vs. Shallow Immutability
By default, `Readonly::Scalar`, `Readonly::Array`, and `Readonly::Hash` are "deep"—they recurse through references to make the entire structure non-modifiable.

*   **Deep (Default)**: Use `Readonly::Scalar $ref => { ... }`. Modifying `$ref->{key}` will cause the program to die.
*   **Shallow**: Use the `1` suffix functions (`Scalar1`, `Array1`, `Hash1`) if you only want the top-level container to be read-only while allowing internal reference modification.

```perl
# Deeply read-only: This will die if you try to change a nested value
Readonly::Scalar my $config => { database => { host => 'localhost' } };
$config->{database}{host} = 'remote'; # Error: Modification of a read-only value attempted

# Shallow read-only: Top level is fixed, but nested values can change
Readonly::Scalar1 my $shallow_ref => { a => 1 };
$shallow_ref->{a} = 2; # This succeeds
```

## Expert Tips and Best Practices

### Lexical Scoping
Unlike `use constant`, which creates package-level symbols, `Readonly` works perfectly with `my`. Always prefer lexical scoping to prevent namespace pollution:
```perl
{
    Readonly my $LOCAL_CONST => 42;
    # $LOCAL_CONST is only visible in this block
}
```

### Interpolation
Because `Readonly` variables use standard sigils, they can be interpolated directly into strings, avoiding the clunky concatenation required by bareword constants:
```perl
Readonly my $USER => 'admin';
print "Welcome, $USER!"; # Works perfectly
```

### Performance Considerations
In modern Perl environments (5.8.x and higher), `Readonly` is highly optimized. While older versions relied on `tie` (which was slow), modern versions use internal SV flags. You do not need `Readonly::XS` for performance on modern Perl.

### Handling Undef
If you need a read-only variable initialized to `undef`, you must provide it explicitly:
```perl
Readonly my $EMPTY => undef;
```

## Reference documentation
- [Readonly - Facility for creating read-only scalars, arrays, hashes](./references/github_com_sanko_readonly.md)
- [perl-readonly - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-readonly_overview.md)