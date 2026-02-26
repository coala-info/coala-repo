---
name: orfm
description: OrfM rapidly identifies and translates open reading frames from DNA sequences into amino acid sequences without requiring start codons. Use when user asks to find ORFs in metagenomic data, translate DNA into protein sequences, or extract potential peptides from fragmented reads.
homepage: https://github.com/wwood/OrfM
---


# orfm

## Overview
OrfM is a specialized tool for rapid ORF calling that prioritizes performance and simplicity. Unlike sophisticated gene predictors (like Prodigal), OrfM identifies any continuous stretch of codons that does not contain a stop codon, regardless of whether a start codon is present. This makes it exceptionally useful for analyzing fragmented DNA, such as short-read metagenomic sequencing, where genes may be truncated. It produces a FASTA file of amino acid translations for all identified ORFs meeting a user-defined length threshold.

## Usage and Best Practices

### Basic Command Line Usage
The most common way to run OrfM is by redirecting a sequence file into the tool:

```bash
orfm < input_sequences.fasta > output_orfs.faa
```

OrfM accepts FASTA or FASTQ files, which can be either uncompressed or gzipped.

### Setting Length Thresholds
The default minimum ORF length is 96 nucleotides. This value is specifically chosen for 100bp reads to ensure that ORFs spanning nearly the entire read in any of the six frames can be captured.

To adjust the minimum length (e.g., to 150 nucleotides):
```bash
orfm -m 150 input.fasta > output.faa
```

### Understanding Output Headers
OrfM appends specific metadata to the original sequence ID in the output FASTA:
`>OriginalID_startPosition_frameNumber_orfNumber [Original Comment]`

*   **startPosition**: The 1-based coordinate where the ORF begins. For reverse frames, this is the left-most position in the original sequence.
*   **frameNumber**: The reading frame (1-6).
*   **orfNumber**: A unique identifier for the ORF within that specific sequence and frame.

### Advanced Options
Based on the tool's development history, several flags provide additional control:
*   `-m [INT]`: Minimum ORF length in nucleotides (default: 96).
*   `-p`: Include stop codons in the output amino acid sequences.
*   `-t [INT]`: Specify an alternative translation table (e.g., for plastids or specific bacteria).
*   `-x`: Print 'X' for unknown nucleotides instead of stopping.

### Performance Optimization
OrfM is significantly faster than tools like `getorf` (EMBOSS) or `prodigal`. For large datasets:
1.  **Piping**: Use pipes to avoid intermediate disk I/O:
    ```bash
    zcat sequences.fastq.gz | orfm -m 96 > orfs.faa
    ```
2.  **Metagenomic Screening**: Use OrfM as a pre-filter to extract all possible peptides before running more computationally expensive searches like BLASTp or HMMER.

## Reference documentation
- [OrfM GitHub Repository](./references/github_com_wwood_OrfM.md)
- [OrfM Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_orfm_overview.md)