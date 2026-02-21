---
name: bioconductor-gpart
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.8/bioc/html/gpart.html
---

# bioconductor-gpart

## Overview
The `gpart` package provides tools for partitioning SNP sequences based on Linkage Disequilibrium (LD) structures and gene location information. It implements the Big-LD algorithm for robust LD block construction and the GPART algorithm for integrating genomic annotations into the partitioning process. This is particularly useful for reducing the dimensionality of genomic data while preserving biological relevance.

## Core Workflows

### 1. Data Preparation
The package requires two primary inputs:
- `geno`: A matrix or data frame of additive genotypes (rows = individuals, columns = SNPs).
- `SNPinfo`: A data frame with columns `chrN`, `rsID`, and `bp`.

```r
library(gpart)
data(geno)
data(SNPinfo)
```

### 2. LD Binning with CLQD
Use `CLQD` to cluster SNPs into highly correlated groups (LD bins).
- `LD`: "r2" (default) or "Dprime".
- `CLQcut`: Threshold for LD (default 0.5 for r2).
- `CLQmode`: "density" (default) or "maximal".

```r
# Cluster first 300 SNPs
clq_results <- CLQD(geno[, 1:300], SNPinfo[1:300,], LD = "r2", CLQcut = 0.5)
# NA values in output represent singletons (bins of size 1)
```

### 3. LD Block Construction with Big-LD
`BigLD` identifies LD block boundaries using interval graph modeling.
- `MAFcut`: Filter rare variants (default 0.05).
- `appendRare`: Set to `TRUE` to add rare variants back into constructed blocks.

```r
# Standard LD block detection
blocks <- BigLD(geno = geno, SNPinfo = SNPinfo, LD = "r2")

# Force specific boundaries
cutlist <- rbind(c(21, "rs440600", 16051956))
blocks_forced <- BigLD(geno = geno, SNPinfo = SNPinfo, cutByForce = cutlist)
```

### 4. Gene-Aware Partitioning with GPART
`GPART` refines LD blocks by considering gene regions. It can split large blocks or merge small ones to meet size constraints.
- `GPARTmode`: "geneBased" (default), "LDblockBased".
- `minsize` / `maxsize`: SNP count thresholds for partitions.

```r
data(geneinfo)
# Partition using pre-calculated BigLD results
gpart_res <- GPART(geno = geno, SNPinfo = SNPinfo, 
                   geneinfo = geneinfo, BigLDresult = blocks,
                   minsize = 4, maxsize = 50)
```

### 5. Visualization
`LDblockHeatmap` generates high-resolution PNG or TIFF files showing LD intensity, block boundaries, and gene tracks.

```r
LDblockHeatmap(geno = geno, SNPinfo = SNPinfo, geneinfo = geneinfo,
               blocktype = "bigld", filename = "ld_plot", res = 300)

# Show LD bins (CLQ) for small regions (<= 200 SNPs)
LDblockHeatmap(geno = geno, SNPinfo = SNPinfo, CLQshow = TRUE, 
               startbp = 16300000, endbp = 16350000, filename = "clq_plot")
```

### 6. Exporting Results
Convert results to Bioconductor-standard `GRanges` objects for downstream genomic analysis.

```r
library(GenomicRanges)
gr_blocks <- convert2GRange(blocks)
```

## Tips and Best Practices
- **Large Files**: For files >10GB (VCF/PLINK), manually load and subset data into R rather than passing file paths directly to `BigLD` to avoid memory exhaustion.
- **Heuristics**: If `CLQD` or `BigLD` hangs on dense regions, adjust `hrstType = "fast"` or `hrstParam` (default 200) to manage the maximal clique detection complexity.
- **Gene Data**: You can fetch gene info automatically by setting `geneDB = "ensembl"` and `assembly = "GRCh38"` within `GPART` or `LDblockHeatmap`.

## Reference documentation
- [gpart](./references/gpart.md)