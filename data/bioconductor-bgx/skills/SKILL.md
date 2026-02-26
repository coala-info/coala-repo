---
name: bioconductor-bgx
description: This tool performs Bayesian hierarchical modeling for Affymetrix GeneChip data to estimate gene expression at the probe level. Use when user asks to estimate gene expression levels, perform Bayesian analysis on Affymetrix data, or quantify uncertainty in expression estimates using MCMC.
homepage: https://bioconductor.org/packages/release/bioc/html/bgx.html
---


# bioconductor-bgx

name: bioconductor-bgx
description: Bayesian Gene eXpression (BGX) analysis for Affymetrix GeneChip data. Use this skill to perform probe-level Bayesian hierarchical modeling, estimate gene expression levels, and account for uncertainty using MCMC.

# bioconductor-bgx

## Overview
The `bgx` package provides a Bayesian hierarchical model for estimating gene expression from Affymetrix GeneChip data. Unlike summary-based methods (e.g., RMA or MAS5), BGX operates at the probe level and uses Markov Chain Monte Carlo (MCMC) to provide full posterior distributions of expression levels. This allows researchers to quantify the uncertainty associated with expression estimates.

## Typical Workflow

1.  **Data Preparation**: Load your raw data into an `AffyBatch` object using the `affy` package.
2.  **Run BGX**: Execute the MCMC simulation. This step is computationally intensive and typically saves results to a temporary or specified directory.
3.  **Post-processing**: Read the MCMC samples back into R to calculate posterior means, variances, or to perform differential expression analysis.
4.  **Visualization**: Use built-in plotting functions to inspect gene-specific posterior distributions.

## Key Functions

### bgx()
The primary function for running the Bayesian analysis.
```r
# Basic usage
# 'data' must be an AffyBatch object
bgx.results <- bgx(data, 
                   burnin = 10000, 
                   iter = 10000, 
                   samp = 100, 
                   output = "outdir")
```
- `burnin`: Number of initial MCMC iterations to discard.
- `iter`: Number of iterations to run after burn-in.
- `samp`: Frequency of sampling (e.g., every 100th iteration).
- `output`: Directory where MCMC samples will be stored as binary files.

### readOutput.bgx()
Loads the saved MCMC samples from the output directory into R for analysis.
```r
posteriors <- readOutput.bgx("outdir")
```

### analysis.bgx()
A wrapper function that performs common post-processing tasks on the output of `bgx`.
```r
# Returns posterior means and other statistics
analysis.results <- analysis.bgx(posteriors)
```

### plotExpression()
Visualizes the posterior distribution of expression for a specific gene.
```r
plotExpression(posteriors, geneIndex = 1)
```

## Tips for Efficient Usage

- **Computational Demand**: BGX is significantly slower than RMA because it uses MCMC. For large datasets, consider running it on a high-performance computing cluster or subsetting your `AffyBatch` to specific genes of interest if a full-genome run is not feasible.
- **Memory Management**: The `bgx` function writes samples to disk to save RAM. Ensure you have sufficient disk space in your `output` directory.
- **Convergence**: Always check for MCMC convergence by inspecting the trace plots of the parameters if the results seem unexpected.
- **Integrated Analysis**: You can use the `interactWithBGX` function (if available in your version) for a graphical interface to explore the results.

## Reference documentation
None