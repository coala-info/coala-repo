---
name: sap
description: SAP performs pairwise comparison and spatial superposition of protein 3D structures using a double dynamic programming approach. Use when user asks to compare protein structures, find structural conservation, or align PDB files based on alpha-carbon coordinates.
homepage: https://github.com/mathbio-nimr-mrc-ac-uk/SAP
---


# sap

## Overview
SAP (Structural Alignment Program) is a specialized tool designed for the pairwise comparison of protein 3D structures. Unlike traditional sequence alignment, SAP utilizes a double dynamic programming approach to find the optimal spatial superposition of two proteins based on their alpha-carbon coordinates. This is particularly effective for detecting structural conservation in proteins with low sequence identity.

## Installation
The tool is most easily managed via the Bioconda channel:
```bash
conda install bioconda::sap
```

## Basic Usage
The primary command requires two PDB files as input:
```bash
sap <PDB_1> <PDB_2>
```

### Optional Parameters
You can provide an optional integer value to adjust the alignment bias:
```bash
sap <PDB_1> <PDB_2> <one2one>
```
*   **one2one**: An integer value added to the diagonal of the scoring matrix. 
*   **Default**: If a negative value is provided or the parameter is omitted, it defaults to **1000**.
*   **Function**: This parameter influences the "rigidity" of the alignment. Higher values tend to favor alignments that follow the sequential order of residues more strictly.

## Best Practices
*   **PDB Preparation**: Ensure your input PDB files are properly formatted and contain valid ATOM records for alpha-carbons (CA), as the algorithm relies on these coordinates.
*   **Interpreting Results**: SAP is optimized for finding global structural similarities. If you are looking for very small local motifs, consider if the default `one2one` bias is too restrictive.
*   **Citation**: When using SAP for published research, it is standard practice to cite the original work by Willie Taylor (Protein Sci. 1999).

## Reference documentation
- [SAP Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_sap_overview.md)
- [SAP GitHub Repository](./references/github_com_mathbio-nimr-mrc-ac-uk_SAP.md)