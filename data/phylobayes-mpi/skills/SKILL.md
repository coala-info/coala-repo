---
name: phylobayes-mpi
description: PhyloBayes-MPI is a Bayesian MCMC sampler used for phylogenetic inference under site-heterogeneous models. Use when user asks to perform phylogenetic reconstruction, run CAT-GTR models, assess MCMC convergence, or compare model fit using cross-validation.
homepage: https://github.com/bayesiancook/pbmpi
metadata:
  docker_image: "quay.io/biocontainers/phylobayes-mpi:1.9--h5c6ebe3_0"
---

# phylobayes-mpi

## Overview

PhyloBayes-MPI is a specialized Bayesian Monte Carlo Markov Chain (MCMC) sampler designed for phylogenetic inference. Its primary strength lies in its implementation of site-heterogeneous models (like the CAT model), which better account for the varying biochemical constraints across different positions in protein or DNA sequences compared to standard site-homogeneous models. The MPI version allows these computationally intensive models to be scaled across multiple CPU cores. Use this skill to determine the correct command-line arguments for model selection, resource allocation, and post-analysis convergence checks.

## Core Command Line Usage

### Running the Sampler (pb_mpi)

The primary executable is `pb_mpi`. Because it uses MPI, it must be launched with `mpirun` or `mpiexec`.

*   **Start a new chain with CAT-GTR:**
    `mpirun -np <number_of_cores> pb_mpi -d <alignment_file> -cat -gtr <chain_name>`
*   **Start a chain with a fixed topology:**
    `mpirun -np <number_of_cores> pb_mpi -d <alignment_file> -t <tree_file> -cat -gtr <chain_name>`
*   **Resume an existing chain:**
    `mpirun -np <number_of_cores> pb_mpi <chain_name>`
*   **Specify sampling frequency (thinning):**
    Use `-x <thinning> <total_samples>` to control how often the MCMC state is saved to disk.

### Model Selection Flags

*   `-cat`: Invokes the Dirichlet process mixture (CAT) model for site-specific amino-acid or nucleotide preferences.
*   `-gtr`: Uses a General Time Reversible exchangeability matrix.
*   `-poisson`: Uses a Poisson (F81-style) exchangeability process.
*   `-ncat <int>`: Sets a fixed number of components for the mixture model (instead of the default Dirichlet process).
*   `-uniformbaseprior` / `-rigidbaseprior`: Adjusts the priors on the base frequencies for CAT-GTR models.

## Model Fit and Comparison

PhyloBayes-MPI includes tools for assessing model fit and calculating marginal likelihoods.

*   **WAIC and LOO-CV:**
    Use `-sitecv` or `-jointcv` to perform cross-validation or calculate the Widely Applicable Information Criterion (WAIC).
*   **Sequential Importance Sampling (SIS):**
    Use `-sis`, `-self_tuned_sis`, or `-emp_ref` to estimate marginal likelihoods for model comparison.
*   **Site Log-Likelihoods:**
    Use `-sitelogl` to output the log-likelihood for each site, which is useful for downstream selection or fit analysis.

## Post-Analysis and Convergence

After running at least two independent chains (e.g., `chain1` and `chain2`), you must assess convergence.

*   **Tracecomp (Parameter Convergence):**
    `tracecomp -x <burn_in> <chain1> <chain2>`
    *   Check the "maxdiff" column. Values < 0.1 indicate good convergence; > 0.3 suggests the chains have not converged.
*   **Bpcomp (Topological Convergence):**
    `bpcomp -x <burn_in> <sampling_interval> <chain1> <chain2>`
    *   This generates a consensus tree and calculates the maximum difference in bipartition frequencies (maxdiff).
*   **Readpb (Posterior Summary):**
    `readpb_mpi -x <burn_in> <chain_name>`
    *   Summarizes the posterior distribution of the parameters for a single chain.

## Expert Tips

1.  **Resource Allocation:** One process (the master) manages the MCMC moves, while the remaining processes (slaves) calculate site likelihoods. For very large alignments, increasing `-np` significantly speeds up the likelihood calculation.
2.  **Burn-in:** A standard burn-in is 10-20% of the total points. Always verify that the log-likelihood has reached a plateau using `tracecomp` before trusting the results.
3.  **Effective Sample Size (ESS):** In `tracecomp`, ensure the ESS for all parameters is > 100 (ideally > 500) for reliable posterior estimates.
4.  **Memory Management:** If the program hangs or crashes with "singular logl" errors, it may be due to empty categories in the mixture model; check your data for highly gapped regions or use the `-v` flag for more verbose output during the run.



## Subcommands

| Command | Description |
|---------|-------------|
| bpcomp | compare bipartition frequencies between independent chains and build consensus based on merged lists of trees |
| mpirun -np <np> pb_mpi | creates a new chain, sampling from the posterior distribution, conditional on specified data |
| tracecomp | measure the effective sizes and overlap between 95% CI of several independent chains |

## Reference documentation
- [PhyloBayes-MPI GitHub Repository](./references/github_com_bayesiancook_pbmpi.md)
- [PhyloBayes-MPI Commit History and Feature Updates](./references/github_com_bayesiancook_pbmpi_commits_master.md)