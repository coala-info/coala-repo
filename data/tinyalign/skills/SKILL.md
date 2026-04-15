---
name: tinyalign
description: tinyalign calculates string distances, including edit and Hamming distance, with a focus on performance for short sequences. Use when user asks to calculate string distance, calculate edit distance, calculate Hamming distance, compare short sequences, or check if string distance is below a certain threshold.
homepage: https://github.com/marcelm/tinyalign/
metadata:
  docker_image: "quay.io/biocontainers/tinyalign:0.2.2--py311haab0aaa_2"
---

# tinyalign

## Overview
tinyalign is a high-performance Python module, partially implemented in Cython, designed for fast string distance calculations. It is particularly useful in bioinformatics workflows (such as those involving `cutadapt`) where millions of short sequence comparisons are required. Its primary advantage is the implementation of "banded" edit distance, which allows for significant speedups when you only care if the distance is below a certain threshold.

## Usage Instructions

### Installation
Install via bioconda:
```bash
conda install bioconda::tinyalign
```

### Python API Usage
The module provides two primary functions: `edit_distance` and `hamming_distance`.

```python
from tinyalign import edit_distance, hamming_distance

# Basic Levenshtein distance (insertions, deletions, substitutions)
dist = edit_distance("banana", "ananas")  # Result: 2

# Hamming distance (substitutions only, strings must be equal length)
h_dist = hamming_distance("hello", "yello")  # Result: 1
```

### Performance Optimization with Banding
The `maxdiff` parameter enables banded alignment. This is the most critical feature for performance.

- **Behavior**: If `maxdiff` is provided, the algorithm only explores a "band" around the diagonal of the dynamic programming matrix.
- **Accuracy**: The result is only guaranteed to be accurate if the actual distance is $\le$ `maxdiff`. If the distance is higher, the function returns a value greater than `maxdiff`, but not necessarily the exact distance.
- **Expert Tip**: Use `maxdiff` whenever you are filtering sequences based on a maximum error threshold.

```python
# Fast check if distance is roughly within 2
dist = edit_distance("hello", "world", maxdiff=2) # Result: 3 (indicates > 2)
```

### Tool Selection Best Practices
- **When to use tinyalign**: Use this module when `maxdiff` is 4 or more, but not extremely close to the length of the strings. In these cases, `tinyalign` is generally faster than other libraries.
- **When to use alternatives**: If you need to compute a regular (unbanded) edit distance, or if your `maxdiff` is less than 4, `polyleven` is typically faster and should be preferred.

## Reference documentation
- [github_com_marcelm_tinyalign.md](./references/github_com_marcelm_tinyalign.md)
- [anaconda_org_channels_bioconda_packages_tinyalign_overview.md](./references/anaconda_org_channels_bioconda_packages_tinyalign_overview.md)