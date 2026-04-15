---
name: bioconductor-msqrob2
description: bioconductor-msqrob2 provides a robust statistical framework for the analysis of label-free quantitative proteomics data. Use when user asks to analyze LFQ proteomics data, perform robust protein summarization, or conduct differential abundance testing using ridge regression.
homepage: https://bioconductor.org/packages/release/bioc/html/msqrob2.html
---

# bioconductor-msqrob2

## Overview

`msqrob2` is a Bioconductor package designed for the analysis of label-free quantitative (LFQ) proteomics data. It addresses common challenges in proteomics, such as peptide-specific effects and context-sensitive missingness. The package provides a robust statistical framework that can either perform inference directly on peptide intensities or use a two-stage summarization strategy. The latter is generally preferred for its computational efficiency and ability to provide protein-level summaries for visualization.

## Typical Workflow

### 1. Data Import and Initialization
Data is typically managed using the `QFeatures` infrastructure. For MaxQuant output, identify the intensity columns and import the `peptides.txt` file.

```r
library(QFeatures)
library(msqrob2)

# Import MaxQuant peptide data
peptides <- read.delim("peptides.txt")
ecols <- grep("Intensity\\.", colnames(peptides))
pe <- readQFeatures(assayData = peptides, fnames = "Sequence", 
                    quantCols = ecols, name = "peptideRaw", sep = "\t")

# Convert 0 to NA for missing values
pe <- zeroIsNA(pe, "peptideRaw")
```

### 2. Preprocessing
Standard preprocessing includes log transformation, filtering, and normalization.

```r
# Log transform
pe <- logTransform(pe, base = 2, i = "peptideRaw", name = "peptideLog")

# Filter for unique proteins and remove decoys/contaminants
pe <- pe[rowData(pe[["peptideLog"]])$Proteins %in% smallestUniqueGroups(rowData(pe[["peptideLog"]])$Proteins), , ]
pe <- filterFeatures(pe, ~ Reverse != "+")
pe <- filterFeatures(pe, ~ Potential.contaminant != "+")

# Filter for peptides observed in at least 2 samples
rowData(pe[["peptideLog"]])$nNonZero <- rowSums(assay(pe[["peptideLog"]]) > 0, na.rm = TRUE)
pe <- filterFeatures(pe, ~ nNonZero >= 2)

# Median centering normalization
pe <- normalize(pe, i = "peptideLog", name = "peptideNorm", method = "center.median")
```

### 3. Robust Summarization
Aggregate peptide-level data to protein-level data using robust summarization, which accounts for peptide-specific effects.

```r
pe <- aggregateFeatures(pe, i = "peptideNorm", fcol = "Proteins", 
                        na.rm = TRUE, name = "protein")
```

### 4. Statistical Analysis
Model the protein expression using `msqrob` and perform hypothesis testing with contrasts.

```r
# Model estimation (e.g., comparing conditions)
pe <- msqrob(object = pe, i = "protein", formula = ~condition)

# Define contrast and test (e.g., Condition B vs Condition A)
L <- makeContrast("conditionB = 0", parameterNames = c("conditionB"))
pe <- hypothesisTest(object = pe, i = "protein", contrast = L)
```

### 5. Advanced: Ridge Regression
For complex designs with multiple conditions, robust ridge regression can improve performance.

```r
# Note: For 2-group designs, drop the intercept to use ridge
pe <- msqrob(object = pe, i = "protein", formula = ~ -1 + condition, 
             modelColumnName = "ridge", ridge = TRUE)

L_ridge <- makeContrast("ridgeconditionB - ridgeconditionA = 0", 
                        c("ridgeconditionB", "ridgeconditionA"))
pe <- hypothesisTest(object = pe, i = "protein", contrast = L_ridge, modelColumn = "ridge")
```

## Tips and Interpretation
- **Missing Values**: `msqrob2` handles missing values naturally through its robust modeling. Do not impute data unless specifically required for a specific visualization.
- **Parameter Names**: Use `getCoef(rowData(pe[["protein"]])$msqrobModels[[1]])` to check the exact names of the model parameters before constructing contrasts.
- **Visualization**: Significant results can be extracted from `rowData(pe[["protein"]])$contrastName`. Use standard `ggplot2` for volcano plots or `heatmap()` for expression profiles of significant proteins.
- **Peptide vs Protein**: While peptide-based workflows are available, the summarization-based workflow (using `aggregateFeatures` followed by `msqrob`) is the recommended default for most users.

## Reference documentation
- [Introduction to proteomics data analysis (Rmd)](./references/cptac.Rmd)
- [Introduction to proteomics data analysis (Markdown)](./references/cptac.md)