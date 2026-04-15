---
name: panman
description: PanMAN is a specialized data representation and toolset for efficiently storing and analyzing massive pangenome datasets using mutation-annotated networks. Use when user asks to construct pangenome mutation-annotated networks, extract variants in VCF format, or convert pangenome data into MSA and GFA formats.
homepage: https://github.com/TurakhiaLab/panman
metadata:
  docker_image: "quay.io/biocontainers/panman:0.1.4--hac847a2_0"
---

# panman

## Overview

PanMAN (Pangenome Mutation-Annotated Network) is a specialized data representation designed for massive pangenome datasets. It provides significant storage efficiency (up to 500x compression) by annotating substitutions, indels, and structural mutations on the branches of phylogenetic trees (PanMATs) which are then linked into a network. 

The primary tool, `panmanUtils`, allows researchers to construct these networks from existing pangenome graphs or raw sequences and provides utilities to extract useful biological information without decompressing the entire dataset.

## Installation and Setup

The recommended installation method is via Conda. Note that PanMAN requires Python 3.11.

```bash
# Create and activate environment
conda create -n panman-env python=3.11 -y
conda activate panman-env

# Configure channels and install
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
conda install panman -y
```

*Note for Apple Silicon (M1/M2/M3):* Use `conda config --env --set subdir osx-64` before installation to use Rosetta 2.

## Core CLI Usage

### 1. Constructing a PanMAN
The most direct way to build a `.panman` file is from a PanGraph (JSON) and a corresponding Tree topology (Newick).

```bash
panmanUtils -P input_pangraph.json -N input_tree.nwk -o output_prefix
```
This generates `output_prefix.panman`.

### 2. Construction from Raw Sequences (Snakemake)
For raw FASTA files, PanMAN provides a Snakemake workflow that automates the generation of intermediate PanGraphs and trees using tools like PGGB, MAFFT, or MashTree.

```bash
# Navigate to the workflows directory within the installation
cd $PANMAN_HOME/workflows

# Run construction from FASTA
snakemake --use-conda --cores 8 --config \
    RUNTYPE="pangraph" \
    FASTA="path/to/sequences.fa" \
    SEQ_COUNT="20" \
    ASSEM="NONE" \
    REF="NONE" \
    TARGET="NONE"
```

### 3. Data Extraction and Analysis
Once a PanMAN is constructed, use `panmanUtils` to extract specific data formats:

*   **Summary Statistics**: Get an overview of the network.
    ```bash
    panmanUtils -i input.panman --summary
    ```
*   **VCF Extraction**: Extract variants relative to a reference.
    ```bash
    panmanUtils -i input.panman --vcf
    ```
*   **MSA/GFA Extraction**: Convert the PanMAN back to Multiple Sequence Alignment or Graphical Fragment Assembly formats.
    ```bash
    panmanUtils -i input.panman --msa
    panmanUtils -i input.panman --gfa
    ```

## Best Practices and Tips

*   **Input Compatibility**: PanMAN is optimized for microbial datasets (SARS-CoV-2, M. tuberculosis, E. coli). For very large datasets, ensure you have sufficient threads assigned in Snakemake (`--cores`).
*   **Environment Consistency**: Always ensure the `panman-env` is active, as the tool relies on specific versions of `capnproto` and `python`.
*   **Memory Management**: When building from fragment assemblies, use the `ASSEM="frag"` and `TARGET="target.txt"` configuration in the Snakemake workflow to handle fragmented inputs efficiently.
*   **Pruning**: Use the sub-network pruning functionality to isolate specific clades or regions of interest, which significantly speeds up downstream analysis.

## Reference documentation
- [PanMAN GitHub Repository](./references/github_com_TurakhiaLab_panman.md)
- [Bioconda PanMAN Overview](./references/anaconda_org_channels_bioconda_packages_panman_overview.md)