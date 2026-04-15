---
name: perl-text-diff
description: The perl-text-diff tool compares text sources such as files, arrays, and scalars to generate configurable diff outputs. Use when user asks to compare text data, generate patch-compatible unified diffs, or format differences between in-memory strings and arrays.
homepage: http://metacpan.org/pod/Text-Diff
metadata:
  docker_image: "quay.io/biocontainers/perl-text-diff:1.45--pl526_0"
---

# perl-text-diff

## Overview
The `perl-text-diff` tool provides a robust interface for comparing text sources. Unlike standard `diff` utilities, it is highly configurable, allowing for the comparison of not just files, but also scalars, arrays, and filehandles. It is particularly useful for generating patch-compatible output or for embedding diffing logic into automated scripts where specific formatting (like Unified diffs) is required for downstream processing.

## Usage Patterns

### Basic File Comparison
To compare two files and output a standard diff:
```bash
perl -MText::Diff -e 'print diff "file1.txt", "file2.txt"'
```

### Specifying Output Formats
The tool supports several styles. Unified is the most common for modern patches.
- **Unified (Default):** `diff $file1, $file2, { STYLE => "Unified" }`
- **Context:** `diff $file1, $file2, { STYLE => "Context" }`
- **OldStyle:** `diff $file1, $file2, { STYLE => "OldStyle" }`

### Comparing In-Memory Data
You can compare arrays or strings directly without writing to temporary files:
```perl
use Text::Diff;
my @array1 = ("line1\n", "line2\n");
my @array2 = ("line1\n", "line3\n");

# Compare arrays
my $diff = diff \@array1, \@array2;

# Compare strings (scalars)
my $string_diff = diff \$string1, \$string2;
```

### Advanced Options
- **FILENAME_A / FILENAME_B**: Use these keys in the options hash to provide custom labels in the diff header, which is useful when comparing memory buffers that don't have actual filenames.
- **OFFSET_A / OFFSET_B**: Define the starting line numbers for the diff hunks.
- **MTIME_A / MTIME_B**: Manually set the modification timestamps in the header.

## Best Practices
- **Newline Consistency**: Ensure that input strings or array elements contain trailing newlines; otherwise, the diff engine may flag "No newline at end of file" or produce unexpected hunk boundaries.
- **Large Files**: When comparing very large files, pass filehandles or file paths rather than loading the entire content into a scalar to conserve memory.
- **Integration**: Use the `Unified` style if the output is intended to be consumed by the `patch` utility.

## Reference documentation
- [Text::Diff - Perform diffs on files and record sets](./references/metacpan_org_pod_Text-Diff.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-text-diff_overview.md)