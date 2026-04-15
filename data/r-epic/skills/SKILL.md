---
name: r-epic
description: r-epic estimates the proportions of immune, stromal, endothelial, and cancer cells from bulk gene expression data using the EPIC method. Use when user asks to perform cell type deconvolution on TPM or RPKM data, estimate the fraction of malignant cells without a reference profile, or account for varying mRNA content across cell types.
homepage: https://cran.r-project.org/web/packages/epic/index.html
---

# r-epic

name: r-epic
description: Estimate the proportion of immune, stromal, endothelial, and cancer cells from bulk gene expression data (RNA-seq) using the EPIC method. Use this skill when you need to perform cell type deconvolution on TPM or RPKM data, especially for tumor samples where "other cells" (cancer cells) need to be estimated without a specific reference profile.

## Overview
EPIC (Estimate the Proportion of Immune and Cancer cells) is an R package designed to deconvolve bulk gene expression data. Unlike many other methods, EPIC accounts for the fact that different cell types have different mRNA content per cell and can estimate the fraction of "other cells" (typically malignant cells) for which no reference profile is provided.

## Installation
```R
install.packages("devtools")
devtools::install_github("GfellerLab/EPIC", build_vignettes=TRUE)
```

## Core Workflow

### 1. Prepare Input Data
The input `bulk` must be a matrix of gene expression values (TPM or RPKM).
- Rows: Genes (Gene Symbols are recommended).
- Columns: Samples.

### 2. Basic Deconvolution
Run EPIC using the default reference (TRef), which includes B cells, CD4 T cells, CD8 T cells, Macrophages, NK cells, Endothelial cells, and CAFs.

```R
library(EPIC)
# bulk_data is a matrix of TPM values
result <- EPIC(bulk = bulk_data)
```

### 3. Accessing Results
The output is a list containing:
- `mRNAProportions`: The proportion of mRNA coming from each cell type.
- `cellFractions`: The estimated true proportion of cells (normalized for mRNA content). **Use this for biological interpretation.**
- `fit.gof`: Goodness of fit statistics, including convergence codes.

```R
# Get the cell fractions
cell_proportions <- result$cellFractions
```

### 4. Custom References
You can provide custom reference profiles and signature genes.
- `reference`: A list containing `refProfiles` (matrix of expression) and `sigGenes` (vector of genes to use).
- `mRNA_cell`: A vector of mRNA content per cell type if known.

```R
result <- EPIC(bulk = bulk_data, reference = my_custom_reference)
```

## Key Tips
- **Cell Fractions vs. mRNA Proportions**: Always prefer `cellFractions` for true cell abundance. Use `mRNAProportions` only when benchmarking against in-silico mixtures that didn't account for mRNA content differences.
- **Other Cells**: The "other cells" category in the output typically represents the cancer cell fraction in tumor samples.
- **Convergence Issues**: If you see a warning about optimization not converging, check `result$fit.gof$convergeCode`. A value of 0 is successful; 1 usually means the maximum iterations were reached.
- **Data Format**: Ensure the input is a `matrix`. If you pass a `data.frame` or `vector`, you may encounter "attempt to set 'colnames' on an object with less than two dimensions" errors.

## Reference documentation
- [EPIC Package Overview](./references/README.md)
- [EPIC R Markdown Documentation](./references/README.Rmd.md)
- [GitHub Articles and Resources](./references/articles.md)
- [EPIC Project Home Page](./references/home_page.md)