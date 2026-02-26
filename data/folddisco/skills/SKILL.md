---
name: folddisco
description: Folddisco searches for complex structural motifs across millions of protein structures by focusing on the spatial arrangement of residues. Use when user asks to index protein structures, search for specific structural motifs like catalytic triads or zinc fingers, or perform batch structural queries.
homepage: https://github.com/steineggerlab/folddisco
---


# folddisco

## Overview
Folddisco is a high-performance structural bioinformatics tool developed by the Steinegger Lab. It enables the search for complex structural motifs—such as catalytic triads or zinc fingers—across millions of protein structures in seconds. Unlike traditional sequence search tools, Folddisco focuses on the spatial arrangement of residues, making it ideal for identifying functional sites that are not conserved in linear sequence.

## Installation
The tool can be installed via Bioconda or used via Docker:
```bash
# Bioconda
conda install -c conda-forge -c bioconda folddisco

# Docker
docker pull ghcr.io/steineggerlab/folddisco:master
```

## Core Workflows

### 1. Building a Custom Index
Before searching, you must index your target structures.
```bash
folddisco index -p path/to/pdb_folder -i index/my_custom_index
```
*   **Tip**: Ensure your input folder contains only valid PDB or mmCIF files.

### 2. Querying a Single Motif
To search for a specific motif, provide the query structure, the specific residues, and the target index.
```bash
folddisco query -i index/target_index -p query.pdb -q "B57,B102,C195"
```
*   **Syntax**: `ChainIDResidueNumber` (e.g., `B57` is Chain B, residue 57).
*   **Whole Structure Search**: Omit the `-q` flag to search for all possible motifs within the query protein.

### 3. Batch Querying
For searching multiple motifs simultaneously, use a tab-separated file (TSV).
```bash
folddisco query -i index/target_index -q motifs_list.txt
```
*   **TSV Format**: `Column 1: Path to structure` | `Column 2: Comma-separated residues` | `Column 3: (Optional) Output path`.

## Motif Syntax & Substitutions
Folddisco allows for flexible residue definitions to increase search sensitivity:
*   **Ranges**: `1-10` (inclusive).
*   **Specific Substitutions**: `164:H` (residue 164 must be Histidine).
*   **Set Substitutions**: `247:ND` (residue 247 can be Asparagine or Aspartic Acid).
*   **Property Wildcards**:
    *   `X`: Any amino acid.
    *   `p`: Positively charged (R, H, K).
    *   `n`: Negatively charged (D, E).
    *   `h`: Polar (N, Q, S, T, Y).
    *   `b`: Hydrophobic (A, C, G, I, L, M, F, P, V).
    *   `a`: Aromatic (H, F, W, Y).

## Performance Tuning
*   **Sensitivity**: Increase `-d` (distance threshold in Å, default 0.5) and `-a` (angle threshold in degrees, default 5) to find more distant structural homologs.
*   **Speed**: Use `--skip-match` to skip the expensive RMSD calculation and rely solely on the geometric hash prefilter. This is significantly faster and usually maintains ranking quality.
*   **Sampling**: For very large query proteins, use `--sampling-ratio 0.3` to reduce the number of hashes processed.
*   **Parallelization**: Use `-t` to specify the number of CPU threads.

## Best Practices
*   **Index Compatibility**: Always ensure your index was built with the current version of Folddisco. Indices from versions prior to 2025 may be incompatible with the latest release.
*   **Residue Numbering**: Verify that the residue numbers provided in the `-q` flag match the numbering in the PDB/mmCIF file exactly.
*   **Memory Management**: When working with massive indices (like AFDB50), ensure the system has sufficient RAM or use high-performance storage for memory-mapped files.

## Reference documentation
- [Folddisco GitHub Repository](./references/github_com_steineggerlab_folddisco.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_folddisco_overview.md)