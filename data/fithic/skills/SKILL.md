---
name: fithic
description: Fit-Hi-C identifies statistically significant interactions in chromosomal contact maps by modeling expected contact frequencies based on genomic distance. Use when user asks to identify significant interactions in Hi-C data, filter raw contact counts, or perform statistical analysis on intra-chromosomal and inter-chromosomal contact maps.
homepage: https://github.com/ay-lab/fithic/tree/master
---


# fithic

## Overview
Fit-Hi-C (and the updated FitHiC2) is a specialized tool for the statistical analysis of chromosomal contact maps. It addresses the challenge of identifying "significant" interactions in Hi-C data by modeling the expected contact frequency based on genomic distance. It is essential for researchers who need to filter raw contact counts to find high-confidence interactions that warrant further biological investigation. The tool supports both intra-chromosomal (cis) and inter-chromosomal (trans) interaction analysis.

## Installation and Setup
The recommended way to install fithic is via Bioconda to ensure all dependencies (Python 3, Numpy, Scipy, Scikit-learn) are correctly managed.

```bash
# Install via bioconda
conda config --add channels defaults
conda config --add channels conda-forge
conda config --add channels bioconda
conda install fithic

# Verify installation
fithic -V
```

## Core CLI Usage
The primary command is `fithic`. If installed via GitHub, use `python fithic.py`.

### Required Input Formats
Fit-Hi-C typically requires two main input files:

1.  **Fragments File (`-f`)**: A 5-column file describing the genomic bins or fragments.
    *   Column 1: Chromosome name/number.
    *   Column 3: Midpoint coordinate of the fragment.
    *   Column 4: Total observed contact counts (mid-range reads).
    *   *Note: Columns 2 and 5 are often placeholders or integers not used in standard runs.*

2.  **Interactions File (`-i`)**: Contains the contact counts between pairs of fragments.

### Common Command Patterns
```bash
# Basic execution (standard parameters)
fithic -f <fragments_file> -i <interactions_file> -o <output_directory> -r <resolution>

# View all available options and advanced parameters
fithic --help
```

## Expert Tips and Best Practices
*   **FitHiC2 Features**: Ensure you are using the latest version (FitHiC2) to access features like inter-chromosomal interaction detection and the merging filter algorithm which removes putative bystander interactions.
*   **Validation**: After installation, it is highly recommended to run the test suite. If using the CLI version, export the tests from the repository and run `./run_tests-cli.sh`.
*   **Significance Thresholds**: Use the reported q-values (False Discovery Rate) rather than raw p-values to determine significant interactions, as Hi-C datasets involve massive multiple testing.
*   **Expected vs. Observed**: FitHiC2 reports the expected contact count alongside the raw count. Always assess the enrichment ratio (observed/expected) in addition to statistical significance.

## Reference documentation
- [Fit-Hi-C GitHub Repository](./references/github_com_ay-lab_fithic.md)
- [Fit-Hi-C Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fithic_overview.md)