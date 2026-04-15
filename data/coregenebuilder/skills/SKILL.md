---
name: coregenebuilder
description: CoreGeneBuilder identifies the conserved core genome of a bacterial species by comparing multiple genomic assemblies against a reference. Use when user asks to identify core genes, perform pangenome analysis, or extract conserved genetic sequences from bacterial assemblies.
homepage: https://github.com/C3BI-pasteur-fr/CoreGeneBuilder
metadata:
  docker_image: "biocontainers/coregenebuilder:v1.0_cv2"
---

# coregenebuilder

## Overview

CoreGeneBuilder is a specialized bioinformatics pipeline designed to identify the conserved genetic core of a bacterial species. It automates the process of taking multiple genomic assemblies, comparing them against a reference, and extracting the sequences (both nucleic and amino-acid) that constitute the core or persistent genome. This tool is essential for pangenome analysis and understanding the shared genetic backbone of bacterial populations.

## Directory Setup

Before running the tool, you must organize your input data into a specific directory structure. CoreGeneBuilder expects a project directory (referred to here as `$DIR`) containing the following:

1.  **assemblies/**: Create this subdirectory and place all genome fasta files here.
    *   Accepted extensions: `.fasta`, `.fas`, `.fa`, `.fna`.
    *   The reference genome fasta file (specified by `-g`) must also be in this directory.
2.  **ref_gbk_annotation/**: Create this subdirectory and place the reference GenBank annotation file here.

## Command Line Usage

The primary command is `coregenebuilder`. Below is the standard pattern for execution:

```bash
coregenebuilder -d $DIR -n $SPECIES_TAG -g $REF_FASTA -a $REF_GBK -e $CONTIG_PREFIX -p $IDENTITY -t $THREADS
```

### Parameter Guide

*   `-d`: The path to your analysis project directory.
*   `-n`: A short designation or tag for the genomes (e.g., `klpn` for *Klebsiella pneumoniae*).
*   `-g`: The filename of the reference genome fasta (must reside in `$DIR/assemblies`).
*   `-a`: The filename of the reference GenBank annotation (must reside in `$DIR/ref_gbk_annotation`).
*   `-e`: The prefix used for contig IDs in the reference files (e.g., `NC_`).
*   `-p`: The identity percentage threshold for core gene identification (e.g., `95`).
*   `-t`: The number of CPU threads to utilize.

## Expert Tips and Best Practices

*   **Contig ID Matching**: Ensure the value provided to `-e` accurately matches the start of the contig identifiers in both your reference fasta and GenBank files, or the pipeline may fail to link annotations to sequences.
*   **Docker Execution**: If running via Docker, you must mount your local data directory to the container's internal path.
    *   Example: `docker run -v /path/to/local_data:/root/mydisk coregenebuilder`
*   **Output Inspection**: After a successful run, the results are organized into specific subfolders:
    *   `core_genome/`: Contains the final core gene sequences in nucleic and amino-acid formats.
    *   `genes/` and `proteins/`: Contain the CDS sequences for all processed genomes.
    *   `progress_file.txt`: Check this file to verify the status of each module (DIVERSITY, ANNOTATION, COREGENOME).
*   **Resource Management**: For large datasets (many assemblies), increase the thread count (`-t`) to significantly speed up the ANNOTATION and COREGENOME modules.

## Reference documentation

- [CoreGeneBuilder Main Documentation](./references/github_com_C3BI-pasteur-fr_CoreGeneBuilder.md)