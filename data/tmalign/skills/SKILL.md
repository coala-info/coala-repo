---
name: tmalign
description: TM-align compares the 3D shapes of proteins and quantifies their structural similarity using the TM-score. Use when user asks to align protein structures, compare protein 3D shapes, calculate TM-scores, superpose protein models, or visualize structural alignments.
homepage: https://zhanglab.ccmb.med.umich.edu/TM-align/
---



# tmalign

## Overview
TM-align is a specialized tool for comparing the 3D shapes of proteins regardless of their sequence identity. It is the industry standard for calculating the TM-score (Template Modeling score), a metric ranging from 0 to 1 that quantifies structural similarity. Unlike RMSD, TM-score is independent of protein length, making it ideal for comparing proteins of different sizes or identifying distant evolutionary relationships where sequence similarity is low but structural topology is preserved.

## Core Usage Patterns

### Basic Pairwise Alignment
To align two protein structures and calculate the TM-score:
```bash
TMalign protein1.pdb protein2.pdb
```
*   **Output Interpretation**: 
    *   **TM-score > 0.5**: Generally the same fold (SCOP/CATH).
    *   **TM-score < 0.2**: Randomly chosen, unrelated proteins.
    *   **Normalization**: TM-align reports two TM-scores. Use the one normalized by the length of the "Target" (usually the native or reference structure) for standard benchmarking.

### Generating Superposed Structures
To save the transformed coordinates of the second protein aligned to the first:
```bash
TMalign protein1.pdb protein2.pdb -o TM.sup
```
This generates `TM.sup` (the aligned coordinates) and `TM.sup_all` (including unaligned residues).

### Sequence-Based Alignment
If you want to calculate the TM-score based on a specific sequence alignment (e.g., comparing a predicted model to a native structure with the same indices) rather than structural heuristics:
```bash
TMalign protein1.pdb protein2.pdb -seq
```

### Visualization Scripts
TM-align can generate scripts to visualize the alignment in PyMOL or RasMol:
```bash
# The -o flag automatically generates TM.sup_atm and TM.sup_all_atm
# It also creates a .pml script for PyMOL
TMalign protein1.pdb protein2.pdb -o alignment
pymol alignment.pml
```

## Expert Tips
- **Format Support**: Modern versions support both `.pdb` and `.cif` (mmCIF) formats.
- **Speed vs. Accuracy**: For massive database searches, consider using `US-align` (the successor) or `TM-search`, but for high-accuracy pairwise comparison, `TMalign` remains the gold standard.
- **Mirror Images**: If you suspect a protein might be a mirror image (common in some de novo designs), TM-align does not check for chirality by default; it assumes standard L-amino acids.
- **Length Dependency**: If comparing a small domain to a large multi-domain protein, always check the TM-score normalized by the length of the smaller protein to see if the domain is locally conserved.

## Reference documentation
- [TM-align Algorithm and Web Server](./references/aideepmed_com_TM-align.md)
- [TM-align Bioconda Package](./references/anaconda_org_channels_bioconda_packages_tmalign_overview.md)