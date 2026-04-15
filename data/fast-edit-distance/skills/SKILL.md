---
name: fast-edit-distance
description: This tool calculates the edit distance between strings using a high-performance implementation optimized for speed with early termination. Use when user asks to calculate Levenshtein distance, find the edit distance between sequences, or perform fast similarity searches with a maximum distance threshold.
homepage: https://github.com/youyupei/fast_edit_distance
metadata:
  docker_image: "quay.io/biocontainers/fast-edit-distance:1.2.2--py39hff71179_0"
---

# fast-edit-distance

## Overview

The `fast-edit-distance` tool is a high-performance C and Cython implementation of the edit distance algorithm. While standard libraries like `Levenshtein` are common, this tool is optimized for speed, particularly when you only need to know if two strings are within a specific distance of each other. By providing a `max_ed` (maximum edit distance) parameter, the algorithm can terminate early once the threshold is exceeded, resulting in significant runtime improvements—often reducing processing time from seconds to fractions of a second in large-scale iterations.

## Installation

The package can be installed via pip or conda:

```bash
# Via pip
pip install fast-edit-distance

# Via bioconda
conda install bioconda::fast-edit-distance
```

## Usage Patterns

### Basic Edit Distance
To calculate the standard Levenshtein distance between two strings:

```python
from fast_edit_distance import edit_distance

# Standard calculation
dist = edit_distance("ACGTACGT", "ACGTTCGT")
print(dist) # Output: 1
```

### Optimized Search with Cutoff (Recommended)
The most powerful feature of this tool is the `max_ed` parameter. Use this when you are searching a large database for matches and only care about results within a certain similarity range.

```python
from fast_edit_distance import edit_distance

# If the actual distance exceeds 2, the function returns early
# This is significantly faster than calculating the full distance
dist = edit_distance("long_string_alpha", "long_string_beta", max_ed=2)
```

### Sub-sequence Edit Distance
For tasks requiring the distance of a sub-sequence, use the `sub_edit_distance` function:

```python
from fast_edit_distance import sub_edit_distance

# Useful for finding local alignments or partial matches
dist = sub_edit_distance("target_sequence", "query")
```

## Expert Tips and Best Practices

1.  **Always Use `max_ed` for Filtering**: If your workflow involves filtering pairs (e.g., "find all sequences with distance < 5"), always pass `max_ed=5`. In benchmarks, this can be up to 90x faster than a standard distance calculation.
2.  **Input Types**: Ensure inputs are strings. While the tool is robust, passing non-string types (like lists or tuples) may cause errors in certain versions.
3.  **Performance Scaling**: This tool is designed for millions of iterations. If you are only comparing a few dozen strings, the overhead of the library might not be necessary, but for bulk processing (e.g., genomic reads or large text corpora), it is highly superior to pure Python implementations.
4.  **Handling Different Lengths**: The implementation correctly handles strings of different lengths by default.

## Reference documentation
- [Fast Edit Distance GitHub Overview](./references/github_com_youyupei_fast_edit_distance.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_fast-edit-distance_overview.md)