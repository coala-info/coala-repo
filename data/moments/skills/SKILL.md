---
name: moments
description: The moments library infers demographic histories and patterns of natural selection by analyzing allele frequency distributions and linkage disequilibrium statistics. Use when user asks to model population demographic events, calculate site frequency spectra, or perform likelihood-based optimization of genetic parameters.
homepage: https://bitbucket.org/simon-gravel/moments
---


# moments

## Overview
The `moments` library is a powerful tool for population geneticists to infer demographic histories and patterns of natural selection. It extends the diffusion approximation framework (originally popularized by dadi) by using a moment-closure approximation to solve the partial differential equations governing allele frequency distributions. This approach allows for significantly faster computation of the SFS and enables the joint analysis of SFS and LD statistics, which provides higher resolution for detecting recent demographic events and multi-population interactions.

## Usage Patterns and Best Practices

### Core Workflow
1.  **Data Preparation**: Convert genomic data (VCF/BCF) into an SFS (Site Frequency Spectrum) or LD (Linkage Disequilibrium) statistics.
2.  **Model Definition**: Define a demographic model (e.g., bottleneck, split, migration) as a Python function.
3.  **Optimization**: Use likelihood-based optimization to find parameters that best fit the observed data.
4.  **Model Comparison**: Use Likelihood Ratio Tests (LRT) or AIC to compare competing demographic hypotheses.

### Working with the Site Frequency Spectrum (SFS)
*   **Initialization**: Load data into a `Spectrum` object.
    ```python
    import moments
    # Load from a file
    fs = moments.Spectrum.from_file("data.sfs")
    ```
*   **Projection**: If your data has missing genotypes, project the SFS down to a smaller sample size to maximize the number of usable sites.
    ```python
    projected_fs = fs.project([20, 20])
    ```
*   **Folding**: If the ancestral state is unknown, fold the SFS.
    ```python
    folded_fs = fs.fold()
    ```

### Linkage Disequilibrium (LD) Analysis
*   `moments.LD` allows for inference using two-locus statistics. This is particularly useful when the SFS lacks power, such as in very recent time scales.
*   Use `moments.LD.Parsing` to compute LD statistics directly from VCF files.

### Optimization Tips
*   **Multiple Restarts**: Likelihood surfaces in demographic inference are often rugged. Always run optimizations from multiple random starting points to ensure convergence to the global maximum.
*   **Parameter Scaling**: Ensure parameters (like $N_e$ or migration rates) are appropriately scaled. `moments` typically uses a reference $N_e$ to scale time in units of $2N_e$ generations.
*   **Masking**: Mask the fixed bins (0 and $2n$) in the SFS if you are only interested in segregating sites or if the data quality at fixed sites is unreliable.

### Integration with dadi
*   `moments` is designed to be a near drop-in replacement for `dadi`. Most `dadi` model functions can be used with `moments` by simply changing the engine call, often resulting in significant speedups for models with more than three populations.

## Reference documentation
- [bioconda moments overview](./references/anaconda_org_channels_bioconda_packages_moments_overview.md)