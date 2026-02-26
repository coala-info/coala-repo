---
name: perl-scalar-list-utils
description: This tool provides high-performance C-based implementations for common functional programming routines and scalar variable introspection in Perl. Use when user asks to find elements in a list, calculate numeric sums or extremes, shuffle arrays, inspect variable types, or manage weak references to prevent memory leaks.
homepage: http://metacpan.org/pod/Scalar-List-Utils
---


# perl-scalar-list-utils

## Overview
The `Scalar::Util` and `List::Util` modules (bundled as `Scalar-List-Utils`) provide high-performance C-based implementations of common functional programming and scalar inspection routines. Use these utilities instead of manual loops or complex regex checks to improve code readability, performance, and reliability in Perl scripts.

## Core List Utilities (List::Util)
Import these functions to handle arrays and lists efficiently:

- **Reduction & Search**:
  - `first { BLOCK } @list`: Returns the first element where the block is true. More efficient than `grep` for finding a single match.
  - `any { BLOCK } @list`: Returns true if any element matches the criteria.
  - `all { BLOCK } @list`: Returns true if all elements match the criteria.
  - `none { BLOCK } @list`: Returns true if no elements match the criteria.
  - `reduce { BLOCK } @list`: Reduces a list to a single value using an accumulator (`$a`) and the current element (`$b`).

- **Numeric & Ordering**:
  - `max @list` / `min @list`: Returns the maximum or minimum numeric value.
  - `maxstr @list` / `minstr @list`: Returns the maximum or minimum string value.
  - `sum @list`: Returns the numerical sum of all elements.
  - `shuffle @list`: Returns the list elements in a random order.

- **Pair Handling**:
  - `pairs @list`: Returns a list of array references, each containing two elements from the original list (useful for iterating over hashes as lists).
  - `unpairs @list`: Flattens a list of pair references back into a flat list.

## Core Scalar Utilities (Scalar::Util)
Use these for variable introspection and memory management:

- **Object & Type Inspection**:
  - `blessed($var)`: Returns the package name if the variable is a blessed object; otherwise returns `undef`.
  - `reftype($var)`: Returns the internal type of a reference (e.g., 'HASH', 'ARRAY', 'CODE') even if the object is blessed.
  - `looks_like_number($var)`: Returns true if Perl thinks the variable can be treated as a number.

- **Memory Management**:
  - `weaken($ref)`: Converts a standard reference into a "weak" reference. This does not increment the reference count, preventing circular dependency memory leaks.
  - `isweak($ref)`: Checks if a reference is currently weakened.

## Best Practices
- **Prefer List::Util over Grep**: Use `first` or `any` when you only need to know if a condition exists. `grep` evaluates the entire list, whereas `first` short-circuits.
- **Handle Empty Lists**: Functions like `max` and `min` return `undef` on empty lists. Always check the result if the input list might be empty.
- **Numeric Safety**: Use `looks_like_number` before performing arithmetic on untrusted scalar input to avoid "Argument is not numeric" warnings.
- **Avoid Manual Shuffling**: Use `shuffle` instead of custom `rand` loops to ensure a uniform distribution and better performance.

## Reference documentation
- [Scalar::Util and List::Util Documentation](./references/metacpan_org_pod_Scalar-List-Utils.md)