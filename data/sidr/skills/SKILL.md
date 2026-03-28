---
name: sidr
description: SIDR uses machine learning to classify and separate target genomic sequences from contaminants based on features like GC content and sequencing coverage. Use when user asks to refine genomic assemblies, filter out sequence contaminants, or classify contigs using decision trees.
homepage: https://github.com/damurdock/SIDR
---


# sidr

## Overview

SIDR (Sequence Identification with Decision tRees) is a bioinformatics tool designed to refine genomic assemblies by separating target sequences from contaminants. It automates the creation of a machine-learning classifier (Decision Tree) that uses sequence-specific features—primarily GC content and per-base sequencing coverage—to predict whether a contig belongs to a specified target taxon. By using a subset of sequences with known taxonomic assignments (from BLAST) as a training set, SIDR can classify the remaining unassigned sequences in an assembly, providing a more comprehensive filter than simple taxon-searching alone.

## Usage Patterns

### Default Mode
Use this mode when you have raw bioinformatics files and need SIDR to calculate features (GC and coverage) automatically.

```bash
sidr default \
    -d /path/to/ncbi/taxdump \
    -b alignment.bam \
    -f assembly.fasta \
    -r blast_results.txt \
    -t "Arthropoda" \
    -k keep.contigids \
    -x remove.contigids
```

**Required Inputs:**
- `-d`: Path to the NCBI taxdump directory (containing `nodes.dmp` and `names.dmp`).
- `-b`: BAM file of reads mapped back to the assembly (used to calculate coverage).
- `-f`: The assembly FASTA file (used to calculate GC content).
- `-r`: BLAST results (typically `outfmt 6` or `7`) used for training the model.
- `-t`: The target phylum or taxon name to keep.

### Runfile Mode
Use this mode if you have already calculated your own variables (e.g., different coverage metrics or k-mer frequencies) and want to provide them in a tabular format.

```bash
sidr runfile \
    -i features.tsv \
    -t "Chordata" \
    -k keep.contigids \
    -x remove.contigids
```

**Input Format:**
The runfile (`-i`) should be a tab-delimited file containing contig IDs, your custom variables, and the taxonomic classification.

## Expert Tips and Best Practices

- **Taxdump Preparation**: Ensure the NCBI taxdump is up to date and the directory contains both `nodes.dmp` and `names.dmp`. The target phylum name provided with `-t` must match the taxdump exactly.
- **BLAST Formatting**: For the default mode, BLAST results should ideally include the `staxids` (Subject Taxonomy IDs) to allow SIDR to map hits to the taxdump correctly.
- **BAM Indexing**: Ensure your BAM file is sorted and indexed (`samtools index`) before running SIDR to prevent errors during coverage calculation.
- **Output Interpretation**:
    - `keep.contigids`: A list of IDs the model classified as the target organism.
    - `remove.contigids`: A list of IDs classified as contaminants or "other."
- **Filtering Strategy**: Use the resulting `keep.contigids` file with a tool like `seqtk` or a custom script to extract the desired sequences from your original FASTA for downstream assembly or analysis.



## Subcommands

| Command | Description |
|---------|-------------|
| default | Runs the default analysis using raw preassembly data. |
| sidr_runfile | Runs a custom analysis using pre-computed data from BBMap or other sources. |

## Reference documentation

- [SIDR GitHub README](./references/github_com_damurdock_SIDR_blob_master_README.rst.md)
- [SIDR Package Metadata](./references/github_com_damurdock_SIDR_blob_master_setup.py.md)