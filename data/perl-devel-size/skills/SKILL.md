---
name: perl-devel-size
description: This tool measures the memory consumption of Perl data structures in bytes. Use when user asks to quantify the size of variables, calculate the total memory used by nested data structures, or profile memory usage to debug leaks.
homepage: http://metacpan.org/pod/Devel::Size
---


# perl-devel-size

## Overview
The `perl-devel-size` skill provides the ability to precisely quantify how much memory Perl data structures occupy. While Perl manages memory automatically, large or deeply nested structures can consume significant resources. This tool allows developers to inspect the "real" size of variables in bytes, distinguishing between the memory used by a single container and the total memory used by all elements within a recursive structure.

## Usage Instructions

### Basic Memory Measurement
To find the size of a specific variable (not including its contents if it is a reference), use `size()`.
```perl
use Devel::Size qw(size total_size);

my $scalar = "A relatively long string that takes up some space";
print "Size of scalar: " . size($scalar) . " bytes\n";

my @array = (1..1000);
print "Size of array overhead: " . size(\@array) . " bytes\n";
```

### Recursive Memory Measurement
To find the total memory used by a complex data structure, including all nested references and elements, use `total_size()`. This is the most common function used for memory profiling.
```perl
my $complex_hash = {
    users => [ { id => 1, name => "Alice" }, { id => 2, name => "Bob" } ],
    metadata => { version => "1.0", tags => ["admin", "test"] }
};

print "Total memory used: " . total_size($complex_hash) . " bytes\n";
```

### Expert Tips & Best Practices
- **Reference Passing**: Always pass a reference to `size()` or `total_size()` when inspecting arrays or hashes to avoid creating a copy of the data, which would skew memory results.
- **String Interning**: Be aware that Perl may share string storage (copy-on-write). `Devel::Size` reports the size of the variable's buffer, which may not always reflect shared memory optimizations.
- **Overhead Awareness**: Remember that a Perl hash or array has significant memory overhead compared to a C-style struct. Use `total_size()` to see the impact of hash keys and bucket allocation.
- **Tracking Growth**: To debug memory leaks, capture `total_size()` at different points in a loop to identify which structure is growing unexpectedly.

## Reference documentation
- [Devel::Size Documentation](./references/metacpan_org_pod_Devel__Size.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-devel-size_overview.md)