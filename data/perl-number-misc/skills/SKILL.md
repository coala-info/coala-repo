---
name: perl-number-misc
description: This tool provides a collection of utilities for formatting, validating, and manipulating numeric data in Perl scripts. Use when user asks to format numbers with commas, round values to specific decimal places, validate numeric types, or check if a number falls within a range.
homepage: http://metacpan.org/pod/Number::Misc
---


# perl-number-misc

## Overview
The `perl-number-misc` skill provides a suite of handy utilities for handling numbers within Perl environments. It is particularly useful for developers and bioinformaticians who need to format raw numeric data for reports (e.g., adding commas to large integers), perform consistent rounding, or validate that values fall within specific numeric ranges. By using this module, you avoid reinventing common mathematical logic and ensure consistent data representation across scripts.

## Usage Guidelines

### Core Functions
To use these utilities, include the module in your Perl script:
```perl
use Number::Misc qw(:all);
```

### Formatting and Rounding
*   **commafy($num)**: Adds commas to a number for readability (e.g., `1234567` becomes `1,234,567`).
*   **round($num, $precision)**: Rounds a number to the specified decimal place.
    *   `round(1.2345, 2)` returns `1.23`.
*   **to_fixed($num, $precision)**: Similar to round, but ensures the result has exactly the specified number of decimal places, padding with zeros if necessary.

### Numeric Validation and Comparison
*   **is_numeric($val)**: Returns true if the input is a valid number.
*   **is_int($val)**: Returns true if the input is an integer.
*   **is_between($num, $low, $high)**: Checks if a number is within a specific range (inclusive).

### Sign and Value Manipulation
*   **sign($num)**: Returns 1 if positive, -1 if negative, and 0 if zero.
*   **max_val(@list)** and **min_val(@list)**: Quick utilities to find the extremas in a list of numbers.

## Best Practices
*   **Importing**: Use the `:all` tag for quick scripts, but for production code, explicitly list the functions you need (e.g., `use Number::Misc qw(commafy round);`) to keep the namespace clean.
*   **Data Cleaning**: Use `is_numeric` before performing arithmetic on data parsed from external files (like CSVs or TSVs) to prevent "Argument is not numeric" warnings.
*   **Reporting**: Always prefer `to_fixed` over `round` when generating columns of data for text-based reports to ensure decimal alignment.

## Reference documentation
- [Number::Misc Documentation](./references/metacpan_org_pod_Number__Misc.md)