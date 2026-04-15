---
name: phu
description: The phu toolkit streamlines the analysis of viral and phage genomic data by providing a high-level wrapper for sequence screening, clustering, and taxonomic simplification. Use when user asks to identify viral sequences in metagenomic assemblies, organize sequences into taxonomic clusters, or simplify verbose taxonomic assignment data.
homepage: https://github.com/camilogarciabotero/phu
metadata:
  docker_image: "quay.io/biocontainers/phu:0.4.4--pyhdfd78af_0"
---

# phu

## Overview

The `phu` (Phage Utilities) toolkit is designed to streamline the analysis of viral and phage genomic data. It acts as a high-level wrapper for complex bioinformatics tools like HMMER, vclust, and Prodigal, providing a consistent command-line interface. This skill helps you navigate its three primary functions: identifying viral sequences in metagenomic assemblies, organizing those sequences into taxonomic clusters, and cleaning up verbose taxonomic assignment data for easier downstream analysis.

## Core Commands and Workflows

### 1. Protein Family Screening (`screen`)
Use this to identify contigs containing specific viral markers (e.g., capsids, portals).

*   **Basic Search**: `phu screen --input-contigs assembly.fasta marker.hmm`
*   **Strict Filtering**: Use `--combine-mode all` when a contig must contain *every* provided HMM profile (e.g., for identifying complete viral genomes).
*   **Flexible Filtering**: Use `--combine-mode threshold --min-hmm-hits 3` to find contigs containing at least a subset of markers.
*   **Advanced Extraction**:
    *   `--save-target-proteins`: Extracts the specific protein sequences that matched the HMMs.
    *   `--save-target-hmms`: Automatically builds new HMM profiles from the matched proteins found in your sample.
*   **Viral Optimization**: If working with viral-specific gene prediction, ensure `pyrodigal-gv` is available in the environment for better handling of overlapping genes.

### 2. Sequence Clustering (`cluster`)
Use this to group viral sequences into meaningful taxonomic or operational units.

*   **Dereplication**: `phu cluster --mode dereplication --input-contigs viral.fna` (Removes redundant sequences; 95% ANI / 85% coverage).
*   **vOTU Clustering**: `phu cluster --mode votu --input-contigs viral.fna` (Groups sequences into viral Operational Taxonomic Units using MIUViG-style defaults).
*   **Species Classification**: `phu cluster --mode species --input-contigs genomes.fna` (Classifies sequences into species using ICTV-style defaults).
*   **Custom Tuning**: Use the `--vclust-params` flag to pass raw arguments to the underlying engine, such as `--vclust-params="--metric tani --tani 0.70"` for genus-level clustering.

### 3. Taxonomy Simplification (`simplify-taxa`)
Use this to convert verbose vContact3 output into a readable format.

*   **Standard Usage**: `phu simplify-taxa -i final_assignments.csv -o simplified.csv`
*   **Lineage Generation**: Use the `--add-lineage` flag to create a single `compact_lineage` column representing the deepest available taxonomic rank (e.g., `Caudoviricetes:NF2:NG1`).
*   **Format Support**: The tool automatically detects CSV vs. TSV based on file extensions.

## Expert Tips

*   **Thread Management**: For `screen` and `cluster`, use `--threads 0` to automatically utilize all available CPU cores, which is critical for large metagenomic datasets.
*   **HMM Modes**: If using a concatenated HMM database (like Pfam), set `--hmm-mode mixed` to ensure `phu` correctly identifies individual models within the single file.
*   **Output Organization**: By default, `phu` creates specific directories (`phu-screen/`, `clustered-contigs/`). Always check the `kept_contigs.txt` file in the output folder for a quick list of identifiers that passed your filters.



## Subcommands

| Command | Description |
|---------|-------------|
| phu cluster | Sequence clustering wrapper around external 'vclust' with three modes. |
| phu screen | Screen contigs for protein families using HMMER on predicted CDS. |
| phu simplify-taxa | Simplify vContact taxonomy prediction columns into compact lineage codes. |

## Reference documentation

- [phu Overview](./references/camilogarciabotero_github_io_phu.md)
- [Screening Command Details](./references/camilogarciabotero_github_io_phu_commands_screen.md)
- [Clustering Command Details](./references/camilogarciabotero_github_io_phu_commands_cluster.md)
- [Taxonomy Simplification Details](./references/camilogarciabotero_github_io_phu_commands_simplify-taxa.md)