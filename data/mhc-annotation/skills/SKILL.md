---
name: mhc-annotation
description: The `mhc-annotation` tool (invoked via the `mhca` command) is a specialized bioinformatic utility for identifying genes and transcripts within human MHC haplotypes.
homepage: https://github.com/DiltheyLab/MHC-annotation
---

# mhc-annotation

## Overview

The `mhc-annotation` tool (invoked via the `mhca` command) is a specialized bioinformatic utility for identifying genes and transcripts within human MHC haplotypes. It automates the alignment and annotation process, transforming raw genomic sequences into structured GFF files. This skill should be used during genomic analysis workflows where high-resolution annotation of the complex HLA region is required, particularly when working with de novo assemblies or specific haplotype sequences.

## Installation and Environment

The tool requires `minimap2` to be installed and available in your system PATH. It also depends on `biopython` and `bcbio-gff`.

**Conda Installation:**
```bash
conda install bioconda::mhc-annotation
```

**Pip Installation:**
```bash
pip install MHC-annotation
```

## Core Workflows

### 1. Annotating MHC Sequences
The primary function is to generate annotations for a FASTA file containing human MHC sequences.

```bash
mhca annotate <input_sequence.fa> <output_folder>
```
*   **Input**: A FASTA file containing sequences from the human HLA region.
*   **Output**: A GFF file containing gene and transcript information within the specified output folder.

### 2. Validating Coding Sequences (CDS)
After annotation, you should verify if the predicted transcripts produce valid protein products.

```bash
mhca check_CDS <input_sequence.fa> <output_folder/your_sequence.gff>
```
*   **Purpose**: Checks the integrity of the CDS in the generated GFF file.
*   **Requirement**: This command requires both the original FASTA and the GFF produced by the `annotate` command.

## Expert Tips and Best Practices

*   **Sequence Specificity**: This tool is strictly optimized for the human MHC region. Using it on non-human sequences or non-MHC regions will result in no meaningful output.
*   **Dependency Check**: Ensure `minimap2` is callable from the command line before running `mhca`. If using a Conda environment, ensure the environment is active.
*   **Output Management**: The tool creates an output folder. Ensure the path is writable and that you use the specific GFF file path generated inside that folder when running the `check_CDS` command.
*   **Broken Transcripts**: The tool includes logic to attempt annotation of IMGT-genes even if the transcript appears broken, which is useful for highly polymorphic HLA regions.

## Reference documentation
- [MHC-annotation GitHub Repository](./references/github_com_DiltheyLab_MHC-annotation.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_mhc-annotation_overview.md)