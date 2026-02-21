---
name: ultra_bioinformatics
description: uLTRA (Universal Long-read Transcriptome Aligner) is a tool designed to align long RNA-seq reads to a genome using a database of exon annotations.
homepage: https://github.com/ksahlin/uLTRA
---

# ultra_bioinformatics

## Overview
uLTRA (Universal Long-read Transcriptome Aligner) is a tool designed to align long RNA-seq reads to a genome using a database of exon annotations. By utilizing a GTF file during the alignment process, it achieves superior accuracy compared to general-purpose long-read aligners, particularly for transcripts containing small exons. It supports both Oxford Nanopore (ONT) and PacBio Iso-Seq technologies.

## Installation and Setup
The recommended way to install uLTRA is via Bioconda:
```bash
conda install -c bioconda ultra_bioinformatics
```
Ensure `namfinder` and `minimap2` are in your PATH, as uLTRA relies on these for seed finding and aligning reads outside of indexed regions.

## Core Workflows

### 1. Indexing the Genome
Before alignment, you must index the reference genome and the GTF annotation.
```bash
uLTRA index genome.fasta /path/to/annotation.gtf outfolder/
```
*   **Optimization**: Use `--disable_infer` to significantly speed up indexing if your GTF file already contains explicit `gene` and `transcript` feature lines.

### 2. Aligning Reads
Alignment requires specifying the sequencing technology to set appropriate heuristics.
*   **Oxford Nanopore (ONT)**:
    ```bash
    uLTRA align genome.fasta reads.fastq outfolder/ --ont --t 8
    ```
*   **PacBio Iso-Seq**:
    ```bash
    uLTRA align genome.fasta reads.fastq outfolder/ --isoseq --t 8
    ```

### 3. All-in-One Pipeline
To run indexing and alignment in a single command:
```bash
uLTRA pipeline genome.fasta annotation.gtf reads.fastq outfolder/ [parameters]
```

## Expert Tips and Best Practices
*   **GTF Formatting**: uLTRA is sensitive to GTF formatting. If you have a GFF3 file or a non-standard GTF, use the AGAT toolkit (`agat_convert_sp_gff2gtf.pl`) to convert it. Standard conversion tools often omit features required by uLTRA.
*   **Output Management**: By default, uLTRA writes to `outfolder/reads.sam`. Use `--prefix <name>` to change the output filename (e.g., `--prefix sample_01` creates `sample_01.sam`).
*   **Index Reuse**: If you have already generated an index in a different directory, point to it using `--index /path/to/index_folder/` to avoid redundant indexing steps.
*   **Resource Allocation**: Use the `--t` parameter to specify the number of threads. Alignment is computationally intensive; 8-16 cores are recommended for standard datasets.

## Reference documentation
- [uLTRA GitHub Repository](./references/github_com_ksahlin_ultra.md)
- [uLTRA Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ultra_bioinformatics_overview.md)