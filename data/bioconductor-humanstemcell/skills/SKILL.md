---
name: bioconductor-humanstemcell
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/humanStemCell.html
---

# bioconductor-humanstemcell

name: bioconductor-humanstemcell
description: Access and analyze the humanStemCell Bioconductor experiment data. Use this skill when a user needs to work with Affymetrix time-course expression data from human embryonic stem cells (H1 line), specifically comparing undifferentiated vs. differentiated states.

# bioconductor-humanstemcell

## Overview
The `humanStemCell` package is a Bioconductor ExperimentData package containing an `ExpressionSet` from a study on Human Embryonic Stem Cells (H1 Line). The experiment compares two states: undifferentiated cells and differentiated cells (maintained for 10-14 days without fibroblast growth factor). It features six arrays (three biological replicates per condition) using the Affymetrix hgu133plus2 platform.

## Loading the Data
To use the dataset, you must load the package and the specific `fhesc` object:

```r
library(humanStemCell)
data(fhesc)
```

## Working with the ExpressionSet
The primary object is `fhesc`, which is an `ExpressionSet` instance.

### Data Inspection
- **View metadata**: `pData(fhesc)` shows the sample information (undifferentiated vs. differentiated).
- **Access expression values**: `exprs(fhesc)` retrieves the log-transformed (if processed) or raw intensity matrix.
- **Feature information**: The data uses the `hgu133plus2.db` annotation package. Use `annotation(fhesc)` to confirm.

### Typical Workflow
1. **Exploration**: Check sample names and phenoData.
   ```r
   sampleNames(fhesc)
   pData(fhesc)
   ```
2. **Differential Expression**: Since this is a simple two-group comparison, it is often used with `limma` or `t.test` to identify genes associated with stem cell differentiation.
   ```r
   # Example using limma
   library(limma)
   design <- model.matrix(~ phenoData(fhesc)$description) # or appropriate column
   fit <- lmFit(fhesc, design)
   fit <- eBayes(fit)
   topTable(fit)
   ```

## Tips
- The dataset is relatively small (6 samples), making it ideal for demonstrating differential expression workflows or testing hgu133plus2 annotation scripts.
- Ensure `hgu133plus2.db` is installed if you need to map probe IDs to gene symbols.

## Reference documentation
- [humanStemCell Reference Manual](./references/reference_manual.md)