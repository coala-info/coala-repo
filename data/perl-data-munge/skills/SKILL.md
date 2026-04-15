---
name: perl-data-munge
description: This tool provides a collection of Perl utility functions for functional-style data transformation, string manipulation, and efficient file handling. Use when user asks to perform non-destructive substitutions, generate optimized regular expressions from lists, trim whitespace, slurp filehandles, or check for element membership in arrays.
homepage: http://metacpan.org/pod/Data::Munge
metadata:
  docker_image: "quay.io/biocontainers/perl-data-munge:0.111--pl5321hdfd78af_0"
---

# perl-data-munge

## Overview

The `perl-data-munge` skill provides access to the `Data::Munge` Perl module, a collection of utility functions designed to simplify common data processing tasks. It is particularly effective for functional-style programming in Perl, allowing for data transformations without side effects, efficient file reading, and the generation of optimized regular expressions from dynamic lists. Use this skill to write cleaner, more maintainable Perl code for data cleaning, string manipulation, and complex logic handling.

## Functional Data Transformation

Avoid side effects and manual variable copying by using functional wrappers.

- **Non-destructive substitution**: Use `byval { BLOCK } SCALAR` to perform operations on a copy of a value.
  ```perl
  # Returns modified string without changing $original
  my $clean = byval { s/\s+//g } $original;
  ```
- **Mapping without aliasing**: Use `mapval { BLOCK } LIST` when you need to transform a list but want to ensure the original elements remain untouched (unlike standard `map`).
  ```perl
  my @trimmed = mapval { chomp } @lines;
  ```

## Regex and String Utilities

- **Optimized Regex Generation**: Use `list2re LIST` to convert an array of strings into a single regex. It automatically handles escaping and sorts by length (longest first) to prevent shorter prefixes from shadowing longer matches.
  ```perl
  my $re = list2re qw(cat category caterpillar); # qr/caterpillar|category|cat/
  ```
- **JS-style Replacement**: Use `replace(STRING, REGEX, REPLACEMENT, FLAG)` for a more familiar string replacement API, supporting both string templates ($1, $2) and subroutines.
- **Whitespace Trimming**: Use `trim $string` for standard leading/trailing whitespace removal.

## File and Logic Handling

- **Slurping**: Use `slurp $fh` to read an entire filehandle into a scalar efficiently.
  ```perl
  my $data = slurp \*STDIN;
  ```
- **Recursive Anonymous Subs**: Use `rec { BLOCK }` to create anonymous subroutines that can call themselves via the first argument (`$_[0]`).
  ```perl
  my $factorial = rec { my ($self, $n) = @_; $n < 2 ? 1 : $n * $self->($n - 1) };
  ```
- **Membership Testing**: Use `elem $scalar, $arrayref` for a fast, short-circuiting linear search to check if a value exists in an array.

## CLI One-Liner Patterns

When using `perl-data-munge` from the command line, use the `-MData::Munge` flag:

```bash
# Trim all lines in a file
perl -MData::Munge -ne 'print trim($_), "\n"' input.txt

# Slurp a file and perform a global replacement using a regex list
perl -MData::Munge -e '$re = list2re(qw/foo bar/); $data = slurp \*STDIN; print replace($data, $re, "baz", "g")' < input.txt
```

## Reference documentation
- [Data::Munge - various utility functions](./references/metacpan_org_pod_Data__Munge.md)
- [perl-data-munge - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-data-munge_overview.md)