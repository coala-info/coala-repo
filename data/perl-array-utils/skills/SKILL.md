---
name: perl-array-utils
description: The `perl-array-utils` skill focuses on the `Operator::Util` library, which provides a pragmatic way to apply standard Perl operators to entire lists.
homepage: https://github.com/patch-orphan/operator-util-pm5
---

# perl-array-utils

## Overview
The `perl-array-utils` skill focuses on the `Operator::Util` library, which provides a pragmatic way to apply standard Perl operators to entire lists. Instead of writing manual loops for summation, concatenation, or interleaving arrays, you can use "opstrings" (strings representing operators like '+', '.', or '*') to perform complex data transformations in a single function call.

## Core Functions and Usage

### Reduction (Folding)
Use `reduce` (or `reducewith` to avoid conflicts with `List::Util`) to collapse a list into a single value using a binary operator.

*   **Summation**: `reduce('+', [1, 2, 3])` returns `6`.
*   **Concatenation**: `reduce('.', ['a', 'b', 'c'])` returns `'abc'`.
*   **Logical Check**: `reduce('||', [0, undef, 'value', 0])` returns the first true value.
*   **Intermediate Results**: Set `triangle => 1` to get a list of all steps (e.g., running totals).
    *   `reduce('+', [1..5], triangle => 1)` returns `(1, 3, 6, 10, 15)`.

### Zipping (Interleaving)
Use `zip` or `zipwith` to combine multiple arrays element-wise.

*   **Default Interleaving**: `zip(['a', 'b'], [1, 2])` returns `('a', 1, 'b', 2)`.
*   **With Operator**: `zipwith('.', ['a', 'b'], [1, 2])` returns `('a1', 'b2')`.
*   **Nested Output**: Use `flat => 0` to return a list of array references instead of a flat list.
    *   `zip(['a', 'b'], [1, 2], flat => 0)` returns `(['a', 1], ['b', 2])`.

### Cross Products
Use `cross` or `crosswith` to generate every possible combination of elements from multiple lists (Cartesian product).

*   **Combinations**: `cross([1, 2], ['a', 'b'])` returns `(1, 'a', 1, 'b', 2, 'a', 2, 'b')`.
*   **Product Calculation**: `crosswith('*', [1, 2], [3, 4])` returns `(3, 4, 6, 8)`.

## Expert Tips and Best Practices

### Opstring Syntax
*   **Infix**: Default strings like `'+'`, `'*'`, or `'=='` are treated as infix.
*   **Prefix/Postfix**: For non-infix operators, prepend the type: `"prefix:++"`, `"postcircumfix:{}"`.
*   **Comparison Chaining**: Unlike native Perl 5, `reduce` with comparison operators (like `<`) automatically handles chaining (e.g., `1 < 3 && 3 < 5`).

### Handling Edge Cases
*   **Empty Lists**: The module provides sensible defaults for empty reductions:
    *   `+` or `|` returns `0`.
    *   `*` or `**` returns `1`.
    *   `.` returns `''`.
    *   `,` returns `[]`.
*   **Single Element**: Reducing a single-element list typically returns that element, except for comparison operators which return `1` (true).

### Performance and Safety
*   **Mutating Operators**: Avoid using assignment operators (e.g., `+=`, `.=`) within `zipwith` or `crosswith` as they are considered mutating and may cause unexpected behavior.
*   **Memory**: Be cautious with `cross` on large arrays, as the resulting list size is the product of the input array lengths.

## Reference documentation
- [Operator::Util Main Documentation](./references/github_com_patch-orphan_operator-util-pm5.md)