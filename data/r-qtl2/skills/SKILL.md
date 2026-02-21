---
name: r-qtl2
description: "Provides a set of tools to perform quantitative     trait locus (QTL) analysis in experimental crosses. It is a     reimplementation of the 'R/qtl' package to better handle     high-dimensional data and complex cross designs.     Broman et al."
homepage: https://cran.r-project.org/web/packages/qtl2/index.html
---

# r-qtl2

name: r-qtl2
description: Perform Quantitative Trait Locus (QTL) analysis in experimental crosses using the qtl2 R package. Use this skill when analyzing high-dimensional genomic data, complex cross designs (e.g., Diversity Outbred, Collaborative Cross, multi-parent RILs), or performing genome scans with linear mixed models (LMM) to account for population structure.

# r-qtl2

## Overview
The `qtl2` package is a reimplementation of R/qtl designed to handle high-dimensional data and complex cross designs. It utilizes a "control file" (YAML or JSON) to link genotypes, phenotypes, and maps. The workflow typically moves from calculating genotype probabilities to performing genome scans and identifying peaks.

## Installation
install.packages("qtl2")

## Core Workflow

1. **Load Data**
   Use `read_cross2()` to load a zipped data set.
   iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

2. **Prepare Map and Probabilities**
   Insert pseudomarkers to create a grid for the scan, then calculate genotype probabilities.
   map <- insert_pseudomarkers(iron$gmap, step=1)
   probs <- calc_genoprob(iron, map, error_prob=0.002)

3. **Calculate Kinship (Optional but Recommended)**
   For complex crosses, use the Leave-One-Chromosome-Out (LOCO) method to account for population structure.
   kinship <- calc_kinship(probs, "loco")

4. **Perform Genome Scan**
   Run the scan using `scan1()`. Provide covariates via `addcovar`.
   Xcovar <- get_x_covar(iron)
   out <- scan1(probs, iron$pheno, kinship=kinship, Xcovar=Xcovar)

5. **Determine Significance**
   Run permutations to find LOD thresholds.
   operm <- scan1perm(probs, iron$pheno, n_perm=1000)
   threshold <- summary(operm, alpha=0.05)

6. **Find and Plot Peaks**
   Identify QTL peaks and visualize results.
   peaks <- find_peaks(out, map, threshold=3, drop=1.5)
   plot(out, map, lodcolumn=1)
   add_threshold(map, threshold)

## Specialized Analysis

### Multi-parent Allele Effects
For multi-parent crosses (e.g., DO mice), convert genotype probabilities to allele probabilities to simplify the model.
A_probs <- genoprob_to_alleleprob(probs)
out_coef <- scan1coef(A_probs[,"7"], iron$pheno[,"liver"], kinship=kinship[["7"]])
plot_coef(out_coef, map[["7"]], columns=1:8)

### SNP Association Mapping
If founder genotypes are available, perform SNP association mapping by interpolating founder SNPs onto the study individuals.
snpinfo <- index_snps(iron$pmap, snpinfo_table)
snpprobs <- genoprob_to_snpprob(probs, snpinfo)
out_snps <- scan1(snpprobs, iron$pheno)

## Tips and Best Practices
- **Memory Management**: For very large datasets, use `lowmem=TRUE` in `calc_genoprob()`.
- **LOCO**: Always use `type="loco"` in `calc_kinship()` when performing scans with kinship to avoid proximal contamination (inflated LOD scores near the QTL).
- **X Chromosome**: Use `get_x_covar()` to automatically generate the necessary sex and direction covariates for the X chromosome scan.
- **Data Integrity**: Run `check_cross2(cross_obj)` after loading to ensure the data structure is valid.

## Reference documentation
- [Package Manual](./references/reference_manual.md)