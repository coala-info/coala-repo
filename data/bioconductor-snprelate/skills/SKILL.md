---
name: bioconductor-snprelate
description: SNPRelate is a Bioconductor package for high-performance genomic data analysis, focusing on population structure and relatedness in large-scale association studies. Use when user asks to perform principal component analysis, estimate identity-by-descent or identity-by-state coefficients, conduct linkage disequilibrium pruning, or convert VCF and PLINK files to GDS format.
homepage: https://bioconductor.org/packages/release/bioc/html/SNPRelate.html
---

# bioconductor-snprelate

## Overview

SNPRelate is a Bioconductor package designed for high-performance computing in genome-wide association studies (GWAS). It utilizes the Genomic Data Structure (GDS) format (via the `gdsfmt` package) to provide efficient memory management and parallel processing for large-scale genomic data. Its primary strengths lie in Principal Component Analysis (PCA), relatedness analysis (IBD/IBS), and Linkage Disequilibrium (LD) pruning.

## Core Workflow

### 1. Data Preparation and Conversion
SNPRelate operates on GDS files. You must convert common formats (PLINK, VCF) before analysis.

```R
library(SNPRelate)

# Convert PLINK BED to GDS
snpgdsBED2GDS("data.bed", "data.fam", "data.bim", "data.gds")

# Convert VCF to GDS (biallelic SNPs only)
snpgdsVCF2GDS("data.vcf", "data.gds", method="biallelic.only")

# Open the GDS file
genofile <- snpgdsOpen("data.gds")
```

### 2. LD-based SNP Pruning
To avoid the influence of SNP clusters in PCA and relatedness analysis, perform LD pruning to obtain a set of independent markers.

```R
set.seed(1000)
snpset <- snpgdsLDpruning(genofile, ld.threshold=0.2)
snpset.id <- unlist(unname(snpset))
```

### 3. Principal Component Analysis (PCA)
PCA is used to identify population structure.

```R
# Run PCA
pca <- snpgdsPCA(genofile, snp.id=snpset.id, num.thread=2)

# Calculate variance proportion
pc.percent <- pca$varprop * 100
head(round(pc.percent, 2))

# Create a data frame for plotting
tab <- data.frame(sample.id = pca$sample.id,
                  EV1 = pca$eigenvect[,1],
                  EV2 = pca$eigenvect[,2],
                  stringsAsFactors = FALSE)

# Plot PCA
plot(tab$EV2, tab$EV1, xlab="PC 2", ylab="PC 1")
```

### 4. Relatedness Analysis (IBD and KING)
Estimate identity-by-descent (IBD) coefficients or use the KING-robust method for relationship inference.

```R
# Method of Moments (MoM)
ibd <- snpgdsIBDMoM(genofile, snp.id=snpset.id, num.thread=2)
ibd.coeff <- snpgdsIBDSelection(ibd)

# KING-robust (robust to population stratification)
ibd.robust <- snpgdsIBDKING(genofile, num.thread=2)
dat <- snpgdsIBDSelection(ibd.robust)
```

### 5. Identity-By-State (IBS) and Clustering
Perform IBS analysis for individual similarity and hierarchical clustering.

```R
# Calculate IBS matrix
ibs <- snpgdsIBS(genofile, num.thread=2)

# Hierarchical clustering
ibs.hc <- snpgdsHCluster(ibs)
groups <- snpgdsCutTree(ibs.hc)
plot(groups$dendrogram, leaflab="none")
```

## Tips for Efficient Usage
- **SNP-major mode**: Ensure your GDS file is in SNP-major mode for faster PCA and IBD calculations. `snpgdsSummary()` will report the current mode.
- **Parallelization**: Most heavy functions support the `num.thread` argument. Increase this based on available CPU cores.
- **Cleanup**: Always close the GDS file using `snpgdsClose(genofile)` when finished to prevent file corruption or memory leaks.
- **SeqArray Integration**: For large-scale Whole Genome Sequencing (WGS) data with multi-allelic sites, use the `SeqArray` package instead of `SNPRelate`.

## Reference documentation
- [Tutorials for the R/Bioconductor Package SNPRelate](./references/SNPRelate.Rmd)
- [Tutorials for the R/Bioconductor Package SNPRelate](./references/SNPRelate.md)