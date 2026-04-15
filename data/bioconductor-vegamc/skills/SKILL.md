---
name: bioconductor-vegamc
description: VegaMC identifies driver chromosomal imbalances such as deletions, amplifications, and loss of heterozygosity from aCGH data using a variational piecewise smooth model. Use when user asks to perform joint segmentation of copy number data, classify genomic regions, or identify recurrent chromosomal aberrations to distinguish driver from passenger mutations.
homepage: https://bioconductor.org/packages/release/bioc/html/VegaMC.html
---

# bioconductor-vegamc

name: bioconductor-vegamc
description: Identification of driver chromosomal imbalances (deletions, amplifications, and LOH) from aCGH data using a variational piecewise smooth model. Use this skill to perform joint segmentation of copy number data, classify genomic regions, and assess statistical significance to distinguish driver from passenger mutations.

# bioconductor-vegamc

## Overview

VegaMC is an R package designed for the analysis of array Comparative Genomic Hybridization (aCGH) data. It implements a variational model to perform joint segmentation across a cohort of samples, allowing for the identification of recurrent chromosomal imbalances. A key feature is its ability to detect Loss of Heterozygosity (LOH) when B Allele Frequency (BAF) data is provided. It is specifically optimized to work with output from the PennCNV tool.

## Data Preparation

The input dataset must be a tab-delimited file where:
- Column 1: Probe name
- Column 2: Chromosome
- Column 3: Genomic position (bp)
- Subsequent Columns: Log R Ratio (LRR) and optionally B Allele Frequency (BAF) for each sample.

Note: If BAF is included, it must immediately follow the LRR column for each sample (e.g., Sample1_LRR, Sample1_BAF, Sample2_LRR, Sample2_BAF).

### Sorting Data
Probes must be ordered by genomic position. If the input (like raw PennCNV output) is unsorted, use `sortData`:

```r
library(VegaMC)
sortData(dataset = "input_file.txt", output_file_name = "sorted_data.txt")
```

## Running the Analysis

The primary interface is the `vegaMC` function. It handles segmentation, classification, and statistical testing in one call.

### Basic Execution
```r
results <- vegaMC("sorted_data.txt", output_file_name = "my_analysis")
```

### Key Parameters
- `beta`: Controls segmentation coarseness (default 0.5). Higher values result in fewer, larger segments.
- `min_region_bp_size`: Minimum size in base pairs for a region to be reported (default 1000).
- `loss_threshold` / `gain_threshold`: LRR thresholds for classification (defaults -0.2 and 0.2).
- `baf`: Set to `FALSE` if BAF data is not available (disables LOH detection).
- `loh_threshold` / `loh_frequency`: Parameters for LOH classification (defaults 0.75 and 0.8).
- `bs`: Number of bootstrap permutations for p-value calculation (default 1000).
- `pval_threshold`: Significance level for driver mutation identification (default 0.05).

### Advanced Example
```r
results <- vegaMC("sorted_data.txt",
                  output_file_name = "high_res_analysis",
                  beta = 1.0,
                  bs = 5000,
                  getGenes = TRUE,
                  mart_database = "ensembl",
                  ensembl_dataset = "hsapiens_gene_ensembl")
```

## Interpreting Results

The function returns a matrix and generates HTML reports by default.

### Output Matrix Columns
- `Loss p-value`, `Gain p-value`, `LOH p-value`: Statistical significance of the aberration being a "driver".
- `% Loss`, `% Gain`, `% LOH`: Frequency of the aberration across the cohort.
- `Focal-score`: Indicates the "focality" of the alteration.

### HTML Reports
- `output_file_name.html`: A summary of parameters and a sortable list of all detected regions and significant imbalances.
- `output_file_nameGenes.html`: (If `getGenes=TRUE`) A list of Ensembl genes overlapping significant regions, including links to the Ensembl web page.

## Reference documentation

- [VegaMC: A Package Implementing a Variational Piecewise Smooth Model for Identification of Driver Chromosomal Imbalances in Cancer](./references/VegaMC.md)