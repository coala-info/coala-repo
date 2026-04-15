---
name: cmip
description: CMIP calculates classical molecular interaction potentials between a target molecule and a probe across a 3D grid. Use when user asks to calculate molecular interaction potentials, predict structural water positions, or identify favorable interaction sites on protein surfaces.
homepage: http://mmb.irbbarcelona.org/gitlab/gelpi/CMIP
metadata:
  docker_image: "quay.io/biocontainers/cmip:2.7.0--h8c3ec31_0"
---

# cmip

## Overview
CMIP is a specialized tool for calculating classical molecular interaction potentials. It is primarily used in structural biology and drug design to identify favorable interaction sites on protein surfaces, predict the locations of structural water molecules, and evaluate the energetic complementarity between molecules. This skill provides guidance on executing CMIP calculations and managing its input/output files.

## Core Functionality
CMIP operates by calculating interaction energies between a "target" molecule (usually a protein) and a "probe" (such as a water molecule, an ion, or a chemical fragment) across a 3D grid.

### Common CLI Patterns
The primary executable is typically `cmip`. It relies heavily on a parameter file (often named `cmip.in` or similar) to define the calculation parameters.

- **Running a calculation**:
  `cmip -i <input_parameter_file> -vdw <vdw_params> -hs <host_pdb> -pr <probe_pdb>`
- **Predicting Water Positions**:
  Use the `watden` or `watden90` utilities included in the suite to process interaction grids into high-probability water densities.

### Key Input Files
- **Parameter File (.in)**: Defines grid dimensions, spacing, dielectric constants, and calculation type (e.g., MIP, solvation, docking).
- **PDB/PQR Files**: Structural data for the host (target) and probe.
- **VDW Parameters**: Definitions for Van der Waals radii and well depths.

### Expert Tips
- **Grid Spacing**: For standard interaction maps, a grid spacing of 0.5 Å is usually sufficient. For high-resolution water prediction, consider 0.25 Å.
- **Box Dimensions**: Ensure the grid box extends at least 5-10 Å beyond the protein surface to capture long-range electrostatic effects.
- **Titration/pH**: When calculating electrostatic potentials, ensure the host PDB is correctly protonated (e.g., using PDB2PQR) to reflect the desired pH environment.

## Reference documentation
- [CMIP Overview](./references/anaconda_org_channels_bioconda_packages_cmip_overview.md)
- [CMIP Repository Structure](./references/github_com_mmb-irb_cmip.md)