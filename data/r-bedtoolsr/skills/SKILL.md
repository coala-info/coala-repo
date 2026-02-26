---
name: r-bedtoolsr
description: bedtoolsr is an R wrapper for the bedtools suite that enables genomic interval analysis and manipulation directly within the R environment. Use when user asks to intersect genomic intervals, merge overlapping regions, find the closest features, or calculate coverage using R data frames or BED files.
homepage: https://cran.r-project.org/web/packages/bedtoolsr/index.html
---


# r-bedtoolsr

## Overview
`bedtoolsr` is an R wrapper for the widely used `bedtools` suite of genomic analysis utilities. It allows users to execute bedtools commands directly from the R environment, providing manual pages for all functions and the ability to pass R objects (like data frames) as inputs and receive results as R objects.

## Installation
To install `bedtoolsr` from GitHub:
```R
install.packages("devtools")
devtools::install_github("PhanstielLab/bedtoolsr")
```
Note: `bedtools` must be installed on the system (macOS or Linux). If it is not in the system PATH, specify it manually:
```R
options(bedtools.path = "/path/to/bedtools")
```

## Core Functions and Usage
All functions in the package follow the naming convention `bt.<function_name>`, corresponding to the original bedtools command.

### Basic Intersection
Find overlaps between two genomic intervals:
```R
A.bed <- data.frame(chrom=c("chr1", "chr1"), start=c(10, 30), end=c(20, 40))
B.bed <- data.frame(chrom=c("chr1"), start=15, end=20)

# Returns a data frame of intersections
results <- bedtoolsr::bt.intersect(A.bed, B.bed)
```

### Common Genomic Operations
- **bt.merge**: Combine overlapping or adjacent intervals.
- **bt.slop**: Increase/decrease the size of intervals (requires a genome file or string like "hg19").
- **bt.pairtobed**: Cross-reference paired-end intervals (BEDPE) with BED files.
- **bt.closest**: Find the nearest feature in another file.
- **bt.coverage**: Compute coverage of features in one file by features in another.

### Workflow Example: Anchor Analysis
This workflow demonstrates expanding peaks and checking for overlaps in paired-end data:
```R
# 1. Expand peaks by 5kb on both sides
peaks_expanded <- bedtoolsr::bt.slop(i = peaks_df, g = "hg19", b = 5000)

# 2. Find loops where both anchors overlap expanded peaks
both_anchors <- bedtoolsr::bt.pairtobed(a = loops_bedpe, b = peaks_expanded, type = "both")

# 3. Find loops where only one anchor overlaps
one_anchor <- bedtoolsr::bt.pairtobed(a = loops_bedpe, b = peaks_expanded, type = "xor")
```

## Tips for AI Agents
- **Input Types**: Functions accept either a file path (string) or an R data frame.
- **Genome Specification**: Functions like `bt.slop` require a genome. You can provide a string (e.g., "hg19", "mm10") if the genome is recognized, or a path to a genome file.
- **Column Names**: When passing data frames, ensure they follow BED (chrom, start, end) or BEDPE standards. `bedtoolsr` typically returns V1, V2, V3... column names.
- **Help**: Use `?bt.<function>` to see specific arguments for any bedtools utility.

## Reference documentation
- [LICENSE.md](./references/LICENSE.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)