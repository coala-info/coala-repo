---
name: stag
description: STAG is a hierarchical taxonomic classifier that uses LASSO logistic regression to annotate metagenomic sequences, marker genes, and genomes. Use when user asks to classify gene sequences, perform taxonomic annotation of 16S amplicon data, or classify whole genomes.
homepage: https://github.com/zellerlab/stag
---


# stag

## Overview

STAG (hierarchical Taxonomic Classifier) is a specialized tool for the taxonomic annotation of metagenomic sequences. It is particularly effective for classifying marker genes, 16S amplicon data, and full genomes. Unlike standard classifiers, STAG utilizes a hierarchical workflow, training individual LASSO logistic regression classifiers for every node in a taxonomic tree. This allows the tool to calculate posterior probabilities at each rank, enabling it to stop classification at the most confident taxonomic level (e.g., assigning a sequence to a Family if the Genus cannot be determined with high certainty).

## Installation and Setup

The most reliable way to install stag and its dependencies (HMMER3, Easel, seqtk, prodigal) is via Bioconda:

```bash
conda install bioconda::stag
```

To verify that the installation and the environment are configured correctly, run the internal test suite:

```bash
stag test
```

## Core Workflows

### 1. Classifying Gene Sequences
Use the `classify` command for individual gene sequences or 16S amplicon reads.

```bash
stag classify -d <database.stagDB> -i <input_sequences.fasta>
```

*   **Output**: A tab-separated format showing the sequence ID and the inferred taxonomic lineage (e.g., `d__Bacteria;p__Proteobacteria;c__Gammaproteobacteria`).

### 2. Classifying Genomes
For whole-genome sequences, STAG uses `prodigal` to predict genes before performing classification.

**Single Genome:**
```bash
stag classify_genome -i <genome.fasta> -d <database.stagDB> -o <output_directory>
```

**Multiple Genomes (Batch):**
```bash
stag classify_genome -D <directory_of_fastas> -d <database.stagDB> -o <output_directory>
```

*   **Note**: When using `-D`, STAG will attempt to classify every FASTA file found within the specified directory.

## Expert Tips and Best Practices

*   **Database Matching**: Ensure you use the correct database type for your input. A database trained on 16S genes will not yield accurate results for general marker genes or whole genomes.
*   **Memory Management**: STAG databases (especially for genomes like GTDB) can be large. Ensure your environment has sufficient RAM to load the `.stagDB` file (which uses the HDF5 format).
*   **Handling Ranks**: If the output taxonomy string is short (e.g., only `d__Bacteria`), it indicates that the classifier could not confidently assign the sequence to lower ranks (Phylum, Class, etc.) based on the accrued posterior probabilities.
*   **Dependency Check**: If `classify_genome` fails, verify that `prodigal` is in your system PATH, as it is required for the initial gene prediction step.

## Reference documentation

- [STAG GitHub Repository](./references/github_com_zellerlab_stag.md)
- [STAG Wiki Home](./references/github_com_zellerlab_stag_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_stag_overview.md)