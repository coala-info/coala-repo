---
name: bioconductor-igc
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/iGC.html
---

# bioconductor-igc

## Overview

The `iGC` package provides a framework for the integrated analysis of gene expression and copy number alterations. It addresses the challenge of low reproducibility across platforms by testing GE profiles and CNA status simultaneously. The package identifies genes where expression levels are significantly driven by copy number gains or losses.

## Core Workflow

The analysis typically follows a four-step process:

### 1. Create Sample Description
Define the relationship between samples and their respective data files.

```r
library(iGC)

# From a CSV file (columns: Sample, CNA_filepath, GE_filepath)
sample_desc_pth <- "path/to/sample_desc.csv"
sample_desc <- create_sample_desc(sample_desc_pth)

# Or from character vectors
sample_desc <- create_sample_desc(
  sample_names = c("Sample1", "Sample2"),
  cna_filepaths = c("path/cna1.txt", "path/cna2.txt"),
  ge_filepaths = c("path/ge1.txt", "path/ge2.txt")
)
```

### 2. Prepare Gene Expression (GE) Data
Consolidate individual sample GE files into a joint expression table.

```r
# Standard reading
gene_exp <- create_gene_exp(sample_desc, progress = FALSE)

# Custom reading for specific formats
gene_exp <- create_gene_exp(
  sample_desc,
  read_fun = read.table,
  header = TRUE,
  sep = "\t"
)
```

### 3. Prepare Copy Number Alteration (CNA) Data
Map CNA data to gene locations and categorize as gain (1), loss (-1), or neutral (0).

**Option A: Chromosome location-based (hg19)**
```r
# Define thresholds (e.g., log2 ratios)
gain_threshold <- log2(2.4) - 1
loss_threshold <- log2(1.6) - 1

gene_cna <- create_gene_cna(
  sample_desc,
  gain_threshold = gain_threshold,
  loss_threshold = loss_threshold,
  progress = FALSE
)
```

**Option B: Gene-based CNA data**
If your CNA data is already mapped to gene symbols, use `direct_gene_cna`.

**Option C: High Performance**
Use `faster_gene_cna` with parallelization for large datasets.
```r
# Requires doMC or similar backend
# doMC::registerDoMC(cores = 4)
# gene_cna <- faster_gene_cna(sample_desc, gain_threshold, loss_threshold, parallel = TRUE)
```

### 4. Identify CNA-driven Genes
Find genes where expression is significantly different in CNA-gain or CNA-loss samples compared to neutral samples.

```r
cna_driven_genes <- find_cna_driven_gene(
  gene_cna, 
  gene_exp,
  gain_prop = 0.15, # Min proportion of samples with gain
  loss_prop = 0.15, # Min proportion of samples with loss
  progress = FALSE
)

# Access results
head(cna_driven_genes$gain_driven)
head(cna_driven_genes$loss_driven)
head(cna_driven_genes$both)
```

## Data Requirements

- **Paired Data**: Each sample must have both GE and CNA data.
- **GE Format**: At least two columns: `GENE` and `Expression`.
- **CNA Format**: 
    - Location-based: `Chromosome`, `Start`, `End`, and `Expression` (Segment Mean).
    - Gene-based: `GENE` and `Expression`.
- **Genome Reference**: Currently optimized for `hg19`.

## Tips for Success

- **Custom Readers**: If `create_gene_exp` or `create_gene_cna` fail to parse your files, write a wrapper function for `read.table` or `data.table::fread` and pass it to the `read_fun` argument.
- **Thresholds**: The `gain_threshold` and `loss_threshold` are critical. Ensure they match the scale of your CNA data (e.g., log2 ratios vs. absolute copy numbers).
- **Memory**: For very large datasets, ensure you have sufficient RAM as `iGC` creates joint tables in memory.

## Reference documentation

- [Introduction to iGC](./references/Introduction.md)