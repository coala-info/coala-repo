---
name: mtm-align
description: mtm-align performs structural alignment of multiple protein molecules based on their 3D coordinates. Use when user asks to align multiple protein structures, find topological matches across a set of proteins, or generate a structural similarity matrix.
homepage: http://yanglab.nankai.edu.cn/mTM-align/help/
metadata:
  docker_image: "quay.io/biocontainers/mtm-align:20220104--h9948957_3"
---

# mtm-align

## Overview
mtm-align (multiple TM-align) is a specialized tool for the structural alignment of multiple protein molecules. Unlike pairwise alignment tools, it seeks to find the optimal topological match across an entire set of proteins. It is particularly effective for proteins with low sequence identity but high structural similarity, as it relies on 3D coordinates rather than amino acid sequences. The tool outputs a multiple structure alignment and provides a structural similarity matrix based on TM-scores.

## Usage Guidelines

### Basic Command Structure
The tool typically requires a list of PDB files as input. The most common way to run it is by providing a file containing the paths to the structures:

```bash
mTM-align -i input_list.txt
```

The `input_list.txt` should contain the path to one PDB file per line.

### Key Parameters and Options
- `-i`: Path to the input list file (required).
- `-o`: Prefix for output files (e.g., `-o alignment_results`).
- `-m`: Output the transformation matrices for each structure relative to the first or consensus structure.
- `-cp`: Enable circular permutation alignment (useful for proteins with swapped domains).

### Best Practices
- **Input Preparation**: Ensure all PDB files are cleaned (remove water molecules and ligands) unless they are critical for the structural fold, as extraneous atoms can occasionally interfere with the center-of-mass calculations.
- **Interpreting Results**: Focus on the "Average TM-score" provided in the output. A TM-score > 0.5 generally indicates that the proteins share the same fold, while a score < 0.17 indicates random similarity.
- **Large Datasets**: For sets larger than 20-30 structures, computational time increases significantly. Consider clustering highly similar structures first and aligning representatives if performance becomes an issue.
- **Output Files**: mtm-align generates several files, including:
    - `.fasta`: The resulting multiple sequence alignment derived from the structural superposition.
    - `.pdb`: A transformed set of coordinates where all proteins are moved into the same 3D reference frame for visualization in tools like PyMOL or ChimeraX.

## Reference documentation
- [mtm-align Overview](./references/anaconda_org_channels_bioconda_packages_mtm-align_overview.md)