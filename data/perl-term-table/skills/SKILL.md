---
name: perl-term-table
description: This tool renders structured data into aligned ASCII tables for terminal display using the Term::Table Perl module. Use when user asks to format array-based data into tables, manage terminal column alignment, or collapse empty columns in a dataset.
homepage: http://metacpan.org/pod/Term::Table
metadata:
  docker_image: "quay.io/biocontainers/perl-term-table:0.028--pl5321hdfd78af_0"
---

# perl-term-table

## Overview
The `perl-term-table` skill provides guidance on using the `Term::Table` Perl module to render structured data into clean, aligned ASCII tables. It handles complex terminal formatting tasks such as automatic width detection, column collapsing for empty data, and sanitization of control characters to prevent display corruption. Use this when you need to present array-based data in a professional, readable format within a terminal environment.

## Core Usage Pattern
To generate a table, initialize a `Term::Table` object with your configuration and data, then iterate through the `render` method.

```perl
use Term::Table;

my $table = Term::Table->new(
    header => ['ID', 'Name', 'Status'],
    rows   => [
        ['001', 'Server_A', 'Online'],
        ['002', 'Server_B', 'Offline'],
    ],
);

# Tables are rendered line-by-line
say $_ for $table->render;
```

## Expert Tips and Best Practices

### Handling Terminal Constraints
*   **Dynamic Sizing**: By default, the module attempts to detect terminal width. Use `max_width` to enforce a hard limit for log files or specific UI layouts.
*   **Overflow Management**: Set `allow_overflow => 1` if it is better to have a wide table than to trigger a Perl exception when data cannot fit within `max_width`.
*   **Padding**: The default `pad => 4` is for legacy compatibility. For tighter displays, set `pad => 0`.

### Data Cleaning and Visibility
*   **Sanitization**: Use `sanitize => 1` when dealing with raw input. This converts tabs and control characters into visible escape sequences (like `\t`) while maintaining the visual structure of the table.
*   **Trailing Whitespace**: Set `mark_tail => 1` to make invisible trailing spaces obvious—crucial for debugging data comparison issues.
*   **Empty Columns**: The `collapse => 1` option is highly recommended for sparse datasets to save horizontal space by hiding columns that contain no data across all rows.

### Column Persistence
If you are using `collapse` but need specific columns to always remain visible (e.g., a primary key or a specific metric), use the `no_collapse` option:
```perl
# Prevent 'ID' column from being hidden even if empty
no_collapse => ['ID'] 
```

## Unicode and Wide Characters
For proper alignment of wide Unicode characters (like CJK characters), ensure `Unicode::GCString` is installed in the Perl environment. Without it, the table borders may become misaligned because the module will treat wide characters as single-width.

## Reference documentation
- [Term::Table - Format a header and rows into a table](./references/metacpan_org_pod_Term__Table.md)