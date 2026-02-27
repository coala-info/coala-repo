---
name: bioconductor-cobindr
description: This tool analyzes and detects transcription factor co-binding pairs within regulatory DNA regions. Use when user asks to identify transcription factor co-occurrence, search for motifs using position weight matrices, calculate spatial distributions between binding sites, or perform statistical detrending analysis.
homepage: https://bioconductor.org/packages/3.8/bioc/html/cobindR.html
---


# bioconductor-cobindr

name: bioconductor-cobindr
description: Analysis and detection of transcription factor (TF) co-binding pairs. Use when analyzing regulatory DNA regions to identify TFs that interact or co-occur. Supports motif searching (PWM), de-novo motif prediction, background model generation for statistical significance, and visualization of spatial distributions and distances between binding sites.

# bioconductor-cobindr

## Overview
The `cobindR` package provides a framework for in silico analysis of transcription factor binding sites (TFBS) to detect co-binding pairs. It integrates sequence manipulation, motif matching, and statistical testing against background models to identify significant spatial relationships between TFs.

## Typical Workflow

### 1. Configuration
Analysis starts with a configuration object. You can load a YAML file or set parameters manually.

```r
library(cobindR)
library(Biostrings)

# Initialize configuration
cfg <- cobindRConfiguration()

# Set path to PFM files (JASPAR or Transfac format)
pfm_path(cfg) <- system.file('extdata/pfms', package='cobindR')

# Define TF pairs to search for
pairs(cfg) <- c('TF_Name1 TF_Name2')

# Configure sequence input (type: 'fasta', 'geneid', or 'chipseq')
sequence_type(cfg) <- 'fasta'
sequence_source(cfg) <- "path/to/sequences.fasta"
species(cfg) <- 'Mus musculus'
```

### 2. Finding Binding Sites and Pairs
Create a `cobindr` object and perform the search.

```r
# Create cobindr object
cobindR.obj <- cobindr(cfg, name = "My_Analysis")

# Search for motifs using PWMs (min.score is % of max possible score)
cobindR.obj <- search.pwm(cobindR.obj, min.score = "80%")

# Find pairs within the sequences
cobindR.obj <- find.pairs(cobindR.obj, n.cpu = 1)
```

### 3. Statistical Significance (Detrending)
To determine if pairs are significant, generate a background model and repeat the search.

```r
# Generate background (markov, local, or ushuffle)
bg_sequence_type(cfg) <- 'markov.3.200'
cobindR.obj <- generate.background(cobindR.obj)

# Scan background for motifs and pairs
cobindR.obj <- search.pwm(cobindR.obj, min.score = "80%", background_scan = TRUE)
cobindR.obj <- find.pairs(cobindR.obj, background_scan = TRUE)
```

### 4. Visualization and Results
`cobindR` offers several plotting functions to interpret TF relationships.

*   **GC/CpG Content:** `testCpG(cobindR.obj, do.plot=T)`
*   **Sequence Logos:** `plot.tfbslogo(cobindR.obj, c('TF1', 'TF2'))`
*   **Spatial Distribution:** `plot.positionprofile(cobindR.obj)`
*   **Co-occurrence Heatmap:** `plot.tfbs.heatmap(cobindR.obj)`
*   **Distance Distribution:** `plot.pairdistance(cobindR.obj, pwm1='TF1', pwm2='TF2')`
*   **Detrending Analysis:** `plot.detrending(cobindR.obj, pwm1='TF1', pwm2='TF2')`

### 5. Exporting Data
Extract significant pairs or predicted binding sites for downstream use.

```r
# Get significant pairs based on detrending
sig.pairs <- get.significant.pairs(cobindR.obj, pwm1='TF1', pwm2='TF2', bin_length=10)

# Write binding sites to file
write.bindingsites(cobindR.obj, file="results.txt")
```

## Tips and Best Practices
*   **Sequence Types:** When using `sequence_type = "geneid"`, ensure `species` is set correctly (e.g., "Homo sapiens") to fetch upstream/downstream regions from ENSEMBL.
*   **Background Models:** Use `markov` for general sequence composition or `local` shuffling to preserve local nucleotide biases.
*   **Alternative Searchers:** Besides `search.pwm`, you can use `rtfbs()` for phylogenetic footprinting or `search.gadem()` for de-novo motif discovery.
*   **Parallelization:** Use the `n.cpu` parameter in `find.pairs` to speed up analysis on large datasets.

## Reference documentation
- [cobindR](./references/cobindR.md)