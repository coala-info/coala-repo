---
name: pavfinder
description: PAVFinder (Post-Assembly Variant Finder) is a bioinformatic tool designed to identify structural variations by analyzing the non-contiguous alignment of assembled contigs against a reference genome.
homepage: https://github.com/bcgsc/pavfinder
---

# pavfinder

## Overview
PAVFinder (Post-Assembly Variant Finder) is a bioinformatic tool designed to identify structural variations by analyzing the non-contiguous alignment of assembled contigs against a reference genome. By focusing on split or gapped alignments, it can resolve complex events—such as translocations, inversions, and novel splice junctions—that are often difficult to characterize using short-read mapping alone. It supports specialized workflows for whole-genome analysis, targeted transcriptome pipelines (TAP/TAP2), and gene fusion detection (Fusion-Bloom).

## Installation and Environment
The package is available via Bioconda. Ensure the environment has the necessary aligners (BWA or GMAP) installed.

```bash
conda install bioconda::pavfinder
```

## Core Workflows and CLI Patterns

### 1. Genomic Structural Variant Detection
Used for identifying translocations, inversions, duplications, and indels in genomic assemblies.
*   **Prerequisite**: Align contigs to the reference genome (c2g) using `bwa mem`.
*   **Command**: `pavfinder genome [options]`
*   **Key Outputs**: Detected genomic SVs including simple-repeat expansions and contractions.

### 2. Transcriptomic Variant Detection
Used for identifying gene fusions, internal tandem duplications (ITD), and partial tandem duplications (PTD).
*   **Prerequisite**: Align transcript contigs to the reference genome using `gmap`.
*   **Command**: `pavfinder fusion [options]`
*   **Note**: For high-sensitivity fusion calling, use the **Fusion-Bloom** pipeline which integrates PAVFinder with RNA-Bloom.

### 3. Splice Variant Analysis
Used for characterizing transcript isoforms, including skipped exons, novel exons/introns, and retained introns.
*   **Command**: `pavfinder splice [options]`
*   **Function**: Infers novel splice acceptors and donors from gapped contig alignments.

## Specialized Pipelines

### TAP and TAP2 (Targeted-Assembly-Pipeline)
Use these for clinical or focused research where only specific genes (e.g., COSMIC genes) are of interest.
*   **TAP**: Uses Trans-ABySS for assembly.
*   **TAP2**: Uses RNA-Bloom for assembly (successor to TAP).
*   **Advantage**: Significantly reduces processing time (e.g., from 24+ hours for whole transcriptome to <30 minutes for targeted sets) by using a multi-index Bloom Filter of target sequences.

## Expert Tips and Best Practices
*   **Alignment Selection**: Always use `bwa mem` for genomic contig-to-genome (c2g) alignments and `gmap` for transcriptomic c2g alignments to ensure proper gap handling.
*   **Read Support (r2c)**: To increase confidence in detected variants, gather read support by aligning the original raw reads back to the assembled contigs (r2c) using `bwa mem`.
*   **Input Quality**: PAVFinder's accuracy is directly dependent on the quality of the de novo assembly. Ensure the assembly tool used (ABySS, RNA-Bloom, etc.) is optimized for the specific data type.
*   **Test Data**: For initial setup verification, refer to the `pavfinder/test` directory in the source repository which contains small datasets for transcriptome and genome workflows.

## Reference documentation
- [PAVFinder GitHub Repository](./references/github_com_bcgsc_pavfinder.md)
- [Bioconda PAVFinder Overview](./references/anaconda_org_channels_bioconda_packages_pavfinder_overview.md)