---
name: stark
description: Stark bluntifies bidirected de Bruijn graphs by identifying and removing sequence overlaps between connected nodes. Use when user asks to bluntify a graph, remove sequence overlaps from a bidirected de Bruijn graph, or convert a graph into a blunt-ended version.
homepage: https://github.com/hnikaein/stark
---


# stark

## Overview
The `stark` tool is a specialized utility designed for bioinformatics researchers working with bidirected de Bruijn graphs. Its primary function is to "bluntify" these graphs by identifying and removing sequence overlaps between connected nodes. This transformation is essential for certain downstream analysis tools that require nodes to represent non-overlapping sequence segments. You should use this skill when you have a graph that contains overlap information (often found in GFA or similar formats) and you need to convert it into a clean, blunt-ended version.

## Usage Guidelines

### Input Requirements
*   **Graph Type**: The tool specifically expects a **bidirected De Bruijn Graph**.
*   **Validation**: `stark` does not internally validate whether the input graph is a mathematically valid bidirected DBG. Ensure your upstream assembly or graph construction tool produces the correct structure before processing.
*   **Data Preservation**: Be aware that `stark` does **not** preserve tags or auxiliary metadata associated with the graph elements. It focuses strictly on the sequence and topology.

### Installation and Setup
The most reliable way to access the tool is via Bioconda:
```bash
conda install -c bioconda stark
```

If building from source, ensure you have CMake 3.10+ and use the recursive clone to pull dependencies:
```bash
git clone --recursive https://github.com/hnikaein/stark
cd stark
mkdir build && cd build
cmake ..
cmake --build . -- -j 8
```

### Best Practices
*   **Pre-processing**: Since the tool does not check input validity, use a graph validator or visualization tool (like Bandage) to inspect your graph if `stark` produces unexpected results.
*   **Pipeline Integration**: Because tags are lost during the bluntifying process, run `stark` as an early step in your pipeline before adding complex annotations or metadata to your graph nodes.
*   **Memory Management**: When working with very large pangenome graphs, monitor system memory, as graph bluntifying can be computationally intensive depending on the number of overlaps.

## Reference documentation
- [stark - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_stark_overview.md)
- [GitHub - hnikaein/stark](./references/github_com_hnikaein_stark.md)