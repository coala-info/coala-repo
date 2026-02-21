---
name: pydpi
description: The `pydpi` library is designed to bridge the gap between chemical and biological data.
homepage: http://cbdd.csu.edu.cn/index
---

# pydpi

## Overview
The `pydpi` library is designed to bridge the gap between chemical and biological data. It provides a unified framework for calculating structural and physicochemical features from small molecules (ligands) and proteins. This skill facilitates the extraction of descriptors necessary for machine learning workflows in drug discovery, specifically focusing on how to represent molecules and proteins as numerical vectors for interaction prediction.

## Core Functionality
The tool is organized into three primary modules:
- **Drug Module**: Calculates descriptors for small molecules (e.g., constitutional, topological, charge, and connectivity indices).
- **Protein Module**: Extracts features from amino acid sequences (e.g., amino acid composition, dipeptide composition, and Moreau-Broto autocorrelation).
- **DPI Module**: Integrates drug and protein descriptors to form combined feature vectors for interaction studies.

## Usage Patterns

### Molecular Descriptor Calculation
Use the `pydpi.drug` module to process SMILES strings or SDF files.
- For basic structural features, utilize the `GetDrug` class.
- Common descriptors include: `Kappa`, `MolecularProperty`, and `Connectivity`.

### Protein Sequence Analysis
Use the `pydpi.protein` module to process FASTA sequences.
- Calculate global descriptors like Amino Acid Composition (AAC) for general protein representation.
- Use Conjoint Triad features for protein-protein or drug-protein interaction modeling.

### Chemogenomics Integration
To create a dataset for interaction prediction:
1. Generate a vector for the drug ($V_d$).
2. Generate a vector for the protein ($V_p$).
3. Combine them using the `pydpi.dpi` module (typically via concatenation or tensor product) to create the final input vector for a classifier.

## Best Practices
- **Data Cleaning**: Ensure SMILES strings are neutralized and desalted before descriptor calculation to avoid noise in chemical indices.
- **Feature Scaling**: Since different descriptors (e.g., molecular weight vs. logP) have different scales, always apply normalization or standardization before training models.
- **Sequence Length**: When calculating autocorrelation descriptors for proteins, ensure the sequence length is greater than the maximum lag parameter chosen.

## Reference documentation
- [pydpi Overview](./references/anaconda_org_channels_bioconda_packages_pydpi_overview.md)