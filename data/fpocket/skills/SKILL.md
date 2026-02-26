---
name: fpocket
description: fpocket is a toolset for protein pocket detection and druggability prediction based on Voronoi tessellation. Use when user asks to identify binding cavities, analyze molecular dynamics trajectories for transient pockets, or calculate geometric descriptors for protein structures.
homepage: https://github.com/Discngine/fpocket
---


# fpocket

## Overview
The `fpocket` suite is a high-speed toolset for protein pocket detection based on Voronoi tessellation. It is primarily used in drug discovery and structural biology to locate cavities on a protein's surface that may accommodate small molecules. Beyond simple detection, it provides druggability scores and geometric descriptors. The suite consists of four main tools: `fpocket` for single structures, `mdpocket` for conformational ensembles, `dpocket` for descriptor extraction, and `tpocket` for scoring function validation.

## Command Line Usage

### Basic Pocket Detection
To run the default pocket detection on a single protein structure:
```bash
fpocket -f protein.pdb
fpocket -f protein.cif
```
*Note: Ensure file extensions are correct as the tool uses them to determine the input parser.*

### Analyzing MD Trajectories (mdpocket)
Use `mdpocket` to find transient pockets or analyze pocket frequency across a trajectory:
```bash
mdpocket --trajectory_file input.xtc --trajectory_format xtc -f topology.pdb
```
Supported trajectory formats include XTC, NetCDF, and DCD. If a topology file (`.prmtop`) is provided, interaction energy grids can be calculated.

### Advanced CLI Options
*   **Explicit Pockets**: To calculate properties for a known binding site rather than searching for new ones, use the explicit pocket flag (check `fpocket -h` for specific version-dependent flags like `-P`).
*   **Chain Handling**: You can define or isolate specific protein chains to characterize protein-protein binding epitopes.
*   **Flexibility**: The tool considers temperature (B-factors) to filter out highly flexible, solvent-exposed areas that are unlikely to be stable binding sites.

## Best Practices and Tips
*   **Druggability Scores**: Pay attention to the "Druggability Score" in the output. This score has been re-optimized in version 4.0+ to better predict the likelihood of a pocket binding a drug-like molecule.
*   **Output Structure**: `fpocket` creates a directory named `[input]_out/` containing:
    *   `pockets/`: Individual PDB files for each detected pocket.
    *   `[input]_out.pdb`: The original structure with Voronoi vertices included.
    *   `[input]_info.txt`: Detailed descriptors (volume, polarity, hydrophobicity) for each pocket.
*   **Docker Usage**: If the local environment lacks dependencies like `libnetcdf`, use the official Docker image:
    ```bash
    docker run -v `pwd`:/workdir fpocket/fpocket fpocket -f /workdir/file.pdb
    ```
*   **mmCIF Support**: For large structures or modern datasets, prefer `.cif` formats as `fpocket` 3.0+ provides full support for mmCIF input and output.

## Reference documentation
- [fpocket GitHub Repository](./references/github_com_Discngine_fpocket.md)