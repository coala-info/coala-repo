---
name: nglview
description: nglview renders 3D molecular structures and trajectories interactively within computational notebooks. Use when user asks to visualize protein structures, display molecular dynamics trajectories, apply molecular representations, or inspect docking results.
homepage: https://github.com/arose/nglview
---


# nglview

## Overview
The `nglview` skill enables the rendering of 3D molecular data directly inside computational notebooks. It acts as a Python interface to the NGL Viewer, allowing users to manipulate structures, apply various representations (like cartoons, surfaces, or ball-and-stick models), and animate molecular dynamics trajectories. This skill should be applied when a user needs to inspect molecular geometries, verify docking results, or analyze simulation frames visually.

## Core Usage Patterns

### Loading Structures
Load molecules from various sources using convenience functions:
- **From PDB ID**: `view = nglview.show_pdbid("3pqr")`
- **From Local File**: `view = nglview.show_file("molecule.pdb")` (Supports .pdb, .gro, .mol2, .sdf, .dx)
- **From Analysis Objects**: 
    - MDTraj: `nglview.show_mdtraj(traj)`
    - MDAnalysis: `nglview.show_mdanalysis(universe)`
    - RDKit: `nglview.show_rdkit(mol)`
    - PyTraj: `nglview.show_pytraj(traj)`

### Managing Representations
Control how the molecule looks by adding or modifying layers:
- **Add specific styles**: 
    - `view.add_cartoon(selection="protein", color="blue")`
    - `view.add_surface(selection="protein", opacity=0.3)`
    - `view.add_licorice("ALA, GLU")`
- **Reset view**: `view.clear_representations()`
- **Update existing**: `view.update_cartoon(opacity=0.4, component=0)`

### Trajectory Control
For molecular dynamics, use the player and frame properties:
- **Jump to frame**: `view.frame = 100`
- **Adjust playback**: `view.player.parameters = dict(delay=0.04, step=-1)` (negative step plays backward)

### Stage and Camera Customization
Modify the global viewing environment:
- **Background**: `view.background = 'black'`
- **Camera**: `view.camera = 'orthographic'` (useful for formal figures) or `'perspective'`
- **Clipping Planes**: 
  ```python
  view.stage.set_parameters(clipNear=0, clipFar=100, fogNear=0, fogFar=100)
  ```

## Expert Tips and Troubleshooting

### Handling Large Systems
If visualizing large solvated systems (e.g., water boxes) causes the notebook to hang or fail to display, you must increase the data rate limit when launching the notebook:
`jupyter notebook --NotebookApp.iopub_data_rate_limit=10000000`

### Selection Language
NGL uses a specific selection string syntax:
- `protein`: All protein residues.
- `hetero`: Non-protein/non-nucleic atoms (ligands, ions).
- `1-50`: Residues 1 through 50.
- `:A`: Chain A.
- `.CA`: Alpha carbons only.

### Clean Initialization
To prevent the default "everything" representation from loading when you want a custom setup:
`view = nglview.show_file("your.pdb", default=False)`
`view.add_rope()`

## Reference documentation
- [NGLview Main Repository and Usage](./references/github_com_nglviewer_nglview.md)
- [Issue #633: Large System Display Issues](./references/github_com_nglviewer_nglview_issues_633.md)