---
name: sfs_code
description: sfs_code is a forward-in-time population genetic simulator that models finite sites under complex evolutionary scenarios including selection, linkage, and demography. Use when user asks to simulate synthetic genomic data, model natural selection and demographic shifts, or generate site frequency spectra under non-coalescent models.
homepage: http://sfscode.sourceforge.net/SFS_CODE/index/index.html
metadata:
  docker_image: "quay.io/biocontainers/sfs:0.1.0--h9ee0642_0"
---

# sfs_code

## Overview
The `sfs_code` tool is a forward-in-time population genetic simulator designed to model finite sites under complex evolutionary scenarios. Unlike coalescent simulators, it tracks every individual in a population, allowing for highly flexible models of natural selection (including deleterious and advantageous mutations), linkage disequilibrium, and intricate demographic shifts like bottlenecks, expansions, and migrations. Use this skill when you need to generate synthetic genomic data that accounts for the interaction between selection and demography.

## Command Line Usage
The primary interface for `sfs_code` is a command-line execution where parameters are passed via flags. The general syntax is:

```bash
sfs_code <number_of_populations> <number_of_iterations> <options>
```

### Core Parameters
- **Populations and Iterations**: The first two arguments are always the number of populations to simulate and the number of independent iterations (replicates).
- **-N <size>**: Sets the ancestral population size (effective population size $N_e$).
- **-L <n_loci> <length>**: Defines the number of loci and the length of each locus in base pairs.
- **-t <theta>**: Sets the mutation rate per site ($\theta = 4N\mu$).
- **-r <rho>**: Sets the recombination rate per site ($\rho = 4Nr$).

### Demographic Events
Demographic changes are specified using the `-td` flag followed by the time (in units of $N$ generations), the event type, and the population index.
- **Size Change**: `-td <time> -n <pop_index> <new_relative_size>`
- **Migration**: `-tm <time> <pop_i> <pop_j> <rate>` (sets migration from population $i$ to $j$).
- **Split**: `-ts <time> <source_pop> <new_pop_size>` (creates a new population from an existing one).

### Selection Models
- **-W <pop> <dist_type> <params>**: Defines the distribution of fitness effects (DFE). Common distributions include gamma or fixed values.
- **-P <locus> <type>**: Annotates a locus as coding (0) or non-coding (1). Coding loci automatically handle synonymous and non-synonymous sites.

## Best Practices
- **Scaling**: Because forward simulations are computationally intensive, consider scaling down $N$ and scaling up $\mu$ and $r$ proportionally to maintain the same $\theta$ and $\rho$ if the absolute population size is not critical to the biological question.
- **Output Redirection**: `sfs_code` outputs data to `stdout`. Always redirect to a file or pipe into a parser.
- **Seed Management**: Use the `-m <seed>` flag to ensure reproducibility across different runs.
- **Burn-in**: Ensure the simulation runs for a sufficient "burn-in" period (typically $10N$ generations) before sampling to reach mutation-recombination-drift equilibrium.

## Reference documentation
- [SFS_CODE Project Overview](./references/sfscode_sourceforge_net_SFS_CODE_index_index.html.md)
- [Bioconda sfs_code Package Summary](./references/anaconda_org_channels_bioconda_packages_sfs_code_overview.md)