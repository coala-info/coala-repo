---
name: apoc
description: APoc aligns and compares protein binding pockets to quantify their structural and chemical similarity. Use when user asks to compare protein functional sites, identify convergent evolution in binding pockets, or screen a pocket against a library of structures.
homepage: http://cssb.biology.gatech.edu/APoc
metadata:
  docker_image: "quay.io/biocontainers/apoc:1b16--0"
---

# apoc

## Overview
The Alignment of Pockets (APoc) tool is a specialized structural biology utility used to quantify the similarity between protein functional sites. Unlike global structural alignment tools, APoc focuses on the local geometry and chemical features of binding pockets. It employs a robust scoring function (PS-score) to determine the statistical significance of an alignment, making it ideal for identifying convergent evolution in binding sites or predicting potential cross-reactivity and polypharmacology.

## Usage Patterns

### Basic Pocket Alignment
To compare two protein pockets, provide the PDB files and specify the residues defining the pockets.
```bash
apoc -p1 pocket1.pdb -p2 pocket2.pdb
```

### Large-scale Screening
For high-throughput structural proteomics, use the template-target mode to screen a single pocket against a library of structures.
```bash
apoc -q pocket_query.pdb -t pocket_library_list.txt
```

### Key Parameters and Best Practices
- **PS-score Interpretation**: A PS-score > 0.4 typically indicates significant structural similarity between pockets that is unlikely to occur by chance.
- **Input Preparation**: Ensure PDB files are cleaned of water molecules and non-essential ligands unless they are part of the pocket definition.
- **Coordinate Systems**: APoc is rotation-invariant; it will find the optimal transformation to superimpose the pocket geometries.

## Expert Tips
- **Chemical Feature Matching**: APoc considers both backbone geometry and side-chain orientations. If a match has a high RMSD but a high PS-score, focus on the conserved chemical environment rather than the exact atom positions.
- **Pocket Definition**: The quality of the alignment is highly dependent on the selection of residues. Use residues within 6-8Å of a bound ligand for the most biologically relevant results.

## Reference documentation
- [APoc Overview](./references/anaconda_org_channels_bioconda_packages_apoc_overview.md)