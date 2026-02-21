---
name: beem-bio
description: BeEM (BEst Effort/Minimal) is a specialized utility for structural bioinformatics that bridges the gap between modern mmCIF data and legacy software requiring PDB files.
homepage: https://github.com/kad-ecoli/BeEM
---

# beem-bio

## Overview
BeEM (BEst Effort/Minimal) is a specialized utility for structural bioinformatics that bridges the gap between modern mmCIF data and legacy software requiring PDB files. While the PDB format has strict technical limitations, BeEM generates "minimal" PDB files containing essential coordinate and citation data, allowing researchers to use older analysis tools with modern, large-scale structures. It also includes a companion tool, `cifte`, for reverse conversion.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::beem-bio
```

## Command Line Usage

### Converting mmCIF to PDB
The primary command converts a PDBx/mmCIF file into one or more PDB files.
```bash
BeEM input_file.cif
```
*   **Compressed Inputs**: BeEM natively supports gzipped files (e.g., `BeEM structure.cif.gz`) on Linux and macOS.
*   **Output**: The tool generates PDB files based on the input filename. If a single chain exceeds 99,999 atoms, BeEM automatically splits it into multiple PDB files to maintain format compatibility.

### Converting PDB to mmCIF
Use the companion tool `cifte` to perform the reverse operation:
```bash
cifte input.pdb output.cif
```

## Expert Tips and Best Practices

### Handling Large Structures
When working with massive complexes, be prepared for multiple output files. Standard PDB files cannot exceed 99,999 atom records; BeEM handles this by splitting the structure. You must ensure your downstream analysis tool can handle multi-file structures or process them sequentially.

### Residue and Ligand Mapping
*   **5-Character Residues**: If the source file contains extended length CCD names (5 characters), BeEM maps them to reserved IDs (01-99, DRG, INH, LIG). 
*   **Mapping Files**: Always check for a generated `ligand-id-mapping.tsv` file in your working directory. This tab-delimited file is essential for identifying which reserved IDs correspond to your original ligands.
*   **Sequence Numbers**: For residue sequence numbers with 5+ characters, BeEM uses the first four for the sequence number and the fifth for the insertion code. Any remaining characters are discarded.

### Metadata Limitations
BeEM produces "minimal" files. It preserves:
*   HEADER, AUTHOR, JRNL
*   CRYST1, SCALEn
*   ATOM, HETATM
*   Optional: SEQRES, DBREF

It **discards** structural metadata like HELIX, SHEET, SSBOND, LINK, and CONECT records. If your analysis depends on PDB-header-defined secondary structure or connectivity, you will need to recalculate these from the coordinates.

## Reference documentation
- [Bioconda beem-bio Overview](./references/anaconda_org_channels_bioconda_packages_beem-bio_overview.md)
- [BeEM GitHub Repository](./references/github_com_kad-ecoli_BeEM.md)