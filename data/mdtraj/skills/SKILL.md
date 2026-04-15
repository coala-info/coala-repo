---
name: mdtraj
description: MDTraj is a Python library and command-line suite designed for the rapid analysis, manipulation, and conversion of molecular dynamics trajectories. Use when user asks to load or save simulation files, perform structural alignments, calculate physical observables like RMSD or hydrogen bonds, and select atoms using a domain-specific language.
homepage: https://github.com/mdtraj/mdtraj
metadata:
  docker_image: "quay.io/biocontainers/mdtraj:1.9.9"
---

# mdtraj

## Overview

MDTraj is a powerful Python library and command-line utility suite designed for the rapid analysis of molecular dynamics trajectories. It acts as a "Swiss Army knife" for computational chemists and biophysicists, providing a lightweight API that emphasizes speed through vectorized operations. Use this skill to handle complex trajectory data, perform structural alignments, or extract specific physical observables from simulation outputs. It is particularly effective when you need to bridge data between different simulation engines (e.g., GROMACS, AMBER, NAMD) or perform high-speed structural calculations that outperform traditional tools.

## High-Utility Instructions

### Trajectory Loading and Saving
MDTraj uses a `load` function that automatically detects file formats. For formats that do not contain topological information (like XTC or DCD), you must provide a topology file (usually a PDB or PRMTOP).

*   **Load a trajectory:** `import mdtraj as md; t = md.load('trajectory.xtc', top='topology.pdb')`
*   **Load a single frame:** `t = md.load_frame('trajectory.xtc', index=0, top='topology.pdb')`
*   **Save a trajectory:** `t.save_pdb('output.pdb')` or `t.save_xtc('output.xtc')`

### Atom Selection (DSL)
MDTraj features a sophisticated Domain Specific Language (DSL) for selecting atoms.
*   **Basic selection:** `atoms = t.topology.select("resname ALA and name CA")`
*   **Distance-based selection:** `atoms = t.topology.select("around 5.0 resname LIG")`
*   **Slicing:** Use `t.atom_slice(atoms)` to create a new trajectory containing only the selected atoms.

### Structural Analysis
*   **RMSD:** Calculate the RMSD to a reference frame: `md.rmsd(t, reference_traj, frame=0)`.
*   **Superposition:** Align a trajectory to a reference: `t.superpose(reference_traj, frame=0)`.
*   **Hydrogen Bonding:** Identify H-bonds using the Baker-Hubbard algorithm: `hbonds = md.baker_hubbard(t)`.
*   **Contacts:** Compute distances between pairs of atoms: `distances, residue_pairs = md.compute_contacts(t, contacts='all')`.

### Command Line Usage: mdconvert
The `mdconvert` utility is the primary CLI tool for quick format conversions and trajectory manipulation without writing Python scripts.

*   **Convert formats:** `mdconvert trajectory.dcd -t topology.prmtop -o output.xtc`
*   **Extract specific frames:** `mdconvert trajectory.xtc -o sampled.xtc -i 0,100,200` (extracts frames 0, 100, and 200).
*   **Stride a trajectory:** `mdconvert trajectory.xtc -o strided.xtc -s 10` (takes every 10th frame).

## Expert Tips
*   **Memory Management:** For very large trajectories that exceed RAM, use `md.iterload('large_traj.xtc', top='top.pdb', chunk=1000)` to process the data in chunks.
*   **Vectorization:** Avoid looping over frames in Python. Most MDTraj functions (like `compute_distances` or `compute_dihedrals`) are vectorized and accept the entire trajectory object as input.
*   **Topology Manipulation:** Use `t.topology.to_dataframe()` to inspect the molecular structure as a Pandas DataFrame for easy filtering and debugging.

## Reference documentation
- [MDTraj Main Repository](./references/github_com_mdtraj_mdtraj.md)