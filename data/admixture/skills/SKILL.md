---
name: admixture
description: Admixture estimates individual ancestry coefficients from large-scale SNP datasets using a maximum likelihood approach. Use when user asks to estimate ancestry proportions, determine the optimal number of ancestral populations through cross-validation, or perform supervised ancestry analysis.
homepage: http://www.genetics.ucla.edu/software/admixture/index.html
metadata:
  docker_image: "quay.io/biocontainers/admixture:1.3.0--0"
---

# admixture

## Overview
The `admixture` tool provides a fast and efficient way to estimate individual ancestry coefficients. It is designed to handle large SNP datasets by using a block-relaxation algorithm to find maximum likelihood estimates. This skill assists in preparing input files, selecting the number of ancestral populations (K), and interpreting the resulting ancestry components.

## CLI Usage Patterns

### Basic Execution
Admixture typically takes PLINK binary files (.bed) as input. The basic syntax requires the input file and the target number of populations (K).
```bash
admixture input_file.bed K
```

### Cross-Validation (CV)
To determine the most likely value of K, use the cross-validation flag. A lower CV error generally indicates a more accurate K.
```bash
admixture --cv input_file.bed K
```
*Tip: Run multiple values of K (e.g., 2 through 10) and compare the CV errors reported in the output.*

### Multithreading
Accelerate analysis on large datasets by specifying the number of available CPU cores.
```bash
admixture -j4 input_file.bed K
```

### Supervised Learning
If you have individuals with known ancestry, you can perform supervised analysis by providing a `.pop` file (a single column file with population labels or '-' for unknown).
```bash
admixture --supervised input_file.bed K
```

## Best Practices
- **Input Preparation**: Ensure input files are in PLINK binary format (.bed, .bim, .fam). All three files must be in the same directory with the same prefix.
- **LD Pruning**: Admixture assumes SNPs are in linkage equilibrium. It is highly recommended to prune your data for Linkage Disequilibrium (LD) using PLINK (e.g., `--indep-pairwise 50 10 0.1`) before running admixture to avoid biased results.
- **Convergence**: Check the log output to ensure the algorithm converged. If it fails to converge, you may need to increase the termination criterion or check for data quality issues.
- **Output Files**:
    - `.Q`: Contains the ancestry fractions for each individual.
    - `.P`: Contains the allele frequencies for each ancestral population.

## Reference documentation
- [Admixture Overview](./references/anaconda_org_channels_bioconda_packages_admixture_overview.md)