---
name: pdb2pqr
description: PDB2PQR converts protein structures from PDB to PQR format by repairing missing atoms, adding hydrogens, and assigning force field parameters. Use when user asks to prepare structures for electrostatics calculations, assign charges and radii, or determine pH-dependent protonation states.
homepage: https://github.com/Electrostatics/pdb2pqr
metadata:
  docker_image: "biocontainers/pdb2pqr:v2.1.1dfsg-5-deb_cv1"
---

# pdb2pqr

## Overview
PDB2PQR is a specialized utility for converting protein structures from the PDB format into PQR format, which is essential for Poisson-Boltzmann electrostatics calculations (such as those performed by APBS). It automates the often tedious process of "cleaning" a structure—repairing missing heavy atoms, adding hydrogens, and assigning force field-specific parameters (charge and radius) to every atom. It is particularly useful when you need to account for pH-dependent protonation states of amino acid side chains.

## Usage Instructions

### Basic Command Structure
The standard syntax for PDB2PQR requires a force field selection, an input PDB file, and a destination PQR filename.
```bash
pdb2pqr --ff={FORCE_FIELD} {input_file}.pdb {output_file}.pqr
```

### Selecting Force Fields
Choose a force field that matches your downstream simulation or calculation requirements:
- **PARSE**: Optimized for electrostatic calculations (highly recommended for APBS).
- **AMBER**: Standard AMBER99 parameters.
- **CHARMM**: Standard CHARMM27 parameters.
- **SWANSON**: Optimized AMBER-based parameters for pKa calculations.

### Handling Titration States (pKa)
To determine the protonation state of residues at a specific pH, use the PROPKA or pKa-ANI methods:
- **PROPKA**: Use `--with-ph={PH_VALUE}` to invoke PROPKA and assign states based on the target pH.
- **pKa-ANI**: A deep-learning based method for titration state prediction (available in newer versions).

### Common Functional Flags
- `--nodebump`: Skips the check for steric clashes; useful if the structure is already well-relaxed.
- `--whitespace`: Inserts whitespace between columns in the PQR file (improves readability but may break older parsers).
- `--assign-only`: Only assigns charges and radii to existing atoms without adding new ones.
- `--neutraln` / `--neutralc`: Neutralizes the N-terminus or C-terminus of the protein.
- `--ligand={MOL2_FILE}`: Assigns parameters to a ligand using a provided MOL2 file (requires the ligand to have charges pre-assigned or compatible naming).

### Expert Tips
- **Naming Inconsistencies**: When using the CHARMM force field, be aware of potential naming mismatches for certain amino acids. If your downstream tool fails to read the PQR, check the residue naming conventions in the output.
- **Hydrogen Addition**: PDB2PQR is excellent at adding missing hydrogens. If your input PDB already has hydrogens (e.g., from an NMR structure), PDB2PQR will typically replace them to ensure consistency with the chosen force field's topology.
- **Non-standard Residues**: For phosphorylated residues or other modifications, ensure you are using a force field that supports them (like PARSE) or provide a custom user force field file via `--userff`.

## Reference documentation
- [PDB2PQR Repository Overview](./references/github_com_Electrostatics_pdb2pqr.md)
- [Community Discussions on Force Fields and Titration](./references/github_com_Electrostatics_pdb2pqr_discussions.md)
- [Known Issues and Bug Reports](./references/github_com_Electrostatics_pdb2pqr_issues.md)