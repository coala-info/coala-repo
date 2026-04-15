---
name: bioconductor-phastcons7way.ucsc.hg38
description: This package provides UCSC phastCons conservation scores for the human genome (hg38) based on alignments of seven vertebrate species. Use when user asks to retrieve evolutionary conservation scores for specific genomic coordinates, annotate genomic ranges with conservation data, or query phastCons scores using the GenomicScores framework.
homepage: https://bioconductor.org/packages/release/data/annotation/html/phastCons7way.UCSC.hg38.html
---

# bioconductor-phastcons7way.ucsc.hg38

name: bioconductor-phastcons7way.ucsc.hg38
description: Access and use UCSC phastCons conservation scores for the human genome (hg38) based on 7 vertebrate species. Use this skill when you need to retrieve evolutionary conservation scores for specific genomic coordinates, ranges, or genes in the hg38 assembly using the GenomicScores framework.

# bioconductor-phastcons7way.ucsc.hg38

## Overview

The `phastCons7way.UCSC.hg38` package is a Bioconductor annotation resource providing phastCons conservation scores for the human genome (hg38). These scores represent the probability that a nucleotide belongs to a conserved element, calculated from multiple alignments of 7 vertebrate species. The data is stored as a `GScores` object, which allows for efficient memory usage via `Rle` (Run-Length Encoding) and standardized access through the `GenomicScores` interface.

## Basic Usage

### Loading the Package and Data

The package automatically exposes a `GScores` object with the same name as the package.

```r
library(phastCons7way.UCSC.hg38)

# Reference the score object
phast <- phastCons7way.UCSC.hg38
phast
```

### Retrieving Conservation Scores

Use the `gscores()` function from the `GenomicScores` package to query specific genomic ranges.

```r
library(GenomicRanges)

# Query a specific range on chromosome 7
rng <- GRanges("chr7:117592326-117592330")
scores <- gscores(phast, rng)
print(scores)
```

### Common Workflows

1.  **Score Annotation**: To add conservation scores as a metadata column to an existing `GRanges` object:
    ```r
    my_regions <- GRanges(c("chr1:1000-1100", "chr2:2000-2100"))
    annotated_regions <- gscores(phast, my_regions)
    ```

2.  **Handling Populations/Scores**: While this specific package focuses on the 7-way vertebrate alignment, you can check available populations or score types:
    ```r
    populations(phast)
    ```

3.  **Citation**: To cite the data source and package in publications:
    ```r
    citation("phastCons7way.UCSC.hg38")
    ```

## Implementation Tips

- **GenomicScores Dependency**: This package is a data container. Most functional operations (like `gscores()`) require the `GenomicScores` library to be loaded.
- **Coordinate System**: Ensure your input `GRanges` use the `hg38` genome build and "UCSC" chromosome naming convention (e.g., "chr1" not "1").
- **Memory Efficiency**: The scores are stored as `Rle` objects. Accessing large swaths of the genome is efficient, but querying millions of individual disjoint points may be slower than querying contiguous ranges.

## Reference documentation

- [phastCons7way.UCSC.hg38 Reference Manual](./references/reference_manual.md)