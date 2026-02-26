---
name: dssp
description: DSSP assigns secondary structure elements to protein structures based on 3D coordinates and hydrogen bonding patterns. Use when user asks to assign secondary structure codes, process mmCIF or PDB files for structural annotation, or identify specific motifs like alpha helices and beta strands.
homepage: https://github.com/PDB-REDO/dssp
---


# dssp

## Overview
DSSP (Define Secondary Structure of Proteins) is a specialized tool designed to standardize the assignment of secondary structure elements to protein entries. Unlike prediction tools, DSSP calculates assignments based on the 3D coordinates of a protein, specifically looking at hydrogen bonding patterns. This version (v4.5+) is a modern rewrite that provides full mmCIF support, writes secondary structure information into the `_struct_conf` category by default, and includes definitions for Poly-Proline helices.

## Command Line Usage
The primary executable for this tool is `mkdssp`.

### Basic Assignment
To process a structure file and output an annotated mmCIF file:
```bash
mkdssp input.cif output.cif
```

### Working with Compressed Files
The tool natively handles gzipped files, which is common when dealing with large PDB/PDB-REDO datasets:
```bash
mkdssp input.cif.gz output.cif
```

## Python Integration
The `mkdssp` module allows you to process structure data directly within Python scripts without calling the CLI.

### Basic Python Workflow
```python
from mkdssp import dssp
import gzip

# Load structure data
with gzip.open("protein.cif.gz", "rt") as f:
    file_content = f.read()

# Initialize DSSP object
data = dssp(file_content)

# Access statistics
print(f"Total residues: {data.statistics.residues}")

# Iterate through residues to get assignments
for res in data:
    # res.type contains the secondary structure code (e.g., H, E, T)
    print(f"Residue {res.seq_id} ({res.compound_id}): {res.type}")
```

## Expert Tips and Best Practices
- **Prefer mmCIF**: While legacy PDB formats are supported, use mmCIF (`.cif`) to take full advantage of the updated data categories and more accurate structural annotations.
- **Secondary Structure Codes**: Familiarize yourself with the standard DSSP codes:
  - `H`: Alpha helix
  - `B`: Residue in isolated beta-bridge
  - `E`: Extended strand, participates in beta ladder
  - `G`: 3-helix (3/10 helix)
  - `I`: 5-helix (pi-helix)
  - `T`: Hydrogen bonded turn
  - `S`: Bend
  - `P`: Poly-Proline helix (specific to this version)
- **Input Validation**: Ensure your input files contain valid 3D coordinates; DSSP will fail or produce incomplete results if the backbone atoms (N, CA, C, O) are missing or poorly defined.
- **PDB-REDO Compatibility**: This version is specifically maintained by the PDB-REDO team, making it the ideal choice for workflows involving refined structural models.

## Reference documentation
- [PDB-REDO/dssp Main Repository](./references/github_com_PDB-REDO_dssp.md)