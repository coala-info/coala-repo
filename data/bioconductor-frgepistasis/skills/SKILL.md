---
name: bioconductor-frgepistasis
description: This package detects epistasis between genes or genomic regions using functional regression and Fourier expansion for large-scale sequencing data. Use when user asks to detect gene-gene interactions, perform rare variant analysis, or run functional regression models on genomic data.
homepage: https://bioconductor.org/packages/release/bioc/html/FRGEpistasis.html
---

# bioconductor-frgepistasis

## Overview

The `FRGEpistasis` package is designed to detect epistasis (interactions) between genes or genomic regions. It addresses the challenges of rare variant analysis—such as low power and high computational cost—by shifting the unit of analysis from individual SNPs to functional regions. It uses Fourier expansion for data reduction, making it memory-efficient and capable of handling large-scale Next-Generation Sequencing (NGS) data.

## Typical Workflow

### 1. Data Preparation
The package requires four specific data components. Files are typically organized by chromosome.

*   **Genotype Files**: Recoded from PLINK PED files (`plink --recodeA`). Columns 1-6 are metadata (FID, IID, etc.); column 7+ are genotypes (0, 1, 2; missing = 3).
*   **Map Files**: 4 columns (Chromosome, SNP ID, Genetic Distance, Base-pair Position). No header.
*   **Phenotype File**: 2 columns (Individual ID, Phenotype).
*   **Gene Annotation File**: 4 columns (Gene Symbol, Chromosome, Start, End). Defines the genomic regions for testing.

### 2. Loading and Formatting Data
```r
library(FRGEpistasis)

# Set working directory where data files are located
work_dir <- "path/to/data/"

# Read index files (text files listing the names of genotype and map files)
geno_files <- read.table(paste0(work_dir, "list_geno.txt"))
map_files <- read.table(paste0(work_dir, "list_map.txt"))

# Read phenotype and annotation data
pheno_info <- read.csv(paste0(work_dir, "phenotype.csv"), header=TRUE)
gene_list <- read.csv(paste0(work_dir, "gene.list.csv"))

# Optional: Transform phenotype (e.g., log or rank transformation)
pheno_info[,2] <- log(pheno_info[,2])
```

### 3. Running Epistasis Tests

#### Functional Regression Model (Recommended)
This is the most efficient method. It reduces genotype dimensions using Fourier expansion before testing.

```r
fdr_threshold <- 0.05
region_extension <- 0 # bp to extend gene boundaries

results_frm <- fRGEpistasis(
  work_dir, 
  pheno_info, 
  geno_files, 
  map_files, 
  gene_list, 
  fdr_threshold, 
  region_extension
)

# Save results
write.csv(results_frm, "Epistasis_Results_FRM.csv")
```

#### PCA and Pointwise Methods
If you require more granular testing or alternative dimensionality reduction, use the PCA/Pointwise hybrid approach. Note: This is significantly slower than the FRM method.

```r
# Requires the output from fRGEpistasis as an initial filter or structure
results_pca_pw <- pCAPiontwiseEpistasis(
  work_dir, 
  results_frm, 
  pheno_info, 
  geno_files, 
  map_files, 
  gene_list, 
  region_extension
)
```

## Key Functions

*   `fRGEpistasis()`: Main function for Functional Regression Model epistasis testing.
*   `pCAPiontwiseEpistasis()`: Performs epistasis testing using Principal Component Analysis and pointwise SNP-SNP interaction within regions.
*   `rankTransPheno(pheno, c)`: Helper function for rank-based transformation of phenotypes.

## Tips for Large Data
*   **Memory Management**: The package only stores the reduced expansion data in memory. Ensure your `geno_files` and `map_files` indices correctly point to per-chromosome files to allow the package to process them sequentially.
*   **FDR Control**: The `fdr` parameter in `fRGEpistasis` controls the False Discovery Rate. Set `fdr = 1` to turn off FDR control and see all raw p-values.
*   **Scope**: Currently, the package supports G x G (two-way) interactions. It does not support higher-order interactions (e.g., G x G x G).

## Reference documentation
- [FRGEpistasis](./references/FRGEpistasis.md)