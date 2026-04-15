---
name: kb-python
description: kb-python is a unified wrapper for the kallisto and bustools suite that processes single-cell RNA-seq data into gene-count matrices. Use when user asks to build a reference index, generate count matrices from FASTQ files, or extract specific reads from sequencing data.
homepage: https://github.com/pachterlab/kb_python
metadata:
  docker_image: "quay.io/biocontainers/kb-python:0.30.0--pyh7e72e81_0"
---

# kb-python

## Overview

`kb-python` (invoked via the `kb` command) is a unified wrapper for the `kallisto` and `bustools` suite. It simplifies the complex single-cell RNA-seq preprocessing pipeline into a few high-level commands. By wrapping these tools, it provides a streamlined workflow for transforming raw FASTQ files into gene-count matrices while maintaining high efficiency and low memory usage.

## Installation

Install the latest stable version via pip:

```bash
pip install kb-python
```

The package includes the necessary `kallisto` and `bustools` binaries, so no additional tool installation is required.

## Core Workflows

### 1. Building a Reference Index (`kb ref`)

Before quantification, you must build a species-specific index from a genome FASTA and a GTF annotation file.

```bash
kb ref -i index.idx -g t2g.txt -f1 transcriptome.fa <GENOME_FASTA> <GENOME_GTF>
```

*   **-i**: Path to the output kallisto index.
*   **-g**: Path to the output transcript-to-gene (T2G) mapping file.
*   **-f1**: Path to the output transcriptome FASTA file.
*   **Expert Tip**: Use the `gget` tool to quickly locate and download the correct Ensembl FASTA and GTF files for your species.

### 2. Generating Count Matrices (`kb count`)

This is the primary command for processing raw sequencing data. It performs pseudoalignment, barcode processing, and UMI counting.

```bash
kb count -i index.idx -g t2g.txt -x <TECHNOLOGY> -o <OUTPUT_DIR> <FASTQ_FILES>
```

*   **-x (Technology)**: Specifies the single-cell technology used. Common strings include:
    *   `10xv2` or `10xv3` (10x Genomics)
    *   `chromium`
    *   `dropseq`
    *   `smartseq`
    *   `indropv1`, `indropv2`
*   **-o**: Directory where the resulting count matrices (in MTX format) and BUS files will be stored.
*   **FASTQ_FILES**: Provide the paths to the R1 and R2 files (and R3 if applicable).

### 3. Extracting Reads (`kb extract`)

Use this to isolate reads that pseudoaligned to specific genes or transcripts, or to filter reads based on alignment status.

```bash
kb extract -i index.idx -g t2g.txt -o <OUTPUT_FASTQ> <FASTQ_FILES>
```

## Best Practices and Tips

*   **Memory Efficiency**: `kb-python` is designed for constant-memory processing. It is suitable for large datasets on machines with limited RAM.
*   **Prebuilt Indices**: To save time, check the Pachter Lab's repository for prebuilt kallisto transcriptome indices for common species (Human, Mouse).
*   **Validation**: Always verify the technology string (`-x`). An incorrect string will lead to failed barcode/UMI extraction and empty count matrices.
*   **Workflow Unification**: `kb` handles the intermediate steps of `bustools` (sorting, inspecting, whitelisting, and transforming) automatically. Only use the underlying tools directly if you need custom BUS file manipulation.



## Subcommands

| Command | Description |
|---------|-------------|
| kb | kb_python 0.30.0 |
| kb count | Generate count matrices from a set of single-cell FASTQ files. Run `kb --list` to view single-cell technology information. |
| kb ref | Build a kallisto index and transcript-to-gene mapping |
| kb-python kb --list | List of supported single-cell technologies |

## Reference documentation
- [kb-python README](./references/github_com_pachterlab_kb_python_blob_master_README.md)
- [kb-python Overview](./references/anaconda_org_channels_bioconda_packages_kb-python_overview.md)