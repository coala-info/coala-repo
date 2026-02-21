---
name: autogrid-test
description: AutoGrid is a specialized utility within the AutoDock suite used to generate grid maps.
homepage: http://autodock.scripps.edu/
---

# autogrid-test

## Overview
AutoGrid is a specialized utility within the AutoDock suite used to generate grid maps. These maps represent the interaction energy between different atom types and a target protein. By pre-calculating these energies, the subsequent docking process is significantly accelerated as the docking engine only needs to look up values in the grid rather than calculating complex potentials at every step.

## Usage Guidelines

### Core Workflow
1. **Prepare Input Files**: Ensure you have the receptor in `.pdbqt` format and a grid parameter file (`.gpf`).
2. **Execution**: Run the tool using the `-p` flag to specify the parameter file and the `-l` flag for logging.
   ```bash
   autogrid4 -p receptor.gpf -l receptor.glg
   ```

### Grid Parameter File (.gpf) Essentials
The `.gpf` file defines the search space and atom types. Key parameters include:
- `npts`: Number of grid points in x, y, and z (must be even integers).
- `spacing`: Distance between grid points (default is usually 0.375Å).
- `gridcenter`: The coordinates for the center of the grid box.
- `ligand_types`: The specific atom types present in your ligand (e.g., C A N O S).

### Best Practices
- **Grid Dimensions**: Always add one extra point to `npts` (e.g., if you want 60 intervals, set `npts 60 60 60`). AutoGrid adds a central point, resulting in an odd number of points total.
- **Atom Types**: Ensure the `receptor_types` and `ligand_types` in the `.gpf` match the atom types defined in your `.pdbqt` files exactly.
- **Spacing**: While 0.375Å is standard for protein-ligand docking, consider smaller spacing (0.25Å) for higher resolution or larger spacing for initial blind docking scans.
- **File Naming**: Keep `.map` file names consistent with the receptor name to avoid confusion during the AutoDock phase.

## Reference documentation
- [AutoGrid Overview](./references/anaconda_org_channels_bioconda_packages_autogrid_overview.md)