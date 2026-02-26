---
name: qualrepair
description: qualrepair synchronizes quality scores between a primary source FASTQ file and a derived subsequence FASTQ file to ensure data integrity. Use when user asks to repair corrupted quality scores, restore quality information after using splitcode, or synchronize quality metrics between original and extracted sequences.
homepage: https://github.com/clintval/qualrepair
---


# qualrepair

## Overview

`qualrepair` is a specialized bioinformatics utility designed to synchronize quality scores between a primary source FASTQ file and a derived subsequence FASTQ file. In many genomic workflows—specifically those involving sequence splitting or demultiplexing with tools like `splitcode`—quality scores can become corrupted or lost. This tool ensures that the extracted subsequences retain the high-fidelity quality information from the original sequencing run by re-mapping the scores based on sequence identity.

## Installation

The tool can be installed via Conda or Pip:

```bash
# Using Conda
conda install bioconda::qualrepair

# Using Pip
pip install qualrepair
```

## Command Line Usage

The primary function of `qualrepair` is to take a source file and a subsequence file and output a repaired version of the subsequence file.

### Basic Syntax
```bash
qualrepair --in-source "original_r1.fastq.gz" --in-subseq "extracted_subsequence.fastq.gz"
```

### Arguments
- `--in-source`: The path to the original, full-length FASTQ file containing the correct quality scores.
- `--in-subseq`: The path to the FASTQ file containing the subsequences that require quality score repair.

## Best Practices and Expert Tips

- **Tool Integration**: `qualrepair` was specifically developed to mitigate an unsolved issue in the `splitcode` tool where quality scores are not correctly preserved during the splitting process. If your workflow involves `splitcode`, include `qualrepair` as a standard post-processing step.
- **File Compression**: The tool natively supports Gzip-compressed FASTQ files (`.fastq.gz`). It is recommended to keep files compressed to save disk space and I/O overhead.
- **Validation**: Before running downstream analysis (like alignment or variant calling), use `qualrepair` to ensure your quality metrics are accurate, as many aligners rely heavily on these scores for mapping quality calculations.
- **Sequence Matching**: Ensure that the `--in-subseq` file is a true derivative of the `--in-source` file. The tool relies on the relationship between the subsequence and the source sequence to perform the repair.

## Reference documentation

- [qualrepair - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_qualrepair_overview.md)
- [GitHub - clintval/qualrepair](./references/github_com_clintval_qualrepair.md)