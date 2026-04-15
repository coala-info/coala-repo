---
name: packmol
description: Packmol generates initial configurations for molecular simulations by packing molecules into defined spatial regions while avoiding atomic overlaps. Use when user asks to create starting configurations, build solvated systems, generate lipid bilayers, or pack molecules into specific volumes.
homepage: https://github.com/m3g/packmol
metadata:
  docker_image: "quay.io/biocontainers/packmol:18.169"
---

# packmol

## Overview

Packmol is a utility used to create starting configurations for molecular simulations. Unlike simple random placement, Packmol uses a constrained optimization approach to pack molecules into specific spatial regions. This ensures that the initial system is well-behaved, avoiding the "atomic overlaps" that often cause simulations to crash during the first few steps. It is ideal for building solvated systems, lipid bilayers, interfaces, and complex mixtures.

## Usage and CLI Patterns

### Basic Execution
Packmol typically reads instructions from a standard input file (often named `input.inp` or `pack.inp`).

```bash
# Standard execution
packmol < input.inp

# Using uv (if installed via python)
uvx packmol < input.inp
```

### Input File Structure
The input file is a plain text file containing global parameters and structure-specific blocks.

**Core Global Keywords:**
- `tolerance 2.0`: Sets the minimum distance (in Angstroms) between atoms of different molecules. 2.0 is the standard recommendation.
- `filetype pdb`: Specifies the format of input and output files (pdb, xyz, or tinker).
- `output system_init.pdb`: The name of the generated file.
- `add_amber_ter`: (Optional) Adds TER flags between molecules, useful for AMBER users.

**Structure Blocks:**
Each type of molecule to be packed requires a `structure` block:

```text
structure water.pdb
  number 1000
  inside box 0. 0. 0. 40. 40. 40.
end structure
```

### Common Spatial Constraints
- `inside box xmin ymin zmin xmax ymax zmax`: Packs molecules within a rectangular volume.
- `inside sphere xcenter ycenter zcenter radius`: Packs molecules within a sphere.
- `inside cylinder x1 y1 z1 x2 y2 z2 radius length`: Packs molecules within a cylinder.
- `outside sphere ...`: Ensures molecules are not placed inside a specific region.
- `fixed x y z a b c`: Places a single molecule at a specific coordinate with specific Euler angles.

## Expert Tips

1. **Tolerance Adjustments**: If Packmol fails to converge (cannot find a solution), try slightly decreasing the `tolerance` (e.g., to 1.8) or increasing the volume of the constraints.
2. **Fixed Proteins**: When solvating a protein, use the `fixed` keyword for the protein structure to keep it at the center, then use `inside box` or `inside sphere` for the solvent molecules around it.
3. **Layered Systems**: To create interfaces or bilayers, define multiple `structure` blocks with adjacent `inside box` constraints (e.g., one box from z=0 to 20, another from z=20 to 40).
4. **Seed for Reproducibility**: Use the `seed -1` keyword to generate a different configuration every time, or a positive integer to get a deterministic result.

## Reference documentation
- [Packmol Main README](./references/github_com_m3g_packmol.md)