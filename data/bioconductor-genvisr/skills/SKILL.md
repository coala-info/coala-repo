---
name: bioconductor-genvisr
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/GenVisR.html
---

# bioconductor-genvisr

name: bioconductor-genvisr
description: Visualizing and interpreting genomic data at a cohort level using GenVisR. Use this skill to create publication-quality graphics including waterfall plots (mutation landscapes), sequence coverage (genCov), transition/transversion ratios (TvTi), copy number alterations (cnSpec, cnView, cnFreq), and Loss of Heterozygosity (lohSpec, lohView).

# bioconductor-genvisr

## Overview
GenVisR (Genomic Visualizations in R) is a Bioconductor package designed to produce highly customizable, publication-quality graphics for genomic data. It focuses primarily on cohort-level visualizations (multiple samples/patients) while leveraging ggplot2 for flexibility. It supports multiple species and common genomic file formats like MAF and MGI.

## Typical Workflow

1.  **Load the Library**:
    ```r
    library(GenVisR)
    ```

2.  **Prepare Input Data**:
    *   **Mutation Data**: Data frames derived from .maf (version 2.4) or MGI annotation formats.
    *   **Copy Number**: Data frames with chromosome, start, end, and segment mean.
    *   **Coverage**: Named lists of data frames with coordinates and coverage values.

3.  **Generate Visualizations**:
    Call the specific function (e.g., `waterfall`, `TvTi`, `cnSpec`) with your data frame and desired aesthetic parameters.

4.  **Customize and Save**:
    Use `pdf()` or `png()` devices to save outputs, ensuring adequate height and width to avoid grob collisions.

## Core Functions

### waterfall (Mutation Landscape)
Visualizes the mutational landscape of a cohort, showing mutation burden, recurrently mutated genes, and clinical data.
*   **Basic Usage**: `waterfall(brcaMAF, fileType="MAF")`
*   **Filtering**: Use `mainRecurCutoff` (0 to 1) to plot genes mutated in at least x% of samples, or `plotGenes` for specific genes.
*   **Clinical Data**: Supply a long-format data frame to `clinDat` to add clinical tracks below the main plot.
*   **Mutation Hierarchy**: For multiple mutations in one cell, GenVisR uses a default hierarchy (e.g., Nonsense > Frame Shift). Customize this with `variant_class_order`.

### TvTi (Transitions and Transversions)
Visualizes the frequency or proportion of transitions and transversions.
*   **Usage**: `TvTi(brcaMAF, type="Frequency", fileType="MAF")`
*   **Expectations**: Compare observed rates against a priori expectations using the `y` parameter.

### Copy Number Visualizations
*   **cnSpec**: Cohort-level view of copy number segments across chromosomes.
    *   `cnSpec(LucCNseg, genome="hg19")`
*   **cnView**: Single-sample view of raw copy number calls with optional ideogram and segment overlays.
    *   `cnView(data, chr="chr14", genome="hg19", z=dataSeg)`
*   **cnFreq**: Displays the frequency of gains and losses across the cohort.

### genCov (Sequence Coverage)
Plots coverage information relative to gene tracks.
*   **Requirements**: Requires a `GRanges` object (region of interest), `TxDb` (transcription metadata), and `BSgenome` (for GC content).
*   **Space Compression**: Use `transform` and `base` to log-compress intronic space to highlight exons.

### LOH (Loss of Heterozygosity)
*   **lohSpec**: Genome-wide LOH spectrum for a cohort using "tile" or "slide" methods.
*   **lohView**: Detailed LOH view for a single sample/chromosome, plotting normal vs. tumor VAF.

## Tips for Success
*   **Graphic Device Size**: GenVisR plots are complex. If labels overlap or "grob collisions" occur, increase the dimensions of your output device: `pdf("plot.pdf", height=10, width=15)`.
*   **ggplot2 Integration**: Most functions accept a `plotLayer` or `mainLayer` parameter. You can pass ggplot2 `theme()` objects here to modify text size, legends, or axes without rewriting the plot logic.
*   **Custom Data**: If your file format isn't MAF or MGI, set `fileType="Custom"` and ensure your data frame has columns: `sample`, `gene`, and `variant_class`.

## Reference documentation
- [GenVisR: An introduction](./references/Intro.md)
- [waterfall: function introduction](./references/waterfall_introduction.md)