---
name: telr
description: "Detects non-reference transposable elements from long read sequencing data. Use when user asks to identify novel transposable element insertions."
homepage: https://github.com/bergmanlab/telr
---


# telr

telr/SKILL.md
---
name: telr
description: |
  Detects non-reference transposable elements (TEs) from long read sequencing data (PacBio or Oxford Nanopore).
  Use when analyzing genomic data to identify and characterize novel TE insertions that are not present in a reference genome.
  This skill is particularly useful for researchers studying genome evolution, mobile genetic elements, and structural variations.
---

## Overview

TELR is a powerful tool designed to identify transposable elements (TEs) that are not present in a reference genome, using long-read sequencing data. It works by mapping long reads to a reference genome, detecting structural variations (SVs) that appear to be insertions, and then using user-provided TE consensus sequences to confirm and characterize these insertions. TELR performs local assembly of the insertion regions, annotates the TE sequences, and determines the precise insertion coordinates and allele frequencies. This makes it invaluable for discovering novel TE insertions and understanding their impact on genome structure and variation.

## Usage Instructions

TELR is a command-line tool written in Python 3. It requires several input files and parameters to run effectively.

### Installation

Install TELR via Conda:
```bash
conda install bioconda::telr
```

### Core Workflow and Parameters

The general workflow involves aligning long reads, detecting SVs, and then using TELR to identify and characterize TE insertions.

**Key Commands and Parameters:**

The primary command for running TELR is `telr`. It requires the following essential arguments:

*   `--bam`: Path to the BAM file containing long reads aligned to the reference genome.
*   `--ref`: Path to the reference genome FASTA file.
*   `--te`: Path to a FASTA file containing TE consensus sequences.
*   `--outdir`: Directory to save the output files.

**Example Command:**

```bash
telr --bam aligned_reads.bam --ref reference.fasta --te te_consensus.fasta --outdir telr_results
```

### Pipeline Stages and Associated Tools

TELR integrates several other bioinformatics tools in its pipeline. Understanding these can help in troubleshooting and optimizing the process.

1.  **Structural Variation (SV) Detection:**
    *   **Alignment:** Long reads are aligned to the reference genome using `NGMLR`.
        ```bash
        ngmlr -t <threads> -r <reference.fasta> -q <long_reads.fastq> -o aligned_reads.bam
        ```
    *   **SV Calling:** `Sniffles` is used to detect structural variations from the aligned reads.
        ```bash
        sniffles -m aligned_reads.bam -v sv_calls.vcf -t <threads>
        ```
    *   **TE Candidate Filtering:** TELR filters SVs reported by Sniffles based on:
        *   SV type being an insertion.
        *   Presence of insertion sequence.
        *   Insertion sequences matching user-provided TE consensus libraries (using `RepeatMasker`).

2.  **Local Reassembly and Polishing:**
    *   Reads supporting TE insertion candidates are used for local assembly.
    *   Assemblers like `wtdbg2` or `Flye` can be used.
    *   `minimap2` is used for re-aligning reads to the assembled contigs for polishing.

3.  **TE Insertion Coordinate Identification:**
    *   TE consensus sequences are aligned to assembled contigs using `minimap2`.
    *   TE-flank boundaries are defined.
    *   Flanking sequences are re-aligned to the reference genome using `minimap2` to determine precise insertion coordinates and target site duplications (TSDs).

4.  **Allele Frequency Estimation:**
    *   Reads are extracted around insertion breakpoints.
    *   Reads are aligned to the assembled contig to identify reads supporting TE insertions and reference alleles.
    *   Intra-sample TE insertion allele frequency is estimated.

### Important Considerations and Tips

*   **Input Data Quality:** The quality of long reads and the accuracy of the reference genome are crucial for TELR's performance.
*   **TE Consensus Library:** A comprehensive and accurate TE consensus library (`--te` argument) is essential for correctly identifying and classifying TEs. Ensure your library is curated for the species or group you are studying.
*   **Computational Resources:** TELR and its associated tools can be computationally intensive, especially for large datasets. Ensure sufficient CPU threads and memory are available.
*   **Output Files:** TELR generates several output files in the specified `--outdir`, including VCF files with TE insertion calls, assembled TE sequences, and allele frequency estimates. Familiarize yourself with these outputs for downstream analysis.
*   **Parameter Tuning:** For specific datasets or research questions, you may need to explore additional parameters for `NGMLR`, `Sniffles`, `wtdbg2`, `Flye`, and `minimap2` to optimize performance. Consult the documentation for these individual tools.

## Reference documentation

- [TELR README](./references/github_com_bergmanlab_TELR.md)
- [TELR Overview on Anaconda.org](./references/anaconda_org_channels_bioconda_packages_telr_overview.md)
- [TELR GitHub Repository Structure](./references/github_com_bergmanlab_telr_tree_master_docs.md)
---