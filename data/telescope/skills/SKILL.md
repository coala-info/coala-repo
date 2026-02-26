---
name: telescope
description: Telescope estimates the expression of individual transposable element loci by reassigning multi-mapping RNA-seq reads using a Bayesian model. Use when user asks to quantify specific transposable element insertions, reassign multi-mapping reads, or analyze locus-specific TE expression.
homepage: https://github.com/mlbendall/telescope
---


# telescope

## Overview
Telescope provides a specialized workflow for estimating the expression of individual transposable element loci. Standard RNA-seq pipelines often struggle with TEs because reads frequently map to multiple highly similar genomic locations. Telescope addresses this by taking multi-mapping alignments and an annotation file as input, then applying a Bayesian model to reassign reads to their most likely locus of origin. This allows for precise quantification of specific TE insertions rather than just family-level summaries.

## Installation and Setup
The most reliable way to install Telescope is via Bioconda:
```bash
conda install -c bioconda telescope
```

## Core Workflow: telescope assign
The primary command is `assign`, which performs the read reassignment and quantification.

### 1. Input Requirements
*   **SAM/BAM File**: Must contain multi-mapping reads (e.g., aligned with `bowtie2 -k 100` or `star --outFilterMultimapNmax 100`).
*   **Sorting**: Input files **must** be sorted by read name or collated so that all alignments for a specific read pair appear sequentially. Coordinate-sorted BAMs will not work.
    *   *Tip*: Use `samtools sort -n` or `samtools collate` to prepare your BAM.
*   **Annotation**: A GTF file defining the TE loci.

### 2. Basic Usage
```bash
telescope assign alignment.bam annotation.gtf
```

### 3. Advanced CLI Patterns
*   **Handling Strandedness**: If your library is stranded, specify the orientation to improve accuracy:
    ```bash
    # For typical Illumina TruSeq stranded (Read 1 reverse, Read 2 forward)
    telescope assign --stranded_mode RF alignment.bam annotation.gtf
    ```
*   **Adjusting Overlap Sensitivity**: By default, 20% of a fragment must overlap a feature. For stricter or looser requirements:
    ```bash
    telescope assign --overlap_threshold 0.5 alignment.bam annotation.gtf
    ```
*   **Reassignment Modes**: Control how the final counts are reported for fragments that remain ambiguous after EM:
    *   `exclude`: (Default) Excludes fragments with multiple "best" assignments.
    *   `average`: Divides the fragment count evenly among best assignments.
    *   `choose`: Randomly selects one of the best assignments.
    *   `unique`: Only includes uniquely aligned reads.

## Expert Tips
*   **Alignment Strategy**: When aligning reads for Telescope, ensure your aligner is configured to report multiple alignments per read. If you only provide unique mappers, the EM algorithm cannot effectively resolve the repetitive landscape.
*   **Updated SAM**: If you need to visualize the reassigned reads in a genome browser (like IGV), use the `--updated_sam` flag. This generates a new SAM file where the `AS` (Alignment Score) and other tags are updated based on the Telescope model.
*   **GTF Attributes**: If your GTF uses a custom attribute to define a locus (other than the default `locus`), specify it with `--attribute YOUR_ATTR_NAME`.
*   **Performance**: While `--ncpu` is an available argument, note that multi-core support may be limited in certain versions; monitor system resources to verify parallel execution.

## Reference documentation
- [Telescope GitHub Repository](./references/github_com_mlbendall_telescope.md)
- [Bioconda Telescope Package](./references/anaconda_org_channels_bioconda_packages_telescope_overview.md)