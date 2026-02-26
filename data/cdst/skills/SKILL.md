---
name: cdst
description: CDST performs decentralized multi-locus sequence typing by using MD5 hashes of coding sequences to identify alleles and cluster bacterial isolates. Use when user asks to perform wgMLST or cgMLST, generate distance matrices, create minimum spanning trees, or merge decentralized allele databases.
homepage: https://github.com/l1-mh/CDST
---


# cdst

## Overview

CDST (CoDing Sequence Typer) is a lightweight, decentralized tool for whole-genome or core-genome multi-locus sequence typing (wgMLST/cgMLST). Instead of relying on a central nomenclature database, it uses MD5 hashes of coding sequences to identify and compare alleles. This approach enables rapid, interoperable genomic surveillance and clustering without the overhead of traditional allele calling. Use this skill to process CDS sequences, compute pairwise distances, and visualize relationships between bacterial isolates.

## Installation and Environment

The tool is available via Conda or Pip. Ensure dependencies like Biopython, Pandas, and NetworkX are available.

```bash
# Recommended installation
conda install bioconda::cdst
# OR
pip install cdst-genome
```

## Core Workflows

### 1. Preparing Input Data
CDST requires FASTA-formatted coding sequences (usually `.ffn`). If you only have genome assemblies (`.fasta`), you must predict CDS first. Consistency in the prediction tool is critical for accurate typing.

**Expert Tip**: Use Prodigal for consistent CDS prediction across your dataset.
```bash
prodigal -i assembly.fasta -d cds_output.ffn
```

### 2. Running the Full Pipeline
To execute the entire workflow (hashing, matrix generation, and clustering) in one command:
```bash
cdst run -i path/to/cds/*.ffn -o output_dir/ -T both
```
*   `-T both`: Generates both Minimum Spanning Tree (MST) and Hierarchical Clustering (HC).

### 3. Modular Analysis Steps
For large datasets or incremental updates, use individual subcommands:

*   **Generate Hash Database**:
    ```bash
    cdst generate -i *.ffn -o output/
    ```
*   **Compute Distance Matrix**:
    ```bash
    cdst matrix -j output/md5_hashes.json -o output/
    ```
*   **Generate Trees**:
    ```bash
    # Minimum Spanning Tree
    cdst mst -m output/difference_matrix.csv -o output/
    # Hierarchical Clustering
    cdst hc -m output/difference_matrix.csv -o output/
    ```

### 4. Comparing New Samples to a Reference
To type new isolates against an existing CDST database without re-processing the entire set:
```bash
cdst test -i new_samples/*.ffn -j existing_database/md5_hashes.json -o results/
```

### 5. Merging Decentralized Databases
One of CDST's primary strengths is merging results from different labs or runs:
```bash
cdst join -d lab1_results/ lab2_results/ -o merged_output/ --matrix --mst
```
*   **Note**: Ensure the `md5_hashes.json` and `comparison_matrix.csv` files are present in the input directories when using the `--matrix` flag to save significant computation time.

## Output Reference

*   `md5_hashes.json`: The primary "allele" database.
*   `difference_matrix.csv`: Pairwise distances based on hash mismatches.
*   `mst.csv`: Edge list for the Minimum Spanning Tree.
*   `hc.newick`: Newick format tree for visualization in tools like iTOL or FigTree.
*   `comparison_results.csv`: Closest matches found during a `test` run.

## Best Practices

*   **Sequence Quality**: CDST automatically ignores CDS sequences containing ambiguous characters (e.g., 'N'). Ensure high-quality assemblies for accurate typing.
*   **Naming Consistency**: Ensure FASTA headers or filenames are unique and descriptive, as these typically serve as sample identifiers in the resulting matrices and trees.
*   **Resource Management**: For very large datasets (thousands of genomes), use the `generate` and `matrix` steps separately to monitor memory usage, as the distance matrix scales quadratically.

## Reference documentation
- [cdst Overview](./references/anaconda_org_channels_bioconda_packages_cdst_overview.md)
- [CDST GitHub Repository](./references/github_com_l1-mh_CDST.md)