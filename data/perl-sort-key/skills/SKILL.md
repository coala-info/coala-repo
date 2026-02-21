---
name: perl-sort-key
description: The `perl-sort-key` skill focuses on the `Sort::Key` Perl module, which provides a fast and memory-efficient way to sort data by calculating sort keys only once.
homepage: http://metacpan.org/pod/Sort-Key
---

# perl-sort-key

## Overview
The `perl-sort-key` skill focuses on the `Sort::Key` Perl module, which provides a fast and memory-efficient way to sort data by calculating sort keys only once. It is significantly faster than the native Perl `sort` function for complex keys because it avoids the overhead of repeated subroutine calls and key recalculation. Use this when performance is critical or when sorting large arrays where the key extraction logic is expensive.

## Core Usage Patterns

### Basic Sorting
Instead of using `sort { $a <=> $b } @data`, use the type-specific functions provided by Sort::Key:

- **Integers**: `ikeysort { $_->id } @objects`
- **Floating Point**: `nkeysort { $_->price } @objects`
- **Strings**: `keysort { $_->name } @objects`
- **Natural Sort**: `nckeysort { $_->version } @versions` (case-insensitive natural order)

### Multi-Key Sorting
To sort by multiple criteria (e.g., by last name, then first name), use `multikeysort`:

```perl
use Sort::Key qw(multikeysort);
my @sorted = multikeysort [\&last_name, \&first_name], @people;
```

### Reverse Sorting
Every function has a corresponding reverse version prefixed with `r`:
- `rikeysort` (Reverse integer sort)
- `rnkeysort` (Reverse numeric/float sort)
- `rkeysort` (Reverse string sort)

## Performance Best Practices
1. **Select the Right Type**: Always use the most specific function (e.g., `ikeysort` for integers) rather than the generic `keysort` to minimize internal conversions.
2. **Avoid Subroutine Overhead**: For very large lists, ensure the key extraction block is as simple as possible.
3. **In-place Sorting**: Use the `_inplace` variants to save memory if the original array order does not need to be preserved:
   ```perl
   use Sort::Key qw(ikeysort_inplace);
   ikeysort_inplace { $_->rank } @big_array;
   ```

## Common Key Types
- `i`: Integer
- `n`: Numeric (Floating point)
- `c`: Character (String)
- `l`: Locale-based string
- `nc`: Natural sort (handles "file10.txt" after "file2.txt")

## Reference documentation
- [Sort::Key Documentation](./references/metacpan_org_pod_Sort-Key.md)