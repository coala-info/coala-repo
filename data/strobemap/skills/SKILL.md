---
name: strobemap
description: Strobemap generates strobemers, which are fuzzy seeds used to improve sensitivity in biological sequence analysis and read mapping. Use when user asks to generate strobemers, create seeds for sequence alignment, or index biological sequences using randstrobes.
homepage: https://github.com/ksahlin/strobemers
metadata:
  docker_image: "quay.io/biocontainers/strobemap:0.0.2--h077b44d_4"
---

# strobemap

## Overview
Strobemap is a tool and library designed for generating strobemers—a type of "fuzzy" seed used in biological sequence analysis. Unlike traditional k-mers, which are contiguous and easily broken by mutations, strobemers consist of multiple shorter k-mers (strobes) linked together with a pseudorandom spacing. This structure allows seeds to match even when sequences contain substitutions or small shifts. The tool is particularly effective for read mapping and sequence alignment where high sensitivity is needed despite sequence divergence.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::strobemap
```

## Core Parameters and Configuration
When using strobemap, the sensitivity and specificity are controlled by four primary parameters:

- **n (Order)**: The number of strobes linked together. Typically set to 2 or 3.
- **k (Strobe Length)**: The length of each individual strobe. Due to bitpacking optimizations in the C++ implementation, `k` cannot exceed 32.
- **w_min (Minimum Window)**: The start of the search window for the next strobe relative to the current one.
- **w_max (Maximum Window)**: The end of the search window for the next strobe.

### Implementation Limits
- **Order 2**: Maximum total strobemer length is 64 (2 * 32).
- **Order 3**: Maximum total strobemer length is 96 (3 * 32).

## Usage Patterns

### Python Integration
The Python implementation is found in the `modules/indexing.py` file. It provides generators for memory-efficient processing.

```python
from modules import indexing
from collections import defaultdict

# Example: Generating randstrobes of order 3
all_mers = defaultdict(list)
for (p1, p2, p3), h in indexing.randstrobes(seq, k_size, w_min, w_max, order=3).items():
    # h is the hash value, (p1, p2, p3) are the strobe positions
    all_mers[h].append((p1, p2, p3))
```

### C++ Integration
For high-performance applications, use the C++ library by including `index.hpp`. The implementation uses bitpacking for speed.

```cpp
#include "index.hpp"

// Define the vector to store strobemer tuples
// Format: (hash, seq_id, pos1, pos2, pos3)
typedef std::vector<std::tuple<uint64_t, unsigned int, unsigned int, unsigned int, unsigned int>> strobes_vector;

strobes_vector randstrobes3;
randstrobes3 = seq_to_randstrobes3(n, k, w_min, w_max, seq, seq_id);
```

## Expert Tips and Best Practices
- **Seed Selection**: `randstrobes` are generally recommended as they are often as fast as `hybridstrobes` or `minstrobes` while providing robust matching performance.
- **Window Shrinking**: In read mapping, avoid shrinking windows at the ends of sequences. Shrinking windows reduces the probability of a match between a read and the reference because the sampling space becomes inconsistent.
- **Performance Bottlenecks**: The primary bottleneck in strobemer generation is often the overhead of pushing results to a vector/list rather than the computation of the hashes themselves.
- **Memory Efficiency**: Use the `randstrobes_iter` generator in Python for large-scale sequence processing to avoid high memory overhead.

## Reference documentation
- [strobemap - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_strobemap_overview.md)
- [GitHub - ksahlin/strobemers: A repository for generating strobemers and evaluation](./references/github_com_ksahlin_strobemers.md)