---
name: cath-tools
description: The cath-tools suite provides high-performance C++ implementations for protein structural alignment, superposition, domain hit resolution, and clustering. Use when user asks to align protein structures using SSAP, generate structure superpositions, resolve overlapping domain hits into architectures, or perform complete-linkage clustering.
homepage: https://github.com/UCLOrengoGroup/cath-tools
metadata:
  docker_image: "quay.io/biocontainers/cath-tools:0.16.5--h78a066a_0"
---

# cath-tools

## Overview

The `cath-tools` suite provides high-performance C++ implementations of algorithms used in the curation of the CATH protein structure database. This skill enables the structural comparison of proteins through the SSAP (Sequential Structure Alignment Program) algorithm, the generation of high-quality superpositions that focus on conserved regions, and the resolution of overlapping domain hits into optimal architectures. It also includes utilities for complete-linkage clustering and mapping between different cluster partitions.

## Core Tools and CLI Patterns

### Structural Alignment (cath-ssap)
Use `cath-ssap` to align a pair of protein structures. It automatically switches between fast secondary-structure-based alignment and slower residue-level alignment based on score thresholds.

*   **Basic Alignment**: `cath-ssap <protein1> <protein2>`
*   **PDB Path Configuration**: Set the environment variable `CATH_TOOLS_PDB_PATH` to avoid repeating `--pdb-path` in every command.
*   **Specific Regions**: Use the format `D[id]start-stop:chain` to align specific domains.
    *   Example: `cath-ssap --align-regions 'D[1cukA01]10-150:A' --align-regions 'D[1bvsA01]15-155:A' 1cukA01 1bvsA01`

### Structure Superposition (cath-superpose)
Unlike standard RMSD-minimizing tools, `cath-superpose` focuses on well-aligned regions to produce more biologically meaningful visualizations.

*   **Automatic All-vs-All**: `cath-superpose --do-the-ssaps --pdb-infile <file1> --pdb-infile <file2>`
*   **Using Existing Alignments**: Provide a `.list` file from `cath-ssap`.
    *   `cath-superpose --ssap-aln-infile alignment.list --pdb-infile p1.pdb --pdb-infile p2.pdb --sup-to-pymol`
*   **Output Formats**:
    *   `--sup-to-pdb-file output.pdb`: Single PDB with faked chain codes.
    *   `--sup-to-pymol-file script.pml`: Generates a PyMOL script for high-quality rendering.

### Resolving Domain Hits (cath-resolve-hits)
Collapses multiple (potentially overlapping) domain matches into the best non-overlapping architecture by maximizing the total score.

*   **HMMER Integration**: Directly process HMMER output.
    *   `cath-resolve-hits --input-format hmmer_domtblout <hits_file>`
*   **Performance Tip**: If hits are already sorted by query ID, use `--input-hits-are-grouped` to significantly reduce memory usage.
*   **Overlap Control**: Use `--overlap-trim-spec 30/10` to allow minor overlaps (up to 10 residues for segments of 30) by trimming segment boundaries.

### Clustering and Mapping (cath-cluster & cath-map-clusters)
*   **Clustering**: Perform complete-linkage clustering on distance or strength data.
    *   `cath-cluster --link_dirn DISTANCE --levels 35,60,95,100 <input_file>`
*   **Mapping**: Map entities between different versions of clusters, accounting for slight residue-range variations.
    *   `cath-map-clusters --map-from-clustmemb-file old_clusters.txt new_clusters.txt`

## Expert Tips and Best Practices

1.  **Environment Variables**: Streamline workflows by exporting `CATH_TOOLS_PDB_PATH`, `CATH_TOOLS_PDB_PREFIX`, and `CATH_TOOLS_PDB_SUFFIX`.
2.  **Alignment Refining**: When superposing multiple structures, use `--align-refining HEAVY` in `cath-superpose` to improve the quality of the "glued" multiple alignment, though it increases computation time.
3.  **Visualization**: Use `--gradient-colour-alignment` in `cath-superpose` to color the structure from blue to red along the alignment length, highlighting structural conservation vs. divergence.
4.  **DSSP Handling**: While `cath-ssap` can calculate secondary structure internally from PDBs, providing pre-calculated DSSP files via `CATH_TOOLS_DSSP_PATH` can speed up large-scale batch processing.



## Subcommands

| Command | Description |
|---------|-------------|
| cath-cluster | Cluster items based on the links between them. |
| cath-refine-align | Iteratively refine an existing alignment by attempting to optimise SSAP score |
| cath-resolve-hits | Collapse a list of domain matches to your query sequence(s) down to the non-overlapping subset (ie domain architecture) that maximises the sum of the hits' scores. |
| cath-score-align | Score an existing alignment using structural data |
| cath-ssap | Run a SSAP pairwise structural alignment |
| cath-superpose | Superpose protein structures using an existing alignment |

## Reference documentation
- [cath-ssap](./references/cath-tools_readthedocs_io_en_latest_tools_cath-ssap.md)
- [cath-superpose](./references/cath-tools_readthedocs_io_en_latest_tools_cath-superpose.md)
- [cath-resolve-hits](./references/cath-tools_readthedocs_io_en_latest_tools_cath-resolve-hits.md)
- [cath-cluster](./references/cath-tools_readthedocs_io_en_latest_tools_cath-cluster.md)
- [cath-map-clusters](./references/cath-tools_readthedocs_io_en_latest_tools_cath-map-clusters.md)