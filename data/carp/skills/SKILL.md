---
name: carp
description: CARP quantifies the rearrangement complexity of pangenomes using the Single-Cut or Join model to identify evolutionary hotspots and structural variation. Use when user asks to calculate global complexity measures, scan for local regions of high complexity, generate colored GFAs for visualization, or extract specific subgraphs from a pangenome.
homepage: https://github.com/gi-bielefeld/scj-carp
---


# carp

## Overview
CARP (Complexity of Arrangements in Pangenomes) is a specialized toolset for quantifying the rearrangement complexity of pangenomes. It implements the Single-Cut or Join (SCJ) model to provide a mathematical measure of how "tangled" or rearranged a genomic graph is compared to a potential ancestral state. This is particularly useful for identifying evolutionary hotspots, simplifying complex graph regions, and visualizing structural variation density across a pangenome.

## Core Binaries and Usage
The toolset consists of three primary binaries: `carp`, `carp-scan`, and `carp-extract`. All tools require an input file specified by either `--gfa <file>` or `--unimog <file>`.

### 1. carp: Global Complexity Measure
Use this to calculate the total SCJ CARP measure for an entire pangenome.
- **Basic calculation**: `carp --gfa input.gfa`
- **Save results**: Use `-m <file>` to write the measure and `-a <file>` to save a potential set of ancestral adjacencies.
- **Filtering**: Use `-s <int>` to ignore nodes smaller than a specific base pair threshold (useful for removing assembly noise).

### 2. carp-scan: Local Complexity Analysis
Use this to identify specific regions of high complexity within the graph.
- **Context Window**: Use `-c <int>` to define the context length in base pairs (for GFA) or number of nodes (for Unimog).
- **Visualization**: Generate a colored GFA for Bandage using `--colored-gfa output.gfa`. This colors nodes based on their local complexity.
- **Statistical Analysis**: Use `--output-histogram <file>` to generate data for complexity distribution.
- **Filtering by Percentile**: Use `--lower-percentile` and `--higher-percentile` (e.g., 0.90 to 1.00) to output only the most complex node IDs to stdout.

### 3. carp-extract: Subgraph Extraction
Use this to isolate a specific neighborhood around a node of interest for closer inspection.
- **Command pattern**: `carp-extract --gfa input.gfa -n <node_id> -d <distance_bp> > subgraph.gfa`
- **Note**: The output is sent to `stdout`, so redirection to a file is required.

## Expert Tips and Best Practices
- **Threading**: Always specify `-t <threads>` for the main computation, as the default may not utilize all available resources. Note that this does not currently speed up initial file reading.
- **GFA Overlaps**: When filtering nodes with `-s`, you must use the `--ignore-gfa-overlap` flag in `carp-scan`, as variable overlaps are not supported during node filtering.
- **Unimog Limitations**: Remember that Unimog files do not contain node lengths. Consequently, `-s` (size threshold) will filter all nodes, and `-c` (context length) will treat the input as a count of nodes rather than base pairs.
- **Visualization Workflow**:
    1. Run `carp-scan` with `--colored-gfa`.
    2. Open the resulting file in **Bandage**.
    3. Use the provided `plotscripts/gradient.py` (if available in the source) to interpret the color scale.

## Reference documentation
- [Anaconda Bioconda Carp Overview](./references/anaconda_org_channels_bioconda_packages_carp_overview.md)
- [GitHub Repository README](./references/github_com_gi-bielefeld_scj-carp.md)