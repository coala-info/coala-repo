---
name: parmed
description: ParmEd facilitates the creation, manipulation, and conversion of molecular topologies and coordinate files across various force field formats. Use when user asks to convert between molecular file formats, modify force field parameters, or programmatically edit chemical systems for simulations.
homepage: https://github.com/ParmEd/ParmEd
metadata:
  docker_image: "quay.io/biocontainers/parmed:3.4.3"
---

# parmed

## Overview

ParmEd is a specialized tool designed to facilitate the creation and manipulation of molecular systems described by classical force fields (Amber, CHARMM, AMOEBA, GROMOS, etc.). It provides a unified interface to read and write a wide array of file formats, making it the "Swiss Army knife" for molecular topology interoperability. 

The tool operates through two primary interfaces:
1. **A Python API**: For programmatic manipulation and integration into simulation workflows.
2. **A CLI Interpreter (`parmed`)**: For executing discrete "Actions" on topology files via scripts or interactive sessions.

## Common CLI Patterns

The `parmed` (or `parmed.py`) executable is the primary way to interact with topologies via the command line.

### Basic File Conversion
To convert an Amber topology and coordinate set to GROMACS format:
```bash
parmed -p system.prmtop -c system.inpcrd << EOF
saveas gromacs system.top system.gro
EOF
```

### Interactive Parameter Editing
You can run `parmed` interactively to inspect or modify a topology:
```bash
parmed -p protein.prmtop
# Inside the interpreter:
printDetails :1-10          # Print details for residues 1 through 10
changeLJSingleType :WAT@O 1.7 0.152  # Change LJ parameters for water oxygen
outparm modified.prmtop     # Save the new topology
```

### Scripted Actions
Use the `-i` flag to run a pre-written script of ParmEd actions:
```bash
parmed -p complex.prmtop -i modify_params.in
```

## Python API Best Practices

The Python API is centered around the `Structure` class, which is the internal representation of the chemical system.

### Universal Loading
Always use `load_file` as it automatically detects the file format:
```python
import parmed as pmd

# Load Amber files
amber = pmd.load_file('prmtop', 'inpcrd')

# Load GROMACS files
gmx = pmd.load_file('system.top', xyz='system.gro')

# Load a PDB
pdb = pmd.load_file('protein.pdb')
```

### Format Conversion
Converting between formats is as simple as loading one and saving as another:
```python
# Convert Amber to CHARMM
amber = pmd.load_file('prmtop', 'inpcrd')
amber.save('charmm.psf')
amber.save('charmm.crd')
```

### Programmatic Modifications
Use the `parmed.tools` package to apply the same actions available in the CLI:
```python
from parmed import load_file
from parmed.tools import addLJType

parm = load_file('system.prmtop')
# Add a new LJ type to atom 1
act = addLJType(parm, '@1', radius=1.0, epsilon=0.5)
act.execute()
parm.save('new.prmtop')
```

## Expert Tips

- **Coordinate Requirement**: When converting to formats like GROMACS or CHARMM, ensure you provide coordinate files (e.g., `.inpcrd`, `.gro`, `.pdb`) during the load step if you intend to save a coordinate-dependent file (like `.gro` or `.crd`).
- **OpenMM Integration**: ParmEd structures can be converted directly to OpenMM System objects: `system = parm.createSystem(nonbondedMethod=pmd.openmm.PME)`.
- **Selection Syntax**: ParmEd uses Amber-style mask syntax (e.g., `:1-10`, `@CA`, `:WAT&!@H=`) for selecting atoms and residues in both the CLI and API.
- **Stripping Atoms**: To remove solvent or specific residues: `parm.strip(':WAT')`. This updates the topology and coordinates simultaneously.

## Reference documentation

- [ParmEd README](./references/github_com_ParmEd_ParmEd.md)
- [ParmEd Wiki](./references/github_com_ParmEd_ParmEd_wiki.md)