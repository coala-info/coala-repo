---
name: intervaltree
description: The intervaltree library provides a mutable, self-balancing data structure for storing and performing high-performance queries on overlapping ranges. Use when user asks to store intervals, find overlaps at specific points or ranges, merge overlapping intervals, or perform range-based restructuring like chopping and slicing.
homepage: https://github.com/chaimleib/intervaltree
---


# intervaltree

## Overview
The `intervaltree` library provides a mutable, self-balancing interval tree data structure. It allows you to store intervals—defined as `[begin, end)`—and associated data, then perform high-performance queries. Unlike standard lists, it optimizes for range-based lookups, making it significantly faster for finding overlaps in large datasets. It also supports complex restructuring operations like chopping, slicing, and merging overlapping or adjacent intervals.

## Core Usage Patterns

### Initialization
Create trees from various formats to suit your data source:
```python
from intervaltree import Interval, IntervalTree

# Empty tree
tree = IntervalTree()

# From an iterable of tuples (begin, end, data)
tree = IntervalTree.from_tuples([(1, 5, "A"), (3, 7, "B")])

# From an iterable of Interval objects
intervals = [Interval(10, 20, "C"), Interval(15, 25, "D")]
tree = IntervalTree(intervals)
```

### Efficient Querying
The library supports both method calls and Pythonic slicing syntax. Note that results are returned as a `set` of `Interval` objects.

*   **Point Queries**: Find all intervals covering a specific coordinate.
    ```python
    results = tree[6]  # or tree.at(6)
    ```
*   **Overlap Queries**: Find intervals that share any part of the range `[begin, end)`.
    ```python
    results = tree[1:10]  # or tree.overlap(1, 10)
    ```
*   **Envelop Queries**: Find intervals completely contained within `[begin, end)`.
    ```python
    results = tree.envelop(1, 10)
    ```

### Modifying the Tree
*   **Adding**: Use `add(interval)` or the shorthand `addi(begin, end, data)`.
*   **Removing**: Use `remove(interval)` (raises ValueError if missing) or `discard(interval)` (silent).
*   **Range Removal**: 
    *   `tree.remove_overlap(1, 10)`: Removes all intervals overlapping the range.
    *   `tree.remove_envelop(1, 10)`: Removes only intervals fully inside the range.

### Restructuring and Merging
These methods are powerful for cleaning up overlapping data:
*   **`merge_overlaps()`**: Joins overlapping intervals into single, larger intervals. You can provide a function to merge the `data` fields.
*   **`merge_neighbors()`**: Joins adjacent intervals (where `end` of one equals `begin` of the next).
*   **`chop(begin, end)`**: Removes the specified range from the tree, shortening or splitting intervals that overlap the boundaries.
*   **`slice(point)`**: Splits any interval covering the point into two separate intervals at that point.

## Expert Tips and Best Practices

*   **Interval Bounds**: Intervals are inclusive of the lower bound and exclusive of the upper bound (`[begin, end)`). A 0-length interval (where `begin == end`) is considered null and will not be found in overlap queries.
*   **Sorting Results**: Because queries return a `set`, the order is non-deterministic. Always use `sorted(tree[point])` if you need to process intervals in coordinate order.
*   **Data Integrity**: When using `merge_overlaps` or `merge_neighbors`, ensure you handle the `data` field. By default, it may be lost or require a custom merger function if the intervals being merged have different data.
*   **Performance**: Membership tests (`interval_obj in tree`) are $O(1)$. Point and range queries are $O(\log n + m)$, where $n$ is the number of intervals and $m$ is the number of results found.
*   **Type Flexibility**: The `begin` and `end` coordinates can be any comparable types, including integers, floats, or `datetime` objects.

## Reference documentation
- [intervaltree Main Documentation](./references/github_com_chaimleib_intervaltree.md)