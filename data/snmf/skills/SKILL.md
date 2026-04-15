---
name: snmf
description: The snmf tool estimates individual admixture coefficients from large genomic datasets using sparse non-negative matrix factorization. Use when user asks to infer ancestry proportions, estimate admixture coefficients, or determine the optimal number of ancestral populations using cross-validation.
homepage: http://membres-timc.imag.fr/Olivier.Francois/snmf/index.htm
metadata:
  docker_image: "quay.io/biocontainers/snmf:1.2--1"
---

# snmf

## Overview
The `snmf` tool provides a high-performance framework for inferring individual admixture coefficients. It is designed to handle massive genomic datasets by utilizing sparse non-negative matrix factorization (sNMF) rather than traditional likelihood-based algorithms. This approach typically yields results 10 to 30 times faster than comparable tools like ADMIXTURE without sacrificing accuracy, making it ideal for modern population genomic workflows.

## Command Line Usage
The primary workflow involves estimating ancestry coefficients for a range of ancestral populations (K).

### Basic Execution
To run an analysis for a specific number of ancestral populations:
```bash
snmf -x <input_file.geno> -K <number_of_populations> -project <project_name.snmfProject>
```

### Common Parameters
- `-x <file>`: Input file in `.geno` format.
- `-K <int>`: The number of ancestral populations to test.
- `-n <int>`: Number of individuals (optional if specified in file).
- `-L <int>`: Number of loci (optional if specified in file).
- `-i <int>`: Maximum number of iterations (default is usually 200).
- `-a <float>`: Regularization parameter (alpha). Default is 10. Higher values lead to sparser results.
- `-s <int>`: Seed for random number generator.
- `-r <int>`: Number of repetitions for the same K (to check for convergence and stability).

### Cross-Validation for Choosing K
To determine the optimal number of ancestral populations, use the cross-entropy criterion:
```bash
snmf -x data.geno -K 1:10 -c
```
The `-c` flag calculates the cross-entropy criterion. The value of K that minimizes this criterion is generally considered the most supported by the data.

## Best Practices
- **Data Format**: Ensure input files are in the `.geno` format (0, 1, 2 for genotypes, 9 for missing data).
- **Multiple Runs**: Always perform multiple repetitions (e.g., `-r 10`) for each K to ensure the global minimum is reached and to assess the stability of the clusters.
- **Regularization**: If the results appear over-fitted or lack sparsity, experiment with the `-a` (alpha) parameter. A common starting point is 10, but values like 100 or 1000 can be used for high-density SNP data.
- **Comparison**: While `snmf` is faster than ADMIXTURE, it is good practice to validate the optimal K results with a subset of the data using likelihood-based methods if computational resources allow.

## Reference documentation
- [sNMF Webpage Overview](./references/membres-timc_imag_fr_Olivier.Francois_snmf_index.htm.md)
- [Bioconda Package Summary](./references/anaconda_org_channels_bioconda_packages_snmf_overview.md)