---
name: bioconductor-isomirs
description: The isomiRs package analyzes microRNA variants by transforming alignment data into specialized objects for normalization, visualization, and differential expression analysis. Use when user asks to load miraligner or mirTOP data, annotate isomiR types, visualize variant distributions, or perform differential expression analysis on miRNA isoforms.
homepage: https://bioconductor.org/packages/release/bioc/html/isomiRs.html
---

# bioconductor-isomirs

## Overview

The `isomiRs` package is designed for the analysis of microRNA (miRNA) variants, known as isomiRs. These variants arise from imprecise cleavage (5' and 3' trimming), non-templated 3' additions, and internal substitutions. The package transforms raw alignment data into an `IsomirDataSeq` object (a subclass of `SummarizedExperiment`), providing tools for normalization, descriptive plotting, and differential expression analysis that accounts for specific isomiR types.

## Core Workflow

### 1. Data Loading
The package primarily consumes output from `miraligner` (*.mirna files) or `mirTOP`.

```r
library(isomiRs)

# design: data.frame with sample metadata; row names must match file names
# fn_list: vector of paths to .mirna files
ids <- IsomirDataSeqFromFiles(fn_list, design = design_df)
```

### 2. IsomiR Annotation and Selection
IsomiRs are named using a specific nomenclature: `miRNA_name;type;tag`.
- **ref**: Reference sequence.
- **iso_5p / iso_3p**: Trimming variants (UPPER case = insertion/upstream, lower case = deletion/downstream).
- **iso_add**: 3' additions.
- **iso_snp**: Substitutions.

```r
# Select specific miRNA data across samples
data(mirData)
head(isoSelect(mirData, mirna = "hsa-let-7a-5p"))

# Get detailed annotation including importance (isomiR_reads / miRNA_reads)
head(isoAnnotate(mirData))
```

### 3. Processing and Normalization
Before analysis, counts must be generated. You can collapse isomiRs into the reference miRNA or keep them separate.

```r
# Generate count matrix (collapsing isomiRs)
ids <- isoCounts(mirData)

# Normalize using rlog (DESeq2 integration)
ids <- isoNorm(ids, formula = ~ condition)

# Access normalized counts
norm_counts <- counts(ids, norm = TRUE)
```

### 4. Visualization
Use `isoPlot` to visualize the distribution of different isomiR types.

```r
# Plot distribution of all isomiR types (trimming, addition, substitution)
isoPlot(ids, type = "all")
```

### 5. Differential Expression (DE)
The `isoDE` function wraps `DESeq2` logic to handle isomiR-specific comparisons.

```r
# Standard DE analysis at the miRNA level
dds <- isoDE(ids, formula = ~ condition)

# DE analysis differentiating between reference and 5' variants
dds_iso5 <- isoDE(ids, formula = ~ condition, ref = TRUE, iso5 = TRUE)

# Extract results
library(DESeq2)
res <- results(dds)
```

## Tips and Best Practices
- **Integration**: Since `IsomirDataSeq` inherits from `SummarizedExperiment`, you can use standard Bioconductor methods like `colData()`, `assay()`, and `metadata()`.
- **Custom DE**: For complex designs, pass `counts(ids)` and `colData(ids)` directly to `DESeqDataSetFromMatrix`.
- **Importance Value**: Use `isoAnnotate` to identify which isomiRs are dominant in your samples versus low-abundance noise.

## Reference documentation
- [Characterization of miRNA and isomiR molecules](./references/isomiRs.md)
- [isomiRs analysis vignette](./references/isomiRs.Rmd)