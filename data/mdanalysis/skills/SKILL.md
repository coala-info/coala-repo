---
name: mdanalysis
description: MDAnalysis is a Python library that provides an object-oriented framework for the scientific analysis of molecular dynamics simulations. Use when user asks to load simulation trajectories, select specific atom groups, iterate through trajectory frames, or perform calculations on atomic coordinates using NumPy arrays.
homepage: https://github.com/MDAnalysis/mdanalysis
---


# mdanalysis

## Overview
MDAnalysis is a specialized Python library that provides an object-oriented framework for scientific analysis of molecular simulations. It abstracts complex file formats into a consistent API centered around the "Universe" (the simulation system) and "AtomGroups" (subsets of atoms). By exposing atomic data—such as positions, velocities, and forces—directly as NumPy arrays, it enables high-performance custom analysis workflows.

## Core Workflow Patterns

### 1. Initializing the Universe
The `Universe` object is the entry point. It requires a topology file (e.g., .tpr, .prmtop, .pdb) and optionally one or more trajectory files (e.g., .xtc, .trr, .dcd).

```python
import MDAnalysis as mda
# Load a topology and a trajectory
u = mda.Universe("topol.tpr", "traj.xtc")
```

### 2. Atom Selection
Use the `select_atoms` method with a selection string. The syntax is similar to VMD.
- **Basic**: `u.select_atoms("protein")`
- **Specific**: `u.select_atoms("resname ALA and name CA")`
- **Distance-based**: `u.select_atoms("around 5.0 resname LIG")`
- **Boolean**: `u.select_atoms("prop z > 50 or name OW")`

### 3. Trajectory Iteration
To perform analysis over time, iterate through the trajectory. The `Universe` state updates to the current frame in each step.

```python
for ts in u.trajectory:
    # 'ts' is the current Timestep object
    # AtomGroup positions update automatically to the current frame
    com = u.select_atoms("protein").center_of_mass()
    print(f"Frame {ts.frame}: COM at {com}")
```

### 4. Accessing Data as NumPy Arrays
For performance, avoid manual loops over atoms. Use the built-in array accessors:
- `ag.positions`: Returns an (N, 3) float32 array.
- `ag.velocities`: Returns an (N, 3) array (if available in trajectory).
- `ag.forces`: Returns an (N, 3) array (if available in trajectory).

## Expert Tips and Best Practices

- **Memory Management**: MDAnalysis typically reads trajectories frame-by-frame (on-the-fly) to save memory. Avoid converting the entire trajectory to a list unless the system is very small.
- **Selection Persistence**: AtomGroups are "static" in terms of the atoms they contain, but "dynamic" in terms of their coordinates. If you select atoms at frame 0, that specific group of atoms is tracked throughout the trajectory iteration.
- **Writing Data**: Use the `Writer` class to save filtered or modified trajectories.
  ```python
  with mda.Writer("output.xtc", u.atoms.n_atoms) as W:
      for ts in u.trajectory[::10]: # Write every 10th frame
          W.write(u.atoms)
  ```
- **Unit Consistency**: MDAnalysis uses Angstroms (length) and picoseconds (time) by default. Be careful when mixing data with GROMACS-native tools which often use nanometers.

## Reference documentation
- [MDAnalysis Repository README](./references/github_com_MDAnalysis_mdanalysis.md)
- [MDAnalysis Wiki Home](./references/github_com_MDAnalysis_mdanalysis_wiki.md)