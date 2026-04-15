---
name: bioconductor-mbecs
description: The bioconductor-mbecs package provides a unified framework for identifying, visualizing, and correcting batch effects in microbiome datasets. Use when user asks to assess batch effects, perform TSS or CLR transformations, visualize data using PCA or RLE plots, and apply correction algorithms like ComBat, RUV3, or BMC.
homepage: https://bioconductor.org/packages/release/bioc/html/MBECS.html
---

# bioconductor-mbecs

name: bioconductor-mbecs
description: Assessment and correction of batch-effects in microbiome data sets using the MBECS R package. Use this skill to process microbiome abundance tables (or phyloseq objects), perform transformations (TSS, CLR), visualize batch effects (PCA, RLE, Heatmaps), and apply various batch-effect correction algorithms (ComBat, RUV3, BMC, etc.).

# bioconductor-mbecs

## Overview
The Microbiome Batch-Effect Correction Suite (MBECS) provides a unified framework for identifying and mitigating batch effects in microbiome research. It integrates several established correction algorithms into a consistent workflow, allowing users to compare the effectiveness of different methods on their specific datasets. The package centers around the `MbecData` class, which extends `phyloseq`, making it compatible with standard microbiome analysis pipelines.

## Workflow and Core Functions

### 1. Data Input and Initialization
MBECS accepts `phyloseq` objects or lists containing abundance and metadata. Use `mbecProcessInput` to create the required `MbecData` object.

```r
library(MBECS)

# From a list (abundance matrix + metadata)
# required.col ensures necessary covariates (e.g., batch, group) exist
mbec.obj <- mbecProcessInput(input.list, required.col = c("batch", "group"))

# From a phyloseq object
mbec.obj <- mbecProcessInput(physeq_obj)
```

### 2. Normalization and Transformation
Microbiome data often requires transformation before batch correction. MBECS provides Total Sum Scaling (TSS) and Centered Log-Ratio (CLR).

```r
# Apply TSS
mbec.obj <- mbecTransform(mbec.obj, method = "tss")

# Apply CLR (recommended for most downstream corrections)
mbec.obj <- mbecTransform(mbec.obj, method = "clr", offset = 0.0001)
```

### 3. Batch Effect Assessment (Exploratory)
Before correction, visualize the data to confirm the presence of batch effects.

*   **PCA:** `mbecPCA(mbec.obj, model.vars = c("batch", "group"), type = "clr")`
*   **RLE:** `mbecRLE(mbec.obj, model.vars = c("batch", "group"), type = "clr")`
*   **Heatmap:** `mbecHeat(mbec.obj, method = "TOP", n = 10, model.vars = c("batch", "group"))`
*   **Variance Analysis:** Use `mbecModelVariance` with methods like `"lm"`, `"lmm"`, `"pvca"`, or `"rda"` to quantify the variance explained by batch vs. biological group.

### 4. Batch Effect Correction
You can run a single correction or multiple corrections simultaneously to compare results.

**Single Correction:**
```r
# Methods: "bat" (ComBat), "ruv3" (RUV-III), "bmc" (Batch Mean Centering), 
# "rbe" (limma), "pn" (Percentile Norm), "svd" (SVD)
mbec.obj <- mbecCorrection(mbec.obj, model.vars = c("batch", "group"), method = "bat", type = "clr")
```

**Multiple Corrections:**
```r
mbec.obj <- mbecRunCorrections(mbec.obj, model.vars = c("batch", "group"), 
                               method = c("bat", "bmc", "rbe"), type = "clr")
```

### 5. Reporting and Retrieval
*   **Reports:** Generate comprehensive HTML reports using `mbecReportPrelim()` (pre-correction) and `mbecReportPost()` (post-correction comparison).
*   **Extraction:** Retrieve the corrected data as a `phyloseq` object for downstream analysis.

```r
# Retrieve ComBat corrected data
ps.corrected <- mbecGetPhyloseq(mbec.obj, type = "cor", label = "bat")
```

## Key Correction Algorithms
*   **ComBat (`bat`):** Empirical Bayes framework; robust for most datasets.
*   **RUV-III (`ruv3`):** Requires technical replicates and negative control features.
*   **Percentile Normalization (`pn`):** Specifically for case-control designs; converts abundances to percentiles of the control distribution.
*   **BMC (`bmc`):** Simple mean centering of batches.
*   **RBE (`rbe`):** Uses `limma::removeBatchEffect` logic.

## Tips for Success
*   **Variable Selection:** Always provide `model.vars` as a vector where the first element is the batch variable and the second is the biological variable of interest.
*   **CLR Transformation:** Most correction algorithms (except Percentile Normalization) perform best on CLR-transformed data.
*   **Control Groups:** If using Percentile Normalization, ensure your group factor is correctly leveled so the "control" group is the reference.

## Reference documentation
- [MBECS introduction](./references/mbecs_vignette.md)
- [MBECS introduction (RMarkdown)](./references/mbecs_vignette.Rmd)