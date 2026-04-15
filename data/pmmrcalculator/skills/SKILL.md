---
name: pmmrcalculator
description: The pmmrcalculator tool calculates the pairwise mismatch rate for individuals within an EigenStrat dataset. Use when user asks to calculate pairwise mismatch rates, identify sample duplicates, or assess genetic similarity between individuals.
homepage: https://github.com/TCLamnidis/pMMRCalculator
metadata:
  docker_image: "quay.io/biocontainers/pmmrcalculator:1.1.0--hdfd78af_0"
---

# pmmrcalculator

## Overview

The pmmrcalculator tool is a specialized utility for population genetics that computes the pairwise mismatch rate (pMMR) for all pairs of individuals within an EigenStrat dataset. It is particularly useful for assessing genetic similarity, identifying potential sample duplicates, or quantifying relatedness in ancient or modern DNA workflows. The tool identifies the intersection of non-missing genotypes between individuals and calculates the cumulative mismatch proportion based on allele counts.

## Command Line Usage

### Basic Execution
To run the calculation using a standard EigenStrat file triplet (prefix.geno, prefix.snp, prefix.ind):

```bash
pMMRCalculator.py -i <INPUT_PREFIX> -o <OUTPUT_FILE>
```

### Handling File Suffixes
If your EigenStrat files have specific suffixes (e.g., prefix.geno.gz), use the `-s` flag:

```bash
pMMRCalculator.py -i <INPUT_PREFIX> -s .gz -o <OUTPUT_FILE>
```

### Generating JSON Output
To produce a machine-readable JSON file in addition to the standard text output:

```bash
pMMRCalculator.py -i <INPUT_PREFIX> -o <OUTPUT_FILE> -j
```

## Best Practices and Expert Tips

- **Input Requirements**: Ensure that all three components of the EigenStrat format (.geno, .snp, and .ind) are present in the same directory and share the exact same prefix.
- **Output Interpretation**:
    - **nSNPs**: This column represents the number of overlapping SNPs where both individuals in the pair have non-missing data.
    - **nMismatch**: The cumulative mismatch proportion across all overlapping SNPs.
    - **pMismatch**: The final pairwise mismatch rate.
- **Handling Missing Data**: If two individuals share zero overlapping SNPs, the tool will output `NA` for the pMMR value.
- **Performance**: For large datasets, omit the `-o` flag to print directly to `stdout` if you intend to pipe the results into another tool or a compressed stream.
- **JSON Integration**: Use the `-j` flag when the output needs to be parsed by downstream Python scripts or web-based visualization tools, as it provides a structured format compared to the standard space-delimited text.

## Reference documentation

- [pMMRCalculator README](./references/github_com_TCLamnidis_pMMRCalculator_blob_master_README.md)
- [pmmrcalculator Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pmmrcalculator_overview.md)