---
name: perl-memoize
description: The `perl-memoize` skill provides a mechanism to trade memory for speed in Perl scripts.
homepage: http://metacpan.org/pod/Memoize
---

# perl-memoize

## Overview
The `perl-memoize` skill provides a mechanism to trade memory for speed in Perl scripts. It transparently wraps existing functions so that subsequent calls with identical arguments return cached results instead of re-executing the logic. This is particularly effective for functions with high computational costs or those that perform redundant sub-calculations.

## Usage Patterns

### Basic Memoization
To memoize a function in place, simply call `memoize` with the function name.
```perl
use Memoize;

sub expensive_calc {
    my $input = shift;
    # ... complex logic ...
    return $result;
}

memoize('expensive_calc');
# Subsequent calls to expensive_calc() are now cached.
```

### Creating a New Memoized Alias
Use the `INSTALL` option to keep the original function intact while creating a faster version.
```perl
memoize('fib', INSTALL => 'fast_fib');
# Original 'fib' remains unmemoized; 'fast_fib' is the cached version.
```

### Handling Equivalent Arguments (Normalizers)
If your function accepts arguments that can be represented in multiple ways (e.g., default values or hash keys in different orders), use a `NORMALIZER` to ensure they share a cache entry.
```perl
# Normalizer that sorts hash keys or fills defaults
sub my_normalizer {
    my @args = @_;
    # Return a string representing the "canonical" form of the arguments
    return join(';', sort @args);
}

memoize('my_func', NORMALIZER => 'my_normalizer');
```

## Best Practices
- **Deterministic Functions Only**: Only memoize functions that are "pure" (given the same input, they always return the same output and have no side effects).
- **Memory Management**: Be cautious when memoizing functions with a vast range of possible inputs, as the cache grows indefinitely in memory by default.
- **Context Awareness**: By default, `Memoize` maintains separate caches for scalar and list contexts. If your function returns the same value regardless of context, use `SCALAR_CACHE => 'MERGE'` or `LIST_CACHE => 'MERGE'` to save space.
- **Persistent Caching**: For data that should persist across script executions, you can link the cache to a file-based DB_File or GDBM_File using the `HASH` option:
  ```perl
  use DB_File;
  tie my %cache => 'DB_File', $filename, O_RDWR|O_CREAT, 0666;
  memoize('expensive_func', SCALAR_CACHE => ['HASH', \%cache]);
  ```

## Reference documentation
- [Memoize - Make functions faster by trading space for time](./references/metacpan_org_pod_Memoize.md)