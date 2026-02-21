---
name: pcangsd
description: PCAngsd is a specialized framework designed to handle the uncertainty inherent in low-coverage sequencing data.
homepage: https://github.com/Rosemeis/pcangsd
---

# pcangsd

## Overview
PCAngsd is a specialized framework designed to handle the uncertainty inherent in low-coverage sequencing data. Unlike standard PCA tools that require hard-called genotypes, PCAngsd works with genotype likelihoods to infer population structure, estimate individual allele frequencies, and account for population stratification in downstream probabilistic analyses. It is particularly effective for heterogeneous populations where traditional methods might be biased by low depth or non-random missingness.

## Common CLI Patterns

### Basic Population Structure Analysis
To estimate a covariance matrix from genotype likelihoods:
```bash
pcangsd --beagle input.beagle.gz --threads 8 --out output_prefix
```

For PLINK binary files (requires .bed, .bim, and .fam with the same prefix):
```bash
pcangsd --plink input_prefix --threads 8 --out output_prefix
```

### Advanced Multi-Analysis Runs
You can combine multiple analyses in a single execution to save computation time:
```bash
pcangsd --beagle input.beagle.gz --eig 2 --admix --selection --inbreeding --threads 16 --out results
```
*   `--eig [int]`: Specifies the number of eigenvectors to use for the iterative model.
*   `--admix`: Estimates admixture proportions.
*   `--selection`: Performs a PC-based selection scan.
*   `--inbreeding`: Estimates per-sample and per-site inbreeding coefficients.

### Output File Reference
*   `.cov`: Covariance matrix (text format).
*   `.admix.K.Q`: Admixture proportions for K clusters.
*   `.admix.K.F`: Ancestral allele frequencies.
*   `.selection`: Selection statistics (can be converted to p-values using a chi-square distribution with 1 DF).
*   `.inbreed.samples`: Individual inbreeding coefficients.
*   `.inbreed.sites`: Site-specific inbreeding coefficients.

## Best Practices and Tips

### Input Preparation
*   **Genotype Likelihoods**: Use ANGSD to generate Beagle files from BAM files. This is the preferred input for low-depth data to maintain statistical uncertainty.
*   **Filtering**: Ensure your input data is filtered for Minor Allele Frequency (MAF) and high-quality sites before running PCAngsd to improve convergence and reduce noise.

### Computational Efficiency
*   **Threading**: Use the `--threads` flag to leverage multi-core systems, as the SVD and iterative frequency estimations are computationally intensive.
*   **Memory**: For very large datasets, ensure the system has sufficient RAM to hold the genotype likelihood matrix, or consider using the EMU software if only accelerated EM-PCA is required.

### Downstream Visualization
*   **PCA Plotting**: Read the `.cov` file into R or Python, perform an eigen-decomposition, and plot the first few eigenvectors.
*   **Selection Scans**: Selection statistics in the `.selection` file follow a Chi-squared distribution. In R, calculate p-values using `pchisq(D, 1, lower.tail = FALSE)`.

## Reference documentation
- [PCAngsd GitHub Repository](./references/github_com_Rosemeis_pcangsd.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_pcangsd_overview.md)