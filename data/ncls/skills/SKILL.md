---
name: ncls
description: The `ncls` (Nested Containment List) skill enables efficient interval management and overlap detection.
homepage: http://github.com/hunt-genes/ncls
---

# ncls

## Overview
The `ncls` (Nested Containment List) skill enables efficient interval management and overlap detection. It provides a Python interface to a high-speed C implementation that outperforms standard interval trees in both construction time and query latency. This tool is most effective when working with static "subject" datasets that need to be queried repeatedly or in bulk against "query" intervals.

## Implementation Patterns

### Core Initialization
To use `ncls`, you must provide three synchronized arrays (typically NumPy arrays or Pandas Series values): starts, ends, and identifiers.

```python
from ncls import NCLS
import pandas as pd

# Prepare data
starts = pd.Series([0, 1, 2])
ends = pd.Series([100, 101, 102])
ids = pd.Series([0, 1, 2])

# Build the index
index = NCLS(starts.values, ends.values, ids.values)
```

### High-Performance Batch Queries
For maximum performance, avoid iterating over queries in Python. Use the `all_overlaps_both` method to perform the entire operation in C/Cython.

```python
# query_starts, query_ends, and query_ids should be numpy arrays
l_idxs, r_idxs = index.all_overlaps_both(q_starts, q_ends, q_ids)

# l_idxs contains the IDs from the query set
# r_idxs contains the IDs from the subject set that overlap
```

### Single Interval Lookups
If you only need to check a single range, use the generator-based `find_overlap`.

```python
# Returns an iterator of (start, end, id) tuples
overlaps = index.find_overlap(10, 20)
for start, end, uid in overlaps:
    print(f"Overlap found with interval {uid}")
```

## Expert Tips and Best Practices

- **Data Types**: Always pass `.values` when using Pandas Series to ensure the underlying NumPy arrays are passed to the C layer.
- **Memory Efficiency**: `ncls` is significantly more memory-efficient than `bx-python` or standard interval trees, making it suitable for datasets with hundreds of millions of intervals.
- **Static Nature**: The index is static. If your interval set changes frequently (insertions/deletions), the overhead of rebuilding the NCLS may negate the lookup speed gains.
- **Alternative Recommendation**: While `ncls` is maintained, the author suggests `ruranges` for new projects requiring even lighter-weight operations and more diverse interval logic.
- **Floating Point Support**: If working with non-integer coordinates, use the experimental `FNCLS` class included in the package.

## Reference documentation
- [NCLS GitHub Repository](./references/github_com_pyranges_ncls.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_ncls_overview.md)