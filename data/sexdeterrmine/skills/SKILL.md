---
name: sexdeterrmine
description: sexdeterrmine estimates the biological sex of individuals from sequencing data by comparing X and Y chromosome coverage relative to autosomes. Use when user asks to determine biological sex from BAM files, calculate relative chromosome depth, or perform sex assignment for low-coverage sequencing data.
homepage: https://github.com/TCLamnidis/Sex.DetERRmine
metadata:
  docker_image: "quay.io/biocontainers/sexdeterrmine:1.1.2--hdfd78af_1"
---

# sexdeterrmine

## Overview
`sexdeterrmine` is a specialized bioinformatics tool designed to estimate the biological sex of individuals from sequencing data. It works by comparing the depth of coverage on the X and Y chromosomes relative to autosomes. By calculating error bars using binomial distribution and error propagation, it provides a statistically robust way to distinguish between male (XY) and female (XX) signatures, even in noisy or low-coverage datasets typical of paleogenomics.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::sexdeterrmine
```

## Core Usage Patterns

### 1. Direct Pipe from Samtools (Recommended)
The most efficient way to use the tool is to pipe the output of `samtools depth` directly into the script. This avoids creating large intermediate files.

```bash
samtools depth -a -q30 -Q30 -b <SNPs.bed> -f <BAM_list.txt> | Sex.DetERRmine.py -f <BAM_list.txt>
```

### 2. Using a Pre-calculated Depth File
If you already have a depth file, ensure it has a header starting with `#` or provide a sample list.

```bash
Sex.DetERRmine.py -I input_depth.txt -f sample_names.txt
```

## Input Requirements

### Depth File Format
The script expects a modified `samtools depth` format. If you are not using the `-f` option, the first line must be a header:
`#Chr Pos Sample1 Sample2 Sample3 ...`

### Sample List (`-f`)
This file should contain one sample name per line, matching the order of the BAM files used to generate the depth information. Using this flag is the preferred method as it bypasses the need to manually edit the `samtools depth` output to add a header.

## Expert Tips and Best Practices

*   **Quality Filtering**: When generating the input depth with `samtools`, always use `-q` (minimum mapping quality) and `-Q` (minimum base quality). For ancient DNA, values of 30 are standard to reduce noise from misincorporations or mapping errors.
*   **Targeted Analysis**: Use a BED file (`-b`) containing specific SNP positions (e.g., 1240k capture sites) to focus the calculation on informative genomic regions.
*   **Handling "chr" Prefixes**: The tool is designed to handle chromosome names both with and without the "chr" prefix (e.g., "chrX" vs "X").
*   **Interpreting Results**:
    *   **Relative X-coverage**: Values near 1.0 typically indicate an XX individual, while values near 0.5 indicate an XY individual.
    *   **Relative Y-coverage**: Values near 0.0 indicate an XX individual, while values near 0.5 indicate an XY individual.
    *   **Error Bars**: Always check the error bars; if they are large, the coverage may be too low for a confident assignment.
*   **Empty Inputs**: Version 1.1.2+ handles empty inputs by setting rates and errors to 0 rather than crashing with a `ZeroDivisionError`.

## Reference documentation
- [Sex.DetERRmine README](./references/github_com_TCLamnidis_Sex.DetERRmine_blob_master_README.md)
- [Bioconda sexdeterrmine Overview](./references/anaconda_org_channels_bioconda_packages_sexdeterrmine_overview.md)