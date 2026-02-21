---
name: quatradis
description: QuaTradis (Quadram TraDIS) is a comprehensive bioinformatics pipeline designed to handle the end-to-end processing of transposon insertion libraries.
homepage: https://github.com/quadram-institute-bioscience/QuaTradis
---

# quatradis

## Overview
QuaTradis (Quadram TraDIS) is a comprehensive bioinformatics pipeline designed to handle the end-to-end processing of transposon insertion libraries. It transforms raw FASTQ data into spatial insertion plots and provides tools for downstream comparative analysis. This skill enables the efficient execution of mapping workflows, the generation of gene-essentiality predictions, and the identification of conditionally essential genes across multiple experimental datasets.

## Core CLI Usage
The primary interface for the toolkit is the `tradis` executable. All sub-commands and pipelines are accessed through this single entry point.

### Pipeline Execution
The most common entry point for new datasets is the plot creation pipeline:
```bash
tradis pipeline create_plots -f <fastq_list.txt> -r <reference.fa> -t <tag_sequence>
```
*   **fastq_list.txt**: A simple text file containing paths to your FASTQ files (one per line).
*   **reference.fa**: The genomic reference sequence in FASTA format.
*   **tag_sequence**: The transposon tag sequence used in the sequencing protocol.

### Common Sub-commands
*   `tradis pipeline analyse`: Runs the full analysis suite on existing plot files.
*   `tradis pipeline compare`: Performs comparative analysis between control and test conditions.
*   `tradis combine`: Merges multiple plot files into a single representative dataset.

## Best Practices and Expert Tips
*   **Environment Management**: Due to complex dependencies between Python, R (specifically `edgeR`), and alignment tools (BWA/SMALT), always run QuaTradis within a dedicated Conda environment. Python 3.10 is the recommended version for stability.
*   **Reference Indexing**: Ensure your reference genome is indexed using `bwa index` or `smalt index` before starting the pipeline to prevent runtime errors during the mapping stage.
*   **R Dependencies**: If the comparative analysis fails, verify that the R packages `edgeR`, `getopt`, and `MASS` are correctly installed and accessible to the shell environment.
*   **Input Validation**: FASTQ files can be provided in gzipped format (.gz) to save disk space; the pipeline handles decompression automatically.
*   **Plot File Integrity**: When using the `combine` function, verify the plot file lengths match the reference genome length to ensure no data truncation occurred during the mapping of reads near the end of the sequence.
*   **Docker for Reproducibility**: For production environments or when encountering OS-specific library conflicts (especially on non-Debian systems), use the official Docker image: `docker pull sbastkowski/quatradis`.

## Reference documentation
- [QuaTradis GitHub Repository](./references/github_com_quadram-institute-bioscience_QuaTradis.md)
- [QuaTradis Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_quatradis_overview.md)