---
name: perl-list-moreutils
description: This Perl module provides a comprehensive set of high-performance list processing functions that extend the core library. Use when user asks to check list properties with boolean logic, filter unique elements, partition lists, or iterate through multiple arrays simultaneously.
homepage: https://metacpan.org/release/List-MoreUtils
---


# perl-list-moreutils

## Overview
`List::MoreUtils` is a standard Perl module that extends the core `List::Util` library. It provides a comprehensive set of high-performance list processing functions implemented in C (via XS) with Perl fallbacks. This skill helps in selecting the most efficient list processing functions to reduce boilerplate code and improve readability in Perl applications.

## Common Functional Patterns

### Boolean Logic and Searching
Check list properties without manual loops:
- `any { BLOCK } @list`: Returns true if any element satisfies the condition.
- `all { BLOCK } @list`: Returns true only if all elements satisfy the condition.
- `none { BLOCK } @list`: Returns true if no elements satisfy the condition.
- `notall { BLOCK } @list`: Returns true if at least one element fails the condition.
- `firstidx { BLOCK } @list`: Returns the index of the first matching element (or -1).
- `lastidx { BLOCK } @list`: Returns the index of the last matching element (or -1).

### List Transformation and Filtering
- `uniq @list`: Returns a list of unique elements (preserves order).
- `singleton @list`: Returns only elements that appear exactly once in the list.
- `part { BLOCK } @list`: Partitions a list into a list of arrays based on the integer returned by the block.
- `mesh @a, @b, @c`: Interleaves multiple arrays (also known as `zip`).

### Iteration and Slicing
- `natatime $n, @list`: Creates an iterator that returns $n$ elements at a time.
- `each_array @a, @b`: Creates an iterator to traverse multiple arrays simultaneously.
- `indexes { BLOCK } @list`: Returns the indices of all elements satisfying the condition.

## Best Practices
- **Importing**: Only import the specific functions needed to keep the namespace clean: `use List::MoreUtils qw(uniq any mesh);`.
- **Performance**: Prefer `List::MoreUtils` over manual `grep` or `foreach` loops for complex operations like finding unique elements or partitioning, as the XS implementation is significantly faster.
- **Context**: Be mindful that most functions behave differently in scalar vs. list context. For example, `indexes` returns the count of matches in scalar context but the actual indices in list context.

## Reference documentation
- [List-MoreUtils Documentation](./references/metacpan_org_release_List-MoreUtils.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-list-moreutils_overview.md)