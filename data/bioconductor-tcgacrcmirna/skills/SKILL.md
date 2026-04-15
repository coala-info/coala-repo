---
name: bioconductor-tcgacrcmirna
description: This package provides miRNA expression profiles and clinical metadata for 450 TCGA colorectal cancer samples. Use when user asks to access TCGA colorectal cancer miRNA data, analyze miRNA expression levels, or retrieve sample metadata for CRC research.
homepage: https://bioconductor.org/packages/release/data/experiment/html/TCGAcrcmiRNA.html
---

# bioconductor-tcgacrcmirna

name: bioconductor-tcgacrcmirna
description: Access and analyze the TCGA colorectal cancer (CRC) miRNA expression dataset. Use this skill when a user needs to retrieve, inspect, or analyze miRNA profiles from the 450-sample TCGA CRC cohort (Level 3 data) for bioinformatics research.

# bioconductor-tcgacrcmirna

## Overview
The `TCGAcrcmiRNA` package is a Bioconductor data experiment package containing miRNA gene expression profiles for 450 primary colorectal cancer samples. The data originated from the TCGA consortium (Level 3) and was generated using HiSeq and GenomeAnalyzer platforms. The data is stored as a standard Bioconductor `ExpressionSet` object, which includes both the expression values and associated phenotypic/probe metadata.

## Loading the Dataset
To use the data, load the library and then use the `data()` function to bring the `TCGAmirna` object into the environment.

```r
library(TCGAcrcmiRNA)

# Load the ExpressionSet object
data(TCGAmirna)

# Inspect the object
TCGAmirna
```

## Working with the ExpressionSet
Since the data is stored as an `ExpressionSet`, use standard `Biobase` methods to interact with it:

- **Expression Data**: Access the miRNA expression matrix (probes vs. samples).
  ```r
  miRNA_matrix <- exprs(TCGAmirna)
  ```
- **Phenotypic Data**: Access sample metadata (e.g., clinical information).
  ```r
  sample_info <- pData(TCGAmirna)
  ```
- **Feature Data**: Access probe/miRNA information.
  ```r
  feature_info <- fData(TCGAmirna)
  ```

## Typical Workflow
1. **Initialization**: Load the package and the dataset.
2. **Exploration**: Check the dimensions and sample metadata to understand the cohort composition.
3. **Preprocessing**: Perform normalization or filtering if required (though TCGA Level 3 data is typically pre-processed).
4. **Analysis**: Use the data for differential expression analysis (e.g., using `limma`), survival analysis, or clustering.

## Tips
- The dataset contains 450 samples, making it suitable for statistically robust discovery and validation of miRNA signatures in colorectal cancer.
- Ensure the `Biobase` package is installed to utilize the accessor functions for the `ExpressionSet`.

## Reference documentation
- [TCGA CRC 450 dataset](./references/TcgaCrcVignette.md)