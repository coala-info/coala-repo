---
name: r-msqrob
description: This tool performs robust statistical inference for quantitative LC-MS proteomics using peptide-level models to handle unbalanced designs and outliers. Use when user asks to perform protein-level inference from label-free proteomics data, conduct differential expression analysis, or visualize protein expression and volcano plots.
homepage: https://cran.r-project.org/web/packages/msqrob/index.html
---

# r-msqrob

name: r-msqrob
description: Robust statistical inference for quantitative LC-MS proteomics using peptide-level models. Use this skill to perform protein-level inference from label-free proteomics data, handle unbalanced designs, and apply robust ridge regression or empirical Bayes variance estimation.

## Overview
The `msqrob` package provides a robust framework for quantitative protein-level statistical inference in LC-MS proteomics. Unlike methods that summarize peptides to proteins first, `msqrob` uses peptide-level input data to correct for unbalancedness and peptide-specific biases. It employs ridge regression to stabilize model estimates and downweighs outliers to improve sensitivity and specificity.

## Installation
To install the `msqrob` package from GitHub:

```R
if (!requireNamespace("devtools", quietly = TRUE))
    install.packages("devtools")
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install()
devtools::install_github("statOmics/MSqRob@MSqRob0.7.7")
library(MSqRob)
```

## Workflow
The standard workflow involves preprocessing peptide intensities, converting them to an `MSnSet` object, and performing differential expression analysis.

### 1. Data Import and Preprocessing
`msqrob` typically works with peptide-level output from MaxQuant (`peptides.txt`), moFF, mzTab, or Progenesis.

```R
# Load data (example using MaxQuant peptides.txt)
peptides <- read.table("peptides.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)

# Preprocess: log transform and normalize
# msqrob integrates with MSnbase for data management
library(MSnbase)
# Convert to MSnSet and perform normalization (e.g., median centering)
```

### 2. Statistical Inference
The core of the package is the robust linear model applied at the peptide level.

```R
# Define the experimental design
# annotation: a data frame mapping samples to conditions
# formula: e.g., ~ condition

# Fit the model
models <- msqrob(msnset, formula = ~condition)

# Test contrasts
results <- testProts(models, contrasts = makeContrasts(conditionGroupB - conditionGroupA, levels = design))
```

### 3. Visualization
The package provides tools to visualize results and diagnostic plots.

```R
# Volcano plot
plotVolcano(results)

# Plot individual protein expressions
plotProtein(msnset, proteinID = "MY_PROTEIN_ID", models = models)
```

## Tips for Success
- **Peptide-level Input**: Always provide peptide-level intensities rather than pre-summarized protein values to leverage the package's robust modeling.
- **Experimental Annotation**: Ensure your annotation file (Excel or CSV) correctly maps the column names of your intensity data to the experimental factors.
- **Missing Values**: For experiments with high missingness, consider the "hurdle" method extensions mentioned in the documentation.
- **Legacy Note**: While `msqrob` is functional, the developers recommend `msqrob2` (available on Bioconductor) for newer projects as it is the maintained successor.

## Reference documentation
- [CHANGELOG.md](./references/CHANGELOG.md)
- [Install-Rtools-for-Windows.md](./references/Install-Rtools-for-Windows.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)