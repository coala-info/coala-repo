---
name: ancestry_hmm
description: ancestry_hmm is a specialized Hidden Markov Model (HMM) tool used in bioinformatics to identify the ancestral origins of chromosomal segments in admixed individuals.
homepage: https://github.com/russcd/Ancestry_HMM
---

# ancestry_hmm

## Overview
ancestry_hmm is a specialized Hidden Markov Model (HMM) tool used in bioinformatics to identify the ancestral origins of chromosomal segments in admixed individuals. Unlike many other tools, it can work directly with low-coverage NGS data (read counts) and supports complex demographic models involving multiple ancestry pulses. It is the preferred tool when you need to estimate the timing of admixture events or when working with non-diploid organisms.

## Command Line Usage

### Basic Execution Pattern
The tool requires an input file, a sample/ploidy file, global ancestry proportions, and at least two ancestry pulses.

```bash
ancestry_hmm -i [input_file] -s [sample_file] -a [num_ancestry] [prop1] [prop2] -p [type] [time] [proportion] -p [type] [time] [proportion]
```

### Defining Ancestry Pulses (-p)
The `-p` flag defines the admixture history. It takes three arguments: `[ancestry_type] [time_in_generations] [proportion]`.
*   **Ancestry Type**: 0 for the first population in the input, 1 for the second, etc.
*   **Time**: 
    *   Positive value: Treated as a fixed parameter.
    *   Negative value: Treated as an initial estimate to be optimized by the HMM.
*   **Proportion**: 
    *   Positive value: Fixed proportion of the pulse.
    *   Negative value: Estimate this parameter during the run.

**Example: Single pulse model**
To model a pulse from ancestry 1 into a base population of ancestry 0 occurring roughly 100 generations ago:
```bash
ancestry_hmm -i data.input -s samples.txt -a 2 0.5 0.5 -p 0 100000 0.5 -p 1 -100 0.5
```
*Note: The "base" population should have a very large fixed time (e.g., 100,000) to represent the state prior to the admixture event.*

### Global Ancestry Proportions (-a)
You must provide the number of ancestral populations followed by their global proportions. It is a best practice to estimate these proportions beforehand using software like ADMIXTURE or NGSAdmix.
```bash
# Three ancestral populations with proportions 0.6, 0.2, and 0.2
-a 3 0.6 0.2 0.2
```

### Input and Sample Files
*   **Input File (-i)**: Contains site-specific data including recombination rates and allele counts.
*   **Sample File (-s)**: A file specifying sample IDs and their respective ploidy.

## Advanced Options and Best Practices

### Decoding Methods
*   **Forward-Backward (Default)**: Provides posterior probabilities for each ancestry state at each site.
*   **Viterbi (-v)**: Provides the single most likely sequence of ancestry states. Use this if you need hard calls for ancestry tracts.

### Data Types
*   **Read Counts (Default)**: Optimized for low-coverage NGS data.
*   **Genotypes (-g)**: Use this flag if your input file contains discrete genotype counts rather than raw read counts.

### Optimization and Performance
*   **Effective Population Size (--ne)**: Set the effective population size (default assumes 2N for diploids).
*   **Restarts (-r)**: Use multiple restarts for the Nelder-Mead search to avoid local optima when estimating pulse times.
*   **Bootstrap (-b)**: Perform block bootstraps to estimate confidence intervals for timing (e.g., `-b 10 1000` for 10 replicates with 1000 SNP blocks).
*   **Precision**: Use `--precision` to control the decimal places in the output files.

### Error Handling
*   **Error Rate (-e)**: Specify a global error rate per site.
*   **Site-specific Errors (-E)**: If your input file contains per-site error rates, use this flag to incorporate them into the HMM.

## Reference documentation
- [GitHub - russcd/Ancestry_HMM](./references/github_com_russcd_Ancestry_HMM.md)
- [ancestry_hmm - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ancestry_hmm_overview.md)