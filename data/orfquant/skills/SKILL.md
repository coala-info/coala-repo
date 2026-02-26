---
name: orfquant
description: "orfquant is an R package for the de-novo identification and quantification of open reading frames from ribosome profiling data. Use when user asks to perform de-novo ORF finding, quantify translation at single-ORF resolution, or analyze Ribo-seq data while accounting for alternative splicing."
homepage: https://github.com/ohlerlab/ORFquant
---


# orfquant

## Overview

orfquant is an R package designed for the analysis of ribosome profiling (Ribo-seq) data with a focus on single-ORF resolution. While many tools quantify translation at the gene or transcript level, orfquant performs de-novo ORF finding and quantification that accounts for alternative splicing. The pipeline typically involves transcript filtering, ORF identification, quantification, and detailed annotation in both transcript and genomic space.

## Installation

The package can be installed via R using devtools or through Bioconda:

```R
# R installation
library("devtools")
install_github(repo = "ohlerlab/ORFquant")
library("ORFquant")
```

```bash
# Conda installation
conda install bioconda::orfquant
```

## Core Workflow

The orfquant analysis pipeline consists of three primary stages.

### 1. Annotation Preparation
Before processing Ribo-seq data, you must parse the genome annotation and sequence files. This step only needs to be performed once per genome/annotation combination.

*   **Function**: `prepare_annotation_files`
*   **Required Inputs**: 
    *   A `.gtf` file containing gene models.
    *   A `.2bit` file containing the genome sequence.
*   **Tip**: If you only have a FASTA file, convert it to `.2bit` using the `faToTwoBit` utility from UCSC.

### 2. Input File Generation
Convert Ribo-seq alignment files (.bam) into the specific format required by orfquant.

*   **Function**: `prepare_for_ORFquant`
*   **Alternative (Recommended)**: Use the `Ribo-seQC` package to create these input files, as it provides robust quality control and preprocessing specifically tuned for orfquant.

### 3. Master Analysis Execution
Run the full analysis workflow, which includes transcript filtering, de-novo ORF finding, quantification, and annotation.

*   **Function**: `run_ORFquant`
*   **Scope**: Can be run on individual genes for testing or on entire transcriptomes for full studies.
*   **Output**: Returns an object containing quantified ORFs and their associated annotations (e.g., alternative splice site usage, uORF translation).

## Best Practices and Expert Tips

*   **Splice-Awareness**: Always ensure your input BAM files are generated using a splice-aware aligner (like STAR) to take full advantage of orfquant's ability to resolve translation across junctions.
*   **Genome Sequences**: When using `prepare_annotation_files`, you can pass a FASTA file directly in newer versions, but `.2bit` remains the standard for performance.
*   **Visualization**: Use the `plot_orfquant_locus` function to inspect translation patterns at specific genomic loci and verify quantification results visually.
*   **Memory Management**: For entire transcriptomes, ensure the R environment has sufficient memory, as the package handles complex genomic features and large Ribo-seq data structures.

## Reference documentation

- [orfquant - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_orfquant_overview.md)
- [ohlerlab/ORFquant: An R package for Splice-aware quantification of translation using Ribo-seq data](./references/github_com_ohlerlab_ORFquant.md)