---
name: bioconductor-cindex
description: This tool calculates Chromosome Instability (CIN) indices from DNA copy number data to quantify genomic imbalances. Use when user asks to calculate chromosome-level or genome-wide instability scores, identify regions of high CIN, or compare CIN scores across different sample groups.
homepage: https://bioconductor.org/packages/release/bioc/html/CINdex.html
---

# bioconductor-cindex

name: bioconductor-cindex
description: Calculate Chromosome Instability (CIN) index using the CINdex R package. Use this skill when analyzing genomic copy number data to quantify chromosome-level or genome-wide instability, identify regions of high CIN, and compare CIN scores across different sample groups (e.g., case vs. control).

# bioconductor-cindex

## Overview
The `CINdex` package calculates a Chromosome Instability (CIN) index using DNA copy number data. It quantifies the level of genomic imbalance by measuring the magnitude and boundaries of gains and losses. This is particularly useful in cancer genomics to characterize the degree of chromosomal instability across samples or groups.

## Core Workflow

### 1. Data Preparation
CINdex requires segmented copy number data and cytoband information. Data should typically be formatted as a `GRanges` object or a specific data frame.

```r
library(CINdex)

# Load example data provided by the package
data("segdata.20")
data("reference.gr")
data("cnvgr.18.19")
```

### 2. Calculate CIN per Chromosome
The `cin.per.chrom` function calculates the CIN index for each chromosome arm (p and q) for each sample.

```r
# Calculate CIN per chromosome
# 'data.type' can be "Rle" or "numeric"
results.chrom <- cin.per.chrom(seg.data = segdata.20, 
                               rel.gr = reference.gr, 
                               comp.type = "all")

# Access the scores
# results.chrom$p.arm.cin
# results.chrom$q.arm.cin
```

### 3. Calculate CIN per Genome
The `cin.per.genome` function provides a single CIN score representing the total instability across the entire genome for each sample.

```r
results.genome <- cin.per.genome(cin.obj = results.chrom)

# View genome-wide scores
print(results.genome)
```

### 4. Gene-Level Analysis
To analyze instability at the gene level, use `extract.genes.search` to map genomic segments to specific gene locations.

```r
# Extract genes in a specific region
data("gene.data")
genes.in.region <- extract.genes.search(seg.data = segdata.20, 
                                        gene.data = gene.data, 
                                        chrom = 1, 
                                        start.pos = 1000000, 
                                        end.pos = 2000000)
```

### 5. Comparing Groups
If you have clinical metadata (e.g., Treatment vs. Control), use `comp.cis.score` to find statistically significant differences in CIN scores between groups.

```r
# Assuming 'clinical.data' has a column 'group'
# comp.cis.score(cin.obj = results.chrom, clinical.data = my_metadata, group.col = "group")
```

## Tips for Success
- **Reference Genome:** Ensure your cytoband reference (e.g., hg18, hg19, hg38) matches the assembly used for your copy number segmentation.
- **Input Format:** The package is sensitive to column naming in data frames. If using custom data, ensure columns like `Chromosome`, `Start.p`, `End.p`, and `Log.Ratio` (or equivalent) are correctly mapped.
- **Thresholds:** CIN calculations depend on thresholds for what constitutes a "gain" or "loss" (typically +/- 0.2 or 0.3 in log2 ratio). Check the `threshold` parameter in calculation functions.

## Reference documentation
- [CINdex Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/CINdex.html)
- [CINdex Vignette](https://bioconductor.org/packages/release/bioc/vignettes/CINdex/inst/doc/CINdex.pdf)