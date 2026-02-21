---
name: biobb_mem
description: The `biobb_mem` module is a specialized component of the BioExcel Building Blocks (BioBB) ecosystem dedicated to membrane biology.
homepage: https://github.com/bioexcel/biobb_mem
---

# biobb_mem

## Overview
The `biobb_mem` module is a specialized component of the BioExcel Building Blocks (BioBB) ecosystem dedicated to membrane biology. It provides a standardized, interoperable interface for performing complex membrane characterization tasks that typically require multiple disparate tools. By wrapping libraries like MDAnalysis, FATSLiM, and LiPyphilic, `biobb_mem` allows you to automate workflows for identifying lipid leaflets, calculating area per lipid, measuring membrane thickness, and analyzing lipid translocation (flip-flops) through a consistent command-line interface.

## Command Line Usage
Each tool within `biobb_mem` is executed as a standalone command. The general syntax follows a pattern of defining input files, output files, and an optional configuration file.

### Standard CLI Pattern
```bash
[tool_name] --input_file1 input.ext --output_file1 output.ext --config config.json
```

### Common Tools and Functions
- **fatslim_membranes**: Used for calculating membrane properties like thickness and area per lipid using the FATSLiM engine.
- **lipyphilic_order**: Calculates lipid tail order parameters (Scd) to assess membrane fluidity and packing.
- **lipyphilic_flipflop**: Analyzes trajectories to detect and quantify lipid translocation events between the upper and lower leaflets.
- **gorder**: A tool for calculating order parameters, often used as a BioBB-compatible alternative to GROMACS order parameter tools.

## Best Practices and Expert Tips

### Input Preparation
- **Centering**: Always ensure your membrane system is properly centered in the simulation box and that periodic boundary conditions (PBC) are handled (e.g., using `gmx trjconv -pbc whole` or `cluster`) before running `biobb_mem` analysis.
- **Selection Strings**: When configuring tools that use MDAnalysis or LiPyphilic under the hood, use standard MDAnalysis selection syntax (e.g., `"resname POPC DPPC"`) to define your lipid species.

### Configuration Management
- **JSON Configs**: While many parameters have defaults, use a JSON configuration file to specify tool-specific settings such as `step`, `ensemble`, or `temperature`.
- **Leaflet Identification**: For asymmetric membranes, ensure your configuration correctly identifies the reference atoms (usually phosphorus atoms like `P` or `PO4`) used to distinguish between leaflets.

### Performance
- **Trajectory Slicing**: For large trajectories, use the `step` parameter in your configuration to analyze every Nth frame, reducing processing time without significantly losing statistical significance for equilibrium properties.
- **Environment**: Since `biobb_mem` relies on several external dependencies (FATSLiM, MDAnalysis), it is best used within a dedicated Conda environment to avoid version conflicts, particularly with `numpy` and `biopython`.

## Reference documentation
- [biobb_mem Overview](./references/anaconda_org_channels_bioconda_packages_biobb_mem_overview.md)
- [GitHub Repository](./references/github_com_bioexcel_biobb_mem.md)