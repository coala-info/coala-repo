---
name: mach2
description: Mach2 reconstructs cancer cell migration histories by applying parsimony criteria to clonal trees and anatomical locations. Use when user asks to reconstruct migration paths between anatomical sites, resolve evolutionary polytomies, or generate optimal migration histories for cancer clones.
homepage: https://github.com/elkebir-group/mach2
metadata:
  docker_image: "quay.io/biocontainers/mach2:1.0.2--pyhdfd78af_0"
---

# mach2

## Overview

The `mach2` skill enables the reconstruction of cancer cell movement between anatomical sites. By applying parsimony criteria to clonal trees and observed clone locations, the tool identifies the most likely migration paths, including comigration events and the presence of unobserved clones. Use this skill to resolve evolutionary polytomies and generate optimal migration histories that can be further explored using the `mach2-viz` tool.

## Prerequisites

Before running `mach2`, ensure the following environment requirements are met:
- **Python**: Version 3.12 is required.
- **ILP Solver**: `mach2` currently requires the Gurobi optimizer (v12 or newer).
- **License**: A valid Gurobi license must be accessible via the `GRB_LICENSE_KEY` environment variable.
- **Library Paths**: Ensure Gurobi is in your `LD_LIBRARY_PATH` (Linux) or `DYLD_LIBRARY_PATH` (macOS).

## Input File Preparation

`mach2` requires two primary space-separated text files:

### 1. Clonal Tree File
Defines the structure of the tree using parent-child relationships.
- **Format**: `node1 node2` (one edge per line)
- **Example**:
  ```text
  1 2
  2 3
  2 4
  ```

### 2. Observed Labeling File
Maps nodes in the clonal tree to the anatomical locations where they were observed.
- **Format**: `node label1 label2 ...`
- **Example**:
  ```text
  1 Breast
  3 Lung Liver
  4 Bone
  ```

## Command Line Usage

The basic syntax for executing a migration analysis is:

```bash
mach2 <clonal_tree> <observed_labeling> -p <primary_location> [options]
```

### Common Arguments
- `-p, --primary`: Specify the primary anatomical location (e.g., `-p Breast`).
- `-c, --criteria`: Set the criteria ordering for parsimony (e.g., migration count, comigration count).
- `-o, --output`: Specify the directory for output files.
- `-t, --threads`: Number of threads for the Gurobi solver.
- `--viz`: Generates a JSON file compatible with the `mach2-viz` tool.

### Example Execution
To run an analysis on breast cancer data with a specific color map:
```bash
mach2 data/A1.tree data/A1.observed.labeling -p breast --colormap data/coloring.txt --viz
```

## Managing Outputs

For every optimal solution found, `mach2` generates:
1. **Refined Tree**: A tree file including timestamps and comigration data.
2. **Location Labeling**: A file mapping every node in the refined tree to a single location of origin.
3. **Node of Origin**: A mapping between the refined tree nodes and the original input clonal tree nodes.
4. **JSON Summary**: If `--viz` is used, a JSON file is created containing all solutions for use in the `mach2-viz` web interface.

## Expert Tips

- **Solution Limits**: For complex trees, the solution space can be vast. Use `--max_solutions` to limit the number of returned histories and `--timelimit` to return the best suboptimal solution if the search takes too long.
- **Visualization**: Always use the `--viz` flag if you intend to perform exploratory analysis. The resulting JSON can be loaded into the `mach2-viz` tool (either the hosted version or a local npm instance) to interactively view migration patterns.
- **Color Mapping**: Use a `--colormap` file (format: `location color_hex`) to ensure consistent anatomical site coloring across different runs and visualizations.

## Reference documentation
- [MACH2 GitHub Repository](./references/github_com_elkebir-group_MACH2.md)
- [MACH2-Viz Documentation](./references/github_com_elkebir-group_mach2-viz.md)