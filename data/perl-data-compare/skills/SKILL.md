---
name: perl-data-compare
description: This tool recursively compares Perl data structures to determine if they are identical. Use when user asks to compare nested data structures, verify if two hashes or arrays are identical, or ignore specific keys during a data comparison.
homepage: http://metacpan.org/pod/Data::Compare
metadata:
  docker_image: "quay.io/biocontainers/perl-data-compare:1.25--pl526_0"
---

# perl-data-compare

## Overview

The `perl-data-compare` skill leverages the `Data::Compare` Perl module to determine if two data structures are identical. While standard Perl operators only check for reference equality or simple scalar values, this tool recursively traverses nested structures (hashes of arrays, arrays of hashes, etc.) to validate their contents. It is particularly useful in automated testing and data processing workflows where you must verify that complex outputs match expected results.

## Usage Instructions

### Basic Comparison
The most common way to use the tool is via the procedural `Compare()` function. It returns `1` if the structures are identical and `0` if they differ.

```perl
use Data::Compare;

my $data1 = { a => [1, 2], b => { c => 3 } };
my $data2 = { a => [1, 2], b => { c => 3 } };

if (Compare($data1, $data2)) {
    print "Structures are identical\n";
}
```

### Ignoring Specific Hash Keys
When comparing data that includes volatile information (like timestamps, UUIDs, or database IDs), use the `ignore_hash_keys` option to skip those specific fields.

```perl
# Compare two hashes but ignore the 'timestamp' and 'id' keys
my $result = Compare($h1, $h2, { ignore_hash_keys => [qw(timestamp id)] });
```

### Handling Regular Expressions
The tool stringifies compiled regular expressions (`qr//`) before comparison. Two regex objects will match if their string representations are identical (including modifiers like `/i`).

### Object-Oriented Interface
For persistent comparison objects or when working within OO frameworks, use the constructor method:

```perl
use Data::Compare;

my $comparator = Data::Compare->new($struct1, $struct2);
if ($comparator->Cmp) {
    # Identical
}

# Or reuse the object for different structures
$comparator->Cmp($struct3, $struct4);
```

### Circular Structures and Depth
- **Circular References**: The tool safely handles circular structures. Comparing a circular structure to itself returns true.
- **Nesting Limits**: If structures are nested deeper than 100 levels, the module will issue a warning.

### Plugins
You can extend the tool's capability to handle custom objects by installing or writing plugins (e.g., `Data::Compare::Plugins::Scalar::Properties`). To prevent plugins from loading (for security or performance), use:
`use Data::Compare ();`

## Reference documentation
- [Anaconda Bioconda: perl-data-compare](./references/anaconda_org_channels_bioconda_packages_perl-data-compare_overview.md)
- [MetaCPAN: Data::Compare](./references/metacpan_org_pod_Data__Compare.md)