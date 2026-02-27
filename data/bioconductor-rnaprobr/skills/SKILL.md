---
name: bioconductor-rnaprobr
description: RNAprobR processes and analyzes high-throughput RNA structure probing data to identify structural features at nucleotide resolution. Use when user asks to calculate Estimated Unique Counts to handle PCR duplicates, compile positional data like termination counts and coverage, or apply normalization methods such as deltaTCR, smooth log-ratio, and Winsorization.
homepage: https://bioconductor.org/packages/3.5/bioc/html/RNAprobR.html
---


# bioconductor-rnaprobr

name: bioconductor-rnaprobr
description: Analysis of high-throughput RNA structure probing data. Use this skill to process sequencing reads where RNA susceptibility is encoded in read termini locations. It supports EUC (Estimated Unique Counts) calculation to handle PCR duplicates, positional data compilation (TC, Coverage, TCR), and multiple normalization methods (deltaTCR, smooth log-ratio, Winsorization).

## Overview

RNAprobR is an R package designed to standardize the processing of RNA structure probing experiments (like HRF-Seq or SHAPE-Seq). The workflow typically starts with "Unique Barcodes" files, calculates Estimated Unique Counts (EUCs) to account for PCR bias, compiles this into nucleotide-resolution positional data, and applies normalization to identify structural features.

## RNAprobR Workflow

### 1. Data Input and EUC Calculation
The `readsamples()` function imports data and calculates EUCs. EUCs estimate the true number of molecules when multiple reads share the same random barcode.

```R
library(RNAprobR)

# Define paths to Unique Barcodes and k2n files
treated_files <- c("path/to/unique_barcodes1.gz", "path/to/unique_barcodes2.gz")
k2n_treated <- c("path/to/k2n_1", "path/to/k2n_2")

# Calculate EUCs using HRF-Seq method (requires k2n files)
treated_euc <- readsamples(treated_files, euc="HRF-Seq", k2n_files=k2n_treated)

# If no random barcodes were used, use:
# treated_euc <- readsamples(treated_files, euc="counts")
```

### 2. Compiling Positional Data
The `comp()` function transforms fragment data into nucleotide-specific metrics: Termination Count (TC), Coverage (Cover), and Termination-Coverage Ratio (TCR).

```R
# cutoff: discards fragments shorter than value
# fasta_file: adds nucleotide identity (nt)
treated_comp <- comp(treated_euc, cutoff=101, fasta_file="reference.fa")
control_comp <- comp(control_euc, cutoff=101, fasta_file="reference.fa")
```

### 3. Normalization
RNAprobR provides three primary normalization methods. You can chain them into a single GRanges object using the `add_to` parameter.

*   **deltaTCR (`dtcr`)**: Calculates the difference in TCR between treated and control.
*   **Smooth Log-Ratio (`slograt`)**: Calculates log-ratios of reactivity.
*   **Smooth Winsorization (`swinsor`)**: Calculates Winsorized values in sliding windows.

```R
# Perform deltaTCR normalization
norm_data <- dtcr(control_GR=control_comp, treated_GR=treated_comp, window_size=3, nt_offset=1)

# Add smooth log-ratio to the same object
norm_data <- slograt(control_GR=control_comp, treated_GR=treated_comp, add_to=norm_data)

# Add Winsorized data
norm_data <- swinsor(Comp_GR=treated_comp, add_to=norm_data)

# Merge raw compilation data (TC, Cover) into the normalized object
norm_data <- compdata(Comp_GR=treated_comp, add_to=norm_data)
```

### 4. Export and Visualization
Results can be converted to data frames, plotted, or exported as BedGraph files for genome browsers.

```R
# Convert to data frame for a specific RNA molecule
df <- GR2norm_df(norm_data, RNAid="MyRNA_1", norm_methods="dtcr")

# Plot deltaTCR values
plotRNA(norm_GR=norm_data, RNAid="MyRNA_1", norm_method="dtcr")

# Export to BedGraph
norm2bedgraph(norm_data, bed_file="annotations.bed", norm_method="dtcr", 
              genome_build="hg38", bedgraph_out_file="output_dtcr")
```

## Key Functions Summary
- `readsamples()`: Initial import and PCR duplicate correction (EUC).
- `comp()`: Generates per-nucleotide termination and coverage stats.
- `dtcr()`, `slograt()`, `swinsor()`: Normalization routines.
- `GR2norm_df()`: Extracts data for specific transcripts into standard R data frames.
- `plotRNA()`: Quick visualization of reactivity profiles.

## Reference documentation
- [RNAprobR](./references/RNAprobR.md)