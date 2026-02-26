---
name: perl-array-compare
description: perl-array-compare is a Perl extension that provides a comparator object for comparing two arrays with configurable constraints. Use when user asks to compare arrays for equality, find indices of differing elements, check if arrays are permutations of each other, or perform comparisons while ignoring specific indices or case sensitivity.
homepage: http://metacpan.org/pod/Array::Compare
---


# perl-array-compare

## Overview

Array::Compare is a Perl extension designed to simplify the process of comparing two arrays. Instead of manual loops, it uses a comparator object to determine if arrays are identical, find the indices of differing elements, or check if one array is a permutation of another. It is particularly useful in data processing pipelines where array consistency needs to be validated with configurable constraints like case sensitivity or ignored indices.

## Usage Patterns

### Basic Comparison
To check if two arrays are identical, create a comparator object and use the `compare` method. Pass array references as arguments.

```perl
use Array::Compare;

my $comp = Array::Compare->new;
my @arr1 = (1, 2, 3);
my @arr2 = (1, 2, 3);

if ($comp->compare(\@arr1, \@arr2)) {
    print "Arrays are identical\n";
}
```

### Identifying Specific Differences
Use `full_compare` to get the indices where two arrays differ. In scalar context, it returns the count of differences; in list context, it returns the actual indices.

```perl
my @arr1 = qw(apple orange banana);
my @arr2 = qw(apple grape banana);

my @diffs = $comp->full_compare(\@arr1, \@arr2);
# @diffs will contain (1)
```

### Checking for Permutations
Use the `perm` method to determine if two arrays contain the same elements regardless of their order.

```perl
my @a = (1, 2, 3);
my @b = (3, 2, 1);

if ($comp->perm(\@a, \@b)) {
    print "Arrays are permutations of each other\n";
}
```

## Configuration and Best Practices

### Handling Data Separators
Internally, the module joins array elements into a string using a separator (default is `^G`). If your data contains this character, the comparison may fail. Override it using the `Sep` attribute.

```perl
my $comp = Array::Compare->new(Sep => '|');
# Or update an existing object
$comp->Sep('|');
```

### Normalizing Comparisons
Control how the comparator treats whitespace and letter casing to avoid false negatives in text data.

- **WhiteSpace(0)**: Consolidates consecutive whitespace characters into a single space before comparing.
- **Case(0)**: Performs case-insensitive comparisons.

```perl
my $comp = Array::Compare->new(
    WhiteSpace => 0,
    Case => 0
);
```

### Skipping Specific Indices
If certain array positions are expected to differ (e.g., timestamps or unique IDs) and should be ignored, use the `Skip` attribute with a hash reference of indices.

```perl
# Ignore the element at index 2
my $comp = Array::Compare->new(Skip => {2 => 1});

# Reset skipping
$comp->NoSkip();
```

## Reference documentation
- [Array::Compare - Perl extension for comparing arrays](./references/metacpan_org_pod_Array__Compare.md)
- [perl-array-compare - bioconda](./references/anaconda_org_channels_bioconda_packages_perl-array-compare_overview.md)