---
name: ruranges
description: ruranges provides high-performance Rust-implemented kernels for interval arithmetic and genomic coordinate operations using NumPy arrays. Use when user asks to calculate overlaps between genomic intervals, find k-nearest neighbors, perform interval subtraction, or merge overlapping regions.
homepage: https://github.com/pyranges/ruranges
metadata:
  docker_image: "quay.io/biocontainers/ruranges:0.0.15--py313he6b6a99_1"
---

# ruranges

## Overview

`ruranges` (specifically the `ruranges-py` package) provides Rust-implemented kernels for interval arithmetic, offering a significantly faster and more feature-rich alternative to libraries like NCLS. It is designed for "stateless" operation, meaning it uses plain functions that accept and return NumPy arrays rather than complex object classes. This makes it highly suitable for integration into existing data science pipelines where performance and memory efficiency (via zero-copy views) are paramount.

Use this skill when you need to:
- Calculate overlaps between two sets of genomic intervals.
- Find the k-nearest neighbors for specific genomic coordinates.
- Perform set algebra like subtracting one set of intervals from another or merging overlapping regions.
- Process large-scale genomic data where standard Python loops or less efficient libraries are too slow.

## Core API Usage

The primary interface is located in `ruranges.numpy`. All inputs should be NumPy arrays.

### 1. Finding Overlaps
To find overlaps between two sets of intervals (A and B), you must provide starts, ends, and group identifiers (e.g., chromosome/strand combinations).

```python
import ruranges
import numpy as np

# Define intervals for set 1 and set 2
starts1 = np.array([1, 10, 30], dtype=np.int32)
ends1 = np.array([5, 15, 35], dtype=np.int32)
groups1 = np.array([0, 0, 1], dtype=np.uint32)

starts2 = np.array([3, 0], dtype=np.int32)
ends2 = np.array([6, 2], dtype=np.int32)
groups2 = np.array([0, 1], dtype=np.uint32)

# Returns indices of overlapping pairs
idx1, idx2 = ruranges.numpy.overlaps(
    starts=starts1, ends=ends1, groups=groups1,
    starts2=starts2, ends2=ends2, groups2=groups2
)
```

### 2. Nearest Neighbor Search
Find the `k` closest intervals in set B for each interval in set A.

```python
idx1, idx2, dists = ruranges.numpy.nearest(
    starts=starts1, ends=ends1, 
    starts2=starts2, ends2=ends2, 
    k=1, 
    include_overlaps=True, 
    direction="any" # Options: "any", "forward", "backward"
)
```

### 3. Interval Subtraction
Subtract intervals in set B from set A. Note that one interval in A may be split into multiple pieces if multiple B intervals overlap it.

```python
idx_keep, sub_starts, sub_ends = ruranges.numpy.subtract(
    starts1, ends1, starts2, ends2
)
```

## Expert Tips and Best Practices

### Data Type Requirements
- **Groups**: Must be non-negative integers fitting in `uint32`. Use `pandas.groupby().ngroup()` to generate these efficiently from chromosome/strand columns.
- **Coordinates**: Use `int32` or `int64`. The library handles normalization internally.
- **Strands**: If a function requires strand information, provide a boolean array where `True` represents the minus (-) strand and `False` represents the plus (+) strand.

### Performance Optimization
- **Zero Copy**: `ruranges` attempts to return NumPy views whenever possible to avoid memory overhead.
- **Sorting**: While the functions often sort internally, providing pre-sorted data is not strictly required but can be beneficial for pipeline predictability. The library returns index permutations so you can map results back to your original data frames.
- **Statelessness**: Since there are no classes to instantiate, you can call these functions directly within list comprehensions or vectorized operations without managing object state.

### Common Workflow: Pandas Integration
When working with DataFrames, the standard pattern is:
1. Concatenate the coordinate/group columns.
2. Generate group IDs using `ngroup()`.
3. Convert columns to NumPy arrays with specific dtypes.
4. Call `ruranges`.
5. Use the returned indices to slice the original DataFrames.

## Reference documentation
- [Anaconda Bioconda ruranges Overview](./references/anaconda_org_channels_bioconda_packages_ruranges_overview.md)
- [ruranges-py GitHub README](./references/github_com_pyranges_ruranges_py.md)