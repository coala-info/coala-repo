---
name: bioconductor-singler
description: SingleR provides automated cell type annotation for single-cell RNA-seq data by comparing gene expression profiles against reference datasets. Use when user asks to annotate single-cell datasets, perform cell type classification using known references, or evaluate the quality of cell label assignments.
homepage: https://bioconductor.org/packages/release/bioc/html/SingleR.html
---

# bioconductor-singler

name: bioconductor-singler
description: Automated annotation of single-cell RNA-seq (scRNA-seq) data using reference datasets. Use this skill when you need to perform cell type classification by comparing test single-cell data against known reference samples (bulk or single-cell) using the SingleR package.

## Overview

SingleR is a Bioconductor package that provides an automatic annotation method for scRNA-seq data. It works by calculating the similarity (Spearman correlation) between the gene expression profiles of individual cells in a test dataset and the profiles of samples in a reference dataset with known labels. The biological knowledge from the reference is then propagated to the test cells, eliminating the need for manual cluster interpretation.

## Core Workflow

### 1. Prepare Reference Data
References can be built-in datasets from the `celldex` package or custom `SummarizedExperiment` objects. References must be log-normalized.

```r
library(celldex)
# Load a built-in reference
ref.se <- HumanPrimaryCellAtlasData()
```

### 2. Prepare Test Data
The test data can be a `SummarizedExperiment`, `SingleCellExperiment`, or a normalized expression matrix. SingleR uses ranks, so while log-transformation is common, it is not strictly required for the test set itself.

```r
library(scRNAseq)
test.sce <- LaMannoBrainData('human-es')
```

### 3. Run Annotation
The `SingleR()` function is the primary interface.

```r
library(SingleR)
pred <- SingleR(test = test.sce, 
                ref = ref.se, 
                labels = ref.se$label.main,
                assay.type.test = 1)
```

### 4. Single-Cell vs. Bulk References
- **Bulk References (Default):** Uses the default marker detection (difference in medians).
- **Single-Cell References:** It is recommended to use Wilcoxon-based marker detection to account for single-cell variance.

```r
pred <- SingleR(test = test.sce, 
                ref = sc.ref.sce, 
                labels = sc.ref.sce$label, 
                de.method = "wilcox")
```

## Annotation Diagnostics

After running `SingleR()`, use these functions to evaluate the quality of the assignments:

- **`plotScoreHeatmap(pred)`**: Visualizes the correlation scores for all labels across all cells. Look for unambiguous high scores for the assigned label.
- **`plotDeltaDistribution(pred)`**: Displays the "delta," which is the difference between the score of the assigned label and the median of all other labels. Low deltas suggest uncertain assignments.
- **`pruneScores(pred)`**: Identifies low-quality assignments. `SingleR()` automatically includes a `pruned.labels` column in the output where poor matches are marked as `NA`.
- **`plotMarkerHeatmap(pred, test.sce, label="cell_type")`**: Shows the expression of the marker genes used for a specific label within the test dataset.

## Integration with Other Objects

SingleR is workflow-agnostic. To add labels back to a `SingleCellExperiment` or `Seurat` object:

```r
# For SingleCellExperiment
test.sce$labels <- pred$labels

# For Seurat
seurat_obj[["SingleR.labels"]] <- pred$labels
```

## Tips for Success

- **Reference Selection:** Ensure the reference contains the cell types expected in your test data. Use `celldex` for standard human/mouse tissues.
- **Label Granularity:** References often provide `label.main` (broad types) and `label.fine` (specific subtypes). Start with `label.main` for more robust initial classification.
- **Multiple References:** `SingleR()` can accept a list of references (e.g., `ref = list(ref1, ref2)`) to improve coverage.

## Reference documentation

- [Using SingleR to annotate single-cell RNA-seq data](./references/SingleR.Rmd)
- [Using SingleR to annotate single-cell RNA-seq data](./references/SingleR.md)