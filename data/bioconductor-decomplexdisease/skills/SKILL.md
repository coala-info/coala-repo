---
name: bioconductor-decomplexdisease
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.8/bioc/html/DEComplexDisease.html
---

# bioconductor-decomplexdisease

name: bioconductor-decomplexdisease
description: Differential expression analysis for complex diseases using bi-clustering to identify heterogeneous gene signatures shared by patient subsets. Use this skill when analyzing RNA-seq or microarray data where patients may not share a single common set of DEGs, or when seeking to identify patient-specific modules and disease subtypes based on shared expression patterns.

## Overview

DEComplexDisease is a Bioconductor package designed for the analysis of complex, heterogeneous diseases. Unlike standard differential expression (DE) tools that assume all patients in a group share the same DEGs, this package uses a bi-clustering algorithm to find DEGs shared by specific subsets of patients. It transforms expression data into a binary matrix (up-regulated, down-regulated, or neutral) and identifies "modules" of genes and patients that represent potential disease mechanisms.

## Core Workflow

### 1. Data Preparation
The package requires an expression matrix (`exp`) and a binary sample annotation vector (`cl`) where 1 is patient and 0 is control.

```r
library(DEComplexDisease)
# exp: rows are genes, columns are samples
# cl: 0 for normal, 1 for disease
# Optional: ann.er for clinical annotations in plots
```

### 2. Binary DEG Transformation
Convert the expression matrix into a binary matrix (-1, 0, 1) using `bi.deg`.

```r
# For RNA-seq counts: use "edger" or "deseq2"
# For normalized data: use "normalized"
deg <- bi.deg(exp, cl, method = "edger", cutoff = 0.05, cores = 4)

# Visualize initial DEGs
Plot(deg, ann = ann.er, show.genes = c("GENE1", "GENE2"))
```

### 3. Cross-Validated Patient-Specific DEGs
Filter noise by finding DEGs that are observed in at least `min.patients`.

```r
res.deg <- deg.specific(deg, min.genes = 30, min.patients = 5, cores = 4)

# Plot cross-validated results
Plot(res.deg, ann = ann.er, max.n = 5)
```

### 4. Module Discovery
Identify signatures shared by patient subsets using `seed.module` and then group similar modules with `cluster.module`.

```r
# Generate patient-seeded modules
seed.mod <- seed.module(deg, res.deg = res.deg, min.genes = 50, 
                        min.patients = 20, overlap = 0.85, cores = 4)

# Cluster modules to find representative signatures
cluster.mod <- cluster.module(seed.mod, cores = 4)

# Plot clustered modules
Plot(cluster.mod, ann = ann.er, type = "model", max.n = 5)
```

## Advanced Analysis and Visualization

### Module Modeling
If the default breakpoints for modules are not ideal, use `module.modeling` to adjust the gene-patient curve based on different criteria:
- `slope.clustering`: Maximum slope changes (default).
- `max.square`: Maximum product of gene and patient numbers.
- `min.slope`: Minimum slope in the curve.

```r
# Manually set gene number for specific modules
new.mod <- module.modeling(cluster.mod, keep.gene.num = c("M1" = 50, "M3" = 40))
module.curve(new.mod, "M1")
```

### Feature Screening
Find modules associated with specific clinical features or mutations.

```r
# Screen for modules associated with a list of feature-positive patients
module.screen(cluster.mod, feature.patients = c("ID1", "ID2", "ID3"))
```

### Module Comparison and Overlap
- `module.overlap(cluster.mod)`: Check gene/patient overlaps between modules in one study.
- `module.compare(mod1, mod2)`: Compare modules across different studies or conditions.

## Usage Tips
- **Parallel Computing**: Always set the `cores` parameter to utilize multi-core hardware, as bi-clustering is computationally intensive.
- **Memory Management**: Clear the session with `rm(list=ls())` before starting a large analysis to prevent excessive memory consumption during parallel processing.
- **Reference Quality**: The accuracy of `bi.deg` depends on the control samples. Perform hierarchical clustering on control samples first to identify and remove outliers.

## Reference documentation
- [DEComplexDisease: A tool for differential expression analysis](./references/decd.md)
- [DEComplexDisease Vignette](./references/vignettes.md)