---
name: r-bedr
description: This tool performs genomic interval arithmetic and region processing in R by wrapping BEDTools, BEDOPS, and Tabix. Use when user asks to merge, intersect, subtract, or join genomic regions, validate and sort intervals, or calculate statistical similarity between region sets.
homepage: https://cloud.r-project.org/web/packages/bedr/index.html
---

# r-bedr

name: r-bedr
description: Genomic region processing using 'bedr' in R. Use this skill to perform genome arithmetic (merge, intersect, subtract, join), validate and sort genomic intervals, and calculate region similarity (jaccard, reldist). It wraps 'BEDTools', 'BEDOPS', and 'Tabix' for high-performance genomic analysis within R.

# r-bedr

## Overview
The `bedr` package provides a suite of tools for genomic interval processing in R. It wraps high-performance command-line engines ('BEDTools', 'BEDOPS', and 'Tabix') to allow for fast, memory-efficient genome arithmetic on both R objects and large on-disk files.

## Installation
To use this package, you must have the underlying binary tools installed and in your system PATH.
```R
install.packages("bedr")
library(bedr)

# Check if dependencies are available
check.binary("bedtools")
check.binary("bedops")
check.binary("tabix")
```

## Core Functions

### Region Validation and Sorting
Always validate and sort regions before performing arithmetic to avoid unexpected results.
```R
# Validate regions (checks chr prefix, start < end, 0-based compliance)
is.valid <- is.valid.region(x)

# Sort regions (lexicographical or natural)
sorted_regions <- bedr.sort.region(x, method = "natural")

# Check status
is.sorted.region(x)
is.merged.region(x)
```

### Genome Arithmetic
- **Merge**: Combine overlapping or adjacent intervals.
  `merged <- bedr.merge.region(x)`
- **Subtract**: Remove regions in B from A.
  `subtracted <- bedr.subtract.region(a, b)`
- **Join/Intersect**: Find overlapping sub-regions.
  `joined <- bedr.join.region(a, b)`
- **In Region**: Logical check for overlaps (similar to `%in%`).
  `overlaps <- a %in.region% b`

### Statistical Similarity
Quantify the similarity between two sets of genomic regions.
```R
# Calculate Jaccard or Relative Distance
j_stats <- jaccard(a, b)
r_stats <- reldist(a, b)

# Comprehensive test with permutations for P-values
sim_results <- test.region.similarity(a, b, n = 100)
```

### GroupBy and Collapsing
Collapse multiple features at the same locus using quantitative or string operations.
```R
# Collapse scores in column 4 for unique regions in columns 1-3
collapsed <- bedr(
  input = list(i = x), 
  method = "groupby", 
  params = "-g 1,2,3 -c 4 -o collapse"
  )
```

## Common Workflows

### Comparing Variant Callers
To find common calls between two VCF files:
1. Read VCFs using `read.vcf(file, split.info = TRUE)`.
2. Convert to 0-based coordinates (`POS - 1`).
3. Use `bedr.join.region(callerA, callerB, report.n.overlap = TRUE)` to find overlaps.

### Processing Copy Number Data
1. Validate segmented data regions.
2. Sort segments per sample.
3. Use `bedr.join.multiple.region(list_of_samples)` to identify Minimal Common Regions (MCR) or recurrent alterations across a cohort.

## Tips for Success
- **Verbose Output**: `bedr` functions default to `verbose = TRUE`. Monitor the log messages; a `status=FAIL` might indicate a data format issue that doesn't stop execution but affects results.
- **Direct API Access**: Use the `bedr()` function for direct access to engine-specific parameters not covered by high-level wrappers.
- **Coordinate Systems**: Be mindful of 0-based (BED) vs 1-based (VCF/GFF) coordinates. `is.valid.region` helps identify these discrepancies.

## Reference documentation
- [Using-bedr](./references/Using-bedr.Rmd)