---
name: quicksect
description: `quicksect` is a Cython-accelerated library designed for efficient interval tree operations.
homepage: https://github.com/brentp/quicksect
---

# quicksect

## Overview
`quicksect` is a Cython-accelerated library designed for efficient interval tree operations. It provides a significant performance boost over pure Python implementations for tasks involving range searching and overlap detection. This skill should be used when you need to build, query, or find neighbors within a set of numeric intervals, a common requirement in bioinformatics and temporal data analysis.

## Installation
The package is available via pip or the Bioconda channel:

```bash
pip install quicksect
# OR
conda install -c bioconda quicksect
```

## Core Usage Patterns
The library offers both a high-level `IntervalTree` interface and a low-level `IntervalNode` interface.

### High-Level IntervalTree
The `IntervalTree` is the most common entry point for managing collections of intervals.

```python
from quicksect import IntervalTree, Interval

tree = IntervalTree()

# Method 1: Add intervals by start and end coordinates
tree.add(23, 45)
tree.add(55, 66)

# Method 2: Insert Interval objects
tree.insert(Interval(88, 444))

# Search for all intervals overlapping a specific range
# Returns a list of Interval objects
overlaps = tree.search(44, 56)

# Find overlaps using an Interval object
results = tree.find(Interval(99, 100))
for match in results:
    print(f"Overlap found: {match.start} to {match.end}")
```

### Low-Level IntervalNode
Use `IntervalNode` when you need to interact directly with the tree structure or perform proximity-based searches.

```python
from quicksect import IntervalNode, Interval

# Initialize a node
root = IntervalNode(Interval(22, 33))

# Insert returns the new root (the tree may rebalance)
root = root.insert(Interval(44, 55))

# Proximity searches: Find 'n' nearest neighbors
# Find 1 interval to the left of the target
left_neighbors = root.left(Interval(34, 35), n=1)

# Find 1 interval to the right of the target
right_neighbors = root.right(Interval(34, 35), n=1)
```

## Expert Tips and Best Practices
- **Coordinate Handling**: By convention, `quicksect` is typically used with 0-indexed, half-open intervals `[start, end)`, where the start is inclusive and the end is exclusive.
- **Performance Optimization**: Because the core logic is Cythonized, it is highly efficient. However, when building very large trees, try to perform all insertions before starting a heavy search phase to benefit from the underlying tree structure.
- **Attribute Access**: The `Interval` objects returned by searches have `.start` and `.end` attributes for easy coordinate retrieval.
- **Empty Results**: Searching a range with no overlaps returns an empty list `[]`. Always check the length of the returned list before accessing indices.

## Reference documentation
- [Quicksect GitHub Repository](./references/github_com_brentp_quicksect.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_quicksect_overview.md)