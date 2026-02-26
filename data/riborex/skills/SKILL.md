---
name: riborex
description: Riborex is an R package that detects differential translation by comparing Ribo-seq and RNA-seq data using statistical frameworks like DESeq2 and edgeR. Use when user asks to identify changes in translation efficiency, analyze ribosome profiling data, or find genes where protein synthesis rates change independently of mRNA levels.
homepage: https://github.com/smithlabcode/riborex
---


# riborex

## Overview

Riborex is a specialized R package designed to detect differential translation by comparing Ribo-seq (ribosome profiling) data with corresponding RNA-seq data. It leverages established statistical frameworks like DESeq2 and edgeR to provide a robust analysis of translation efficiency, allowing users to distinguish between changes in transcript abundance and changes in actual protein synthesis rates. This tool is particularly useful for identifying genes where the translation rate changes independently of mRNA levels.

## Usage and Best Practices

### Installation
The recommended way to install Riborex is via Bioconda to ensure all dependencies (DESeq2, edgeR, fdrtool) are correctly managed.

```bash
conda install -c bioconda r-riborex
```

Alternatively, for the latest development version within R:
```R
devtools::install_github('smithlabcode/riborex')
```

### Data Preparation
Riborex requires two main inputs: an RNA-seq count table and a Ribo-seq count table.
- **Column Naming**: If your RNA and Ribo samples share the same names, append `.rna` and `.ribo` to the respective column names to avoid conflicts. Riborex often handles this internally, but explicit naming ensures clarity.
- **Filtering**: Filter out low-count genes before running the analysis to improve statistical power and reduce the false discovery rate.

### Core Workflow
The primary function is `riborex()`. It typically requires:
1. `rnacnt`: The RNA-seq count matrix.
2. `ribocnt`: The Ribo-seq count matrix.
3. `rnaCond`: A vector defining the conditions for RNA samples.
4. `riboCond`: A vector defining the conditions for Ribo samples.

### Engine Selection
Riborex is flexible and can use different underlying statistical "engines." You can specify the engine based on your preference or existing pipeline:
- **DESeq2**: Often the default; robust for small sample sizes.
- **edgeR**: Efficient for larger datasets or specific GLM requirements.

### Correcting Null Distributions
In cases where the p-value distribution is skewed (often due to systematic biases in Ribo-seq data), use the `correctNullDistribution` function. This re-estimates p-values to ensure the empirical null distribution is properly modeled, which is critical for accurate FDR calculations.

### Expert Tips
- **Paired Samples**: When working with paired RNA/Ribo samples from the same biological source, ensure your experimental design formula accounts for the pairing to increase sensitivity.
- **Vignettes**: For detailed parameter tuning and complex experimental designs, refer to the package vignettes (`vignettes/riborex.pdf`) which contain comprehensive walkthroughs of the statistical models.

## Reference documentation
- [Riborex Overview](./references/anaconda_org_channels_bioconda_packages_riborex_overview.md)
- [Riborex GitHub Repository](./references/github_com_smithlabcode_riborex.md)