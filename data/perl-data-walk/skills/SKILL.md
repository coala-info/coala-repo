---
name: perl-data-walk
description: This tool provides a path-based interface for traversing, retrieving, and modifying values within nested Perl data structures. Use when user asks to iterate through data leaves, access values via key paths, or flatten complex nested structures.
homepage: https://github.com/danboo/perl-data-leaf-walker
---


# perl-data-walk

## Overview
The `perl-data-walk` skill leverages the `Data::Leaf::Walker` module to provide a path-based interface for nested Perl data. Instead of writing recursive functions to find data, you can treat a complex structure as a collection of "leaves." Each leaf is identified by a "key path"—an array reference containing the sequence of hash keys and array indices required to reach the value. This skill is essential for data transformation tasks, debugging large data structures, and performing bulk updates on specific nesting levels.

## Core Methods and Usage

### Initialization
Create a walker object by passing a reference to the data structure (HASH or ARRAY).
```perl
use Data::Leaf::Walker;
my $walker = Data::Leaf::Walker->new($data_structure);
```

### Iterating through Leaves
The `each` method is the primary way to traverse the structure. It returns the next key path and its associated value.
```perl
while (my ($path, $value) = $walker->each) {
    # $path is an arrayref: ['users', 0, 'name']
    # $value is the leaf value: 'John Doe'
    print join(' -> ', @{$path}) . " = $value\n";
}
```

### Path-Based Access
You can retrieve or modify values directly using a path array.
- **Fetch**: `$walker->fetch([ 'a', 'b', 0 ])` returns the value at that specific location.
- **Store**: `$walker->store([ 'a', 'b', 0 ], 'new_value')` updates the value in the original data structure.

### Depth Control
Limit the traversal using `min_depth` and `max_depth` options. Depth is defined by the number of elements in the key path.
- **max_depth**: Stops the walker from descending further. If a structure exists at `max_depth`, that structure itself is returned as the "leaf" value.
- **min_depth**: Skips all nodes shallower than the specified level.

```perl
# Only process leaves between depth 2 and 4
$walker->opts( min_depth => 2, max_depth => 4 );
```

## CLI One-Liner Patterns
For quick data inspection from the terminal, use Perl one-liners with the module.

### Flattening a Data Structure
To see every leaf and its path in a serialized format:
```bash
perl -MData::Leaf::Walker -MData::Dumper -e '$w = Data::Leaf::Walker->new($data); while(($p,$v)=$w->each){ print "@$p: $v\n" }'
```

### Filtering by Depth
To inspect only the top-level keys and their immediate values (or sub-structures):
```bash
perl -MData::Leaf::Walker -e '$w = Data::Leaf::Walker->new($data); $w->opts(max_depth => 1); ...'
```

## Expert Tips
- **Iterator State**: The walker maintains internal state. Use `$walker->reset()` if you need to restart the `each` loop from the beginning of the data structure.
- **In-Place Modification**: `store()` modifies the original reference passed to the constructor. If you need to preserve the original data, clone it before initializing the walker.
- **Empty Paths**: Calling `fetch([])` with an empty array reference returns the entire top-level data structure.
- **Non-Existent Paths**: If `fetch()` is called on a path that doesn't exist, it returns `undef`. If `store()` is called on a path that doesn't exist, it will automatically create the intermediate HASH or ARRAY structures to reach that path.

## Reference documentation
- [Main README and Synopsis](./references/github_com_danboo_perl-data-leaf-walker.md)
- [Feature Updates (min_depth, max_depth, reset)](./references/github_com_danboo_perl-data-leaf-walker_commits_master.md)