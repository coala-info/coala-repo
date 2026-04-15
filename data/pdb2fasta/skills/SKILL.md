---
name: pdb2fasta
description: pdb2fasta extracts protein sequences from PDB structural coordinate files and converts them into FASTA format. Use when user asks to convert PDB files to FASTA, extract sequences from protein structures, or perform batch conversion of structural data to sequence format.
homepage: https://github.com/kad-ecoli/pdb2fasta
metadata:
  docker_image: "quay.io/biocontainers/pdb2fasta:1.0--h7b50bb2_0"
---

# pdb2fasta

## Overview
`pdb2fasta` is a specialized tool for extracting primary protein sequences from structural coordinate files. It automates the conversion of PDB formatted data into the standard FASTA format, ensuring that structural nuances like alternative atom locations, insertion codes, and specific non-standard residues (like Selenomethionine) are handled consistently according to bioinformatics standards.

## Usage Patterns
The tool typically operates via standard input/output redirection.

### Basic Conversion
To convert a single PDB file to a FASTA file:
`pdb2fasta protein.pdb > sequence.fasta`

### Batch Processing
To process multiple PDB files in a directory using a shell loop:
`for file in *.pdb; do pdb2fasta "$file" > "${file%.pdb}.fasta"; done`

## Technical Behavior and Best Practices
When using `pdb2fasta`, be aware of the following internal logic to ensure data integrity:

- **Alternative Locations**: If a PDB file contains atoms with alternative location identifiers, the tool only considers those marked with a space (' ') or 'A'.
- **Non-standard Residues**: The tool specifically converts Selenomethionine (MSE) residues to Methionine (MET). Other non-standard amino acids are generally ignored.
- **Multi-model Files**: For PDB files containing multiple models (common in NMR structures), only the first model is processed.
- **Insertion Codes**: Residues containing insertion codes are correctly identified and included in the resulting sequence.

## Reference documentation
- [pdb2fasta Overview](./references/anaconda_org_channels_bioconda_packages_pdb2fasta_overview.md)
- [pdb2fasta GitHub Repository](./references/github_com_kad-ecoli_pdb2fasta.md)