---
name: orthologer
description: OrthoLoger identifies orthologous genes by mapping sequences to the OrthoDB database or performing de novo ortholog discovery across multiple species. Use when user asks to map protein sequences to OrthoDB taxonomic nodes, perform de novo ortholog discovery, or identify orthologous groups among custom FASTA files.
homepage: https://orthologer.ezlab.org
metadata:
  docker_image: "quay.io/biocontainers/orthologer:3.9.0--py312hf097cbd_0"
---

# orthologer

## Overview
OrthoLoger is a high-performance standalone pipeline used to identify orthologous genes—genes in different species that originated from a single ancestral gene through speciation. This skill enables the use of two primary workflows: `ODB-mapper`, which assigns your sequences to existing OrthoDB orthologous groups, and `orthologer`, which performs de novo ortholog discovery among a provided set of FASTA files. It leverages optimized tools like DIAMOND or MMseqs2 for homology searches and BRHCLUS for clustering.

## Command Line Usage

### ODB-mapper (Annotation)
Use `ODB-mapper` to map your protein sequences against the OrthoDB database for functional annotation.

*   **Basic Mapping**: Map a FASTA file to a specific OrthoDB taxonomic node.
    ```bash
    ODB-mapper MAP <mylabel> <input.fasta> <tax_node_id>
    ```
*   **High Sensitivity**: Disable subsampling to use the full OrthoDB dataset (requires more resources).
    ```bash
    ODB-mapper MAP <mylabel> <input.fasta> <tax_node_id> subsample=no
    ```
*   **Retrieve Results**: Once the mapping is complete, extract the results.
    ```bash
    ODB-mapper RESULT <mylabel>
    ```

### Orthologer (De Novo Discovery)
Use `orthologer` to find orthologs within a custom set of species/proteomes.

*   **Initialize Workspace**: Create the necessary directory structure.
    ```bash
    orthologer -c create
    ```
*   **Run Pipeline**: Execute the ortholog detection workflow.
    ```bash
    orthologer -w /absolute/path/to/workdir
    ```

## Expert Tips and Best Practices

*   **Absolute Paths**: In version 3.8.1 and later, the `-w` (workdir) flag for the `orthologer` command requires an absolute directory path to function correctly.
*   **Environment Workaround**: If using version 3.8.0, the `orthologer -c create` command may fail with an "unbound variable" error. Fix this by exporting the following variable before running the command:
    ```bash
    export STEP_FULL_ID=""
    ```
*   **Custom Work Directory**: By default, `ODB-mapper` uses `./odbmapper`. You can redirect this by setting the environment variable:
    ```bash
    export ODBMAPPER_WORK_BASE=/your/custom/path
    ```
*   **Input Requirements**: Ensure your FASTA headers are simple and unique. The pipeline relies on `segmasker` for low-complexity masking and `diamond` or `mmseqs` for homology; ensure these are in your PATH if not using the Bioconda/Docker distributions.
*   **Taxonomic Nodes**: When using `ODB-mapper`, choose the most specific taxonomic node ID relevant to your species from OrthoDB to improve annotation accuracy.

## Reference documentation
- [OrthoLoger Overview and Usage](./references/orthologer_ezlab_org_index.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_orthologer_overview.md)