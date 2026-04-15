---
name: traitar
description: Traitar predicts microbial phenotypes and metabolic traits from genomic sequences using machine learning models and protein family annotations. Use when user asks to predict phenotypes from nucleotide or protein sequences, identify protein families within a genome, or inspect the features contributing to specific trait predictions.
homepage: http://github.com/aweimann/traitar
metadata:
  docker_image: "quay.io/biocontainers/traitar:3.0.1--pyhdfd78af_0"
---

# traitar

## Overview
Traitar (the microbial trait analyzer) is a computational framework designed to bridge the gap between genomic data and microbial ecology. It automates the process of phenotyping microbes by identifying protein families (Pfams) within a genome and applying pre-trained machine learning models to predict the presence or absence of specific biological traits. It is particularly useful for researchers working with newly sequenced isolates or metagenome-assembled genomes (MAGs) who need to understand the metabolic capabilities and environmental preferences of their samples.

## Core Workflows

### Phenotype Prediction from Nucleotides
Use this command for raw genomic sequences (FASTA). It runs the full pipeline: ORF prediction (Prodigal), Pfam annotation (HMMER), and phenotype classification.

```bash
traitar phenotype <in_dir> <sample_file> from_nucleotides <out_dir> -c <threads>
```

### Phenotype Prediction from Genes
Use this if you have already performed gene prediction and have protein sequences available.

```bash
traitar phenotype <in_dir> <sample_file> from_genes <out_dir> -c <threads>
```

### Model Inspection
To understand which protein families contribute to a specific trait prediction, use the `show` command.

```bash
traitar show '<Trait Name>' --predictor <phypat|phypat+PGL>
```
*Example:* `traitar show 'Glucose fermenter'`

## Input Requirements

### Sample File Format
The `<sample_file>` must be a tab-separated file with a mandatory header row.
```text
sample_file_name	sample_name	category
genome1.fasta	Staph_aureus	Pathogen
genome2.fasta	B_subtilis	Soil
```

### Pfam Models
Traitar requires Pfam 27.0 HMM models. If they are not present, initialize them:
```bash
# Download and extract automatically
traitar pfam <path_to_download_folder>

# Or point to a local manual download
traitar pfam --local <path_to_pfam_folder>
```

## Best Practices and Tips

- **Parallelization**: Always use the `-c` flag (e.g., `-c 8`) to enable parallel processing via GNU Parallel, as Pfam annotation is computationally expensive.
- **Resuming Jobs**: If a run is interrupted, Traitar can resume from the last successful step if pointed to the same `<out_dir>` in interactive mode.
- **Feature Tracks**: If using `from_nucleotides`, Traitar generates GFF files in the output directory. These can be loaded into a genome browser (like IGV or JBrowse) to visualize exactly where trait-relevant genes are located on the contigs.
- **Classifier Selection**: 
    - `phypat`: Pure phyletic pattern classifier.
    - `phypat+PGL`: Phylogeny-aware classifier (often more accurate as it accounts for evolutionary relationships).
- **Output Interpretation**:
    - `0`: Negative prediction.
    - `1`: Predicted by `phypat` only.
    - `2`: Predicted by `phypat+PGL` only.
    - `3`: Supported by both algorithms (highest confidence).



## Subcommands

| Command | Description |
|---------|-------------|
| traitar annotate | Annotate genomes |
| traitar new | create new phenotype model archive |
| traitar pfam | Download and uncompress pfam files. The files are required for gene annotation. |
| traitar phenotype | Annotate genomes and then run phenotyping |
| traitar_evaluate | compare Traitar predictions against a given standard of truth |
| traitar_remove | remove phenotypes from a given phenotype archive |
| traitar_show | show features important for classification |

## Reference documentation
- [Traitar README](./references/github_com_aweimann_traitar_blob_master_README.md)
- [Installation Guide](./references/github_com_aweimann_traitar_blob_master_INSTALL.md)
- [Trait List](./references/github_com_aweimann_traitar_blob_master_traits.tsv.md)