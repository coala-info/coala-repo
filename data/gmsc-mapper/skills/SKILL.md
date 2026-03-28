---
name: gmsc-mapper
description: gmsc-mapper is a bioinformatics pipeline for predicting and aligning small proteins from metagenomic data against the Global Microbial SmORF Catalog. Use when user asks to predict smORFs from raw contigs, map amino acid or nucleotide sequences to the GMSC, or provide ecological and evolutionary context for small proteins.
homepage: https://github.com/BigDataBiology/GMSC-mapper
---


# gmsc-mapper

## Overview

gmsc-mapper is a specialized bioinformatics pipeline for the analysis of small proteins within the global microbiome. It handles the end-to-end process of predicting smORFs from raw contigs or taking pre-defined gene sequences (nucleotide or amino acid) and aligning them against the GMSC. By leveraging optimized aligners like DIAMOND and MMseqs2, it provides ecological and evolutionary context to small proteins that are frequently missed by standard annotation pipelines.

## Database Preparation

Before running annotations, you must prepare the local GMSC reference.

1.  **Download the database**:
    ```bash
    gmsc-mapper downloaddb --dbdir ./gmsc_db
    ```
2.  **Create the index**:
    Choose an aligner (DIAMOND is default and generally faster; MMseqs2 is available for specific sensitivity requirements).
    ```bash
    # For DIAMOND (Default)
    gmsc-mapper createdb -i ./gmsc_db/GMSC10.90AA.faa.gz -o ./gmsc_db -m diamond

    # For MMseqs2
    gmsc-mapper createdb -i ./gmsc_db/GMSC10.90AA.faa.gz -o ./gmsc_db -m mmseqs
    ```

## Common Mapping Patterns

The tool automatically detects the workflow based on the input flag used.

### 1. Predicting from Raw Contigs
Use this when you have unannotated genomic or metagenomic assemblies.
```bash
gmsc-mapper -i assembly.fasta --dbdir ./gmsc_db -o ./output_dir
```

### 2. Mapping Amino Acid Sequences
Use this when you already have predicted protein sequences.
```bash
gmsc-mapper --aa-genes proteins.faa --dbdir ./gmsc_db -o ./output_dir
```

### 3. Mapping Nucleotide Genes
Use this for predicted gene sequences that require translation before mapping.
```bash
gmsc-mapper --nt-genes genes.fna --dbdir ./gmsc_db -o ./output_dir
```

## Expert Tips and Best Practices

*   **Tool Selection**: If you created the database index with MMseqs2, you must explicitly specify the tool during the mapping phase using `--tool mmseqs`.
*   **Performance Optimization**: If you only need specific information, disable unnecessary annotation modules to reduce processing time and output clutter:
    ```bash
    gmsc-mapper -i input.fasta --dbdir ./db --no-habitat --no-taxonomy --no-quality --no-domain
    ```
*   **Output Interpretation**:
    *   `predicted.filtered.smorf.faa`: Contains the actual sequences of smORFs found in your contigs.
    *   `alignment.out.smorfs.tsv`: The raw alignment hits; useful for custom filtering by e-value or bitscore.
    *   `habitat.out.smorfs.tsv`: Provides ecological context (e.g., soil, human gut).
*   **Citation**: To ensure reproducible research, print the citation for the specific GMSC version used:
    ```bash
    gmsc-mapper citation
    ```
*   **Environment Management**: Avoid heavy top-level imports if modifying the tool; keep dependencies like `pandas` or `numpy` inside functional blocks to maintain CLI responsiveness.



## Subcommands

| Command | Description |
|---------|-------------|
| downloaddb | Download the GMSCMapper database. |
| gmsc-mapper createdb | Create a database for GMSC. |

## Reference documentation

- [GMSC-mapper README](./references/github_com_BigDataBiology_GMSC-mapper_blob_main_README.md)
- [GMSC-mapper Agent Guidelines](./references/github_com_BigDataBiology_GMSC-mapper_blob_main_AGENTS.md)
- [GMSC-mapper ChangeLog](./references/github_com_BigDataBiology_GMSC-mapper_blob_main_ChangeLog.md)