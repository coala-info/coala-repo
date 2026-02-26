---
name: fatslim_biobb
description: This tool performs rapid, memory-efficient analysis of lipid membrane molecular dynamics trajectories across various morphologies and force fields. Use when user asks to identify membrane leaflets, calculate membrane thickness, or determine area per lipid for bilayers and vesicles.
homepage: https://fatslim.github.io/
---


# fatslim_biobb

## Overview
The `fatslim_biobb` skill provides a streamlined interface for FATSLiM (Fast Analysis Toolbox for Simulations of Lipid Membranes). It excels at rapid, memory-efficient analysis of large MD trajectories. Unlike many tools that assume a flat bilayer, this tool is morphology-agnostic, making it suitable for complex geometries like vesicles or highly curved membranes. It supports both atomistic (e.g., Slipids) and coarse-grained (e.g., Martini) force fields.

## Command-Line Usage and Best Practices

### Core Requirements
To run any analysis, you typically need three files:
1.  **Configuration (`-c`)**: A `.gro` file containing atom names and residues.
2.  **Index (`-n`)**: An `.ndx` file containing a group representing the lipid headgroups.
3.  **Trajectory (`-t`)**: An `.xtc` or `.trr` file. If omitted, the tool analyzes the single frame in the configuration file.

### Common Analysis Patterns

**1. Identifying Leaflets**
Use this to determine which lipids belong to the upper or lower leaflets. This is often the first step before more complex analysis.
```bash
fatslim membranes -c conf.gro -t traj.xtc -n index.ndx --output-index leaflets.ndx
```

**2. Calculating Membrane Thickness**
Calculates the distance between leaflets and can generate a plot of thickness over time.
```bash
fatslim thickness -t traj.xtc --plot-thickness thickness.xvg
```

**3. Area Per Lipid (APL) Analysis**
Calculates the area occupied by individual lipids. For detailed post-processing, export the raw values to CSV.
```bash
fatslim apl -t traj.xtc --export-apl-raw apl_values.csv
```

### Expert Tips and Optimization

*   **Headgroup Selection**: By default, FATSLiM looks for an index group named "headgroups". If your group has a different name, specify it using `--hg-group <name>`. You can use a single atom (like Phosphorus) or a group of atoms (like the whole choline headgroup); FATSLiM will use the center of geometry.
*   **Parallelization**: The tool uses OpenMP for multi-threading. It defaults to using all available cores, but you can limit this in shared environments using `--nthreads <number>`.
*   **Memory Efficiency**: FATSLiM is designed to be "frugal." It scales linearly with the number of lipids, making it significantly faster than standard GROMACS utilities for specific membrane tasks.
*   **Vesicle Analysis**: When working with vesicles, FATSLiM automatically handles the curvature to provide accurate inner and outer leaflet areas, which is a significant advantage over tools designed only for XY-plane bilayers.

## Reference documentation
- [FATSLiM Homepage and Usage Guide](./references/fatslim_github_io_index.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_fatslim_biobb_overview.md)