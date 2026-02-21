---
name: perl-set-intervaltree
description: The `Set::IntervalTree` module provides an optimized data structure for storing and querying intervals.
homepage: https://metacpan.org/pod/Set::IntervalTree
---

# perl-set-intervaltree

## Overview
The `Set::IntervalTree` module provides an optimized data structure for storing and querying intervals. Unlike simple lists, an interval tree allows you to find all intervals overlapping a specific range in O(log n + m) time, where n is the number of intervals and m is the number of overlaps found. This is a standard tool in bioinformatics for tasks like identifying genes within a specific genomic window or finding overlaps between different sequencing datasets.

## Usage Patterns

### Basic Implementation
To use the interval tree in a Perl script, you must initialize the object and then populate it with intervals.

```perl
use Set::IntervalTree;

my $tree = Set::IntervalTree->new;

# Insert intervals: insert(value, start, end)
# Note: Intervals are typically treated as [start, end)
$tree->insert("GeneA", 100, 200);
$tree->insert("GeneB", 150, 300);
$tree->insert("GeneC", 500, 600);
```

### Querying Overlaps
The primary use case is retrieving values that overlap a target range.

```perl
# Fetch all values overlapping the range [180, 220)
my $results = $tree->fetch(180, 220);
# Returns: ["GeneA", "GeneB"]

# Fetch values within a window (strictly contained or overlapping)
my $window_results = $tree->fetch_window(150, 250);
```

### Finding Nearest Neighbors
You can find the closest intervals to a specific point if no direct overlap exists.

```perl
# Find the nearest interval to the left or right of position 400
my $nearest = $tree->fetch_nearest(400);
```

## Expert Tips and Best Practices

- **Coordinate Systems**: Be consistent with your coordinate system. Perl modules and many bioinformatics formats (like BED) use 0-based, half-open intervals `[start, end)`. Ensure your input data matches this logic to avoid "off-by-one" errors.
- **Value Types**: The "value" inserted into the tree can be a simple string (like an ID) or a reference to a complex hash containing multiple attributes. Using references allows you to store rich metadata within the tree.
- **Memory Management**: While efficient, building very large trees (millions of intervals) can consume significant RAM. If processing whole-genome data, consider building separate trees for each chromosome to keep memory usage manageable.
- **Removal**: Use `$tree->remove(start, end)` to delete intervals. Note that this typically removes intervals that match the exact boundaries provided.

## Reference documentation
- [Set::IntervalTree Documentation](./references/metacpan_org_pod_Set__IntervalTree.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-set-intervaltree_overview.md)