---
name: perl-list-moreutils-xs
description: This tool provides a high-performance C backend for the List::MoreUtils Perl module to accelerate list manipulation and searching tasks. Use when user asks to perform fast array transformations, find element indexes, remove duplicates, or partition lists into sub-groups within Perl scripts.
homepage: https://metacpan.org/release/List-MoreUtils-XS
metadata:
  docker_image: "quay.io/biocontainers/perl-list-moreutils-xs:0.430--pl5321h7b50bb2_5"
---

# perl-list-moreutils-xs

## Overview
The `perl-list-moreutils-xs` package provides the compiled C (XS) backend for the `List::MoreUtils` Perl module. It serves as a high-performance supplement to the standard `List::Util` library, offering a wide array of functions for list manipulation, searching, and transformation. This skill focuses on utilizing these functions within Perl scripts to ensure maximum execution speed, which is critical when processing large genomic datasets or complex arrays in Bioconda-based environments.

## Usage and Best Practices

### Performance Advantage
Always prefer the XS version over the pure-Perl implementation for large-scale data. The XS version is significantly faster for iterative operations. Ensure it is correctly loaded by checking the backend if performance issues arise.

### Key Functional Categories
- **Junctions**: Use `any`, `all`, `none`, and `notall` for readable boolean logic across arrays.
- **Transformation**: Use `mesh` (or `zip`) to interleave multiple arrays, and `uniq` to efficiently remove duplicates while preserving order.
- **Partitioning**: Use `part` to split a list into multiple sub-lists based on a specific criteria or index.
- **Searching**: Use `firstidx` and `lastidx` to find the position of elements, or `indexes` to return all matching positions.

### Common Patterns
- **Filtering Unique Values**:
  ```perl
  use List::MoreUtils qw(uniq);
  my @unique_ids = uniq @all_ids;
  ```
- **Interleaving Arrays**:
  ```perl
  use List::MoreUtils qw(mesh);
  my @keys = ('a', 'b', 'c');
  my @vals = (1, 2, 3);
  my @combined = mesh @keys, @vals; # Result: ('a', 1, 'b', 2, 'c', 3)
  ```
- **Grouping Data**:
  ```perl
  use List::MoreUtils qw(part);
  my $i = 0;
  my @groups = part { $i++ % 3 } @data; # Splits data into three buckets
  ```

### Expert Tips
- **Memory Efficiency**: When working with very large lists, be mindful that many `List::MoreUtils` functions return new arrays. For extreme memory constraints, consider iterative approaches, though `List::MoreUtils` is generally optimized for speed.
- **Dependency Management**: In Conda environments, ensure the package is installed via `conda install bioconda::perl-list-moreutils-xs` to provide the necessary shared objects (.so files) that the Perl interpreter needs for the XS acceleration.

## Reference documentation
- [List-MoreUtils-XS on MetaCPAN](./references/metacpan_org_release_List-MoreUtils-XS.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-list-moreutils-xs_overview.md)