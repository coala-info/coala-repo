---
name: plip
description: PLIP automatically detects and characterizes non-covalent interactions between proteins and ligands from 3D structural data. Use when user asks to identify chemical contacts in a PDB file, generate interaction reports, or create PyMOL visualization sessions for molecular complexes.
homepage: https://github.com/pharmai/plip
---

# plip

## Overview

The Protein-Ligand Interaction Profiler (PLIP) is a specialized tool for the automated detection and characterization of non-covalent interactions in molecular complexes. It transforms raw 3D structural data (PDB files) into detailed interaction profiles, identifying specific chemical contacts that govern molecular recognition. This skill enables the execution of PLIP via its command-line interface or Python API to generate human-readable reports, XML data, and PyMOL visualization sessions.

## CLI Usage and Best Practices

### Basic Analysis
To analyze a structure by its PDB ID (requires internet access) or a local file:
- **PDB ID**: `plip -i 1vsn`
- **Local File**: `plip -i /path/to/protein_ligand.pdb`

### Visualization
To generate a PyMOL session file (.pse) and rendered images of the interactions:
- `plip -i 1vsn -yv`
The resulting `.pse` file can be opened directly in PyMOL to inspect the 3D geometry of the detected contacts.

### Advanced CLI Options
- **Output Directory**: Specify where results should be saved using `-o /path/to/output/`.
- **Region-based Analysis**: Use the `--regions` flag to detect interactions between specific protein regions (e.g., domains).
- **Filtering**: Use flags to suppress specific outputs if only data is needed (e.g., avoiding heavy image rendering in high-throughput runs).

### Common CLI Patterns
- **Silent/Batch Mode**: When running on large datasets, ensure you use the containerized version (Docker/Singularity) to avoid local dependency conflicts with OpenBabel.
- **Report Naming**: By default, PLIP names reports based on the input. For batch processing, ensure your input filenames are unique to prevent overwriting.

## Python Module Integration

For complex workflows, use the PLIP Python API to extract interaction data programmatically:

```python
from plip.structure.preparation import PDBComplex

# Initialize and load structure
my_mol = PDBComplex()
my_mol.load_pdb('/path/to/complex.pdb')

# Identify binding sites
print(my_mol.ligands) # Lists available ligands

# Analyze a specific binding site (HetID:Chain:Position)
my_bsid = 'NFT:A:283' 
my_mol.analyze()
my_interactions = my_mol.interaction_sets[my_bsid]

# Access specific interaction types
for hb in my_interactions.hbond:
    print(f"H-Bond between {hb.donor.resname}{hb.donor.resnr} and {hb.acceptor.resname}{hb.acceptor.resnr}")
```

## Expert Tips

1. **Binding Site Identifiers**: PLIP uses a unique string format `[HetID]:[Chain]:[Position]`. Always verify this ID by printing `my_mol.ligands` before attempting to access `interaction_sets`.
2. **Dependency Management**: OpenBabel and PyMOL bindings are notoriously difficult to configure manually. Always prefer the Docker image (`pharmai/plip:latest`) for CLI tasks to ensure deterministic results.
3. **Large Complexes**: For very large structures or those with many ligands, use the `--nofix` flag if the PDB file is already pre-processed, as PLIP's internal "fixing" step can be time-consuming.
4. **DNA/RNA Support**: PLIP 2021+ supports nucleic acid interactions. The workflow remains identical to protein-ligand analysis.

## Reference documentation
- [PLIP Main Documentation](./references/github_com_pharmai_plip.md)
- [PLIP Issues and Troubleshooting](./references/github_com_pharmai_plip_issues.md)