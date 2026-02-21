---
name: r-tidygenomics
description: Skill for using the CRAN R package r-tidygenomics.
homepage: https://cran.r-project.org/web/packages/tidygenomics/index.html
---

# r-tidygenomics

name: r-tidygenomics
description: Handle genomic data frames using tidyverse-style verbs. Use this skill when you need to perform genomic interval operations (intersect, subtract, join, cluster, complement) directly on R data frames or tibbles without converting to GRanges objects.

# r-tidygenomics

## Overview
The `tidygenomics` package provides a "tidy" interface for genomic interval manipulation in R. It allows users to treat data frames as genomic ranges, similar to `bedtools` or `GenomicRanges`, while maintaining compatibility with `dplyr` workflows and preserving metadata columns.

## Installation
```R
install.packages("tidygenomics")
# Or for the development version:
# devtools::install_github("const-ae/tidygenomics")
```

## Core Functions

### genome_intersect
Joins two data frames based on genomic overlap and updates the `start` and `end` coordinates to represent the actual overlapping region.
```R
genome_intersect(x, y, by = c("chromosome", "start", "end"), mode = "both")
```

### genome_subtract
Removes regions in data frame `x` that overlap with regions in data frame `y`. This may split a single interval into multiple smaller ones.
```R
genome_subtract(x, y, by = c("chromosome", "start", "end"))
```

### genome_join_closest
Joins two data frames based on genomic proximity. If no overlap exists, it finds the nearest interval.
- `distance_column_name`: Name for the calculated distance column.
- `mode`: "left", "inner", etc.
```R
genome_join_closest(x, y, by = c("chr", "start", "end"), distance_column_name = "dist")
```

### genome_cluster
Assigns a `cluster_id` to intervals that overlap or are within a specified distance of each other.
- `max_distance`: Maximum gap allowed between intervals to be considered part of the same cluster.
```R
genome_cluster(x, by = c("chromosome", "start", "end"), max_distance = 0)
```

### genome_complement
Calculates the gaps between genomic regions within the data frame.
```R
genome_complement(x, by = c("chromosome", "start", "end"))
```

### genome_join
Provided by the `fuzzyjoin` package (re-exported or used alongside). Performs a standard join where rows are matched if their genomic intervals overlap. Unlike `genome_intersect`, it keeps the original coordinates of both data frames.
```R
fuzzyjoin::genome_join(x, y, by = c("chr", "start", "end"), mode = "inner")
```

## Usage Tips
- **Column Naming**: Ensure the `by` argument correctly maps the chromosome, start, and end columns. They do not have to have the same names in both data frames (e.g., `by = c("chr" = "chromosome", "start" = "begin", "end" = "stop")`).
- **Tidy Integration**: These functions return data frames (or tibbles), making them pipe-friendly with `dplyr` verbs like `filter()`, `mutate()`, and `group_by()`.
- **Coordinate Systems**: Be mindful of 0-based vs 1-based indexing common in genomics; `tidygenomics` treats the input as-is.

## Reference documentation
- [README](./references/README.md)
- [Tidy Genomics Intro](./references/intro.Rmd)