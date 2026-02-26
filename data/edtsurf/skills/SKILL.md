---
name: edtsurf
description: "EDTSurf constructs macromolecular surfaces and calculates structural metrics using Euclidean Distance Transforms. Use when user asks to generate molecular surfaces, calculate protein depth, identify internal cavities, or create triangulated meshes from PDB files."
homepage: https://github.com/UnixJunkie/EDTSurf
---


# edtsurf

## Overview

EDTSurf is a high-performance tool designed for the rapid construction of macromolecular surfaces using Euclidean Distance Transforms. It transforms atomic coordinates from PDB files into triangulated meshes, allowing for the visualization and geometric analysis of protein and nucleic acid shapes. Beyond surface generation, it provides critical structural metrics such as depth (how far an atom is from the surface) and identifies buried cavities that may represent ligand binding sites or structural voids.

## Command Line Usage

The basic syntax for EDTSurf is:
`EDTSurf -i <input_pdb> [options]`

### Common Surface Generation Patterns

*   **Generate Molecular Surface (Default):**
    `EDTSurf -i protein.pdb`
    Produces `protein.ply` (mesh) and `protein.asa` (surface area).

*   **Generate Solvent-Accessible Surface (SAS):**
    `EDTSurf -i protein.pdb -s 2`

*   **Generate van der Waals Surface (VWS):**
    `EDTSurf -i protein.pdb -s 1`

*   **Calculate Protein Depth:**
    `EDTSurf -i protein.pdb -s 0`
    Produces `_atom.dep` and `_res.dep` files containing depth values for each atom and residue.

### Parameter Optimization

*   **Probe Radius (`-p`):** The default is 1.4Å (standard for water). Adjust this to model different solvents or to probe for larger channels.
*   **Scale Factor (`-f`):** Default is 4.0. Increasing this value improves the resolution of the surface mesh but significantly increases memory consumption. Use higher values for small, high-detail regions and lower values for very large complexes.
*   **Triangulation Type (`-t`):** 
    *   `1`: Marching Cubes (MC)
    *   `2`: Volumetric Centroid Marching Cubes (VCMC) - **Recommended** for more accurate and smoother triangulated surfaces.
*   **Color Mode (`-c`):**
    *   `1`: Pure color
    *   `2`: Atom-based coloring (Standard for visualization)
    *   `3`: Chain-based coloring

## Expert Tips and Best Practices

*   **Cavity Analysis:** When generating a Molecular Surface (MS) or SAS, EDTSurf automatically identifies internal cavities. These are saved in a separate file suffixed with `-cav.pdb`. This is highly useful for identifying potential allosteric sites.
*   **Visualization:** The primary output `.ply` files are best viewed in MeshLab or similar 3D mesh processing software.
*   **Surface Filtering:** Use the `-h` option to isolate specific parts of the geometry:
    *   `-h 2`: Output only the outer surface (useful for excluding internal noise).
    *   `-h 3`: Output only the inner surfaces (useful for focusing on cavities).
*   **Solvent Excluded Surface (SES):** While the default `-s 3` is the Molecular Surface, some versions/patches support `-s 4` specifically for SES. If `-s 3` does not yield the expected results for a rolling-ball surface, try `-s 4`.

## Reference documentation
- [EDTSurf README](./references/github_com_UnixJunkie_EDTSurf.md)
- [EDTSurf Pull Requests (SES Fix)](./references/github_com_UnixJunkie_EDTSurf_pulls.md)