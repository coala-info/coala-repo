---
name: bioconductor-mulder2012
description: This tool analyzes functional gene interactions and identifies modules in RNAi screening data using Posterior Association Networks. Use when user asks to reproduce results from Mulder et al. (2012) or Arora et al. (2010), preprocess RNAi screen data, fit beta-mixture models to gene associations, or search for functional modules in epigenetic and kinase networks.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/Mulder2012.html
---


# bioconductor-mulder2012

name: bioconductor-mulder2012
description: Analysis of functional interactions and epigenetic strategies in epidermal differentiation and Ewing's sarcoma using Posterior Association Networks (PANs). Use this skill to reproduce results from Mulder et al. (2012) and Arora et al. (2010), including data preprocessing of RNAi screens, beta-mixture modeling of gene associations, and functional module searching.

## Overview
The `Mulder2012` package is an experiment data package that provides the datasets and analysis pipelines for two major studies using Posterior Association Networks (PANs). It allows users to infer functional associations between genes (such as chromatin factors or kinases) based on high-throughput RNAi screening data. The package relies heavily on the `PANR` package for the underlying statistical modeling and `RedeR` for network visualization.

## Core Workflows

### Application I: Epidermal Stem Cell Differentiation
This workflow analyzes 332 chromatin factors across five conditions to predict functional interactions.

1.  **Data Loading and Preprocessing**:
    ```r
    library(Mulder2012)
    library(PANR)
    data(Mulder2012.rawScreenData)
    data(Mulder2012.rawScreenAnnotation)
    # Normalize and compute Z-scores
    Mulder2012 <- Mulder2012.RNAiPre(rawScreenData, rawScreenAnnotation)
    ```

2.  **Beta-Mixture Modeling**:
    Quantify associations (cosine similarities) by fitting a three-component model (positive, negative, and lack of association).
    ```r
    bm <- new("BetaMixture", pheno=Mulder2012, metric="cosine", model="global")
    # Fit NULL distribution via permutation
    bm <- fitNULL(bm, nPerm=100)
    # Fit the mixture model using EM algorithm
    bm <- fitBM(bm)
    ```

3.  **Incorporating Prior Knowledge (PPI)**:
    Improve predictions by stratifying gene pairs based on known Protein-Protein Interactions.
    ```r
    PPI <- Mulder2012.PPIPre()
    bm_ext <- new("BetaMixture", pheno=Mulder2012, model="stratified")
    # ... follow fitNULL and fitBM steps for stratified model ...
    ```

4.  **Network Inference and Module Searching**:
    ```r
    pan <- new("PAN", bm1=bm_ext)
    pan <- infer(pan, para=list(type="SNR", log=TRUE, cutoff=log(10)))
    # Search for modules using bootstrap resampling (requires pvclust)
    pan <- pvclustModule(pan, nboot=10000)
    ```

### Application II: Ewing's Sarcoma Kinase Screens
This workflow identifies kinase modules critical for cancer cell growth across four cell lines.

1.  **Load Data**:
    ```r
    data(Arora2010)
    ```
2.  **Pipeline Execution**:
    Use the high-level pipeline to reproduce the entire analysis:
    ```r
    Arora2010.pipeline(nboot=10000)
    ```

## Key Functions and Data
- `Mulder2012.RNAiPre()`: Specific preprocessing for the TG1/DRAQ5 screening data.
- `Mulder2012.PPIenrich()`: Performs GSEA to test if PPIs are enriched in high-posterior association scores.
- `Mulder2012.module.visualize()`: Helper for rendering inferred modules in `RedeR`.
- `Arora2010.hypergeo()`: Performs hypergeometric tests for KEGG pathway enrichment on identified modules.
- `Mulder2012.fig()` and `Arora.fig()`: Functions to reproduce specific figures from the original publications.

## Tips and Troubleshooting
- **Version Requirement**: The package was designed for R 2.14/3.5 contexts; ensure dependencies like `PANR`, `RedeR`, and `pvclust` are installed.
- **Parallel Computing**: Module searching is computationally expensive. Use the `snow` package to initialize a cluster before running `pvclustModule`.
- **Customizing pvclust**: To use the specific "second-order" clustering required by PANs, the package provides `dist.pvclust4PAN` and `parPvclust4PAN` to override standard `pvclust` functions.
- **Visualization**: Network visualization requires an active `RedeR` session (`calld(rdp)`).

## Reference documentation
- [Mulder2012: Diverse epigenetic strategies interact to control epidermal differentiation](./references/Mulder2012-Vignette.md)