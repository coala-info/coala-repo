---
name: bioconductor-structuralvariantannotation
description: This tool provides a framework for parsing, annotating, and comparing structural variants from VCF files using a breakend-centric approach. Use when user asks to convert VCF records to breakend-centric GRanges, find overlaps between structural variant callsets, handle ambiguous breakpoint positions, or identify complex events like insertion-duplication equivalence.
homepage: https://bioconductor.org/packages/release/bioc/html/StructuralVariantAnnotation.html
---

# bioconductor-structuralvariantannotation

name: bioconductor-structuralvariantannotation
description: Expert guidance for the Bioconductor R package StructuralVariantAnnotation. Use this skill when parsing, annotating, comparing, or visualizing structural variants (SVs) from VCF files. It provides specialized workflows for converting VCF records into breakend-centric GRanges, handling ambiguous breakpoint positions, finding overlaps between SV callsets, and identifying complex events like transitive breakpoints or insertion-duplication equivalence.

# bioconductor-structuralvariantannotation

## Overview

The `StructuralVariantAnnotation` package provides a framework for handling structural variants (SVs) in R using a "breakend-centric" approach. Unlike standard BEDPE formats that treat breakpoints as pairs, this package represents each side of a breakpoint as a separate entry in a `GRanges` object, linked by a `partner` field. This allows for a unified representation of deletions, duplications, inversions, translocations, and single breakends (where only one side is known).

## Core Workflow

### 1. Loading SV Data
The package builds on `VariantAnnotation`. Use `readVcf` to load the data, then convert it to the specialized GRanges format.

```r
library(StructuralVariantAnnotation)
library(VariantAnnotation)

# Load VCF
vcf <- readVcf("path/to/file.vcf")

# Convert to breakpoint-centric GRanges
# This handles BND, DEL, DUP, INV, etc.
gr <- breakpointRanges(vcf)

# Load single breakends (records with only one known side)
begr <- breakendRanges(vcf)

# Combine and sort
all_sv <- sort(c(gr, begr))
```

### 2. Navigating Breakpoints
Because each breakpoint is represented by two records, use the `partner()` function to find the other side.

```r
# Get the partner for each breakend
partner_gr <- partner(gr)

# Check if a record has a valid partner in the current object
valid_idx <- hasPartner(gr)
gr_clean <- gr[valid_idx]
```

### 3. Comparing Callsets (Overlaps)
Standard `findOverlaps` is insufficient for SVs because both sides of the breakpoint must match. Use `findBreakpointOverlaps`.

```r
# Compare a query set to a truth set
overlaps <- findBreakpointOverlaps(query_gr, truth_gr,
                                   maxgap = 100,           # Distance allowed between breakends
                                   sizemargin = 0.25,      # Relative size difference allowed
                                   restrictMarginToSizeMultiple = 0.5)

# Count matches (useful for Precision-Recall curves)
query_gr$matches <- countBreakpointOverlaps(query_gr, truth_gr, maxgap = 100)
```

### 4. Handling Complex and Equivalent Variants
*   **Insertion-Duplication Equivalence**: Short-read callers often call duplications while long-read callers call insertions. Use `findInsDupOverlaps(gr1, gr2)` to match these.
*   **Transitive Breakpoints**: Identify breakpoints that are actually shortcuts for multiple smaller rearrangements.
    ```r
    transitive_calls <- findTransitiveCalls(query_gr, truth_gr)
    ```

## Data Representation Details

*   **Strand Logic**: 
    *   `+` (Forward): The derivative chromosome consists of bases **at and before** the position.
    *   `-` (Reverse): The derivative chromosome consists of bases **at and after** the position.
*   **Ambiguity**: The package incorporates `CIPOS` and `HOMPOS` from VCFs into the `start` and `end` coordinates of the `GRanges`. To use only the nominal position, set `nominalPosition = TRUE` in `breakpointRanges()`.

## Visualization
To create circos plots with `ggbio`, you must add a `to.gr` metadata column representing the partner's location.

```r
library(ggbio)
# Prepare for circos
gr_circos <- gr
mcols(gr_circos)$to.gr <- granges(partner(gr_circos))

# Plot links
ggbio() + circle(gr_circos, geom = "link", linked.to = "to.gr") + circle(hg19sub, geom = "ideo")
```

## Conversion to Other Formats
To interface with tools expecting BEDPE or `Pairs` objects:

```r
# To BEDPE/Pairs
pairs_obj <- breakpointgr2pairs(gr)
rtracklayer::export(pairs_obj, "output.bedpe")

# From BEDPE/Pairs
new_gr <- pairs2breakpointgr(rtracklayer::import("input.bedpe"))
```

## Reference documentation
- [StructuralVariantAnnotation Quick Overview](./references/vignettes.md)