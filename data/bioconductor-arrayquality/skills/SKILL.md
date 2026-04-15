---
name: bioconductor-arrayquality
description: This tool performs comprehensive quality assessment and diagnostic reporting for spotted microarrays. Use when user asks to generate diagnostic plots, perform print-run quality assessment, or create HTML quality reports for Agilent, GenePix, or Spot format data.
homepage: https://bioconductor.org/packages/release/bioc/html/arrayQuality.html
---

# bioconductor-arrayquality

name: bioconductor-arrayquality
description: Comprehensive quality assessment for spotted microarrays (Agilent, GenePix, and Spot formats). Use when analyzing two-channel microarray data to generate diagnostic plots, comparative boxplots, and HTML quality reports. Supports specialized controls for HEEBO and MEEBO sets, as well as print-run quality assessment.

# bioconductor-arrayquality

## Overview

The `arrayQuality` package provides functions for performing print-run and array-level quality assessment on spotted microarrays. It automates the generation of diagnostic plots (e.g., MA-plots, spatial plots) and quantitative quality measures, comparing them against reference databases of "good" slides for Mouse (Mm) and Human (Hs) genomes.

## Core Workflows

### General Array Quality Assessment

The package provides format-specific wrappers that generate HTML reports containing diagnostic plots and comparative boxplots.

*   **Agilent Format**: Use `agQuality(fnames, organism = "Mm")`.
*   **GenePix Format**: Use `gpQuality(fnames, organism = "Mm")`.
*   **Spot Format**: Use `spotQuality(fnames, organism = "Mm")`.

Common arguments for these functions:
*   `fnames`: Character vector of input file names.
*   `path`: Directory containing the data (default is current directory).
*   `organism`: Either "Mm" (Mouse) or "Hs" (Human).
*   `resdir`: Directory to save the HTML report and images.
*   `compBoxplot`: Logical; if TRUE, compares results to a reference database.

### Specialized Oligo Sets (HEEBO/MEEBO)

For arrays using HEEBO or MEEBO control sets, use dedicated functions to assess performance of mismatch, tiling, and doping (spike-in) controls.

*   **HEEBO**: `heeboQuality(fnames, SpikeTypeFile = "DCV.txt", organism = "Hs")`
*   **MEEBO**: `meeboQuality(fnames, SpikeTypeFile = "StanfordDCV.txt", organism = "Mm")`

### Print-Run Quality Assessment

To evaluate the quality of a specific print-run (e.g., checking for pin-clogging or consistency across the block), use:

*   **9mers Hybridization**: `PRv9mers(fnames, prname = "PrintRunName")`
*   **QC Hybridization**: `PRvQCHyb(fnames, prname = "PrintRunName")`

## Advanced Usage

### Creating Custom Reference Tables

If the default Mouse/Human reference databases are not suitable, create a custom reference from a set of known high-quality slides:

```r
# Generate reference measures
ref_matrix <- globalQuality(fnames = good_slides, inputsource = "readGPR")

# Use custom reference in quality assessment
gpQuality(fnames = test_slides, reference = ref_matrix)
```

### Manual Quality Scoring

To extract specific quality statistics without generating a full HTML report:

1.  Read data: `data <- readGPR("file.gpr")`
2.  Calculate stats: `stats <- slideQuality(data)`
3.  Generate comparative boxplot: `qualBoxplot(stats, organism = "Mm")`
4.  Calculate percentage scores: `scores <- qualityScore(stats, organism = "Mm")`

## Tips for Success

*   **File Formats**: Ensure file extensions match the function used (`.gpr` for `gpQuality`, `.txt` for `agQuality`, `.spot` for `spotQuality`).
*   **Control IDs**: If the default control identification fails, specify the `controlId` argument (e.g., `controlId = "ProbeName"` or `controlId = "ID"`).
*   **Dependencies**: This package relies heavily on `marray` and `limma` objects. You can often pass `marrayRaw` or `RGList` objects directly to plotting functions like `maQualityPlots`.
*   **Graphics Device**: Use the `dev` argument to switch between "png", "jpeg", and "ps" for output images.

## Reference documentation

- [arrayQuality Reference Manual](./references/reference_manual.md)