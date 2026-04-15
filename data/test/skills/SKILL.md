---
name: test
description: The test tool processes high-throughput sequencing data to perform format conversion, sequence manipulation, and quality-based trimming. Use when user asks to convert sequence formats, subsample reads, mask or trim sequences, and extract specific genomic regions.
homepage: https://github.com/lh3/seqtk
metadata:
  docker_image: "quay.io/biocontainers/test:0.1--h73052cd_7"
---

# test

## Overview
The `test` tool (built on the `seqtk` engine) is a high-performance, lightweight utility designed for the fast processing of high-throughput sequencing data. It excels at handling large, gzipped sequence files with minimal memory overhead. Use this skill to perform essential bioinformatics pre-processing tasks such as converting between sequence formats, generating random subsets of reads for pipeline testing, and masking or trimming sequences based on quality scores or genomic coordinates.

## Common CLI Patterns

### Format Conversion and Basic Manipulation
*   **Convert FASTQ to FASTA**:
    `seqtk seq -a input.fastq.gz > output.fasta`
*   **Reverse complement sequences**:
    `seqtk seq -r input.fq > output.fq`
*   **Fold long lines (e.g., 60 bp per line) and remove comments**:
    `seqtk seq -Cl60 input.fa > output.fa`
*   **Convert multi-line FASTQ to standard 4-line format**:
    `seqtk seq -l0 input.fq > output.fq`

### Quality Control and Masking
*   **Mask low-quality bases**:
    Convert to FASTA and mask bases with quality < 20 to lowercase:
    `seqtk seq -aQ64 -q20 input.fq > output.fa`
*   **Mask specific regions to lowercase**:
    Use a BED file to define regions:
    `seqtk seq -M regions.bed input.fa > output.fa`

### Subsampling and Extraction
*   **Randomly subsample reads**:
    Extract 10,000 reads using a specific seed (100) for reproducibility:
    `seqtk sample -s100 input.fq 10000 > subset.fq`
    *Note: When subsampling paired-end data, use the same seed for both files to maintain read pairing.*
*   **Extract sequences by name**:
    `seqtk subseq input.fq name_list.lst > output.fq`
*   **Extract sequences by genomic region**:
    `seqtk subseq input.fa regions.bed > output.fa`

### Trimming
*   **Adaptive trimming (Phred algorithm)**:
    `seqtk trimfq input.fq > output.fq`
*   **Fixed-length trimming**:
    Trim 5bp from the left (5') and 10bp from the right (3'):
    `seqtk trimfq -b 5 -e 10 input.fa > output.fa`

### Advanced Analysis
*   **Identify telomeric repeats**:
    `seqtk telo input.fa > telomeres.bed`

## Expert Tips
*   **Gzip Support**: The tool natively supports gzipped files. You do not need to decompress files before processing, which saves significant disk space and I/O time.
*   **Piping**: `test` is designed to work within Unix pipes. Combine it with other tools (like `samtools` or `grep`) to create efficient one-liner workflows.
*   **Reproducibility**: Always provide a seed (`-s`) when using the `sample` command to ensure that your subsampling results can be replicated.
*   **Memory Efficiency**: Because it is written in C and uses a stream-based parser, it can process files much larger than the available RAM.

## Reference documentation
- [Bioconda test package overview](./references/anaconda_org_channels_bioconda_packages_test_overview.md)
- [Seqtk GitHub Documentation](./references/github_com_lh3_seqtk.md)