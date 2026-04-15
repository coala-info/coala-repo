---
name: longestrunsubsequence
description: The longestrunsubsequence tool extracts the longest possible subsequence from a string or list where each unique element appears in only one contiguous block. Use when user asks to find the longest run subsequence, reconcile contig sets in genomic research, or identify trends that maintain single-visit consistency for each category.
homepage: https://github.com/AlBi-HHU/longest-run-subsequence
metadata:
  docker_image: "quay.io/biocontainers/longestrunsubsequence:1.0.1--py_0"
---

# longestrunsubsequence

## Overview

The `longestrunsubsequence` tool provides a specialized solver for a specific string optimization problem. In a "Longest Run Subsequence," the goal is to extract elements from a sequence to form a new sequence where no character "reappears" after a different character has been introduced. For example, in the string `ccbcbbbdaaddd`, a valid run subsequence could be `cccbbbaaddd` (indices 0, 1, 3, 4, 5, 6, 8, 9, 10, 11, 12), because 'c', 'b', 'a', and 'd' each appear in exactly one contiguous block.

This tool is primarily used in genomic research to reconcile contig sets from different individuals of the same species. It automatically selects between Dynamic Programming (DP) and Integer Linear Programming (ILP) algorithms based on the input's characteristics and applies reduction rules to optimize performance.

## Installation

Install the package via Bioconda:

```bash
conda install bioconda::longestrunsubsequence
```

## Usage Instructions

### Python API Usage
The tool is primarily designed to be used as a Python module. Import the `lrs` function to process sequences.

```python
from longestrunsubsequence import lrs

# Input can be a string
sequence_str = 'ccbcbbbdaaddd'
result_indices = lrs(sequence_str)
print(f"Indices: {result_indices}")

# Input can also be a list of arbitrary elements
sequence_list = [10, 20, 10, 20, 20, 30]
result_indices_list = lrs(sequence_list)
print(f"Indices: {result_indices_list}")
```

### Understanding the Output
The `lrs` function returns a **list of indices**. To reconstruct the actual subsequence, use a list comprehension or a loop:

```python
input_data = 'ccbcbbbdaaddd'
indices = lrs(input_data)
subsequence = "".join([input_data[i] for i in indices])
# Result: 'cccbbbaaddd'
```

## Expert Tips and Best Practices

### Algorithm Selection
The solver automatically switches strategies based on the input:
*   **Dynamic Programming (DP):** Optimized for long strings with small alphabets.
*   **Integer Linear Programming (ILP):** Optimized for short strings with large alphabets.

### Dependencies for ILP
If your data requires the ILP approach (short strings/large alphabets), ensure the `PuLP` library is installed in your environment. Without `PuLP`, the ILP solver will be unavailable.

### Data Pre-processing
The tool internally applies reduction rules to split instances into smaller sub-problems. You do not need to manually segment your data unless the sequences are exceptionally large (millions of characters), in which case manual partitioning at clear boundaries may assist memory management.

### Input Flexibility
Since the tool accepts lists with arbitrary elements, you can use it for non-genomic data, such as time-series events or categorical logs, where you need to identify the longest trend that maintains "single-visit" consistency for each category.

## Reference documentation
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_longestrunsubsequence_overview.md)
- [GitHub Repository README](./references/github_com_AlBi-HHU_longest-run-subsequence.md)