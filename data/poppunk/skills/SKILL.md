---
name: poppunk
description: PopPUNK performs rapid bacterial population clustering and genomic divergence estimation using k-mer based distances. Use when user asks to assign new samples to existing species databases, create new genomic models for uncharacterized species, or visualize population structures.
homepage: https://github.com/johnlees/PopPUNK
---


# poppunk

## Overview

PopPUNK (POPulation Partitioning Using Nucleotide Kmers) is a high-performance tool designed for bacterial population genetics. It utilizes k-mer based distances to estimate core and accessory genomic divergence between pairs of isolates, allowing for rapid clustering without the computational overhead of full-genome alignments. This skill provides guidance on the two primary workflows: assigning new samples to existing species databases and building new models for uncharacterized species.

## Installation

The recommended method for installation is via Conda:

```bash
conda install bioconda::poppunk
```

## Core Workflows

### 1. Assigning Samples to an Existing Database
Use this workflow when you have a supported species with a pre-calculated database.

*   **Basic Assignment**:
    ```bash
    poppunk_assign --db <database_directory> --query <input_list.txt> --output <output_dir>
    ```
*   **Stable Nomenclature**: To ensure new samples are assigned to their nearest neighbor without merging existing clusters (mimicking schemes like LIN), use the `--stable` flag:
    ```bash
    poppunk_assign --db <db> --query <queries> --output <out> --stable
    ```
*   **Database Updates**: To add the query samples to the reference database after assignment:
    ```bash
    poppunk_assign --db <db> --query <queries> --output <out> --update-db
    ```
    *Note: In PopPUNK v2.7.0+, the large `<db_name>.dists.npy` file is no longer required or written during assignment, saving significant disk space.*

### 2. Creating a New Species Database
Use this workflow when starting with a new set of genomes.

1.  **Sketching**: Generate k-mer sketches for your sequences.
    ```bash
    poppunk_sketch --r-file <reference_list.txt> --output <db_name> --cpus 8
    ```
2.  **Model Building**: Create the initial population partition.
    ```bash
    poppunk --create-db --r-file <reference_list.txt> --output <db_name>
    ```

## Common CLI Patterns and Tools

*   **Visualization**: Generate files for Microreact, Phandango, or Cytoscape.
    ```bash
    poppunk_visualise --db <db_dir> --output <out_dir> --microreact
    ```
*   **Information Retrieval**: Check the contents and model type of an existing database.
    ```bash
    poppunk_info --db <db_dir>
    ```
*   **Tree Generation**: Create a neighbor-joining or maximum likelihood tree from the distances.
    ```bash
    poppunk_mst --db <db_dir> --out <out_dir>
    ```

## Expert Tips and Troubleshooting

*   **Citations**: Run any command with the `--citation` flag to generate a list of relevant papers and a suggested methods paragraph for your publication.
*   **Model Compatibility**: If you encounter errors loading HDBSCAN models, it is likely due to a `scikit-learn` version mismatch (v1.0.0 changed the API). Resolve this by:
    1.  Refitting the model in your current environment.
    2.  Running model refinement to convert it into a boundary model.
*   **Memory Management**: For very large datasets, avoid using `--update-db` unless necessary, as the `.dists.pkl` file must still be managed.
*   **GPU Acceleration**: If `pp-sketchlib` is compiled with CUDA support, PopPUNK can significantly speed up distance calculations on compatible hardware.

## Reference documentation

- [PopPUNK GitHub Repository](./references/github_com_bacpop_PopPUNK.md)
- [PopPUNK Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_poppunk_overview.md)