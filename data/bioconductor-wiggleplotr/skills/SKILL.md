---
name: bioconductor-wiggleplotr
description: This tool visualizes genomic read coverage from BigWig files alongside gene models with the ability to rescale introns for clearer exon visualization. Use when user asks to visualize RNA-seq coverage, plot transcript structures from Ensembl or UCSC databases, or compare genomic signal across different experimental conditions.
homepage: https://bioconductor.org/packages/release/bioc/html/wiggleplotr.html
---

# bioconductor-wiggleplotr

name: bioconductor-wiggleplotr
description: Visualizing RNA-seq read coverage across annotated exons and genomic features using BigWig files. Use this skill to create publication-quality gene models and coverage plots, rescale introns for better visualization of alternative splicing, and compare coverage across different experimental conditions or genotypes.

# bioconductor-wiggleplotr

## Overview

`wiggleplotr` is an R package designed to visualize genomic read coverage (RNA-seq, ATAC-seq, ChIP-seq) alongside gene models. Its standout feature is the ability to rescale introns to a fixed length, which prevents long introns from obscuring the visualization of exon-level coverage differences. It integrates seamlessly with Bioconductor annotation objects like `EnsDb` and `TxDb`.

## Core Workflows

### 1. Visualizing Transcript Structures
Use `plotTranscripts` to view gene models without coverage data.

```r
library(wiggleplotr)

# Basic plot with real genomic coordinates
plotTranscripts(exons = ncoa7_exons, cdss = ncoa7_cdss, annotations = ncoa7_metadata, rescale_introns = FALSE)

# Plot with rescaled introns (default 50bp) to focus on exons
plotTranscripts(exons = ncoa7_exons, cdss = ncoa7_cdss, annotations = ncoa7_metadata, rescale_introns = TRUE)
```

### 2. Visualizing Read Coverage
Use `plotCoverage` to combine transcript models with BigWig data. This requires a `track_data` data frame.

**Setup Track Data:**
```r
track_data <- data.frame(
  sample_id = c("S1", "S2"),
  track_id = c("Condition_A", "Condition_B"), # Groups samples into tracks
  colour_group = c("A", "B"),                 # Defines line/fill colors
  bigWig = c("path/to/s1.bw", "path/to/s2.bw"),
  scaling_factor = c(1, 1)                    # Optional normalization
)
```

**Generate Plot:**
```r
plotCoverage(
  exons = ncoa7_exons, 
  cdss = ncoa7_cdss, 
  transcript_annotations = ncoa7_metadata, 
  track_data = track_data,
  rescale_introns = TRUE,
  fill_palette = c("A" = "blue", "B" = "red")
)
```

### 3. Automated Annotation Extraction
Instead of manual GRanges lists, use wrappers for Ensembl or UCSC objects.

*   **Ensembldb:** `plotTranscriptsFromEnsembldb()` and `plotCoverageFromEnsembldb()`
*   **UCSC/TxDb:** `plotTranscriptsFromUCSC()` and `plotCoverageFromUCSC()`

```r
library(EnsDb.Hsapiens.v86)
plotTranscriptsFromEnsembldb(EnsDb.Hsapiens.v86, gene_names = "NCOA7")
```

## Key Parameters and Customization

*   **`rescale_introns`**: Set to `TRUE` to make exons visible in genes with large introns.
*   **`mean_only`**: If `TRUE` (default), plots the average coverage per `colour_group`. Set to `FALSE` and adjust `alpha` to see individual sample overlays.
*   **`coverage_type`**: Use `"area"` (default) for filled plots or `"line"` for overlapping profiles (useful for eQTL visualization).
*   **`heights`**: A vector (e.g., `c(2, 1)`) to control the relative height of the coverage tracks vs. the transcript models.
*   **`connect_exons` & `transcript_label`**: Set to `FALSE` when plotting non-transcript data like ChIP-seq peaks or ATAC-seq open chromatin regions.

## Tips for Success

*   **BigWig Files**: Ensure BigWig files are indexed and the chromosome naming (e.g., "chr1" vs "1") matches your annotation objects.
*   **Filtering**: When plotting genes with many isoforms, filter the `exons` list to only include the most relevant transcripts to avoid a cluttered plot.
*   **Legends**: `wiggleplotr` uses `cowplot` for alignment, which can strip standard ggplot2 legends. You may need to manually add legends or use `getGenotypePalette()` for consistent coloring.

## Reference documentation

- [Introduction to wiggleplotr](./references/wiggleplotr.md)