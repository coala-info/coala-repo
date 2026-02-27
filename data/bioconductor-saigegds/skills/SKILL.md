---
name: bioconductor-saigegds
description: SAIGEgds performs large-scale association testing and phenome-wide association studies using generalized linear mixed models optimized for genomic data structure files. Use when user asks to fit a null model with a genetic relationship matrix, perform single-variant association tests using saddlepoint approximation, or analyze biobank-scale datasets with case-control imbalance.
homepage: https://bioconductor.org/packages/release/bioc/html/SAIGEgds.html
---


# bioconductor-saigegds

## Overview

SAIGEgds is a high-performance R package designed for large-scale PheWAS. It optimizes the SAIGE (Scalable and Accurate Implementation of Generalized mixed model) method by utilizing the Genomic Data Structure (GDS) format and C++ optimization. It is particularly effective for biobank-scale data (e.g., UK Biobank) where case-control imbalance is common. The package supports both integer genotypes and numeric imputed dosages.

## Core Workflow

### 1. Data Preparation and LD Pruning
Before fitting a null model, you must prepare a pruned set of SNPs to create a Genetic Relationship Matrix (GRM).

```R
library(SeqArray)
library(SNPRelate)
library(SAIGEgds)

# Open SeqArray GDS file
gds <- seqOpen(geno_fn)

# Perform LD pruning
set.seed(1000)
snpset <- snpgdsLDpruning(gds)
snpset.id <- unlist(snpset, use.names=FALSE)

# Export pruned SNPs to a new GDS file for GRM
grm_fn <- "grm_geno.gds"
seqSetFilter(gds, variant.id=snpset.id)
seqExport(gds, grm_fn, info.var=character(), fmt.var=character(), samp.var=character())
seqClose(gds)
```

### 2. Fitting the Null Model
Fit the generalized linear mixed model (GLMM) under the null hypothesis. This step accounts for sample relatedness using the GRM.

```R
# pheno: data.frame containing sample.id, outcome (y), and covariates (x1, x2)
glmm <- seqFitNullGLMM_SPA(y ~ x1 + x2, 
                           pheno.data = pheno, 
                           gds.fn = grm_fn, 
                           trait.type = "binary", 
                           sample.col = "sample.id")
```
*   `trait.type`: Use "binary" for case-control studies or "quantitative" for continuous traits.
*   `sample.col`: The column name in the phenotype data frame matching the GDS sample IDs.

### 3. Association Testing (P-value Calculation)
Run the association analysis for all variants in the main genotype file using the fitted null model.

```R
# Calculate associations using SPA
assoc <- seqAssocGLMM_SPA(geno_fn, 
                          glmm, 
                          mac = 10, 
                          parallel = 2)

# Optional: Save results directly to a GDS file for large outputs
seqAssocGLMM_SPA(geno_fn, glmm, mac=10, res.savefn="assoc.gds")
```
*   `mac`: Minimum Allele Count filter.
*   `parallel`: Number of CPU cores to use.

### 4. Loading and Visualizing Results
Load results from a saved GDS file or visualize the data frame directly.

```R
# Load from GDS
res <- seqSAIGE_LoadPval("assoc.gds")

# Visualization using ggmanh
library(ggmanh)
manhattan_plot(res, pval.colname="pval", chr.colname="chr", pos.colname="pos")
qqunif(res$pval)
```

## Key Functions
- `seqFitNullGLMM_SPA()`: Fits the null model using a GRM.
- `seqAssocGLMM_SPA()`: Performs single-variant association tests with SPA.
- `seqSAIGE_LoadPval()`: Efficiently loads association results from GDS files.
- `seqExport()`: Used to subset GDS files for GRM construction.

## Tips for Performance
- **Memory Management**: Use GDS files instead of loading full genotype matrices into RAM.
- **Parallelization**: Always utilize the `parallel` argument in `seqAssocGLMM_SPA` for whole-genome scans.
- **Sparse GRM**: For very large cohorts, ensure the GRM is constructed from a high-quality, LD-pruned set of variants (typically 2,000–5,000 SNPs are sufficient for relatedness).

## Reference documentation
- [SAIGEgds Tutorial](./references/SAIGEgds.Rmd)
- [Scalable Generalized Mixed Models in PheWAS using SAIGEgds](./references/SAIGEgds.md)