---
name: desman
description: DESMAN (De novo Extraction of Strains from MetAgeNomes) is a specialized tool for identifying individual strains within a metagenomic assembly.
homepage: https://github.com/chrisquince/DESMAN
---

# desman

## Overview
DESMAN (De novo Extraction of Strains from MetAgeNomes) is a specialized tool for identifying individual strains within a metagenomic assembly. It operates by analyzing the frequency of nucleotide variants at specific positions across multiple samples. By distinguishing between sequencing errors and true biological variation using a Gibbs sampler, DESMAN reconstructs the haplotypes of the strains present and estimates their proportions in the community. This skill provides the necessary command-line patterns to filter variants and perform strain inference.

## Core Workflow and CLI Patterns

### 1. Identifying Variant Positions
The first step is to identify high-quality variant positions from a base frequency file.

```bash
Variant_Filter.py <input_frequencies.freq> -o <output_prefix> -p
```

**Key Parameters:**
- `<input_frequencies.freq>`: A CSV file containing base frequencies (A, C, G, T) for each position across samples.
- `-o`: The output file stub/prefix.
- `-p`: Enables one-dimensional optimization of individual base frequencies. While more time-consuming, it is highly recommended for better accuracy.

**Primary Outputs:**
- `*_outsel_var.csv`: The selected variants used for the next step.
- `*_outtran_df.csv`: The estimated error transition matrix.

### 2. Inferring Haplotypes and Abundances
Once variants are filtered, use the `desman` command to perform the actual strain inference.

```bash
desman <selected_variants.csv> -g <number_of_strains> -e <error_matrix.csv> -o <output_directory> -i <iterations>
```

**Key Parameters:**
- `-g`: The number of haplotypes (strains) to infer.
- `-e`: The initial estimate for the error transition matrix (typically the `outtran_df.csv` from the filtering step).
- `-o`: The directory where results will be stored.
- `-i`: Number of iterations for the Gibbs sampler (e.g., 50-100).

## Best Practices and Expert Tips

- **Input Format**: Ensure your frequency file follows the specific DESMAN format: `Contig, Position, Sample1-A, Sample1-C, Sample1-G, Sample1-T, ...`.
- **Model Selection**: Since the number of strains (`-g`) is often unknown, it is common practice to run DESMAN across a range of `-g` values and compare the results using the `fit.txt` output.
- **Interpreting Results**:
    - **Tau_star**: Use `Filtered_Tau_star.csv` for the predicted strain haplotypes.
    - **Gamma_star**: Use `Gamma_star.csv` to find the relative frequency of each haplotype in each sample.
    - **Posterior Means**: `Tau_mean.csv` and `Gamma_mean.csv` provide posterior means. Note that `Tau_mean` may contain non-discrete values; these should be discretized before downstream analysis.
- **Environment Setup**: If installing from source, ensure `gcc` and the GNU Scientific Library (`gsl`) are available on your system. For most users, the Bioconda installation is preferred: `conda install bioconda::desman`.

## Reference documentation
- [bioconda / desman Overview](./references/anaconda_org_channels_bioconda_packages_desman_overview.md)
- [DESMAN GitHub Repository](./references/github_com_chrisquince_DESMAN.md)