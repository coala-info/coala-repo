---
name: scripps-msms
description: MSMS computes the solvent excluded surface and reduced surface of molecular structures to generate triangulated meshes and surface area calculations. Use when user asks to calculate molecular surface areas, generate triangulated meshes from atomic coordinates, or identify internal cavities in a protein structure.
homepage: https://ccsb.scripps.edu/msms/
metadata:
  docker_image: "quay.io/biocontainers/scripps-msms:2.6.1--h9ee0642_0"
---

# scripps-msms

## Overview

MSMS (Molecular Surface) is a high-performance algorithm designed to compute the Solvent Excluded Surface (SES) and Reduced Surface of molecular structures. It transforms atomic coordinates and radii into triangulated meshes suitable for visualization and provides detailed surface area calculations per atom. It is a standard tool for structural biology workflows requiring analytical or triangulated surface representations.

## Installation

The tool is available via Bioconda:
```bash
conda install bioconda::scripps-msms
```

## Core CLI Usage

The primary command is `msms`. It requires an input file in `.xyzr` format (X, Y, Z coordinates and atomic radius).

### Basic Surface Generation
To generate a triangulated surface with default parameters (1.5Å probe radius, 1.0 density):
```bash
msms -if molecule.xyzr -of output_prefix
```
This produces `output_prefix.vert` (vertices) and `output_prefix.face` (triangles).

### High-Resolution Surface
For smaller molecules or detailed analysis, increase the triangulation density:
```bash
msms -if molecule.xyzr -density 3.0 -probe_radius 1.4 -of output_prefix
```

### Calculating Surface Areas
To calculate solvent excluded and accessible surface areas without generating a full mesh:
```bash
msms -if molecule.xyzr -af areas.txt -no_area
```

## Advanced Options and Best Practices

### Handling Internal Cavities
By default, MSMS only computes the external component of the molecular surface. To include internal cavities:
```bash
msms -if molecule.xyzr -all_components -of output_prefix
```

### Input Format (.xyzr)
The input file must be a free-format text file where each line contains:
`x y z radius`
Lines starting with `#` are treated as comments.

### Output File Structure
- **.vert files**: Contain coordinates (x, y, z), normals (nx, ny, nz), and metadata including the index of the closest sphere and the face type (1=toric, 2=reentrant, 3=contact).
- **.face files**: Contain 1-based vertex indices for triangles and the analytical face number.

### Troubleshooting and Stability
- **Numerical Instability**: If MSMS fails to triangulate, it automatically attempts to restart by slightly adjusting atomic radii. To prevent this behavior (e.g., if you require exact radii), use `-no_rest`.
- **Headers**: If piping output to other scripts, use `-no_header` to suppress the 3-line metadata header in output files.
- **Hydrogen Atoms**: Use `-noh` to skip atoms with a radius typically associated with hydrogen (approx 1.2Å) if they interfere with surface continuity.

## Reference documentation
- [MSMS Documentation](./references/ccsb_scripps_edu_msms_documentation.md)
- [MSMS Overview](./references/ccsb_scripps_edu_msms.md)
- [Bioconda scripps-msms](./references/anaconda_org_channels_bioconda_packages_scripps-msms_overview.md)