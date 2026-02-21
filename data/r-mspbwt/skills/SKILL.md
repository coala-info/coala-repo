---
name: r-mspbwt
description: R package mspbwt (documentation from project home).
homepage: https://cran.r-project.org/web/packages/mspbwt/index.html
---

# r-mspbwt

name: r-mspbwt
description: R package for Multi Symbol Positional Burrows Wheeler Transform (msPBWT). Use when Claude needs to perform sequence encoding, indexing, and searching using the msPBWT algorithm, particularly for genetic imputation workflows or large-scale sequence analysis.

## Overview

The `mspbwt` package implements the Multi Symbol Positional Burrows Wheeler Transform. It was primarily designed to facilitate efficient genetic imputation, specifically as a component of the QUILT2 framework. The package allows for the encoding of multi-symbol sequences into a positional BWT format, which can then be indexed and queried for rapid pattern matching.

## Installation

To install the package from CRAN:

```R
install.packages("r-mspbwt")
```

To install the development version from GitHub:

```R
# install.packages("pak")
pak::pkg_install("rwdavies/mspbwt/mspbwt")
```

## Core Functions

The package revolves around three primary operations: encoding, indexing, and searching.

### ms_encode
Encodes raw sequence data into the msPBWT format. This is the first step in the workflow.
- **Usage**: Used to transform input matrices or sequences into the internal representation required for indexing.

### ms_index
Creates a searchable index from the encoded msPBWT data.
- **Usage**: This step processes the output of `ms_encode` to allow for efficient substring or pattern searches across positions.

### ms_find
Performs search queries against the created index.
- **Usage**: Used to locate specific patterns or matches within the positional transform.

## Typical Workflow

1. **Data Preparation**: Organize your multi-symbol sequence data (e.g., genotypes or haplotypes).
2. **Encoding**: Use `ms_encode()` to convert the data into the msPBWT structure.
3. **Indexing**: Use `ms_index()` on the encoded object to prepare it for querying.
4. **Searching**: Use `ms_find()` to perform specific searches or match-finding operations required for your analysis.

## Tips for AI Agents
- When working with genetic data, ensure the symbols are properly mapped to integers if required by the encoding function.
- The msPBWT is particularly efficient for "positional" queries where the match must occur at specific indices in the sequence.
- This package is a low-level dependency for QUILT2; if the user is performing imputation, check if they should be using the higher-level QUILT2 functions instead.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)