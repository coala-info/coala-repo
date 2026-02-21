---
name: guessmylt
description: `guessmylt` is a diagnostic tool designed to infer the library preparation method of RNA-Seq datasets.
homepage: https://github.com/NBISweden/GUESSmyLT
---

# guessmylt

## Overview

`guessmylt` is a diagnostic tool designed to infer the library preparation method of RNA-Seq datasets. By analyzing how reads map to a reference genome or transcriptome—often in conjunction with gene annotations—it determines whether a library is stranded (first-strand or second-strand) or unstranded, and identifies the relative orientation of paired-end reads (e.g., fr, rf, ff). Use this skill to ensure correct parameters are used in subsequent steps like read counting (featureCounts), assembly (Trinity), or alignment (STAR/HISAT2).

## Usage Instructions

### Core Command Patterns

The tool's behavior depends on the available input files. Providing more information (like annotations) generally increases the accuracy of the guess.

**1. Reads Only (De novo approach)**
If you have no reference, the tool uses Trinity and BUSCO to find conserved genes.
```bash
GUESSmyLT --reads read_1.fastq read_2.fastq
```

**2. Reference Genome and Annotation (Recommended)**
The most accurate mode for known organisms.
```bash
GUESSmyLT --reads R1.fastq R2.fastq --reference ref.fa --mode genome --annotation annotation.gff --organism euk
```

**3. Using Existing Alignments**
If you have already mapped the reads, you can skip the internal mapping step.
```bash
GUESSmyLT --reads R1.fastq R2.fastq --reference ref.fa --mode genome --mapped aligned.bam
```

**4. Transcriptome Reference**
Use this when mapping directly to transcripts rather than a genome.
```bash
GUESSmyLT --reads R1.fastq R2.fastq --reference transcripts.fa --mode transcriptome
```

### Interpreting Results

The tool outputs a table showing the percentage of reads matching specific orientations.

*   **Unstranded:** If there is a roughly 50/50 split between `firststrand` and `secondstrand` for a specific orientation (usually `fr`), the library is unstranded.
*   **Stranded:** A high percentage (e.g., >90%) in one category (like `fr_firststrand`) indicates a stranded library.
*   **Orientation Codes:**
    *   `fr`: Forward-Reverse (Standard for Illumina paired-end).
    *   `rf`: Reverse-Forward.
    *   `ff`: Forward-Forward.

### Expert Tips

*   **Organism Selection:** Always specify `--organism euk` for eukaryotes or `--organism prok` for prokaryotes when using the tool to ensure the correct BUSCO datasets are utilized.
*   **Compressed Files:** The tool natively supports compressed (`.gz`) fastq files.
*   **Subsampling:** `guessmylt` automatically performs subsampling to maintain efficiency; you do not need to manually downsample large FASTQ files before running.
*   **Header Formats:** The tool is compatible with Old/New Illumina headers and SRA formats. If using custom headers, ensure they follow standard naming conventions for paired mates.

## Reference documentation

- [GUESSmyLT Main Documentation](./references/github_com_NBISweden_GUESSmyLT.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_guessmylt_overview.md)