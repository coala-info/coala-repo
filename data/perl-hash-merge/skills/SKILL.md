---
name: perl-hash-merge
description: This skill provides guidance on using the `Hash::Merge` Perl module to combine two arbitrarily deep hashes into one.
homepage: http://metacpan.org/pod/Hash::Merge
---

# perl-hash-merge

## Overview
This skill provides guidance on using the `Hash::Merge` Perl module to combine two arbitrarily deep hashes into one. While Perl's native hash assignment can merge flat hashes, `perl-hash-merge` handles recursive merging of nested structures. It allows you to define specific "behaviors" to determine which data takes precedence when keys overlap, such as favoring the left hash, the right hash, or specific data types (e.g., preferring arrays over scalars).

## Usage Patterns

### Basic Merging
The most common use case is a simple merge of two hash references. By default, the module uses `LEFT_PRECEDENT` behavior.

```perl
use Hash::Merge qw( merge );

my %hash1 = ( key1 => 'val1', nested => { a => 1 } );
my %hash2 = ( key2 => 'val2', nested => { b => 2 } );

# merge returns a hashref
my $merged = merge( \%hash1, \%hash2 );
```

### Setting Merge Behaviors
You can change how conflicts are handled globally or via an object-oriented interface.

*   **LEFT_PRECEDENT** (Default): Keeps left-side values; adds non-conflicting right-side values.
*   **RIGHT_PRECEDENT**: Right-side values override left-side values.
*   **STORAGE_PRECEDENT**: "Bigger" types win (Hash > Array > Scalar).
*   **RETAINMENT_PRECEDENT**: No data lost; scalars/arrays are merged into new structures.

**OO Approach (Recommended for local scope):**
```perl
use Hash::Merge;

my $merger = Hash::Merge->new('RIGHT_PRECEDENT');
my $merged = $merger->merge(\%hash1, \%hash2);
```

**Global Approach:**
```perl
Hash::Merge::set_behavior('STORAGE_PRECEDENT');
my $merged = merge(\%hash1, \%hash2);
```

### Handling Cloning
By default, `Hash::Merge` clones data using the `Clone` module to prevent side effects on the original hashes. If performance is a concern and you don't mind modifying originals, disable cloning:

```perl
my $merger = Hash::Merge->new();
$merger->set_clone_behavior(0); # Disable cloning
```

### Custom Behavior Specification
If built-in behaviors don't fit, define a custom matrix for type conflicts (SCALAR, ARRAY, HASH).

```perl
$merger->add_behavior_spec({
    'SCALAR' => {
        'SCALAR' => sub { $_[0] . $_[1] }, # Concatenate scalars
        'ARRAY'  => sub { [ $_[0], @{$_[1]} ] },
        'HASH'   => sub { $_[1] },
    },
    'ARRAY' => { ... },
    'HASH'  => { ... },
}, "MyCustomMerge");
```

## Expert Tips
*   **Recursive References**: Avoid using this tool on self-referencing hashes or circular dependencies, as it does not handle them well and may cause infinite recursion.
*   **Type Sensitivity**: The tool treats everything that isn't an ARRAY or HASH reference as a SCALAR. Ensure your data structures are strictly typed as references where expected.
*   **Dependency Note**: In environments like Bioconda, ensure `perl-clone` and `perl-clone-choose` are available, as `Hash::Merge` relies on them for deep copying.

## Reference documentation
- [Hash::Merge - Merges arbitrarily deep hashes into a single hash](./references/metacpan_org_pod_Hash__Merge.md)
- [perl-hash-merge - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-hash-merge_overview.md)