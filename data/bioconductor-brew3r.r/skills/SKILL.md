---
name: bioconductor-brew3r.r
description: BREW3R.r improves transcriptomic annotations by extending the 3' ends of genes using a template annotation while preventing overlaps with neighboring genes. Use when user asks to extend gene annotations, improve 3' UTR coverage, or prevent gene collisions in transcriptomic references.
homepage: https://bioconductor.org/packages/release/bioc/html/BREW3R.r.html
---

# bioconductor-brew3r.r

## Overview

The **BREW3R.r** package provides a specialized tool for improving transcriptomic annotations by extending the 3' ends of genes. It works by taking a "to-be-extended" annotation (e.g., GENCODE) and using a "template" annotation (e.g., RefSeq) to fill in missing 3' information. The package intelligently handles gene collisions to ensure extensions do not overlap with neighboring genes on the same strand.

## Core Workflow

### 1. Data Preparation
Load the necessary Bioconductor packages and import your GTF files as `GRanges` objects using `rtracklayer`.

```r
library(rtracklayer)
library(GenomicRanges)
library(BREW3R.r)

# Import annotations
gr_to_extend <- rtracklayer::import("your_annotation.gtf")
gr_template <- rtracklayer::import("template_annotation.gtf")
```

### 2. Preserving Non-Exon Features
The extension function focuses on exons. If you need to keep CDS, start codons, or stop codons, subset them beforehand to re-add them later. 
*Note: Do not preserve 'gene' or 'transcript' types as their coordinates will become invalid after extension.*

```r
# Save CDS for later
gr_cds <- subset(gr_to_extend, type == "CDS")
```

### 3. Extending Annotations
Use the `extend_granges` function. This is the primary function of the package.

```r
# Perform extension
new_exons <- extend_granges(
    input_gr_to_extend = gr_to_extend,
    input_gr_to_overlap = gr_template
)
```

### 4. Recomposing and Exporting
Combine the newly extended exons with your preserved features and export the result.

```r
# Combine and sort
final_gr <- sort(c(new_exons, gr_cds))

# Export to GTF
rtracklayer::export.gff(final_gr, "extended_annotation.gtf")
```

## Configuration and Verbosity

You can control the level of feedback provided during the extension process using R options:

- **Mute messages**: `options(rlib_message_verbosity = "quiet")`
- **Detailed progress**: `options(BREW3R.r.verbose = "progression")`

## Key Considerations

- **Collision Prevention**: The package automatically stops 3' extension if it encounters another gene on the same strand to prevent chimeric transcript models.
- **Input Types**: The package primarily utilizes `type == "exon"` entries from the input `GRanges`.
- **Compatibility**: This tool is highly recommended for preprocessing references used in scRNA-seq pipelines (like CellRanger) when 3' UTR coverage in the standard annotation is poor.

## Reference documentation

- [BREW3R.r Vignette (Rmd)](./references/BREW3R.r.Rmd)
- [BREW3R.r Documentation (md)](./references/BREW3R.r.md)