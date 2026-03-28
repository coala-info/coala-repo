---
name: cdst
description: CDST performs genome typing by converting coding sequences into MD5 hashes to enable nomenclature-free bacterial comparison and clustering. Use when user asks to perform genome typing, generate MD5 hashes from coding sequences, compute distance matrices, or construct minimum spanning trees and hierarchical clustering trees.
homepage: https://github.com/l1-mh/CDST
---


# cdst

## Overview

CDST (CoDing Sequence Typer) provides a simple and efficient method for genome typing that avoids the need for a centralized nomenclature server. By converting coding sequences into MD5 hashes, it allows researchers to compare bacterial genomes across different sites using standardized hash identifiers. It supports the generation of distance matrices, Minimum Spanning Trees (MST), and Hierarchical Clustering (HC) trees directly from predicted gene sequences.

## Installation and Environment

Ensure the tool is installed via pip:
```bash
pip install cdst-genome
```

Required dependencies include `biopython`, `pandas`, `networkx`, and `scipy`.

## Core Workflows

### 1. Full Pipeline Execution
To run the entire analysis (hashing, matrix generation, and tree construction) in one command:
```bash
cdst run -i path/to/cds/*.ffn -o output_dir/ -T both
```
*   `-T both`: Generates both MST and Hierarchical Clustering trees.

### 2. Step-by-Step Analysis
For larger datasets or custom workflows, run the modules individually:

1.  **Generate Hashes**: Create a JSON database of MD5 hashes from CDS files.
    ```bash
    cdst generate -i input/*.ffn -o output/
    ```
2.  **Compute Distance**: Calculate the difference matrix based on shared hashes.
    ```bash
    cdst matrix -j output/md5_hashes.json -o output/
    ```
3.  **Build Trees**:
    *   **MST**: `cdst mst -m output/difference_matrix.csv -o output/`
    *   **HC**: `cdst hc -m output/difference_matrix.csv -o output/`

### 3. Comparing New Samples
To compare new isolates against an existing database without re-processing the entire set:
```bash
cdst test -i new_samples/*.ffn -j existing_database/md5_hashes.json -o results/
```

### 4. Merging Databases
To combine results from different projects or laboratories:
```bash
cdst join -d project1_dir/ project2_dir/ -o merged_output/ --matrix --mst
```
*   Ensure `md5_hashes.json` and `comparison_matrix.csv` are present in the source directories.

## Expert Tips and Best Practices

*   **CDS Prediction**: CDST requires CDS sequences (usually `.ffn` files). If you only have genome assemblies (`.fasta`), use **Prodigal** first:
    `prodigal -i assembly.fasta -d cds_output.ffn`
*   **Consistency is Key**: Always use the same gene prediction tool and parameters across all samples in a comparison to ensure the MD5 hashes remain comparable.
*   **Handling Ambiguity**: CDST automatically ignores sequences containing ambiguous characters (e.g., "N"). Ensure your assemblies are high quality to maximize the number of shared loci.
*   **Output Interpretation**:
    *   `comparison_matrix.csv`: Shows the count of identical genes shared between samples.
    *   `difference_matrix.csv`: Represents the distance (dissimilarity) used for clustering.
    *   `hc.newick`: Can be visualized in tools like iTOL or FigTree.



## Subcommands

| Command | Description |
|---------|-------------|
| cdst hc | Performs hierarchical clustering on a difference matrix. |
| cdst mst | Compute the Minimum Spanning Tree (MST) of a difference matrix. |
| cdst_generate | Generate CDS files |
| cdst_matrix | Generate a matrix from JSON input. |
| cdst_run | Run CDS analysis pipeline |

## Reference documentation
- [CDST README](./references/github_com_l1-mh_CDST_blob_main_README.md)
- [CDST Project Metadata](./references/github_com_l1-mh_CDST_blob_main_pyproject.toml.md)