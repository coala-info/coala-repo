---
name: digest
description: The digest library performs efficient sub-sampling of k-mers from DNA sequences using various minimizer schemes and rolling hash functions. Use when user asks to sub-sample genomic data, extract windowed minimizers, implement syncmer or modimizer schemes, or handle non-ACTG characters in sequence analysis.
homepage: https://github.com/VeryAmazed/digest
---


# digest

## Overview

The `digest` library is a high-performance toolset designed for the efficient sub-sampling of k-mers within DNA sequences. By utilizing the ntHash rolling hash function, it allows researchers to reduce genomic data complexity while preserving representative sequence information. Use this skill to implement various minimizer schemes, handle non-ACTG characters via specific policies, and leverage parallel execution for large-scale datasets.

## Installation

Install the library and its bindings using one of the following methods:

- **Conda (Recommended)**: `conda install -c bioconda digest`
- **Source (C++)**:
  ```bash
  git clone https://github.com/VeryAmazed/digest.git
  meson setup --prefix=<ABS_PATH_TO_BUILD> --buildtype=release build
  meson install -C build
  ```
- **Source (Python)**: After the C++ installation, run `pip install .` from the repository root.

## Sub-sampling Schemes

Choose the appropriate scheme based on your analysis requirements:

- **Windowed Minimizer**: Identifies the smallest k-mer within a user-specified window ($w$). It uses the rightmost k-mer to break ties.
- **Modimizer**: Selects k-mers whose hash values are congruent to a specific value within a defined mod-space.
- **Syncmer**: Classifies a window as a minimizer if its smallest value matches the hashes of the leftmost or rightmost k-mer in that window.

## Python Usage Patterns

The Python bindings provide a high-level interface for rapid processing.

### Basic Extraction
```python
from digest import window_minimizer, syncmer, modimizer

# Returns a list of positions
pos = window_minimizer(sequence, k=15, w=30)

# Returns positions and hash values
data = modimizer(sequence, k=15, mod=5, include_hash=True)
```

### Performance Optimization
- **Parallelization**: Use the `num_threads` parameter to speed up processing on large sequences (e.g., whole chromosomes).
  ```python
  window_minimizer(large_seq, k=15, w=30, num_threads=4)
  ```
- **Numpy Integration**: For downstream numerical analysis, use the `_np` variants to return results as numpy arrays.
  ```python
  from digest import window_minimizer_np
  arr = window_minimizer_np(sequence, k=15, w=30)
  ```

## C++ Implementation Best Practices

When integrating `digest` into C++ projects, focus on the `digester` object and memory management.

### Handling Non-ACTG Characters
Specify a `BadCharPolicy` to determine how the library handles ambiguous bases:
- `digest::BadCharPolicy::WRITEOVER`: Replaces any non-ACTG character with 'A'.
- `digest::BadCharPolicy::SKIPOVER`: Skips any k-mer containing non-ACTG characters.

### Efficient Rolling
Use the `roll_minimizer` function to populate vectors without manual iteration:
```cpp
#include "digest/digester.hpp"
#include "digest/window_minimizer.hpp"

// Initialize with sequence, k-mer size, and window size
digest::WindowMin<digest::BadCharPolicy::WRITEOVER, digest::ds::Adaptive> digester(dna, 15, 7);

std::vector<size_t> output;
// Find up to 1000 minimizers
digester.roll_minimizer(1000, output);
```

## Reference documentation
- [Bioconda Digest Overview](./references/anaconda_org_channels_bioconda_packages_digest_overview.md)
- [Digest GitHub README](./references/github_com_VeryAmazed_digest.md)