---
name: r-bayesprism
description: R package bayesprism (documentation from project home).
homepage: https://cran.r-project.org/web/packages/bayesprism/index.html
---

# r-bayesprism

name: r-bayesprism
description: Bayesian cell Proportion Reconstruction Inferred using Statistical Marginalization (BayesPrism). Use this skill to perform deconvolution of bulk RNA-seq data using scRNA-seq references to estimate cell type fractions and cell type-specific gene expression, particularly in tumor microenvironments.

# r-bayesprism

## Overview
BayesPrism is a fully Bayesian inference framework designed to deconvolve bulk RNA-seq samples. It jointly estimates the posterior distribution of cell type composition (fractions) and cell type-specific gene expression. It includes a deconvolution module for cell type fractions and an embedding learning module to model malignant gene programs using Expectation-Maximization (EM).

## Installation
```R
# Install dependencies
install.packages(c("snowfall", "NMF", "gplots", "devtools"))
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install(c("scran", "BiocParallel"))

# Install BayesPrism from GitHub
library(devtools)
install_github("Danko-Lab/BayesPrism/BayesPrism")
```

## Core Workflow

### 1. Data Preparation and QC
Use `cleanup.genes` to remove problematic genes (ribosomal, mitochondrial, sex-chromosome linked) and lowly expressed genes that may introduce batch effects.

```R
library(BayesPrism)

# Clean up reference and mixture
sc.dat.filtered <- cleanup.genes(input=sc.dat,
                                 input.type="count.matrix",
                                 species="hs", 
                                 gene.group=c("Rb","Mt","X","Y"),
                                 exp.cells=5)
```

### 2. Constructing the Prism Object
The `new.prism` function aligns the reference and bulk data, collapses cell states into cell types, and performs normalization.

```R
myPrism <- new.prism(reference=sc.dat.filtered, 
                     mixture=bulk.dat, 
                     input.type="count.matrix", 
                     cell.type.labels=cell.type.labels, 
                     cell.state.labels=cell.state.labels,
                     key="tumor") # 'key' specifies the malignant cell type
```

### 3. Running Deconvolution
The `run.prism` function executes the Bayesian inference.

```R
bp.res <- run.prism(prism=myPrism, n.cores=10)
```

### 4. Extracting Results
*   **Cell Type Fractions:** Use `get.fraction` to retrieve the updated posterior estimates ($\theta_f$).
*   **Cell Type Specific Expression:** Use `get.res` to extract the deconvolved expression profiles.

```R
# Get cell type fractions
theta <- get.fraction(bp.res, which.theta="final", state.or.type="type")

# Get coefficient of variation (uncertainty)
cv <- bp.res@posterior.theta_f@cv
```

## Best Practices and Tips
*   **Malignant Cells:** If malignant cells are unmatched between reference and bulk, ensure they are correctly labeled and use the `key` argument in `new.prism`.
*   **Missing Cell Types:** BayesPrism assumes a complete reference. If a cell type is missing, its fraction will be redistributed to transcriptionally similar types.
*   **Initial vs. Final Theta:** Use the updated $\theta_f$ (final) for most applications. Use $\theta_0$ (initial) only if tumor fraction is very low (<50%) or if there are no batch effects (e.g., flow-sorted references).
*   **Marker Genes:** While not required, subsetting on signature genes using `select.marker` can improve accuracy when batch effects are severe or cell types are highly similar.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)
- [tutorial_deconvolution.html.md](./references/tutorial_deconvolution.html.md)
- [tutorial_embedding_learning.html.md](./references/tutorial_embedding_learning.html.md)