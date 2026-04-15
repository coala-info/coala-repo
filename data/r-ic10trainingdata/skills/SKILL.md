---
name: r-ic10trainingdata
description: This package provides training datasets and genomic annotations for the iC10 breast cancer classifier. Use when user asks to access training data for iC10 group prediction, train the pamr classifier for breast cancer samples, or load copy number and expression profiles for integrated classification.
homepage: https://cran.r-project.org/web/packages/ic10trainingdata/index.html
---

# r-ic10trainingdata

name: r-ic10trainingdata
description: Provides training datasets for the iC10 breast cancer classifier. Use this skill when working with the iC10 R package to perform integrated classification of breast cancer samples using copy number and/or gene expression data. It is essential for training the pamr classifier required for iC10 group prediction.

# r-ic10trainingdata

## Overview
The `ic10trainingdata` package contains the necessary training datasets for the `iC10` package. It implements the features and genomic annotations required for the classifier described in "Genome-driven integrated classification of breast cancer validated in over 7,500 samples" (Ali HR et al., 2014). The data includes copy number and expression profiles from breast cancer samples, with genomic annotations derived from the `IlluminaHumanv3.db` package.

## Installation
To install the package from CRAN:
```R
install.packages("ic10trainingdata")
```

## Usage
This package is primarily a data dependency for the `iC10` package. It is rarely used in isolation but must be loaded or available for the `iC10` classifier to function.

### Loading the Data
To explore the datasets provided by the package:
```R
library(ic10trainingdata)

# View available datasets
data(package = "ic10trainingdata")

# Common datasets included:
# - train.CN: Training copy number data
# - train.Exp: Training expression data
# - iC10.training: The combined training object for the classifier
```

### Workflow with iC10
The typical workflow involves using these datasets to initialize or train the iC10 classifier:
1. Load `ic10trainingdata` to make the training objects available.
2. Use the `iC10` package functions to map your features (Gene Symbols or Entrez IDs) to the training set.
3. Predict the iC10 clusters for new breast cancer samples.

## Tips
- **Dependency**: If you are using the `iC10` package, ensure `ic10trainingdata` is installed, as `iC10` depends on it for the underlying `pamr` classifier training.
- **Annotation**: The genomic annotations are based on Illumina Human v3. If your data uses different versions or platforms, ensure proper gene identifier mapping (e.g., using `biomaRt` or `org.Hs.eg.db`) before attempting classification.

## Reference documentation
- [iC10TrainingData Home Page](./references/home_page.md)