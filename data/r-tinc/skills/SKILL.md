---
name: r-tinc
description: R package tinc (documentation from project home).
homepage: https://cran.r-project.org/web/packages/tinc/index.html
---

# r-tinc

name: r-tinc
description: Assessment of tumour-in-normal (TIN) contamination and tumour purity (TIT) for matched tumour-normal sequencing assays. Use this skill when you need to estimate the proportion of cancer cells in a normal sample to flag potential false negatives in somatic mutation calling or to determine if a sample is better suited for tumour-only pipelines.

# r-tinc

## Overview
The `tinc` package implements evolutionary theory-based methods to assess Tumour-in-Normal (TIN) contamination and Tumour-in-Tumour (TIT) purity using read count data from Whole-Genome Sequencing (WGS). It helps bioinformaticians identify cases where somatic mutation callers might fail due to the presence of tumour DNA in the matched normal sample.

## Installation
To install the package from CRAN:
```R
install.packages("tinc")
```
To install the development version from GitHub:
```R
# install.packages("devtools")
devtools::install_github("caravagnalab/TINC")
```

## Core Workflow
The primary entry point for the package is the `autofit` function, which automates the estimation of TIN and TIT.

### 1. Data Preparation
You need somatic mutations (VAFs) and copy number data.
- **Mutations**: A dataframe with chromosome, position, and read counts (ref/alt) for both tumour and normal.
- **CNA**: Copy number segments for the tumour sample.

### 2. Running the Assessment
```R
library(tinc)

# Run the automated fit
fit = autofit(
  input = mutations_dataframe,
  cna = cna_dataframe,
  reference = "GRCh38" # or "GRCh37"
)

# Print summary results
print(fit)
```

### 3. Interpreting Results
The fit object contains the estimated contamination levels:
- **TIN**: Tumour-in-Normal score (0 to 1). High TIN (> 0.05) suggests significant contamination.
- **TIT**: Tumour-in-Tumour score (purity).
- **Status**: Samples are often flagged as "Keep" or "Filter" based on the reliability of somatic calls in the presence of the detected TIN.

## Visualization
`tinc` provides built-in plotting functions to inspect the VAF distributions and the quality of the fit:
```R
# Plot the TIN/TIT analysis
plot(fit)
```

## Tips for Success
- **Somatic Mutations**: Ensure you provide a high-quality set of candidate somatic mutations. TINC uses the distribution of these mutations in the normal sample to estimate contamination.
- **Clonality**: The method is most robust when using clonal mutations.
- **Flagging**: If TINC reports high TIN, consider using a tumour-only calling strategy or a caller specifically designed for contaminated normals.

## Reference documentation
- [NEWS.md](./references/NEWS.md)
- [README.Rmd.md](./references/README.Rmd.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)