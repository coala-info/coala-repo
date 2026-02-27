---
name: bioconductor-plyinteractions
description: This tool provides a tidy interface for manipulating genomic interaction data in R using dplyr and plyranges-like syntax. Use when user asks to filter, mutate, group, or perform overlap analysis on Hi-C, ChIA-PET, or other paired genomic range datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/plyinteractions.html
---


# bioconductor-plyinteractions

name: bioconductor-plyinteractions
description: Comprehensive tidy manipulation of genomic interactions (GInteractions) using dplyr and plyranges-like syntax. Use when working with Hi-C, ChIA-PET, or other paired genomic range data in R to filter, mutate, group, or perform overlap analysis on interaction anchors.

# bioconductor-plyinteractions

## Overview

The `plyinteractions` package provides a "tidy" interface for `GInteractions` objects (from the `InteractionSet` package). It allows users to apply familiar `dplyr` verbs (like `filter`, `mutate`, `group_by`) and `plyranges` operations (like `stretch`, `anchor`, `find_overlaps`) directly to genomic interaction data. This is particularly useful for processing Hi-C, ChIA-PET, and other paired-end genomic datasets.

## Core Workflows

### 1. Importing Data
Convert tabular data (from BEDPE or pairs files) into `GInteractions` objects.

```r
library(plyinteractions)

# From a data frame
gi <- bedpe_df |>
    as_ginteractions(
        seqnames1 = V1, start1 = V2, end1 = V3, strand1 = V9,
        seqnames2 = V4, start2 = V5, end2 = V6, strand2 = V10,
        starts.in.df.are.0based = TRUE
    )
```

### 2. Tidy Manipulation (dplyr verbs)
You can manipulate metadata and core genomic fields using standard verbs. Core fields for anchors are accessed by appending `1` or `2` (e.g., `start1`, `seqnames2`).

```r
# Filter for cis-interactions on a specific chromosome
cis_chr1 <- gi |> 
  filter(seqnames1 == seqnames2, seqnames1 == "chr1")

# Mutate to add interaction distance
gi <- gi |> 
  mutate(dist = abs(start2 - start1))

# Group and summarize
stats <- gi |> 
  group_by(seqnames1) |> 
  summarize(count = n(), avg_dist = mean(dist))
```

### 3. Pinned Operations (plyranges verbs)
To use `plyranges` arithmetic (like `stretch` or `flank`), you must "pin" the interaction to one of the two anchors.

```r
# Pin the first anchor and stretch it by 500bp
pinned_gi <- gi |> 
  pin_by("first") |> 
  stretch(500)

# Use anchors to control stretching direction
anchored_gi <- gi |> 
  pin_by("second") |> 
  anchor_center() |> 
  stretch(1000)

# Revert to standard GInteractions
final_gi <- unpin(anchored_gi)
```

### 4. Overlap Analysis
Perform overlaps between `GInteractions` (query) and `GRanges` (subject).

```r
# Find interactions where either anchor overlaps a promoter
overlaps <- find_overlaps(gi, promoter_granges)

# Find interactions where ONLY the pinned anchor overlaps
pinned_overlaps <- gi |> 
  pin_by("first") |> 
  find_overlaps(promoter_granges)

# Count overlaps and add as metadata
gi <- gi |> 
  mutate(n_overlaps = count_overlaps(gi, feature_granges))
```

## Key Functions Reference

| Function | Description |
| :--- | :--- |
| `as_ginteractions()` | Coerce data frames to GInteractions objects. |
| `pin_by("first"\|"second")` | Target a specific anchor for range arithmetic. |
| `anchors1()`, `anchors2()` | Extract GRanges for the first or second anchors. |
| `mutate()`, `filter()`, `select()` | Standard dplyr verbs adapted for GInteractions. |
| `group_by()`, `summarize()` | Aggregate data across interactions. |
| `find_overlaps()` | Find overlaps between interactions and GRanges. |
| `annotate()` | Overlap-based join to add metadata from a GRanges object. |

## Tips and Best Practices
*   **Naming Convention**: Always use the suffix `1` or `2` to refer to the first or second anchor's properties (e.g., `strand1`, `width2`).
*   **Unpinning**: Remember to `unpin()` if you need to return to a standard `GInteractions` object for downstream Bioconductor tools that don't recognize the `PinnedGInteractions` class.
*   **Strandness**: Overlap functions like `find_overlaps()` are unstranded by default. Use `find_overlaps_directed()` if strand information is required.
*   **Metadata**: `select()` only operates on metadata columns unless `.drop_ranges = TRUE` is specified, which converts the output to a `DataFrame`.

## Reference documentation
- [plyinteractions](./references/plyinteractions.md)
- [process_pairs](./references/process_pairs.md)