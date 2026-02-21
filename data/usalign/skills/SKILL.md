---
name: usalign
description: US-align is a unified protocol for comparing 3D structures of diverse macromolecules.
homepage: https://zhanggroup.org/US-align
---

# usalign

## Overview
US-align is a unified protocol for comparing 3D structures of diverse macromolecules. It extends the TM-align algorithm to handle proteins, RNAs, and DNAs in various assembly states (monomers, oligomers, and complexes). It is the primary tool for generating optimal structural alignments by maximizing the TM-score, a metric where values ≥0.5 for proteins (or ≥0.45 for RNAs) indicate a shared global topology.

## Common CLI Patterns

### Basic Pairwise Alignment
Align two monomeric structures (default considers the first chain of each file):
```bash
USalign structure1.pdb structure2.pdb
```

### Oligomer and Complex Alignment
To align biological assemblies or multi-chain complexes, use the `-mm` (multimeric) flag:
- **Pairwise Oligomers**: Align two complexes.
  ```bash
  USalign structure1.pdb structure2.pdb -mm 1
  ```
- **Monomer-to-Oligomer**: Align multiple monomeric chains to a template oligomer.
  ```bash
  USalign structure1.pdb structure2.pdb -mm 2
  ```
- **Multiple Monomers**: Generate a single consensus alignment for multiple structures.
  ```bash
  USalign structure1.pdb structure2.pdb structure3.pdb -mm 4
  ```

### Handling Multi-Model Files
Control how models (e.g., NMR ensembles or biological units) are read:
- **First Model Only**: Recommended for asymmetric units.
  ```bash
  USalign structure1.pdb structure2.pdb -ter 1
  ```
- **All Models**: Recommended for biological assemblies.
  ```bash
  USalign structure1.pdb structure2.pdb -ter 0
  ```

### Sequence-Specific Constraints
By default, US-align performs sequence-independent alignment. Use these flags for specific correspondences:
- **Residue Index Correspondence**: Superimpose based on matching residue numbers.
  ```bash
  USalign structure1.pdb structure2.pdb -i
  ```
- **Sequence Alignment Based**: Superimpose based on a global sequence alignment.
  ```bash
  USalign structure1.pdb structure2.pdb -s
  ```

## Expert Tips

- **Molecule Type**: While US-align often auto-detects molecule types, you can force the mode for specific backbone atoms. For proteins, it uses **CA**; for RNA/DNA, it defaults to **C3'**.
- **Backbone Customization**: You can specify alternative backbone atoms for nucleic acids (e.g., C4', C5', P) using the advanced options if the default C3' is insufficient for your structural analysis.
- **TM-score Interpretation**: 
    - **1.0**: Identical structures.
    - **>0.5 (Protein)**: Same global fold/topology.
    - **>0.45 (RNA)**: Same global fold/topology.
    - **<0.2**: Random structural similarity.
- **Performance**: For large-scale database searches or alignments of more than 10 chains, use the standalone compiled C++ version rather than the web server to avoid timeout and memory constraints.

## Reference documentation
- [US-align: complex structure alignment](./references/aideepmed_com_US-align.md)
- [US-align Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_usalign_overview.md)