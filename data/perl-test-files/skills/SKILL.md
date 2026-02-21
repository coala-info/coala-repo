---
name: perl-test-files
description: The `perl-test-files` skill provides a specialized interface for the `Test::Files` Perl module.
homepage: http://metacpan.org/pod/Test::Files
---

# perl-test-files

## Overview
The `perl-test-files` skill provides a specialized interface for the `Test::Files` Perl module. It simplifies the process of asserting that files and directories match expected states during automated testing. Instead of manually opening handles and comparing strings, this tool allows for direct comparison of file contents, file sizes, and directory listings. It supports advanced features like content filtering (to ignore timestamps or non-deterministic data) and recursive directory comparisons.

## Usage Guidelines

### Basic File Comparisons
Use `file_ok` to compare a file's content against a string, or `compare_ok` to compare two files.

```perl
use Test::Files;
use Path::Tiny qw(path);

# Compare file content to a string
file_ok("output.txt", "expected content\n", "Check output content");

# Compare two files directly
compare_ok("actual.txt", "reference.txt", "Files should be identical");

# Check existence or size only
compare_ok("actual.txt", "reference.txt", { EXISTENCE_ONLY => 1 }, "File exists");
compare_ok("actual.txt", "reference.txt", { SIZE_ONLY => 1 }, "File sizes match");
```

### Filtering Non-Deterministic Data
When files contain timestamps, paths, or IDs that change every run, use a `FILTER` to normalize the data before comparison.

```perl
# Replace timestamps (HH:MM:SS) with zeros to allow comparison
my $filter = sub { shift =~ s/\b\d{2}:\d{2}:\d{2}\b/00:00:00/gr };

file_filter_ok("output.log", "Log entry at 00:00:00", $filter, "Log matches ignoring time");

# Using the options hash (preferred for consistency)
compare_ok("actual.log", "ref.log", { FILTER => $filter }, "Logs match after filtering");
```

### Directory Assertions
Verify the contents of directories, including recursive checks and pattern matching.

```perl
# Check if directory contains specific files (non-recursive)
dir_contains_ok("results_dir", [qw(log.txt data.csv)], "Required files present");

# Check if directory contains ONLY specific files
dir_only_contains_ok("results_dir", [qw(log.txt data.csv)], "No extra files present");

# Recursive symmetric comparison of two directories
compare_dirs_ok("current_run/", "gold_standard/", { 
    RECURSIVE => 1, 
    SYMMETRIC => 1 
}, "Full directory tree matches");

# Filter by filename pattern
compare_dirs_ok("dir1", "dir2", { NAME_PATTERN => qr/\.csv$/ }, "Only CSVs match");
```

### Best Practices
- **Path Management**: Use `Path::Tiny` for robust path manipulation when passing arguments to `Test::Files` functions.
- **Symmetric Checks**: When comparing directories, use `SYMMETRIC => 1` to ensure that no unexpected files exist in the "got" directory that aren't in the "reference" directory.
- **Plan Your Tests**: Always include a `plan` or use `done_testing` as `Test::Files` integrates with `Test::Builder`.
- **Archive Testing**: For `.tar` or `.zip` files, use `compare_archives_ok` to check logical identity without worrying about compression artifacts or file ordering.

## Reference documentation
- [Test::Files - metacpan.org](./references/metacpan_org_pod_Test__Files.md)
- [perl-test-files - bioconda](./references/anaconda_org_channels_bioconda_packages_perl-test-files_overview.md)