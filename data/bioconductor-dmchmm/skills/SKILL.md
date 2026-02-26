---
name: bioconductor-dmchmm
description: This tool identifies differentially methylated CpG sites in bisulfite sequencing data using Hidden Markov Models. Use when user asks to import Bismark files, simulate methylation data, predict methylation levels using EM or MCMC algorithms, or perform statistical testing for differentially methylated sites.
homepage: https://bioconductor.org/packages/release/bioc/html/DMCHMM.html
---


# bioconductor-dmchmm

name: bioconductor-dmchmm
description: Use this skill to identify Differentially Methylated CpG (DMC) sites in bisulfite sequencing (BS-Seq) data using Hidden Markov Models (HMM). This skill covers data importing (Bismark format), data simulation, methylation level prediction using EM or MCMC algorithms, and statistical testing for DMCs.

# bioconductor-dmchmm

## Overview

The `DMCHMM` package provides a framework for analyzing DNA methylation patterns from bisulfite sequencing (BS-Seq) data. It utilizes Hidden Markov Models (HMM) to smooth methylation levels and identify differentially methylated CpG sites. The package is particularly useful for handling the inherent noise in NGS methylation data by leveraging spatial correlations between CpG sites.

## Core Workflow

### 1. Data Representation and Loading
The package uses the `BSData` class (extending `SummarizedExperiment`).

*   **Importing Bismark files**: Use `readBismark()` to load raw data.
    ```r
    library(DMCHMM)
    # fn.f is a vector of full paths to Bismark files
    # fn is a vector of sample names
    OBJ <- readBismark(fn.f, fn, mc.cores = 2)
    
    # Add sample metadata
    colData(OBJ) <- DataFrame(Group = factor(c("G1", "G1", "G2", "G2")), 
                              row.names = colnames(OBJ))
    ```
*   **Manual Creation**: Use `cBSData()` if you already have count matrices.
    ```r
    OBJ <- cBSData(rowRanges = my_granges, 
                   methReads = my_meth_matrix, 
                   totalReads = my_total_matrix, 
                   colData = my_metadata)
    ```

### 2. Predicting Methylation Levels (Smoothing)
Before testing for DMCs, the data must be smoothed using HMM. There are two primary algorithms:

*   **EM Algorithm (Fast)**: Recommended for initial analysis or finding the optimal HMM order.
    ```r
    # MaxK is the maximum number of hidden states
    OBJ_EM <- methHMEM(OBJ, MaxK = 2)
    ```
*   **MCMC Algorithm (Accurate)**: More robust but slower. It is best practice to run EM first to determine the HMM order, then pass that object to MCMC.
    ```r
    OBJ_MCMC <- methHMMCMC(OBJ_EM)
    ```

### 3. Identifying DMCs
Once smoothed, use `findDMCs()` to perform statistical testing.

*   **Basic Comparison**: Compares groups defined in `colData`.
    ```r
    OBJ_FINAL <- findDMCs(OBJ_MCMC)
    ```
*   **Complex Models**: Use the `formula` argument for covariates.
    ```r
    OBJ_FINAL <- findDMCs(OBJ_MCMC, formula = ~ Group + Age)
    ```

### 4. Extracting Results
Results are stored in the metadata slot of the returned `BSDMCs` object.

```r
results <- metadata(OBJ_FINAL)$DMCHMM
head(results)
# Columns include: pvalues, qvalues, DMCs (binary indicator), and methylation direction
```

## Tips and Best Practices

*   **Parallelization**: `readBismark` supports `mc.cores` for faster loading on Linux/macOS.
*   **HMM Order**: If you are unsure of the number of hidden states, `methHMEM` with a `MaxK` value (e.g., 2 or 3) will help identify the best fit for each sample.
*   **Memory Management**: BS-Seq data can be large. Ensure your `rowRanges` (CpG sites) are filtered to relevant chromosomes or regions if memory is limited.
*   **Data Simulation**: Use `cBSData` with random matrices to test your pipeline logic before applying it to large experimental datasets.

## Reference documentation

- [DMCHMM: Differentially Methylated CpG using Hidden Markov Model](./references/DMCHMM.Rmd)
- [DMCHMM Vignette (Markdown)](./references/DMCHMM.md)