---
name: bioconductor-genomeintervals
description: The genomeIntervals package provides S4 classes and methods for managing genomic intervals with support for strand specificity and inter-base coordinates. Use when user asks to represent genomic features as intervals, perform interval set operations like union or intersection, calculate distances between genomic elements, or parse GFF3 files.
homepage: https://bioconductor.org/packages/release/bioc/html/genomeIntervals.html
---

# bioconductor-genomeintervals

## Overview

The `genomeIntervals` package provides S4 classes and methods for handling genomic intervals (e.g., exons, ChIP-seq peaks) represented as integers on Z. It extends the `intervals` package to a genomic context by adding sequence names (chromosomes) and strand specificity. A key feature is its support for both "base" intervals (nucleotides) and "inter-base" intervals (points between nucleotides, like insertion sites).

## Core Classes

- **Genome_intervals**: Represents intervals with `seq_name` (chromosome) and `inter_base` status.
- **Genome_intervals_stranded**: Extends the above with `strand` information (+ or -).

## Key Workflows

### 1. Creating and Accessing Intervals
Intervals can be created from matrices or loaded from example data.

```R
library(genomeIntervals)

# Create from scratch
m <- matrix(c(1, 10, 20, 30), ncol = 2, byrow = TRUE)
annot <- data.frame(
  seq_name = factor(c("chr1", "chr1")),
  inter_base = FALSE,
  strand = factor(c("+", "-"), levels = c("+", "-"))
)
gi <- new("Genome_intervals_stranded", m, closed = TRUE, annotation = annot)

# Accessors
seqnames(gi)
strand(gi)
inter_base(gi)
size(gi) # Number of bases contained
```

### 2. Interval Manipulation
The package allows fine-grained control over interval boundaries (open, closed, or mixed).

```R
# Standardize to closed intervals [start, end]
gi_closed <- close_intervals(gi)

# Adjust closure for all intervals
closed(gi) <- c(TRUE, FALSE) # Sets all to [start, end)

# Combine objects
combined <- c(gi1, gi2)
```

### 3. Overlap and Set Operations
Operations are performed per sequence name and (if applicable) per strand.

```R
# Find overlaps (returns a list of indices)
ov <- interval_overlap(from = gi1, to = gi2)

# Set operations
union_gi <- interval_union(gi)
intersect_gi <- interval_intersection(gi1, gi2)
complement_gi <- interval_complement(gi)
```

### 4. Distance and Nearest Neighbor
Calculates the absolute distance between intervals.

```R
# Distance to nearest interval in 'to'
# Returns 0 if overlapping, 0.5 if between a base and adjacent inter-base
dist <- distance_to_nearest(from = gi1, to = gi2)
```

### 5. Working with GFF3
The package includes robust support for GFF3 files and attribute parsing.

```R
# Read GFF3 file
gff <- readGff3("path/to/file.gff3", isRightOpen = FALSE)

# Extract specific attributes
ids <- getGffAttribute(gff, "ID")
parents <- getGffAttribute(gff, "Parent")

# Parse all attributes into a matrix
all_attr <- parseGffAttributes(gff)
```

## Usage Tips
- **Inter-base intervals**: Use `inter_base = TRUE` for features like restriction sites or insertion points. These have a `size` of 0.
- **Closure Logic**: Be mindful of interval closure (e.g., `[1, 2]` vs `[1, 2)`). Use `close_intervals()` to standardize before performing set operations to ensure predictable results.
- **Annotation**: The `annotation(gi)` slot is a data frame. You can add custom columns using `gi$my_col <- values` or `gi[["my_col"]]`.

## Reference documentation
- [The genomeIntervals package](./references/genomeIntervals.md)