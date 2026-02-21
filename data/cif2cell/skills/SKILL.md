---
name: cif2cell
description: cif2cell is a specialized tool that automates the translation of experimental crystallographic data into the specific input formats required by various density functional theory (DFT) and electronic structure simulation packages.
homepage: https://github.com/torbjornbjorkman/cif2cell
---

# cif2cell

## Overview

cif2cell is a specialized tool that automates the translation of experimental crystallographic data into the specific input formats required by various density functional theory (DFT) and electronic structure simulation packages. It handles the complex task of applying symmetry operations defined in a CIF file to generate atomic positions and lattice vectors, supporting both primitive and conventional cell representations.

## Common CLI Patterns

The basic syntax for the tool is:
`cif2cell [options] <inputfile.cif>`

### Basic Conversion
To generate a basic output for a specific program, use the `-p` (or `--program`) flag:
- **VASP**: `cif2cell crystal.cif -p vasp`
- **Quantum Espresso**: `cif2cell crystal.cif -p quantum_espresso`
- **ABINIT**: `cif2cell crystal.cif -p abinit`
- **XYZ format**: `cif2cell crystal.cif -p xyz`

### Program-Specific Options
Many supported programs have additional flags to refine the output:
- **VASP Cartesian Positions**: `cif2cell <file>.cif -p vasp --vasp-cartesian-positions`
- **CASTEP VCA**: Use for Virtual Crystal Approximation support in CASTEP.

### Supported Electronic Structure Codes
The tool provides tailored output for a wide range of codes, including:
- **Standard DFT**: VASP, ABINIT, Quantum Espresso, CASTEP, FHI-aims, Siesta, CPMD.
- **All-electron/Specialized**: Fleur, elk, exciting, RSPt, EMTO, SPR-KKR.
- **Utilities**: ASE, ATAT, Crystal09, crymol.

## Best Practices and Tips

- **Check Help for Flags**: Each program backend often has unique flags. Always run `cif2cell -h` to see the full list of options available for your specific target program.
- **Cell Selection**: By default, the tool can generate either primitive or conventional cells. Ensure you specify the desired cell type if the calculation requires a specific symmetry representation.
- **Alloy Support**: For systems with partial occupancy, check if your target program (like VASP or EMTO) supports the alloy/VCA features provided by cif2cell.
- **Installation**: If the tool is missing, it can be installed via pip: `pip install cif2cell`. It requires the `PyCIFRW` package.
- **Manual Access**: A detailed manual (`cif2cell.pdf`) is typically located in the installation directory under `lib/cif2cell/docs/`.

## Reference documentation
- [cif2cell README](./references/github_com_torbjornbjorkman_cif2cell.md)