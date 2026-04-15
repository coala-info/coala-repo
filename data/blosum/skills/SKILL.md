---
name: blosum
description: The blosum module provides a lightweight utility for loading and querying protein substitution matrices without heavy dependencies. Use when user asks to load BLOSUM matrices, retrieve amino acid substitution scores, or perform sequence similarity calculations.
homepage: https://github.com/not-a-feature/blosum
metadata:
  docker_image: "quay.io/biocontainers/blosum:2.2.0--pyhdfd78af_0"
---

# blosum

## Overview

The `blosum` module is a lightweight Python utility designed for bioinformatics tasks that require protein substitution scores. It eliminates the need for heavy dependencies when your primary requirement is simply reading and querying BLOSUM matrices. It is ideal for scripts performing sequence similarity calculations, alignment algorithms, or evolutionary analysis.

## Installation

Install the package via pip or conda:

```bash
pip install blosum
# OR
conda install bioconda::blosum
```

## Core Usage Patterns

### Loading Standard Matrices
The library includes built-in support for the most common BLOSUM versions.

```python
import blosum as bl

# Supported integers: 45, 50, 62, 80, 90
matrix = bl.BLOSUM(62)

# Access scores using amino acid single-letter codes
score = matrix["A"]["Y"]
```

### Handling Missing Keys and Default Values
By default, the matrix behaves like a `defaultdict` and returns `float("-inf")` for unknown keys. You can override this behavior during initialization.

```python
# Set a custom default score for missing pairs
matrix = bl.BLOSUM(62, default=0)

# Accessing a row returns a defaultdict of that row
row_dict = matrix["A"]
```

### Loading Custom Matrices
You can load external matrix files by providing a file path.

```python
matrix = bl.BLOSUM("path/to/custom_matrix.txt")
```

**Custom Matrix File Format Requirements:**
- Comments must start with `#`.
- Values must be separated by one or more whitespace characters.
- The first row and first column should contain the amino acid labels.

## Expert Tips

- **Memory Efficiency**: Since the module has no third-party dependencies (like NumPy or Pandas), it is highly suitable for serverless functions or environments with strict resource constraints.
- **Data Structure**: Remember that `matrix["A"]` returns a `defaultdict`. If you are iterating over scores, you can treat the matrix object as a nested dictionary.
- **Input Validation**: Ensure amino acid characters are uppercase, as the matrix keys are case-sensitive based on the source file or internal defaults.

## Reference documentation
- [blosum GitHub Repository](./references/github_com_not-a-feature_blosum.md)
- [blosum Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_blosum_overview.md)