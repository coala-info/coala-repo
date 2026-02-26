---
name: hifihla
description: "hifihla performs high-resolution HLA allele calling from PacBio HiFi sequencing data. Use when user asks to call HLA alleles from PacBio HiFi data."
homepage: https://github.com/PacificBiosciences/hifihla
---


# hifihla

An HLA star-calling tool for PacBio HiFi data. Use when you need to perform high-resolution (4-field) HLA allele calls from PacBio HiFi sequencing data. This tool identifies the closest matching HLA allele(s) and any differences compared to the IPD-IMGT/HLA database, supporting aligned HiFi reads, assembly contigs, and amplicon consensus as input data types.
---
## Overview

hifihla is a specialized bioinformatics tool designed for accurate HLA (Human Leukocyte Antigen) typing using PacBio HiFi sequencing data. It excels at generating high-resolution, 4-field HLA allele calls by comparing sequencing reads or contigs against the IPD-IMGT/HLA database. This makes it suitable for research applications requiring precise HLA genotyping from long-read sequencing data.

## Usage and Installation

### Installation

To install hifihla, use conda:

```bash
conda install bioconda::hifihla
```

### Basic Usage

The primary function of hifihla is to call HLA alleles from input data. The general command structure involves specifying input files and output directories.

```bash
hifihla --input <input_file> --output <output_directory> [options]
```

### Key Options and Parameters

*   `--input <input_file>`: Path to the input data file. This can be aligned HiFi reads (e.g., BAM format), assembly contigs (e.g., FASTA format), or amplicon consensus sequences.
*   `--output <output_directory>`: Directory where the results will be saved.
*   `--genes <gene_list>`: (Optional) Specify a comma-separated list of HLA genes to call (e.g., `HLA-A,HLA-B,HLA-DRB1`). If not provided, hifihla will attempt to call all relevant genes.
*   `--threads <num_threads>`: (Optional) Number of threads to use for computation.
*   `--ploidy <ploidy_level>`: (Optional) Specify the ploidy level for HLA calling (e.g., `diploid`).

### Input Data Types

hifihla supports the following input data types:

*   **Aligned HiFi Reads**: Typically in BAM format. Ensure reads are properly aligned to a reference genome.
*   **Assembly Contigs**: In FASTA format. These are assembled sequences from the sequencing data.
*   **Amplicon Consensus**: Consensus sequences derived from PCR amplicons.

### Output Interpretation

The output directory will contain files detailing the HLA allele calls. Key files to examine include:

*   **Allele calls**: A summary of the most likely HLA allele for each gene.
*   **Differences**: Information on any discrepancies between the called alleles and the reference database.
*   **Alignment details**: (If applicable) Information related to the alignment of reads or contigs.

### Expert Tips

*   **Data Quality**: Ensure your PacBio HiFi data is of high quality, with long reads and low error rates, for optimal HLA calling.
*   **Reference Database**: hifihla relies on the IPD-IMGT/HLA database. Ensure you are using a recent version for the most accurate calls.
*   **Gene Specificity**: If you are interested in specific HLA genes, use the `--genes` option to speed up the analysis and focus the output.
*   **Resource Allocation**: For large datasets, utilize the `--threads` option to leverage multi-core processors and reduce runtime.

## Reference documentation
- [README](./references/github_com_PacificBiosciences_hifihla_blob_main_README.md)