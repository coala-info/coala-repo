---
name: mupbwt
description: mupbwt is a high-performance tool for genomic haplotype matching that uses the Positional Burrows-Wheeler Transform to index genotype panels. Use when user asks to build a PBWT index, identify shared genetic segments, or find matches between query haplotypes and a reference panel.
homepage: https://github.com/dlcgold/muPBWT
---


# mupbwt

## Overview

mupbwt (mu-PBWT) is a high-performance tool for genomic haplotype matching. It implements an efficient version of the Positional Burrows-Wheeler Transform (PBWT) to index genotype panels. This skill enables the rapid identification of shared genetic segments (SMEMs) between a query set and a reference panel. It is particularly useful when working with biobank-scale data where standard PBWT implementations might exceed memory limits.

## Installation

The tool is available via Bioconda:
```bash
conda install -c bioconda mupbwt
```

## Common CLI Patterns

### 1. Building an Index
To create a reusable index from a reference panel:
```bash
mupbwt -i panel.bcf -s panel_index.ser
```

### 2. Querying an Existing Index
To search for matches using a previously saved index:
```bash
mupbwt -l panel_index.ser -q query.bcf -o match_results.txt
```

### 3. One-Shot Execution
To perform a query without saving the index to disk:
```bash
mupbwt -i panel.bcf -q query.bcf -o match_results.txt
```

### 4. Combined Indexing and Querying
To build the index, save it for future use, and run a query simultaneously:
```bash
mupbwt -i panel.bcf -s panel_index.ser -q query.bcf -o match_results.txt
```

## Expert Tips and Best Practices

### Input Requirements
*   **Biallelic Only**: mupbwt only supports biallelic SNPs. You must filter your VCF/BCF files before processing.
*   **Filtering Command**: Use `bcftools` to prepare your data:
    ```bash
    bcftools view -m2 -M2 -v snps input.vcf.gz -O b -o filtered_output.bcf
    ```

### Memory and Performance
*   **Memory Details**: Use the `-d` or `--details` flag to print memory usage statistics to stdout. This is helpful for estimating requirements for larger chromosomes.
*   **MaCS Format**: If working with simulated data from MaCS, use the `-m` or `--macs` flag.

### Interpreting Output
The output follows Durbin's PBWT standard for SMEMs:
`MATCH <query_index> <panel_index> <start_column> <end_column> <length>`

*   **Index Mapping**: Indices are 0-based and incremental. Since humans are diploid, row index 0 and 1 correspond to the two haplotypes of the first sample in the VCF, 2 and 3 to the second, and so on.
*   **Resolving Sample Names**: To map the numeric indices back to sample names, use the provided `mem_sample.py` script:
    ```bash
    python mem_sample.py -i match_results.txt -p panel.bcf -q query.bcf -o named_results.txt
    ```
*   **Manual Sample Extraction**: You can also extract sample names manually using `bcftools query -l <file>`.

## Reference documentation
- [muPBWT GitHub Repository](./references/github_com_dlcgold_muPBWT.md)
- [mupbwt Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mupbwt_overview.md)