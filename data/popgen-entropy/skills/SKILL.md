---
name: popgen-entropy
description: The `entropy` program addresses the challenges of polyploid genetics by utilizing genotype likelihoods rather than hard-called genotypes.
homepage: https://bitbucket.org/buerklelab/mixedploidy-entropy/src/master/
---

# popgen-entropy

## Overview
The `entropy` program addresses the challenges of polyploid genetics by utilizing genotype likelihoods rather than hard-called genotypes. This accounts for the inherent uncertainty in sequencing depth and allelic dosage. It is the primary tool for researchers working with mixed-ploidy populations who need to estimate ancestry coefficients (Q) and ancestral allele frequencies (P) without the bias introduced by traditional genotype calling in polyploids.

## Command Line Usage
The core executable is typically named `entropy`. It relies on a control file or direct CLI arguments to define the model parameters.

### Basic Execution
To run a basic analysis, you must provide the input data (genotype likelihoods) and specify the number of ancestral populations (k).

```bash
entropy -i input_data.gl -k 3 -n 10000 -l 1000 -b 2000 -t 5 -o output_k3.mcmc
```

### Key Parameters
- `-i <file>`: Input file containing genotype likelihoods (often in a specific .gl or .mpgl format).
- `-k <int>`: The number of clusters/ancestral populations to test.
- `-n <int>`: Total number of MCMC iterations.
- `-l <int>`: Thinning interval (steps between saved samples).
- `-b <int>`: Burn-in period (number of initial iterations to discard).
- `-t <int>`: Number of chains or threads (if supported by the specific build).
- `-o <file>`: Prefix or filename for the MCMC output.

## Best Practices
- **Data Preparation**: Ensure your input genotype likelihoods are formatted correctly. The tool typically expects a headerless file where each row represents a locus and columns contain likelihoods for all possible genotypes for each individual.
- **K-Selection**: Run multiple values of K (e.g., K=1 through K=10). Use the Deviance Information Criterion (DIC) provided in the output to compare models and identify the most parsimonious number of clusters.
- **MCMC Convergence**: Always run multiple independent chains for each K to ensure the model has converged on a global optimum rather than a local peak. Compare the posterior distributions of the chains.
- **Ploidy Handling**: One of the tool's strengths is handling mixed ploidy. Ensure your input metadata correctly identifies the ploidy level of each individual if the model requires explicit ploidy assignment.

## Reference documentation
- [Bitbucket Source and Documentation](./references/bitbucket_org_buerklelab_mixedploidy-entropy_src_master.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_popgen-entropy_overview.md)