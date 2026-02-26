---
name: phylobayes-mpi
description: Phylobayes-MPI is a Bayesian MCMC sampler that performs phylogenetic reconstruction using site-heterogeneous models on large protein alignments. Use when user asks to perform phylogenetic reconstruction, run Bayesian MCMC sampling with CAT models, or estimate marginal likelihoods using MPI parallelization.
homepage: https://github.com/bayesiancook/pbmpi
---


# phylobayes-mpi

## Overview
Phylobayes-MPI is a specialized Bayesian MCMC sampler designed for phylogenetic reconstruction under complex, site-heterogeneous models. It is particularly effective for analyzing large protein alignments where standard site-homogeneous models (like GTR) may fail due to long-branch attraction. By utilizing the Message Passing Interface (MPI), it distributes the computational load of site-specific likelihood calculations across multiple processors, enabling the use of Dirichlet Process mixture models (CAT) on phylogenomic-scale data.

## Core Command Line Usage

### Starting a New Chain
The primary executable is `pb_mpi`. It must be launched via `mpirun` or `mpiexec`. You must allocate at least two processes: one master process and at least one slave process.

```bash
# Basic run using the CAT-GTR model on a protein alignment
mpirun -np 16 pb_mpi -d alignment.phy -cat -gtr chain_name

# Using the CAT-Poisson model (faster than CAT-GTR)
mpirun -np 8 pb_mpi -d alignment.phy -cat -poisson chain_name
```

### Common Model Options
*   `-cat`: Activates the Dirichlet Process mixture for site-specific amino-acid profiles.
*   `-gtr`: Uses a General Time Reversible exchangeability matrix.
*   `-poisson`: Uses a Poisson (F81-like) exchangeability matrix.
*   `-d <file>`: Specifies the input dataset (typically Phylip format).
*   `-T <treefile>`: Fixes the topology to a specific tree, sampling only model parameters.
*   `-mutsel`: Invokes the mutation-selection framework for codon-based models.

### Advanced Model Fit and Comparison
Phylobayes-MPI includes specific flags for assessing model fit and calculating marginal likelihoods:

*   **Cross-Validation**: Use `-sitecv` or `-jointcv` for site-wise or joint cross-validation.
*   **Information Criteria**: Use `-loocv_waic` to calculate the Widely Applicable Information Criterion via Leave-One-Out Cross-Validation.
*   **Marginal Likelihood**: Use Sequential Importance Sampling (SIS) for model comparison:
    *   `-sis`: Standard SIS.
    *   `-self_tuned_sis`: Automatically tuned SIS for marginal likelihood estimation.
    *   `-emp_ref`: Uses an empirical reference for SIS.

### Priors and Constraints
*   `-uniformbaseprior`: Sets a uniform prior on the base frequencies of the mixture components.
*   `-rigidbaseprior`: Sets a more constrained prior on base frequencies.
*   `-v`: Verbose output; writes posterior samples of relative rates to file.

## Post-Analysis and Convergence
After running multiple chains (e.g., `chain1`, `chain2`), use the auxiliary tools to check for convergence:

1.  **tracecomp**: Checks for convergence of continuous parameters (burn-in and thinning should be applied).
    ```bash
    tracecomp -x 100 chain1 chain2
    ```
2.  **bpcomp**: Compares the consensus trees and calculates the maximum difference (maxdiff) between bipartitions.
    ```bash
    bpcomp -x 100 1 chain1 chain2
    ```

## Expert Tips
*   **Process Allocation**: For optimal performance, ensure the number of MPI processes minus one is a divisor of the number of sites in your alignment, or simply provide enough slaves to handle the site-likelihood distribution.
*   **Chain Monitoring**: Monitor the `.trace` file to ensure the log-likelihood has stabilized before assuming convergence.
*   **Memory Management**: If the program hangs or crashes with "corrupted size" errors during `-mutsel` runs, check for memory limits on your HPC cluster or reduce the number of mixture components if possible.
*   **Restarting**: To resume a crashed or stopped chain, simply run the exact same command again with the same chain name; the program will detect the existing `.param` file and resume.

## Reference documentation
- [Phylobayes-MPI Overview](./references/anaconda_org_channels_bioconda_packages_phylobayes-mpi_overview.md)
- [GitHub Repository and Commit History](./references/github_com_bayesiancook_pbmpi_commits_master.md)
- [Issue Tracker for Troubleshooting](./references/github_com_bayesiancook_pbmpi_issues.md)