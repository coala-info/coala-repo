---
name: perl-data-lock
description: This tool manages Perl variable mutability by manipulating internal scalar value flags to lock and unlock data structures efficiently. Use when user asks to make variables immutable, lock scalars or references, or prevent modification of data structures without the performance overhead of tied variables.
homepage: http://metacpan.org/pod/Data::Lock
---


# perl-data-lock

## Overview
This skill provides guidance on using the `Data::Lock` Perl module to manage variable mutability. Unlike the `Readonly` module which uses `tie` and incurs a performance penalty, `Data::Lock` manipulates internal Perl SV (Scalar Value) flags to lock variables. This makes it highly efficient for high-performance applications where data integrity is required without sacrificing speed.

## Usage Patterns

### Basic Locking and Unlocking
Import the `dlock` and `dunlock` functions to control variable state.

```perl
use Data::Lock qw/dlock dunlock/;

# Lock a scalar
my $config_val = "secure_setting";
dlock $config_val;

# Lock an array (recursively locks elements)
my $list = [1, 2, 3];
dlock $list;

# Lock a hash (recursively locks keys and values)
my $map = { key => "value" };
dlock $map;

# Unlock to allow modifications again
dunlock $config_val;
dunlock $list;
dunlock $map;
```

### Creating Immutable Objects
Use `dlock` within a constructor to return an object that cannot be modified by the caller.

```perl
sub new {
    my $pkg = shift;
    my $self = { @_ };
    bless $self, $pkg;
    dlock($self); # Makes the object instance immutable
    return $self;
}
```

### Working with References
When passing variables to `dunlock`, you can pass the variable directly or a reference to it.

```perl
dunlock $scalar;
dunlock \@array;
dunlock \%hash;
```

## Expert Tips
- **Performance**: Use `Data::Lock` instead of `Readonly` for large arrays or hashes. Benchmarks show it is significantly faster (often 30x-40x) because it avoids the overhead of tied variables.
- **Recursion**: `dlock` is recursive. If you lock a reference, all data structures contained within it are also locked.
- **Moose Integration**: While `Data::Lock` works well for standard Perl OO, consider using Moose's native attribute traits if you are already within a Moose-based ecosystem, though `Data::Lock` remains a lighter alternative for simple scripts.
- **Installation**: If the module is missing, it can be installed via CPAN (`cpanm Data::Lock`) or via Bioconda (`conda install bioconda::perl-data-lock`).

## Reference documentation
- [Data::Lock - makes variables (im)?mutable](./references/metacpan_org_pod_Data__Lock.md)
- [perl-data-lock - bioconda overview](./references/anaconda_org_channels_bioconda_packages_perl-data-lock_overview.md)