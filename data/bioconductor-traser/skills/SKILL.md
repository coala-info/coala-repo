---
name: bioconductor-traser
description: bioconductor-traser performs trait-associated SNP enrichment analyses to determine if genomic intervals are functionally connected with specific traits or diseases using GWAS data. Use when user asks to test for enrichment of trait-associated SNPs in genomic regions, compare intervals against dbGaP or NHGRI databases, or visualize the distribution of SNP functional classes for specific traits.
homepage: https://bioconductor.org/packages/release/bioc/html/traseR.html
---

# bioconductor-traser

name: bioconductor-traser
description: Perform TRait-Associated SNP EnRichment (traseR) analyses to determine if genomic intervals (like ChIP-seq peaks) are functionally connected with specific traits or diseases using GWAS data. Use this skill when you need to: (1) Test for enrichment of trait-associated SNPs (taSNPs) in genomic regions, (2) Compare genomic intervals against built-in databases from dbGaP and NHGRI, (3) Perform binomial, chi-square, Fisher's exact, or nonparametric tests for SNP enrichment, or (4) Visualize the distribution of SNP functional classes and p-values for specific traits.

## Overview

The `traseR` package provides a quantitative assessment of whether a set of genomic intervals is likely to be functionally connected with certain traits or diseases. It leverages a built-in database of trait-associated SNPs (taSNPs) and linkage disequilibrium (LD) SNPs from the 1000 Genomes Project. The core workflow involves providing genomic coordinates (as a `GRanges` object or data frame) and testing them against cataloged SNP-trait associations.

## Core Workflow

### 1. Load Data and Prepare Regions
The package includes built-in SNP databases and example datasets. Genomic intervals must be in `GRanges` format or a data frame with `chr`, `start`, and `end` columns.

```R
library(traseR)
data(taSNP)    # Standard trait-associated SNPs
data(taSNPLD)  # taSNPs including those in LD (r2 > 0.8)
data(CEU)      # Background SNPs from 1000 Genomes
data(Tcell)    # Example genomic intervals (T-cell H3K4me1 peaks)
```

### 2. Perform Enrichment Analysis
The `traseR` function is the primary interface for hypothesis testing.

```R
# Basic enrichment test using whole genome as background
res <- traseR(snpdb = taSNP, region = Tcell)

# Using all SNPs as background and including LD SNPs
res_ld <- traseR(snpdb = taSNPLD, region = Tcell, snpdb.bg = CEU)

# Customizing the test
res_custom <- traseR(snpdb = taSNP, 
                     region = Tcell, 
                     test.method = "fisher", # options: "binomial", "chisq", "fisher", "nonparametric"
                     alternative = "greater", 
                     rankby = "pvalue")
print(res_custom)
```

### 3. Statistical Test Selection
- **Binomial (Default):** Best for general use; not limited by sample size or distribution.
- **Fisher's Exact:** Preferred when contingency table counts are small (e.g., < 20).
- **Chi-square:** Use when counts in the contingency table are large and balanced.
- **Nonparametric:** Use when the number of query intervals is small (e.g., < 1000).

## Exploration and Visualization

### Querying the Database
You can extract specific SNPs or genes from the database based on keywords or identifiers.

```R
# Query by keyword (e.g., "Autoimmune")
autoimmune_snps <- queryKeyword(snpdb = taSNP, region = Tcell, keyword = "autoimmune", returnby = "SNP")

# Query by gene name
gene_info <- queryGene(snpdb = taSNP, genes = c("AGRN", "SSU72"))

# Query by SNP ID
snp_info <- querySNP(snpdb = taSNP, snpid = c("rs3766178", "rs880051"))
```

### Visualization
TraseR provides functions to visualize the functional context and p-value distributions of the SNPs.

```R
# Plot distribution of SNP functional classes (Intron, Intergenic, etc.)
plotContext(snpdb = taSNP, region = Tcell, keyword = "Autoimmune")

# Plot p-value distribution of taSNPs
plotPvalue(snpdb = taSNP, region = Tcell, keyword = "autoimmune", plot.type = "densityplot")

# Plot SNPs/Genes within a specific genomic interval
plotInterval(snpdb = taSNP, region = data.frame(chr="chrX", start=152633780, end=152737085))
```

## Tips for Success
- **Background Selection:** Choosing `snpdb.bg = CEU` restricts the background to known SNP positions, which is often more biologically relevant than using the "Whole Genome" (default) which treats every base pair as a potential SNP site.
- **LD SNPs:** Using `taSNPLD` instead of `taSNP` expands the search to include SNPs in high linkage disequilibrium, which can increase sensitivity but may also increase the false discovery rate.
- **Input Format:** Ensure your chromosome names in the `region` object match the `snpdb` (e.g., "chr1" vs "1").

## Reference documentation
- [traseR](./references/traseR.md)