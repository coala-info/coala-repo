---
name: bioconductor-chipseqspike
description: The bioconductor-chipseqspike package normalizes ChIP-seq data using exogenous spike-in controls to account for global signal shifts between samples. Use when user asks to normalize ChIP-seq datasets with spike-in DNA, estimate scaling factors from endogenous and exogenous reads, or generate normalized binding profiles and heatmaps.
homepage: https://bioconductor.org/packages/3.8/bioc/html/ChIPSeqSpike.html
---

# bioconductor-chipseqspike

## Overview

The `ChIPSeqSpike` package provides a specialized workflow for normalizing ChIP-seq data using exogenous spike-in controls (e.g., Drosophila DNA added to Human samples). Unlike standard RPM (Reads Per Million) normalization, which assumes total signal remains constant across conditions, spike-in normalization allows for the detection of global signal shifts. The package operates primarily on BigWig and BAM files and does not require peak calling, though it can incorporate peak coordinates if available.

## Standard Workflow

The normalization procedure follows a specific four-step sequence:

1.  **RPM Scaling**: Initial normalization for sequencing depth.
2.  **Input Subtraction**: Removing background noise using a control (Input) sample.
3.  **RPM Scaling Reversal**: Returning data to a state where exogenous factors can be applied.
4.  **Exogenous Scaling**: Applying the final scaling factor derived from the spike-in DNA.

### 1. Dataset Initialization

Data is managed via an experiment info file (CSV or TSV). Required columns: `expName`, `endogenousBam`, `exogenousBam`, `inputBam`, `bigWigEndogenous`, and `bigWigInput`.

```r
library(ChIPSeqSpike)

# Define paths to your files
bam_path <- "path/to/bam_files"
bigwig_path <- "path/to/bigwig_files"
info_file_csv <- "metadata.csv"

# Create the dataset object
# Use boost = TRUE to keep data in memory (faster but memory-intensive)
csds <- spikeDataset(info_file_csv, bam_path, bigwig_path, boost = FALSE)
```

### 2. Estimating Scaling Factors

The package calculates scaling factors based on the number of reads mapped to the endogenous and exogenous genomes.

```r
# Calculate counts and factors
csds <- estimateScalingFactors(csds)

# View a summary of counts and factors
spikeSummary(csds)

# Check the ratio of exogenous/endogenous DNA (ideally between 2-25%)
getRatio(csds)
```

### 3. The Normalization Pipeline

Execute the steps in order. Note: Windows users cannot perform these steps due to `rtracklayer` limitations with BigWig files.

```r
# 1. RPM Scaling
csds <- scaling(csds, outputFolder = "normalized_data")

# 2. Input Subtraction
csds <- inputSubtraction(csds)

# 3. Reverse RPM Scaling
csds <- scaling(csds, reverse = TRUE)

# 4. Apply Exogenous Scaling
csds <- scaling(csds, type = "exo")
```

Alternatively, use the wrapper function for the entire pipeline:
```r
csds <- spikePipe(info_file_csv, bam_path, bigwig_path, gff_vec, genome_name)
```

### 4. Extracting and Plotting Results

To visualize data, you must first extract binding values based on genomic coordinates (GFF).

```r
# Extract scores for annotations
csds <- extractBinding(csds, gff_file = "coords.gff", genome = "hg19")

# Plot average profiles
plotProfile(csds, legend = TRUE)

# Plot profiles comparing spiked vs unspiked
plotProfile(csds, legend = TRUE, notScaled = TRUE)

# Generate heatmaps
plotHeatmaps(csds, clustering_method = "kmeans", nb_of_groups = 2)

# Boxplots for distribution analysis
boxplotSpike(csds, spiked = TRUE)

# Correlation analysis between samples
plotCor(csds, method_scale = "log")
```

## Tips for Success

*   **Memory Management**: If working with large datasets, avoid `boost = TRUE` unless you have significant RAM. The package will otherwise write intermediate BigWig files to disk.
*   **Input Subtraction**: This step is critical for removing false positives. Ensure your `info.csv` correctly pairs IP samples with their corresponding Input controls.
*   **Exogenous Ratio**: If `getRatio()` reports less than 2%, the normalization may be unreliable. If it reports >25%, it is generally safe but indicates a very high spike-in concentration.
*   **File Formats**: Ensure BigWig files are "fixed steps" for compatibility with the internal processing engines.

## Reference documentation

- [ChIPSeqSpike](./references/ChIPSeqSpike.md)