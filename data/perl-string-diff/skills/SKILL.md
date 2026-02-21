---
name: perl-string-diff
description: perl-string-diff provides a specialized way to compare strings beyond simple line-based differences.
homepage: https://github.com/yappo/p5-String-Diff
---

# perl-string-diff

## Overview

perl-string-diff provides a specialized way to compare strings beyond simple line-based differences. It identifies specific insertions and deletions within a sequence and wraps them in customizable markers. This is particularly useful for developers needing to visualize text changes in web interfaces, terminal outputs, or for data scientists needing to generate "diff-based" regex patterns that match multiple variations of a string.

## Installation

The tool is available via Bioconda:

```bash
conda install bioconda::perl-string-diff
```

## Common Usage Patterns

### 1. Basic String Comparison
To get a side-by-side representation of changes where deletions are marked with `[]` and additions with `{}`:

```perl
use String::Diff;
my ($old, $new) = String::Diff::diff('this is Perl', 'this is Ruby');
# $old: "this is [Perl]"
# $new: "this is {Ruby}"
```

### 2. Merged Diff Output
To see both the old and new values in a single string:

```perl
use String::Diff qw(diff_merge);
my $merged = diff_merge('this is Perl', 'this is Ruby');
# Output: "this is [Perl]{Ruby}"
```

### 3. Generating Regular Expressions
Use this to create a non-capturing group regex that matches both input strings:

```perl
use String::Diff qw(diff_regexp);
my $regex = diff_regexp('this is Perl', 'this is Ruby');
# Output: "this\ is\ (?:Perl|Ruby)"
```

### 4. Custom HTML Markers
For web-based visualization, you can override the default brackets with HTML tags:

```perl
my $diff = String::Diff::diff($str1, $str2,
    remove_open  => '<del>',
    remove_close => '</del>',
    append_open  => '<ins>',
    append_close => '</ins>',
);
```

## Expert Tips

*   **Linebreak Handling**: If your strings contain newlines and you want the diff to respect line boundaries, always pass the `linebreak => 1` option to any of the diff functions.
*   **Data Escaping**: When generating HTML diffs, use the `escape` callback to prevent XSS or broken tags if the source strings contain special characters:
    ```perl
    escape => sub { HTML::Entities::encode_entities($_[0]) }
    ```
*   **CLI One-liners**: You can use the module directly from the command line for quick checks:
    ```bash
    perl -MString::Diff -E 'say String::Diff::diff_merge("Version 1.0", "Version 1.1")'
    ```
*   **Detailed Analysis**: If you need to programmatically process every hunk of the diff (e.g., for custom logic), use `diff_fully`. It returns an array of arrays where each element is tagged as `u` (unchanged), `-` (removed), or `+` (added).

## Reference documentation
- [GitHub Repository Overview](./references/github_com_yappo_p5-String-Diff.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-string-diff_overview.md)