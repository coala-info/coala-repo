---
name: structure
description: The `structure` skill provides a framework for applying Bayesian clustering algorithms to genetic data.
homepage: https://web.stanford.edu/group/pritchardlab/structure.html
---

# structure

## Overview
The `structure` skill provides a framework for applying Bayesian clustering algorithms to genetic data. It helps determine the most likely number of populations (K) in a dataset and quantifies the ancestral proportions of individuals. This skill is essential for evolutionary biology, conservation genetics, and association mapping where population stratification must be accounted for.

## CLI Usage and Best Practices

### Basic Command Structure
The command-line version of structure is typically invoked using:
```bash
structure -m mainparams -e extraparams -i input_file -o output_file
```

### Parameter Configuration
Structure relies on two text files for configuration. Do not attempt to pass all variables via CLI; use these files for reproducibility:

1.  **mainparams**: Defines the core run parameters.
    - `MAXPOPS (K)`: The number of clusters to test.
    - `BURNIN`: Number of iterations to discard (typically 10,000–100,000).
    - `NUMREPS`: Number of MCMC iterations after burn-in (typically 100,000–1,000,000).
    - `NUMINDS`: Number of individuals in the data file.
    - `NUMLOCI`: Number of loci in the data file.

2.  **extraparams**: Defines the model logic.
    - `NOADMIX`: Set to 0 for the Admixture model (default for most natural populations).
    - `FREQSCORR`: Set to 1 to allow correlated allele frequencies (improves clustering of closely related populations).
    - `LOCPRIOR`: Set to 1 if using sampling locations as a prior to assist clustering at low divergence.

### Input Data Format
- Ensure the input file is a white-space delimited text file.
- Each individual usually occupies two rows (for diploid data).
- Missing data should be represented by a consistent integer (e.g., -9).
- Columns should follow this order: Individual ID, (Optional) Pop ID, (Optional) Info, Genotype Data.

### Expert Tips for Convergence
- **Run Replicates**: Always run multiple independent simulations (e.g., 5-10 iterations) for each value of K to ensure the MCMC chain has converged and results are consistent.
- **Assess K**: Use the "Evanno Method" (Delta K) or the log probability of data [LnP(D)] to determine the optimal number of populations.
- **Large Datasets**: For genome-wide SNP data where `structure` may be computationally prohibitive, consider using `fastSTRUCTURE` as an alternative.

## Reference documentation
- [Structure Software Overview](./references/web_stanford_edu_group_pritchardlab_structure.html.md)
- [Bioconda Structure Package](./references/anaconda_org_channels_bioconda_packages_structure_overview.md)