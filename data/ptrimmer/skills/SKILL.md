---
name: ptrimmer
description: pTrimmer is a high-performance utility designed to clean amplicon sequencing data by identifying and stripping primer sequences. Use when user asks to trim primers from sequencing reads, process single-end or paired-end amplicon data, or filter reads based on quality and primer matches.
homepage: https://github.com/DMU-lilab/pTrimmer
---


# ptrimmer

## Overview

pTrimmer is a high-performance utility designed to clean amplicon sequencing data by identifying and stripping primer sequences. It employs a hybrid approach using k-mer indexing for rapid searching and dynamic programming for precise alignment, making it capable of handling thousands of primer pairs simultaneously. This tool is particularly useful in workflows where primer-induced artifacts must be removed before alignment or variant calling to ensure biological accuracy.

## Usage Guidelines

### 1. Preparing the Amplicon File
The amplicon file (`-a`) is a required tab-delimited text file defining the primer pairs. Each line must follow this structure:
`ForwardPrimer	ReversePrimer	InsertLength	AuxInfo`

*   **Primer Direction**: Both forward and reverse primers must be provided in the **5' to 3'** direction.
*   **Insert Length**: The distance between the primers. While pTrimmer uses this to determine trimming conditions (like read-through), it does not need to be perfectly exact.
*   **AuxInfo**: A label or name for the amplicon.

### 2. Basic Command Patterns

**Single-End Sequencing:**
```bash
ptrimmer -t single -a amplicons.txt -f input.fq -d trimmed_output.fq
```

**Paired-End Sequencing:**
```bash
ptrimmer -t pair -a amplicons.txt -f R1.fq -r R2.fq -d trimmed_R1.fq -e trimmed_R2.fq
```

**Handling Compressed Files:**
To output gzipped files directly, use the `-z` flag. Input files can be `.fq`, `.fastq`, or `.gz`.
```bash
ptrimmer -t pair -z -a amplicons.txt -f R1.fq.gz -r R2.fq.gz -d out_R1.fq.gz -e out_R2.fq.gz
```

### 3. Advanced Configuration and Best Practices

*   **Handling Unmatched Reads**: By default, pTrimmer discards reads where primers cannot be located. Use `-l` (or `--keep`) to retain these reads in the output instead of discarding them.
*   **Mismatch Tolerance**: The default maximum mismatch is 3. For highly variable regions or lower quality data, you can adjust this with `-m`. However, values `<= 3` are recommended to maintain specificity.
*   **Quality Filtering**: Use `-q` to set the minimum average quality score (default is 20). pTrimmer automatically detects Phred+33 or Phred+64 encoding.
*   **Primer Metadata**: Use the `-i` flag to append primer information (index and coordinates) to the comment line of each trimmed read in the output FASTQ. This is helpful for troubleshooting or multi-amplicon tracking.
*   **K-mer Optimization**: The default k-mer length is 8 (`-k 8`). Increasing this value improves speed and accuracy but may reduce the sensitivity for finding primers in very noisy data.

### 4. Summary Output
pTrimmer generates a summary file (default: `Summary.ampcount`) that records the number of reads processed for each amplicon defined in your input file. Use the `-s` flag to specify a custom path for this report.

## Reference documentation
- [pTrimmer GitHub Repository](./references/github_com_DMU-lilab_pTrimmer.md)
- [Bioconda pTrimmer Overview](./references/anaconda_org_channels_bioconda_packages_ptrimmer_overview.md)