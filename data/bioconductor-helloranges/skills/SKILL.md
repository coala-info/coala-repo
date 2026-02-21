---
name: bioconductor-helloranges
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/HelloRanges.html
---

# bioconductor-helloranges

name: bioconductor-helloranges
description: Translating bedtools commands into Bioconductor R code using HelloRanges. Use this skill when you need to perform genomic range operations (intersect, merge, coverage, etc.) in R using a bedtools-like syntax or when you need to generate idiomatic R/Bioconductor code (GRanges) from bedtools recipes.

## Overview

HelloRanges is a pedagogical and functional bridge between the `bedtools` command-line suite and the Bioconductor `Ranges` infrastructure. It provides a compiler that translates `bedtools` arguments into executable R code. This allows users to leverage their knowledge of `bedtools` to learn the `GRanges` API and build performant, reproducible R workflows.

## Core Workflows

### 1. Generating R Code from bedtools Commands
The primary entry point is the `bedtools_*` family of functions. These return an R language object (the code) rather than the result itself.

```r
library(HelloRanges)
# Generate code to intersect two BED files
code <- bedtools_intersect("-a cpg.bed -b exons.bed -g hg19")
# Print the code to see the Bioconductor implementation
print(code)
# Evaluate the code to get a GRanges object
result <- eval(code)
```

### 2. Direct Execution (The `do_` Family)
If you want to skip the code generation step and get the result immediately, use the `do_` prefix.

```r
# Returns a GRanges object directly
result <- do_bedtools_intersect("-a cpg.bed -b exons.bed -g hg19")
```

### 3. Chaining Operations in R
HelloRanges supports a functional R interface (`R_` prefix) that accepts R objects (like `GRanges`) as inputs, allowing for piping and integration with other Bioconductor tools.

```r
library(magrittr)
# Chain coverage and intersection
do_bedtools_genomecov("exons.bed", g="hg19.genome", bga=TRUE) %>%
    subset(score > 0L) %>%
    do_bedtools_intersect("cpg.bed", .)
```

## Key Functions and Mapping

| bedtools Command | HelloRanges Function | Bioconductor Equivalent |
| :--- | :--- | :--- |
| `intersect` | `bedtools_intersect` | `findOverlapPairs`, `pintersect` |
| `merge` | `bedtools_merge` | `reduce` |
| `genomecov` | `bedtools_genomecov` | `coverage` |
| `complement` | `bedtools_complement` | `setdiff` |
| `subtract` | `bedtools_subtract` | `subsetByOverlaps(invert=TRUE)` |
| `closest` | `bedtools_closest` | `nearest`, `distanceToNearest` |
| `jaccard` | `bedtools_jaccard` | `intersect` / `union` widths |

## Important Usage Tips

- **Genome Information**: Always provide a genome (e.g., `-g hg19` or a genome file) to ensure `Seqinfo` is correctly populated. This prevents errors with incompatible builds.
- **Strand Sensitivity**: Unlike `bedtools`, Bioconductor is strand-aware by default. HelloRanges code explicitly uses `ignore.strand = TRUE` to match `bedtools` behavior unless specified otherwise.
- **Metadata**: Use `mcols(result)` to access tabular annotations (like overlap counts or scores) attached to the genomic ranges.
- **Aggregation**: When using `merge` with `-c` and `-o`, HelloRanges uses `reduce(..., with.revmap=TRUE)` and `aggregate()` to summarize data.
- **Performance**: For large datasets, import data once using `rtracklayer::import()` and then use the `R_` or `do_` functions on the in-memory objects.

## Reference documentation

- [Saying Hello to the Bioconductor Ranges Infrastructure](./references/tutorial.md)