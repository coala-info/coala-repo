---
name: bioconductor-segmenter
description: This tool performs chromatin segmentation analysis by wrapping ChromHMM to learn de-novo chromatin states from multivariate ChIP-seq data within the R/Bioconductor ecosystem. Use when user asks to binarize genomic signals, train Hidden Markov Models to identify chromatin states, compare models with different state numbers, or visualize state emissions and transitions.
homepage: https://bioconductor.org/packages/release/bioc/html/segmenter.html
---


# bioconductor-segmenter

name: bioconductor-segmenter
description: Chromatin segmentation analysis using a Hidden Markov Model (HMM) via ChromHMM. Use when you need to learn de-novo chromatin states from multivariate ChIP-seq data, binarize genomic signals, compare models with different state numbers, or visualize state emissions and transitions within the R/Bioconductor ecosystem.

# bioconductor-segmenter

## Overview

The `segmenter` package is an R/Bioconductor wrapper for the Java-based ChromHMM software. It allows users to perform chromatin segmentation analysis—transforming ChIP-seq signals into discrete chromatin states (e.g., promoters, enhancers, repressed regions) using a multivariate Hidden Markov Model. The package captures ChromHMM output in an S4 `segmentation` object, enabling seamless integration with other Bioconductor tools like `GenomicRanges`, `Gviz`, and `ComplexHeatmap`.

## Core Workflow

### 1. Data Preparation (Binarization)
ChromHMM requires binarized input (0/1) representing the presence or absence of a mark in genomic bins.

```r
library(segmenter)

# Define a table mapping cells to marks and BAM files
# Format: cell\tmark\tbamfile
cellmarkfiletable <- "cell_mark_table.tsv" 
chromsizefile <- "hg18.txt"

binarize_bam(inputdir = "path/to/bams",
             chromsizefile = chromsizefile,
             cellmarkfiletable = cellmarkfiletable,
             outputdir = "binarized_out",
             binsize = 200)
```

### 2. Learning the Model
The `learn_model` function executes the HMM training. It requires directories for binarized data and genomic annotations (coordinates and anchors).

```r
# Standard annotations are often provided by the chromhmmData package
coordsdir <- system.file('extdata/COORDS', package = 'chromhmmData')
anchorsdir <- system.file('extdata/ANCHORFILES', package = 'chromhmmData')

obj <- learn_model(inputdir = "binarized_out",
                   coordsdir = coordsdir,
                   anchorsdir = anchorsdir,
                   chromsizefile = chromsizefile,
                   numstates = 5,
                   assembly = 'hg18',
                   cells = c('Cell1', 'Cell2'),
                   annotation = 'RefSeq',
                   binsize = 200)
```

### 3. Model Comparison and Selection
To determine the optimal number of states, train multiple models and compare their likelihood or state correlations.

```r
# Compare a list of segmentation objects
objs <- lapply(3:8, function(x) {
    learn_model(..., numstates = x)
})

# Plot correlation or likelihood
compare_models(objs, type = 'likelihood', plot = TRUE)
compare_models(objs, type = 'correlation', plot = TRUE)
```

### 4. Accessing and Interpreting Results
The `segmentation` object contains several slots accessible via functions:

*   `emission(obj)`: Probability of each mark being in a state.
*   `transition(obj)`: Probability of moving from one state to another.
*   `overlap(obj)`: Fold-enrichment of states in genomic annotations (Exons, Genes, etc.).
*   `TSS(obj)` / `TES(obj)`: Enrichment around transcription start/end sites.
*   `segment(obj)`: Returns a `GRanges` object of state assignments.

### 5. Visualization
Use `plot_heatmap` for model parameters and `Gviz` for genomic tracks.

```r
# Heatmap of emissions
plot_heatmap(obj, type = 'emission')

# Heatmap of TSS enrichment
plot_heatmap(obj, type = 'TSS')

# Frequency of states
get_frequency(segment(obj), plot = TRUE, normalize = TRUE)
```

## Tips for Success
*   **Java Dependency**: Ensure a Java Runtime Environment (JRE) is installed and accessible to R, as `segmenter` calls Java executables internally.
*   **Annotation Files**: Use the `chromhmmData` package to easily access standard coordinates (hg18, hg19, mm9, etc.) required by ChromHMM.
*   **Memory**: Binarization and model learning can be memory-intensive for large genomes or many marks; ensure the R session has sufficient resources.
*   **State Interpretation**: ChromHMM states are numbered (E1, E2, etc.). You must interpret their biological meaning (e.g., "Active Promoter") by looking at the emission probabilities of known markers like H3K4me3.

## Reference documentation
- [Chromatin Segmentation Analysis Using segmenter](./references/segmenter.Rmd)
- [Chromatin Segmentation Analysis Using segmenter](./references/segmenter.md)