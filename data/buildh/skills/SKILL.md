---
name: buildh
description: The `buildh` tool is designed for researchers working with united-atom lipid models who need to recover atomic-level detail for hydrogen positions.
homepage: https://github.com/patrickfuchs/buildH
---

# buildh

## Overview
The `buildh` tool is designed for researchers working with united-atom lipid models who need to recover atomic-level detail for hydrogen positions. It serves two primary functions: geometrically reconstructing hydrogen atoms based on the positions of carbon atoms in a united-atom simulation and calculating the carbon-deuterium order parameters ($S_{CD}$) which are essential for validating simulation results against NMR data. It is particularly useful when transitioning from a coarse-grained or united-atom representation to an all-atom analysis or when preparing trajectories for specific analysis tools that require explicit hydrogens.

## Usage and Best Practices

### Core Command Structure
The basic execution requires a coordinate file, a lipid type specification, and a definition file:
```bash
buildH -c system.pdb -t traj.xtc -l Berger_POPC -d Berger_POPC.def
```

### Key Arguments
- `-c/--coord`: Input structure file (e.g., `.pdb`, `.gro`).
- `-t/--traj`: Input trajectory file (e.g., `.xtc`).
- `-l/--lipid`: The force field and lipid type (e.g., `Berger_POPC`, `CHARMM36_POPC`).
- `-d/--defop`: The `.def` file specifying which C-H bonds to reconstruct and analyze.
- `-opx`: Use this to generate an output trajectory containing the reconstructed hydrogens.
- `-igch3`: Ignore methyl (CH3) groups during order parameter calculation to speed up processing.

### Critical Pre-processing: PBC Handling
`buildh` requires molecules to be "whole." If lipids are split across periodic boundary conditions (PBC), the reconstruction will produce incorrect geometries.
**Expert Tip**: Always run your trajectory through a PBC-correcting tool before using `buildh`. For GROMACS users:
```bash
gmx trjconv -f broken_traj.xtc -s topol.tpr -pbc mol -o whole_traj.xtc
```

### Performance Modes
- **Fast Mode**: Run without the `-opx` flag if you only need the order parameters. This avoids the heavy I/O overhead of writing a new trajectory.
- **Slow Mode**: Use `-opx` only when you specifically need the resulting structure/trajectory for visualization or further all-atom analysis.

### Supported Lipid Types
Ensure your `-l` flag matches one of the supported internal definitions. Common options include:
- **Berger**: `Berger_POPC`, `Berger_DPPC`, `Berger_POPE`, `Berger_CHOL`.
- **CHARMM36 UA**: `CHARMM36UA_DPPC`.
- **GROMOS**: `GROMOS53A6L_DPPC`.

### Output Files
- **Order Parameters**: By default, results are written to `OP_buildH.out`.
- **Structure/Trajectory**: If `-opx` is used, it generates a PDB and an XTC file containing the built hydrogens.

## Reference documentation
- [buildH GitHub Repository](./references/github_com_patrickfuchs_buildH.md)
- [buildH Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_buildh_overview.md)