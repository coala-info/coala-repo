---
name: perl-test-differences
description: This tool provides visual diffing capabilities for Perl testing to highlight discrepancies between complex data structures or multi-line strings. Use when user asks to compare nested hashes or arrays, perform deep data comparisons with visual output, or identify specific differences in long text blocks during testing.
homepage: http://metacpan.org/pod/Test-Differences
---


# perl-test-differences

## Overview

This skill facilitates the use of `Test::Differences`, a Perl module designed to provide intelligent "diffing" capabilities within a testing environment. While standard testing tools often simply report that two values do not match, this tool produces a visual representation of the differences (similar to the `diff` command-line utility). It is particularly effective for comparing nested hashes, arrays, or multi-line text blocks where manual inspection of a "got vs. expected" string is impractical.

## Usage Guidelines

### Core Functions

- **`eq_or_diff($got, $expected, $name)`**: The primary replacement for `is()` or `is_deeply()`. It compares two scalars or references and outputs a diff if they differ.
- **`eq_or_diff_data($got, $expected, $name)`**: Specifically for data structures; it ensures the data is stringified in a consistent way before diffing.
- **`eq_or_diff_text($got, $expected, $name)`**: Optimized for comparing long strings or file contents, ensuring line endings are handled appropriately for the diff output.

### Best Practices

- **Context Control**: Use `unified_diff()` (default), `context_diff()`, or `old_diff()` to change the output format. Unified diffs are generally the most readable for terminal-based testing.
- **Table Formatting**: For very complex data, you can use `table_diff()` to present differences in a columnar format.
- **Integration with Test::More**: Always load `Test::More` before `Test::Differences`.
  ```perl
  use Test::More tests => 1;
  use Test::Differences;

  my $got = { a => 1, b => [1, 2, 3] };
  my $expected = { a => 1, b => [1, 5, 3] };

  eq_or_diff $got, $expected, "Testing complex structure";
  ```

### Expert Tips

- **Handling Whitespace**: If tests fail due to invisible trailing whitespace, use `eq_or_diff_text` which is more sensitive to line-by-line variations.
- **Deep Comparisons**: Unlike `is_deeply`, `eq_or_diff` provides a visual pointer to the specific key or index that failed in a nested structure, significantly reducing debugging time in large JSON or configuration object tests.
- **Global Options**: You can set `$Test::Differences::Format = 'Context'` globally to change the output style for all tests in a script.

## Reference documentation

- [Test::Differences Documentation](./references/metacpan_org_pod_Test-Differences.md)