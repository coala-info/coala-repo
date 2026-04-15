---
name: setsimilaritysearch
description: The setsimilaritysearch library provides high-performance algorithms for finding similar sets and performing all-pairs similarity searches in Python. Use when user asks to find similar sets, perform all-pairs similarity search, deduplicate data, or query a collection for sets exceeding a similarity threshold.
homepage: https://github.com/ekzhu/SetSimilaritySearch
metadata:
  docker_image: "quay.io/biocontainers/setsimilaritysearch:1.0.0"
---

# setsimilaritysearch

## Overview

The `setsimilaritysearch` library provides high-performance algorithms for finding similar sets in Python. It is particularly useful for recommendation systems (e.g., finding users with similar reading lists), deduplication, and data mining tasks where brute-force $O(n^2)$ comparisons are computationally prohibitive. It implements the "All-Pair-Binary" algorithm with position filter optimizations, making it faster than approximate methods like MinHash LSH for many ad-hoc tasks.

## Library Usage

### All-Pairs Similarity Search
Use `all_pairs` to find every pair of sets in a collection that exceeds a similarity threshold.

```python
from SetSimilaritySearch import all_pairs

# Input: List of iterables (lists, sets, or tuples)
sets = [[1, 2, 3], [3, 4, 5], [2, 3, 4], [5, 6, 7]]

# Returns an iterable of (index_1, index_2, similarity_score)
pairs = all_pairs(sets, similarity_func_name="jaccard", similarity_threshold=0.1)

for idx1, idx2, score in pairs:
    print(f"Set {idx1} and Set {idx2} similarity: {score}")
```

### Querying Against a Collection
Use `SearchIndex` when you have a static collection and need to perform one or more searches with external query sets.

```python
from SetSimilaritySearch import SearchIndex

sets = [[1, 2, 3], [3, 4, 5], [2, 3, 4], [5, 6, 7]]

# Build the static index
index = SearchIndex(sets, similarity_func_name="jaccard", similarity_threshold=0.1)

# Query with a new set
results = index.query([5, 3, 4])
# Returns list of (index, similarity_score)
```

## Command Line Usage

The package includes a CLI tool `all_pairs.py` for processing file-based datasets.

### Input Format
The input file should contain one `SetID Token` pair per line, separated by whitespace.
```text
# Example input.txt
user1 book_a
user1 book_b
user2 book_b
user2 book_c
```

### Execution
Run the script to find all similar pairs:
```bash
python all_pairs.py -f input.txt -t 0.5 -s jaccard
```

## Supported Similarity Functions

| Function Name | Description | Formula |
| :--- | :--- | :--- |
| `jaccard` | Standard intersection over union | $|A \cap B| / |A \cup B|$ |
| `cosine` | Geometric mean of sizes | $|A \cap B| / \sqrt{|A| \cdot |B|}$ |
| `containment` | Intersection over query size | $|A \cap B| / |A|$ |

## Best Practices and Tips

- **Ad-hoc vs. Persistent Search**: Use `SetSimilaritySearch` for ad-hoc all-pairs tasks. For persistent, high-volume querying where sets are very large, consider `datasketch` (MinHash LSH), though `SetSimilaritySearch` is often faster for smaller sets or when exact results are required.
- **Memory Management**: The library is optimized for sets that fit in memory. If you encounter `MemoryErrors` on datasets larger than 14k-20k sets with very high dimensionality, consider increasing available RAM or pre-filtering extremely frequent tokens.
- **Data Types**: Ensure input sets are lists of iterables. While the library is flexible, using integers as tokens instead of long strings can reduce memory overhead.
- **Threshold Tuning**: Higher thresholds (e.g., > 0.5) significantly improve performance as the algorithm can prune more candidates using the position filter.

## Reference documentation
- [SetSimilaritySearch README](./references/github_com_ekzhu_SetSimilaritySearch.md)