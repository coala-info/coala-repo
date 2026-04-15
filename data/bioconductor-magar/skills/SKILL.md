---
name: bioconductor-magar
description: This tool identifies methylation quantitative trait loci (methQTL) by associating DNA methylation data with genotyping data using correlation blocks and linear modeling. Use when user asks to compute methQTL, identify SNP-CpG interactions, or group CpGs into correlation blocks.
homepage: https://bioconductor.org/packages/release/bioc/html/MAGAR.html
---

# bioconductor-magar

name: bioconductor-magar
description: Methylation-Aware Genotype Association in R (MAGAR). Use this skill to compute methylation quantitative trait loci (methQTL) by associating DNA methylation data (Illumina BeadArrays/bisulfite sequencing) with genotyping data (microarrays/WGS). Use for data import via RnBeads, CpG correlation block computation, and linear modeling of SNP-CpG interactions.

## Overview

MAGAR identifies statistically significant interactions between single nucleotide polymorphisms (SNPs) and DNA methylation states. To reduce redundancy and multiple testing burdens, MAGAR groups neighboring, highly correlated CpGs into "correlation blocks" and uses a representative "tag-CpG" for methQTL calling.

## Core Workflow

### 1. Setup and External Tools
MAGAR requires PLINK for genotype processing. Set the path to the executable before starting:
```r
library(MAGAR)
qtlSetOption(plink.path = "/path/to/plink")
```

### 2. Data Import
Use `doImport` to combine methylation and genotyping data. MAGAR uses `RnBeads` for methylation processing.

```r
# Define data locations
data.loc <- list(idat.dir = "path/to/meth_idats", geno.dir = "path/to/plink_files")

# Import and preprocess
imp.data <- doImport(
  data.location = data.loc,
  s.anno = "sample_annotation.csv",
  s.id.col = "SampleID",
  out.folder = getwd()
)
```
*   **Genotype types:** Supports `plink` (binary .bed/.bim/.fam) or `idat` (raw).
*   **Methylation types:** Supports `idat.dir`, `rnb.set`, `GEO`, etc.

### 3. methQTL Calling
The `doMethQTL` function performs both correlation block identification and association testing.

```r
# Set clustering parameters (optional, defaults exist for 450k/EPIC/WGBS)
qtlSetOption(cluster.cor.threshold = 0.75, standard.deviation.gauss = 100)

# Run analysis
meth.qtl.res <- doMethQTL(imp.data, p.val.cutoff = 0.05)
```

**Key Options for `meth.qtl.type`:**
*   `allVSall`: Returns all SNP-CpG pairs below the p-value threshold.
*   `oneVSall`: Returns only the SNP with the lowest p-value per CpG.
*   `fastQTL`: Uses the external FastQTL software for computation.

### 4. Results and Interpretation
Extract results into data frames for downstream analysis.

```r
# Get main result table
res_table <- getResult(meth.qtl.res)

# Get annotations
meth_anno <- getAnno(meth.qtl.res, "meth")
geno_anno <- getAnno(meth.qtl.res, "geno")
```

### 5. Visualization
```r
# Plot specific SNP-CpG interaction
qtlPlotSNPCpGInteraction(imp.data, res_table$CpG[1], res_table$SNP[1])

# Scatterplot of p-values vs genomic distance
qtlDistanceScatterplot(meth.qtl.res)
```

## Advanced Features

*   **Covariates:** Specify via `qtlSetOption(sel.covariates = c("age", "sex"))`.
*   **Imputation:** Enable via `qtlSetOption(impute.geno.data = TRUE)` (requires Michigan Imputation Server API token).
*   **Enrichment:** Use `qtlLOLAEnrichment` for genomic region enrichment or `qtlBaseSubstitutionEnrichment` for SNP properties.
*   **Large Datasets:** Use `qtlSetOption(hdf5dump = TRUE)` to store large matrices on disk instead of RAM.

## Reference documentation

- [MAGAR: Methylation-Aware Genotype Association in R](./references/MAGAR.md)
- [MAGAR Rmarkdown Source](./references/MAGAR.Rmd)