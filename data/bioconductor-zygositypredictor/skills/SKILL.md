---
name: bioconductor-zygositypredictor
description: This tool predicts gene zygosity and the number of affected copy numbers for small variants in cancer and germline genomes. Use when user asks to calculate mutated gene copies, phase multiple variants, or determine if wild-type copies remain in tumor suppressor genes.
homepage: https://bioconductor.org/packages/release/bioc/html/ZygosityPredictor.html
---

# bioconductor-zygositypredictor

name: bioconductor-zygositypredictor
description: Predicts gene zygosity and affected copy numbers of small variants (SNVs/Indels) in cancer and germline genomes. Use this skill to calculate how many copies of a gene are mutated, phase multiple variants, and determine if wild-type copies remain (e.g., for tumor suppressor genes).

## Overview
ZygosityPredictor assesses the impact of small variants on gene copies by integrating somatic copy number alterations (sCNAs), purity, and ploidy. It is particularly useful in translational oncology to determine if a gene has undergone "two-hit" inactivation (all copies affected) or if wild-type copies persist. It supports both germline and somatic variants and utilizes read-level phasing (RLP) and allelic imbalance phasing (AIP) to resolve the spatial relationship between mutations.

## Installation
```R
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("ZygosityPredictor")
library(ZygosityPredictor)
```

## Core Workflows

### 1. Calculating Affected Copies for Single Variants
Use these functions for quick assessment of individual variants.

**Germline Variants:**
```R
# af: allele frequency, tcn: total copy number, purity: tumor content
aff_germ_copies(af = 0.5, tcn = 2, purity = 0.8, chr = "chr1", sex = "female")
```

**Somatic Variants:**
```R
aff_som_copies(af = 0.3, tcn = 2, purity = 0.8, chr = "chr1", sex = "female")
```

### 2. Predicting Zygosity for Genes
The `predict_zygosity()` function is the primary entry point for multi-variant phasing and gene-level status prediction.

**Required Inputs:**
- `purity`: Numeric (0-1).
- `sex`: "male" or "female".
- `somCna`: GRanges object with `tcn` (total copy number) and `cna_type` (e.g., "LOH").
- `geneModel`: GRanges object defining gene boundaries.
- `bamDna`: Path to indexed .bam file (required for read-level phasing).

**Optional Inputs:**
- `somSmallVars` / `germSmallVars`: GRanges of variants with `ref`, `alt`, `af`, and `gene` columns.
- `vcf`: Path to VCF for SNP-based phasing.
- `ploidy`: Sample ground ploidy.

**Example Execution:**
```R
results <- predict_zygosity(
  purity = 0.98,
  ploidy = 1.6,
  sex = "female",
  somCna = my_gr_scna,
  somSmallVars = my_gr_somatic,
  geneModel = my_gene_model,
  bamDna = "path/to/alignments.bam"
)
```

## Interpreting Results
The output is a list of tibbles. Use helper functions for easy exploration:

- `ZP_ov(results)`: Provides a high-level summary of analyzed genes and their statuses (e.g., `all_copies_affected`, `wt_copies_left`).
- `gene_ov(results, GENE_NAME)`: Displays detailed phasing and variant information for a specific gene.

### Key Statuses
- **all_copies_affected**: No wild-type copies remain.
- **wt_copies_left**: At least one functional wild-type copy is predicted.
- **insufficient**: Data suggests wild-type copies remain, but phasing is incomplete.

## Usage Tips
- **Clonality Assumption**: The tool assumes a fully clonal tumor. Results for subclonal samples should be interpreted with caution.
- **Gene Filtering**: Runtime increases with the number of genes. Restrict the `geneModel` to specific genes of interest (e.g., TP53, BRCA1) to improve performance.
- **Large Deletions**: If `tcn` < 0.5, the tool assumes a homozygous deletion. Ensure `somCna` accurately reflects these regions.
- **Phasing**: If variants are too far apart for direct RLP, provide a `vcf` to enable SNP-based indirect phasing.

## Reference documentation
- [Usage of ZygosityPredictor](./references/Usage.md)