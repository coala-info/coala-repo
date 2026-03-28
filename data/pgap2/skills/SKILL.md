---
name: pgap2
description: PGAP2 is a high-performance toolkit for the rapid construction and analysis of prokaryotic pan-genomes using sequence similarity and gene synteny. Use when user asks to perform pan-genome clustering, generate presence-absence variation matrices, construct single-copy core phylogenetic trees, or conduct population clustering and evolutionary analysis.
homepage: https://github.com/bucongfan/PGAP2
---

# pgap2

## Overview

PGAP2 (Pan-Genome Analysis Pipeline 2) is a high-performance toolkit designed for the rapid construction and analysis of prokaryotic pan-genomes. It utilizes a Fine-Grained Feature Network—combining gene identity (sequence similarity) and gene synteny (positional adjacency)—to accurately identify orthologous groups even in highly variable regions. The tool is optimized for scale, capable of processing 1,000 genomes in approximately 20 minutes. It supports a full workflow from raw sequence data and quality control to phylogenetic tree construction and population clustering.

## Core Workflows

### 1. Preprocessing (Quality Control)
Use the `prep` module to validate input data and generate interactive visualizations.
```bash
pgap2 prep -i input_dir/ -o output_dir/
```
*   **Inputs**: Supports mixed formats (GFF, GBFF, FASTA) in one directory.
*   **Output**: Generates an interactive HTML report and vector figures for data inspection.

### 2. Main Pan-Genome Construction
The `main` module performs the core clustering and network association.
```bash
pgap2 main -i input_dir/ -o output_dir/
```
*   **Mixed Inputs**: Automatically recognizes Prokka-style GFFs, GenBank (GBFF), and FASTA files.
*   **FASTA-only Input**: If providing only genome FASTA files, you must include the `--annot` flag to trigger structural annotation.
*   **Refinement Flags**:
    *   `--retrieve`: Uses `miniprot` and `seqtk` to find missing gene loci and reduce "false" absences in the PAV (Presence-Absence Variation) matrix.
    *   `--reannot`: Re-annotates all genomes using `prodigal` to ensure consistent gene calling across the dataset.

### 3. Postprocessing and Downstream Analysis
The `post` module contains several submodules for specific biological insights. The input directory for these commands should be the output directory from the `main` step.

*   **Statistical Profiling**:
    ```bash
    pgap2 post profile -i main_output/ -o post_output/
    # Or run independently using a PAV file
    pgap2 post profile --pav your_pav_file.csv -o post_output/
    ```
*   **Phylogenetic Tree (Single-copy Core)**:
    ```bash
    pgap2 post singletree -i main_output/ -o post_output/
    ```
*   **Population Clustering (BAPS)**:
    ```bash
    pgap2 post baps -i main_output/ -o post_output/
    ```
*   **Evolutionary Analysis (Tajima's D)**:
    ```bash
    pgap2 post tajima -i main_output/ -o post_output/
    ```

## Expert Tips and Best Practices

*   **Input Consistency**: While PGAP2 handles mixed formats, using `--reannot` is recommended when combining genomes from different sources (e.g., RefSeq vs. in-house assemblies) to avoid annotation bias.
*   **Handling "Sticky" Nodes**: PGAP2 automatically resolves nodes that are sequence-similar but syntenically distant (e.g., paralogs or transposable elements) using the Conserved Gene Neighbor (CGN) rule.
*   **Insertion Sequences**: The pipeline performs a specific merging step for sequences with >99% similarity regardless of synteny to prevent highly mobile elements from fragmenting the synteny network.
*   **Performance Tuning**: For large datasets (>1,000 genomes), ensure `diamond` and `mmseqs2` are installed, as they are significantly faster than `blast+` and `cd-hit` for the initial identity network construction.
*   **Dependency Management**: Use the Mamba solver for installation to resolve the complex bio-dependency tree (R packages, alignment tools, and phylogeny software) more reliably than standard Conda.



## Subcommands

| Command | Description |
|---------|-------------|
| pgap2 main | Main entry point for pgap2. |
| pgap2 post | Performs post-processing analysis on pangenome data. |
| pgap2_add | Add new sequences to an existing PGAP2 analysis. |
| pgap2_prep | Prepares input data for pgap2. |

## Reference documentation
- [PGAP2 GitHub README](./references/github_com_bucongfan_PGAP2.md)
- [PGAP2 Algorithm Details](./references/github_com_bucongfan_PGAP2_wiki_Algorithm.md)
- [PGAP2 Installation Guide](./references/github_com_bucongfan_PGAP2_wiki_Installation.md)
- [PGAP2 Quick Start](./references/github_com_bucongfan_PGAP2_wiki_Quick-start.md)