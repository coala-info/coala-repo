---
name: pling
description: Pling quantifies the evolutionary distance between plasmids by accounting for structural rearrangements and shared content. Use when user asks to calculate plasmid distances, cluster related plasmids, or identify structural evolution between plasmid sequences.
homepage: https://github.com/iqbal-lab-org/pling
---


# pling

## Overview
Pling is a specialized bioinformatics workflow designed to quantify the evolutionary distance between plasmids. Unlike simple sequence identity metrics, Pling uses the Double Cut and Join Indel (DCJ-indel) distance to account for structural rearrangements. It intelligently combines containment distance (shared content) with these rearrangement metrics and filters out common mobile elements that might otherwise obscure true phylogenetic relationships. This results in more accurate clustering of related plasmids based on their structural evolution.

## Usage Guidelines

### Core Workflow
Pling typically operates as a Snakemake-based pipeline. The primary entry point is the `pling` command, which manages several sub-processes:
1. **Alignment**: Uses `mummer` (NUCmer) to identify syntenic blocks between plasmid pairs.
2. **Distance Calculation**: Computes Jaccard-like containment distances and DCJ-indel distances.
3. **Clustering**: Infers clusters of related plasmids based on the combined distance metrics.

### Common CLI Patterns
The tool is executed via the `pling` command (defined in `setup.py` and `pyproject.toml`).

```bash
# Basic execution (typical pattern for Snakemake-based tools)
pling --input <plasmids.fasta> --output <output_directory>
```

### Environment and Dependencies
Pling relies on a specific bioconda environment. If you are troubleshooting execution, ensure the following dependencies are available:
- **Python**: 3.10 (as specified in `env.yaml`)
- **Snakemake**: 7.32.4
- **Alignment**: `mummer` (3.23)
- **Distance/Network**: `plasnet` (0.6.0), `sourmash`, `glpk`
- **Logic**: `dingII` (for DCJ-indel calculations)

### Expert Tips
- **Mobile Elements**: Pling is specifically designed to prevent shared mobile elements from "clouding" the analysis. If your results show unexpected clusters, verify if the plasmids share high-frequency insertion sequences that Pling is attempting to filter.
- **Input Preparation**: Ensure your input FASTA headers are unique and contain no special characters that might break the Snakemake wildcards used in the internal `Snakefile` logic.
- **Resource Management**: Since Pling uses `glpk` (GNU Linear Programming Kit) for distance optimization and `mummer` for all-vs-all alignments, it can be computationally intensive for large datasets. Use the `--threads` or `--cores` flag if available to parallelize the Snakemake tasks.



## Subcommands

| Command | Description |
|---------|-------------|
| pling | pling is a tool for reconstructing plasmid relationships from genome assemblies. |
| pling | Integerisation method: "align" for alignment, "skip" to skip integerisation altogether. Make sure to input a unimog file if skipping integerisation. |

## Reference documentation
- [Pling GitHub Repository](./references/github_com_iqbal-lab-org_pling.md)
- [Environment Dependencies](./references/github_com_iqbal-lab-org_pling_blob_main_env.yaml.md)
- [Project Configuration](./references/github_com_iqbal-lab-org_pling_blob_main_pyproject.toml.md)