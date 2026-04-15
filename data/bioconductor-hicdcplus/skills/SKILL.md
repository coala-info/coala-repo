---
name: bioconductor-hicdcplus
description: HiCDCPlus performs statistical analysis of Hi-C and HiChIP data to identify significant genomic interactions while accounting for systematic biases. Use when user asks to identify significant chromatin interactions, perform differential interaction analysis, call Topologically Associating Domains, or extract A/B compartments.
homepage: https://bioconductor.org/packages/release/bioc/html/HiCDCPlus.html
---

# bioconductor-hicdcplus

name: bioconductor-hicdcplus
description: Statistical analysis of Hi-C and HiChIP data using the HiCDCPlus Bioconductor package. Use this skill to identify significant genomic interactions, perform differential interaction analysis between conditions, call Topologically Associating Domains (TADs) using TopDom, and extract A/B compartments.

# bioconductor-hicdcplus

## Overview

`HiCDCPlus` is an R package designed for the systematic analysis of Hi-C and HiChIP datasets. It utilizes a negative binomial generalized linear model (HiC-DC+) to account for genomic biases such as GC content, mappability, and effective length. The package supports various input formats including `.hic`, HiC-Pro outputs, and `HiTC` objects.

Key capabilities:
- **Interaction Calling**: Identifying statistically significant chromatin interactions.
- **Differential Analysis**: Using a modified DESeq2 framework to find differences between conditions.
- **TAD Calling**: Implementation of the TopDom algorithm.
- **Compartment Analysis**: Integration with Juicer for A/B compartment detection.

## Standard Workflow

### 1. Feature Construction
Before modeling, you must generate genomic features (GC, mappability, length) for your specific binning strategy.

```r
library(HiCDCPlus)

# Generate features for 50kb uniform bins
construct_features(output_path = "hg19_50kb_GATC",
                   gen = "Hsapiens", gen_ver = "hg19",
                   sig = "GATC",
                   bin_type = "Bins-uniform",
                   binsize = 50000,
                   chrs = c("chr21", "chr22"))
```

### 2. Data Ingestion (The gi_list)
`HiCDCPlus` uses a `gi_list` object (a list of `InteractionSet` objects) to store data.

```r
# Initialize gi_list from features
gi_list <- generate_bintolen_gi_list(bintolen_path = "hg19_50kb_GATC_bintolen.txt.gz")

# Add counts from a .hic file
gi_list <- add_hic_counts(gi_list, hic_path = "path/to/data.hic")

# For HiC-Pro data:
# gi_list <- add_hicpro_matrix_counts(gi_list, absfile_path, matrixfile_path)
```

### 3. Significance Calling
Expand 1D features to 2D space and run the model.

```r
# Expand features
gi_list <- expand_1D_features(gi_list)

# Run the model (use HiCDCPlus_parallel for multiple cores)
set.seed(1010)
gi_list <- HiCDCPlus(gi_list)

# Results are in the metadata columns: pvalue, qvalue (FDR), mu (expected), sdev
head(gi_list$chr21)
```

### 4. Differential Interaction Analysis
Requires significant interactions called for each replicate/condition.

```r
# input_paths is a named list of paths to gi_list_write outputs
hicdcdiff(input_paths = list(Cond1 = c("rep1.txt.gz", "rep2.txt.gz"),
                             Cond2 = c("rep3.txt.gz", "rep4.txt.gz")),
          filter_file = "union_significant_indices.txt.gz",
          output_path = "diff_results/",
          chrs = "chr22",
          binsize = 50000)
```

## Domain-Specific Tasks

### TAD Calling (TopDom)
Requires ICE normalized counts.

```r
# Normalize .hic to ICE
gi_list_ice <- hic2icenorm_gi_list(hic_path, binsize = 50e3, chrs = 'chr22')

# Call TADs
tads <- gi_list_topdom(gi_list_ice, chrs = "chr22", window.size = 10)
```

### Exporting Results
Results can be saved to text or converted back to `.hic` for visualization in Juicebox or HiCExplorer.

```r
# Save to text
gi_list_write(gi_list, fname = "results.txt.gz")

# Save to .hic (mode can be 'pvalue', 'qvalue', 'normcounts', or 'zvalue')
hicdc2hic(gi_list, hicfile = "results.hic", mode = 'normcounts', gen_ver = 'hg19')
```

## Tips for Success
- **Distance Thresholds**: For Hi-C, the default `Dmax` is usually sufficient. For HiChIP, consider reducing the threshold (e.g., 1.5e6).
- **Parallelization**: Use `HiCDCPlus_parallel` to speed up processing across chromosomes.
- **Custom Features**: Use `add_1D_features` or `add_2D_features` to incorporate user-defined genomic tracks into the model.

## Reference documentation
- [Analyzing Hi-C and HiChIP data with HiCDCPlus](./references/HiCDCPlus.md)