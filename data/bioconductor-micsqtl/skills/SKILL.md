---
name: bioconductor-micsqtl
description: bioconductor-micsqtl performs integrative analysis of matched bulk transcriptome and proteome data to estimate cell-type proportions and map cell-type-specific QTLs. Use when user asks to perform cross-source deconvolution using JNMF, integrate multi-omic data via AJIVE, or conduct cell-type-specific QTL mapping.
homepage: https://bioconductor.org/packages/release/bioc/html/MICSQTL.html
---


# bioconductor-micsqtl

## Overview
MICSQTL is a Bioconductor package designed for the integrative analysis of matched bulk transcriptome and proteome data. Its primary strengths lie in "cross-source" deconvolution—using RNA information to improve protein cell-type proportion estimates—and performing cell-type-specific QTL (csQTL) mapping. It utilizes Joint Non-negative Matrix Factorization (JNMF) for deconvolution, Angle-based Joint and Individual Variation Explained (AJIVE) for multi-omic integration, and the TOAST framework for csQTL analysis.

## Core Workflow

### 1. Data Preparation
The package centers around the `SummarizedExperiment` object.
- **Assays**: Bulk protein expression (log or MinMax scaled).
- **rowData**: Protein annotations (Chr, Start, End, Symbol).
- **Metadata**: Must include `gene_data` (matched bulk RNA), and optionally `SNP_data`, `anno_SNP`, and signature matrices (`ref_gene`, `ref_protein`).

```r
library(MICSQTL)
library(SummarizedExperiment)

# Initialize object
se <- SummarizedExperiment(
    assays = list(protein = protein_matrix),
    rowData = protein_annotation_df
)
metadata(se)$gene_data <- gene_expression_matrix
```

### 2. Cross-Source Deconvolution
To estimate cell-type proportions in the proteome by leveraging the transcriptome:
1. Use `ajive_decomp` with `refactor_loading = TRUE` for feature selection.
2. Use `deconv` with `method = "JNMF"`.

```r
# Identify markers and joint variation
se <- ajive_decomp(se, use_marker = FALSE, refactor_loading = TRUE)

# Perform joint deconvolution
se <- deconv(se, 
             source = "cross", 
             method = "JNMF", 
             pinit = initial_proportions, # e.g., from CIBERSORT on RNA
             ref_pnl = reference_signature_matrix)
```

### 3. Integrative Visualization (AJIVE)
Decompose variation into joint (shared across omics) and individual (specific to one omic) components.

```r
se <- ajive_decomp(se, plot = TRUE, group_var = "condition_column")
# Access common normalized scores plot
metadata(se)$cns_plot
```

### 4. Feature Filtering for QTL
Before csQTL mapping, filter SNPs based on distance (cis-QTL) and allele frequency.

```r
# Define target proteins (e.g., those on a specific chromosome)
targets <- rowData(se)[rowData(se)$Chr == "1", "Symbol"]

se <- feature_filter(se,
    target_protein = targets,
    filter_method = c("allele", "distance"),
    filter_allele = 0.15,
    filter_geno = 0.05,
    ref_position = "TSS" # Transcription Start Site
)
```

### 5. Cell-Type-Specific QTL (csQTL) Analysis
Run the `csQTL` function to test for associations between genotypes and expression within specific cell types using the TOAST algorithm.

```r
se <- csQTL(se)

# Results are stored in metadata
results_list <- metadata(se)$TOAST_output
# Each element contains p-values per cell type for a protein-SNP pair
head(results_list[[1]])
```

## Tips and Best Practices
- **Scaling**: Ensure both protein and gene data use the same transformation (e.g., both log-transformed) and are non-negative for JNMF.
- **Sample Matching**: Column names (samples) in `protein_data`, `gene_data`, and `SNP_data` must match exactly.
- **Marker Genes**: For deconvolution, using a subset of known marker genes rather than the whole transcriptome typically yields more accurate proportions.
- **Step Size**: If `deconv` returns non-finite values, try decreasing the `Step` parameter (e.g., `Step = c(1e-10, 1e-8)`).

## Reference documentation
- [MICSQTL: Multi-omic deconvolution, Integration and Cell-type-specific Quantitative Trait Loci](./references/MICSQTL.md)
- [MICSQTL Vignette Source](./references/MICSQTL.Rmd)