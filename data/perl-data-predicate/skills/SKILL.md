---
name: perl-data-predicate
description: This tool provides guidance on using the Data::Predicate Perl module to encapsulate and compose logical tests into reusable objects. Use when user asks to build logical predicates, filter or transform data lists, and combine multiple boolean conditions into complex validation objects.
homepage: http://metacpan.org/pod/Data::Predicate
---


# perl-data-predicate

## Overview

The `perl-data-predicate` skill provides guidance on using the `Data::Predicate` Perl module to compose logic into reusable objects. Instead of writing hard-coded `if/else` blocks or complex `grep` statements, this tool allows you to build "predicates"—objects that encapsulate a specific logical test. These predicates can be combined using boolean operators (AND/OR), applied to single values, or used to filter and transform entire lists of data. This is particularly useful in data-heavy environments like bioinformatics where filtering criteria are complex and subject to change.

## Core Usage Patterns

### Basic Predicate Application
The primary method is `apply()`, which tests a single value against the predicate logic.

```perl
use Data::Predicate::Predicates qw(:all);

# Create a predicate that checks if a value is defined
my $p = p_defined();

$p->apply(1);      # Returns true
$p->apply(undef);  # Returns false
```

### Filtering and Transforming Lists
Predicates excel at processing array references efficiently.

*   **filter()**: Returns a new array reference containing only items that pass the predicate.
*   **filter_transform()**: Filters the list and simultaneously applies a subroutine to the passing elements.

```perl
my $data = [undef, 1, 2, 'a', 3];
my $p = p_defined();

# Returns [1, 2, 'a', 3]
my $filtered = $p->filter($data);

# Returns [2, 4, 6] (filters out undef and 'a' if using a numeric predicate)
my $transformed = $p->filter_transform($data, sub { $_ * 2 });
```

### Logical Composition
Combine multiple predicates to create complex business logic. The module supports short-circuiting for performance.

```perl
use Data::Predicate::Predicates qw(:all);

# Build: (Defined AND (Equals 'a' OR Equals 'b'))
my $logic = p_and(
    p_defined(),
    p_or(
        p_string_equals('a'),
        p_string_equals('b')
    )
);

$logic->apply('a'); # True
$logic->apply('c'); # False
```

### Batch Validation
Use `all_true()` and `all_false()` to validate entire sets of data without manual loops.

```perl
# Returns true only if every element in the array ref is defined
$p->all_true([1, 2, 3]); 

# Returns true only if every element fails the predicate
$p->all_false([undef, undef]);
```

## Expert Tips and Best Practices

*   **Prefer Pre-built Predicates**: Always check `Data::Predicate::Predicates` before writing custom logic. It contains optimized versions of common tests like `p_defined`, `p_string_equals`, and `p_is_numeric`.
*   **Avoid Over-Engineering**: Do not use predicates for simple, one-off `if` tests or basic `grep` operations. Predicates are most valuable when the logic needs to be passed as an object, reused across different data sets, or composed dynamically.
*   **Performance**: Predicates use method calls which are slightly slower than native Perl operators. Use them when the benefit of code clarity and reusability outweighs the micro-overhead of the object-oriented approach.
*   **Custom Predicates**: If the standard library is insufficient, you can create custom predicates by applying the `Data::Predicate` role to your own class and implementing the `apply()` method.

## Reference documentation
- [Data::Predicate - metacpan.org](./references/metacpan_org_pod_Data__Predicate.md)
- [perl-data-predicate - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-data-predicate_overview.md)