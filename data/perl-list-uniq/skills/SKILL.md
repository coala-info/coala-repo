---
name: perl-list-uniq
description: This tool extracts unique elements from lists or nested arrays using the Perl List::Uniq module. Use when user asks to identify unique items in a collection, flatten nested array references, or generate sorted unique lists.
homepage: http://metacpan.org/pod/List::Uniq
metadata:
  docker_image: "quay.io/biocontainers/perl-list-uniq:0.23--pl5321hdfd78af_0"
---

# perl-list-uniq

## Overview
The `perl-list-uniq` skill facilitates the use of the `List::Uniq` Perl module to efficiently identify and extract unique items from a collection. While Perl developers often use hashes to find unique elements, this tool provides a cleaner API that handles complex cases like recursive flattening of nested array references and custom sort orders in a single function call.

## Usage Patterns

### Basic Uniqueness
To get unique elements from a standard array:
```perl
use List::Uniq qw(uniq);
my @data = ('a', 'b', 'a', 'c');
my @unique = uniq(@data);
```

### Handling Nested Arrays
By default, the tool flattens nested array references. This is useful for processing complex data structures where elements are buried in sub-arrays:
```perl
# Returns ('foo', 'bar', 'baz', 'quux')
my @list = ('foo', [['bar']], [[['baz', 'quux']]]);
my @unique = uniq(@list);
```
To disable this behavior and treat array references as literal elements, pass `flatten => 0` in the options hash.

### Sorted Unique Lists
You can combine deduplication and sorting into a single operation:
```perl
# Sorts using Perl's default comparison
my @sorted_unique = uniq({ sort => 1 }, @data);

# Using a custom comparison (e.g., numeric sort)
my @numeric_unique = uniq({ sort => 1, compare => sub { $_[0] <=> $_[1] } }, @numbers);
```

### Context-Aware Returns
The `uniq` function adapts to the calling context:
- **List Context**: Returns an array of unique elements.
- **Scalar Context**: Returns a reference to an array of unique elements.

### Command Line One-Liners
If the module is installed (e.g., via Bioconda), it can be used directly in shell pipelines for quick data processing:
```bash
# Deduplicate lines in a file and print them
perl -MList::Uniq=:all -e 'print uniq(<>)' input.txt

# Deduplicate and sort words from a stream
cat words.txt | perl -MList::Uniq=:all -e 'print join("\n", uniq({sort => 1}, <>))'
```

## Expert Tips
- **Performance**: For very large datasets where speed is critical, sorting the output of `uniq` manually (e.g., `sort(uniq(@list))`) is often faster than using the `compare` option, as the latter incurs overhead by calling a sub-routine for every comparison.
- **Default Flattening**: Remember that `flatten` defaults to **true**. If your list contains array references that should be preserved as references rather than expanded, you must explicitly set `{ flatten => 0 }`.
- **Importing**: Use `use List::Uniq ':all';` to export the `uniq` function into your namespace for cleaner code.

## Reference documentation
- [List::Uniq - extract the unique elements of a list](./references/metacpan_org_pod_List__Uniq.md)