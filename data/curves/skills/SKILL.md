---
name: curves
description: Curves+ analyzes the numerical geometry of nucleic acid structures by calculating helical parameters and backbone descriptors from atomic coordinates. Use when user asks to analyze DNA or RNA structural parameters, process molecular dynamics trajectories for nucleic acid geometry, or calculate helical features from PDB files.
homepage: https://bisi.ibcp.fr/tools/curves_plus/index.html
metadata:
  docker_image: "quay.io/biocontainers/curves:3.0.3--h70c14e6_1"
---

# curves

## Overview
Curves+ is the standard tool for the numerical analysis of nucleic acid geometry. It transforms atomic coordinates from PDB or trajectory files into a comprehensive set of helical parameters (shift, slide, rise, tilt, roll, twist) and backbone descriptors. This skill provides the necessary command-line patterns to execute structural analysis on single structures or large ensembles from simulations.

## Usage Patterns

### Basic Structural Analysis
To analyze a single PDB file, Curves+ requires a configuration file (usually `.inp`) or standard input.

```bash
Cur+ <<EOF
 &inp
  pdbid='structure.pdb',
  lis='analysis_output',
  lib='standard',
 &end
 2 1 18 17
 1:18
 19:36
EOF
```
*Note: The numbers following the `&end` tag define the strand composition and residue ranges (e.g., two strands, first strand residues 1-18, second strand residues 19-36).*

### Analyzing Molecular Dynamics Trajectories
For trajectories, specify the topology and trajectory files. Curves+ can process NetCDF or MDCRD formats.

```bash
Cur+ <<EOF
 &inp
  pdbid='topology.pdb',
  trjdat='trajectory.nc',
  itrj=1, ftrj=1000, strj=1,
  lis='trajectory_analysis',
 &end
 2 1 20 20
 1:20
 21:40
EOF
```

### Key Parameters in `&inp`
- `pdbid`: Input PDB file (or topology for trajectories).
- `trjdat`: Path to the trajectory file.
- `itrj`, `ftrj`, `strj`: Initial frame, final frame, and step size.
- `lis`: Prefix for output files (.lis, .lib, .sol).
- `isoc`: Set to `.true.` to calculate solute-solvent interactions if water is present.
- `circ`: Set to `.true.` for circular DNA analysis.

## Expert Tips
- **Standard Conventions**: Curves+ follows the "Cambridge Convention" for nucleic acid geometry. Ensure your input PDB residues are numbered sequentially for the easiest setup.
- **Output Files**: 
    - `.lis`: Human-readable summary of parameters.
    - `.lib`: Binary file used for further processing with `Canal` (the companion tool for statistical analysis of Curves+ data).
- **Canal Integration**: After running Curves+ on a trajectory, use the `Canal` utility to generate time-series data or histograms from the resulting `.lib` file.
- **Memory Management**: For very large trajectories, use the `strj` parameter to sample frames rather than processing every single step to save time and disk space.

## Reference documentation
- [Curves+ Overview](./references/anaconda_org_channels_bioconda_packages_curves_overview.md)