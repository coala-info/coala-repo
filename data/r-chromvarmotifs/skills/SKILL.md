---
name: r-chromvarmotifs
description: The r-chromvarmotifs package provides curated collections of transcription factor motif sets as PWMatrixList objects for chromatin accessibility analysis. Use when user asks to load human or mouse cisBP motifs, access HOMER or ENCODE motif collections, or provide motif inputs for chromVAR and motifmatchr workflows.
homepage: https://cran.r-project.org/web/packages/chromvarmotifs/index.html
---


# r-chromvarmotifs

## Overview
The `chromVARmotifs` package provides a collection of curated transcription factor motif sets stored as `PWMatrixList` objects (from the `TFBSTools` package). These collections are primarily intended for use with `chromVAR` and `motifmatchr` to analyze chromatin accessibility data.

## Installation
To install the package from GitHub:
```R
devtools::install_github("GreenleafLab/chromVARmotifs")
```

## Loading Motif Collections
The package provides several pre-defined datasets. Use the `data()` function to load them into your environment:

*   **cisBP Human Motifs**:
    *   `data("human_pwms_v1")`: Curated collection.
    *   `data("human_pwms_v2")`: Filtered collection (less redundancy).
*   **cisBP Mouse Motifs**:
    *   `data("mouse_pwms_v1")`: Curated collection.
    *   `data("mouse_pwms_v2")`: Filtered collection (less redundancy).
*   **Other Collections**:
    *   `data("homer_pwms")`: Motifs from HOMER.
    *   `data("encode_pwms")`: Motifs from ENCODE.

## Common Workflows

### Using with motifmatchr
The motifs are stored as `PWMatrixList` objects, making them directly compatible with `motifmatchr` for finding motif occurrences in genomic ranges.

```R
library(chromVARmotifs)
library(motifmatchr)

# Load human motifs
data("human_pwms_v2")

# Find motif matches in a GRanges object
# matches <- matchMotifs(human_pwms_v2, my_ranges, genome = "hg38")
```

### Using with chromVAR
These motifs are the standard input for computing motif deviations in single-cell or bulk ATAC-seq data.

```R
library(chromVAR)
library(chromVARmotifs)

data("human_pwms_v2")

# Compute deviations
# dev <- computeDeviations(object = my_counts_obj, annotations = human_pwms_v2)
```

## Motif Metadata and Structure
*   **Object Type**: `PWMatrixList` (from `TFBSTools`).
*   **Naming Convention**: cisBP motifs typically follow the format `ID_Name_TF-Symbol`.
*   **PWM Conversion**: Motifs were converted from frequency matrices using a 0.008 pseudocount (except for HOMER) and log-relative frequencies.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)