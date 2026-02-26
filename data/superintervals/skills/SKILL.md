---
name: superintervals
description: superintervals is a library for performing rapid interval intersection queries using a cache-friendly superset-index approach. Use when user asks to perform fast genomic interval searches, find overlapping features in RNA-seq or Nanopore data, or index intervals for high-performance intersection queries.
homepage: https://github.com/kcleal/superintervals
---


# superintervals

## Overview

superintervals is a library designed for rapid interval intersection queries using a "superset-index" approach. It maintains intervals in a position-sorted order that is cache-friendly and supports SIMD optimization for counting operations. It is significantly faster than many traditional interval tree implementations (like NCLS or standard interval trees), making it an excellent choice for bioinformatics workflows involving large-scale genomic data like RNA-seq or Nanopore alignments.

## Implementation Best Practices

### Core Requirements
- **End-Inclusive**: Intervals in superintervals are considered end-inclusive (e.g., an interval 10-20 includes both 10 and 20).
- **Build Step**: You must call the `build()` function after adding all intervals and before performing any queries.
- **Result Order**: Found intervals are returned in reverse position-sorted order.

### Python Usage
Install via `pip install superintervals` or `conda install bioconda::superintervals`.

```python
from superintervals import IntervalMap

# 1. Initialize
imap = IntervalMap()

# 2. Add intervals (start, end, value)
imap.add(10, 20, 'Feature_A')
imap.add(15, 25, 'Feature_B')

# 3. Index the map (Required)
imap.build()

# 4. Query
# search_values returns the values associated with overlapping intervals
results = imap.search_values(12, 18) 
```

### Rust Usage
Add to your project using `cargo add superintervals`. For maximum performance, compile with native CPU features to enable SIMD.

```rust
use superintervals::IntervalMap;

let mut imap = IntervalMap::new();
imap.add(1, 5, "A");
imap.build();

let mut results = Vec::new();
imap.search_values(4, 11, &mut results);
```

### C++ Usage
This is a header-only implementation. Copy `SuperIntervals.hpp` to your include directory.

```cpp
#include "SuperIntervals.hpp"

si::IntervalMap<int, std::string> imap;
imap.add(1, 5, "A");
imap.build();

std::vector<std::string> results;
imap.search_values(4, 9, results);
```

## Performance Optimization

### SIMD Acceleration
To leverage SIMD (AVX2 for x86_64 or Neon for ARM), ensure you are compiling for the native architecture:
- **Rust**: `RUSTFLAGS="-Ctarget-cpu=native" cargo run --release`
- **C++**: Use `-march=native` during compilation.

### Memory Layout (C++ Only)
For slightly faster queries in C++, you can use the Eytzinger memory layout. This layout improves cache locality during the search process.

### Thread Safety
Search functions in C++ and Rust (as of v0.3.1) are thread-safe, allowing for concurrent querying of a built index.

## Common Patterns

### Processing BED Files
While superintervals is a library, it is frequently used in scripts to process BED files. A common pattern for intersecting two BED files (A and B) involves:
1. Loading BED B into an `IntervalMap`.
2. Calling `build()`.
3. Iterating through BED A and querying the map for each record.

Note that the provided test utilities (e.g., `test/run-py-libs.py`) typically focus on single-chromosome processing (often `chr1`). When building production tools, ensure you handle chromosome-specific maps (e.g., a dictionary of `IntervalMap` objects keyed by chromosome name).

## Reference documentation
- [GitHub Repository Overview](./references/github_com_kcleal_superintervals.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_superintervals_overview.md)