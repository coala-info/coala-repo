---
name: bioconductor-harmonizedtcgadata
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/HarmonizedTCGAData.html
---

# bioconductor-harmonizedtcgadata

## Overview

The `HarmonizedTCGAData` package provides processed, harmonized multi-omic data from the Cancer Genome Atlas (TCGA). It specifically contains precomputed affinity matrices for 2,582 patients across five primary cancer sites (adrenal gland, lung, uterus, kidney, and colorectal). These matrices are designed for use with the `ANF` (Affinity Network Fusion) package to cluster patients into disease subtypes.

The package includes three main components:
1. `Wall`: A nested list of 90 affinity matrices (5 cancer types × 6 normalization methods × 3 omic views).
2. `project_ids`: Ground truth mapping of patients to TCGA project IDs (disease types).
3. `surv.plot`: Patient survival data for clinical evaluation of clustering results.

## Data Retrieval

Data is hosted on `ExperimentHub`. Use the following workflow to load the objects:

```r
library(ExperimentHub)
eh <- ExperimentHub()
tcga_data <- query(eh, "HarmonizedTCGAData")

# Load the three main objects
Wall <- tcga_data[[1]]
project_ids <- tcga_data[[2]]
surv.plot <- tcga_data[[3]]
```

## Understanding the Wall Object

`Wall` is structured as a deeply nested list: `Wall[[CancerType]][[Normalization]][[View]]`.

- **Cancer Types**: `adrenal_gland`, `lung`, `uterus`, `kidney`, `colorectal`.
- **Normalization Types**: 
    - `raw.all` / `raw.sel`: Raw counts (all or differentially expressed).
    - `log.all` / `log.sel`: Log2 transformed counts.
    - `vst.sel`: Variance stabilizing transformation.
    - `normalized`: FPKM or normalized counts.
- **Views**: `fpkm` (Gene expression), `mirnas` (miRNA), `methy450` (DNA methylation).

## Typical Workflow

### 1. Single Matrix Clustering
To cluster patients using a single data type (e.g., adrenal gland log-transformed gene expression):

```r
library(ANF)
# Extract specific affinity matrix
affinity.mat <- Wall$adrenal_gland$log.sel$fpkm

# Perform spectral clustering (k = number of clusters)
labels <- spectral_clustering(affinity.mat, k = 2)

# Evaluate against ground truth
true.types <- as.factor(project_ids[rownames(affinity.mat)])
table(labels, true.types)
```

### 2. Multi-Omic Fusion (ANF)
To improve clustering by fusing multiple omic views (e.g., for uterus cancer):

```r
# Fuse the three views (fpkm, mirnas, methy450) for a specific normalization
fused.mat <- ANF(Wall = Wall$uterus$raw.all)

# Cluster on the fused matrix
res <- eval_clu(true_class = project_ids[rownames(fused.mat)], w = fused.mat)
print(res$nmi) # Normalized Mutual Information
```

### 3. Survival Analysis Evaluation
Evaluate if the identified clusters show significant differences in survival:

```r
# Subset survival data to match the affinity matrix patients
current_surv <- surv.plot[rownames(affinity.mat), ]

# Calculate p-value using survival package
f <- survival::Surv(current_surv$time, !current_surv$censored)
fit <- survival::survdiff(f ~ labels)
pval <- stats::pchisq(fit$chisq, df = length(fit$n) - 1, lower.tail = FALSE)
```

## Tips and Best Practices
- **View Names**: Note that `fpkm` is used as a generic label for gene expression views, even when the data is actually raw counts or VST-transformed.
- **Evaluation**: Use `ANF::eval_clu` for a streamlined evaluation that calculates NMI, ARI, and survival p-values in one step.
- **Patient IDs**: Row names of matrices are Case IDs; column names are Aliquot IDs (TCGA barcodes). Use these to link back to the GDC Data Portal if raw files are needed.

## Reference documentation
- [HarmonizedTCGAData](./references/HarmonizedTCGAData.md)