---
name: strangepg
description: strangepg is a high-performance, cross-platform tool designed for the interactive visualization of massive pangenome graphs.
homepage: https://github.com/qwx9/strangepg
---

# strangepg

## Overview

strangepg is a high-performance, cross-platform tool designed for the interactive visualization of massive pangenome graphs. It specializes in handling GFAv1 files by automatically coarsening them to a manageable size (typically <7.5k nodes) at startup, allowing for fluid interaction even with graphs containing hundreds of millions of nodes. The tool uses a parallelized Fruchterman-Reingold force-directed layout and includes an embedded programming language, strawk, for advanced graph manipulation and data querying.

## Common CLI Patterns

### Basic Visualization
Load a GFA file with default settings:
`strangepg some.gfa`

### Performance and Layout
Increase the number of threads for the layout engine to improve responsiveness on large graphs:
`strangepg -t 8 some.gfa`

Switch to 3D visualization mode:
`strangepg -l 3d some.gfa`

### Metadata and Tagging
Load external metadata from a CSV file to be used for coloring or grouping:
`strangepg -c metadata.csv some.gfa`

Adjust node width for better visibility:
`strangepg -s 1 3 some.gfa`

### Offline Processing
Compute a layout non-interactively and save the state to a file:
`strangepg -n output.lay some.gfa`

Resume an interactive session from a saved layout:
`strangepg -f output.lay some.gfa`

## Scripting with strawk

strangepg allows executing commands immediately upon loading. These can be passed as trailing arguments or piped via stdin.

### Common Commands
- **Group by Tag**: `strangepg some.gfa 'groupby("SN")'` (Groups nodes by the SN tag)
- **Find Specific Node**: `strangepg some.gfa 'findnode("s42")'`
- **Batch Execution**:
  ```bash
  cat << EOF > commands.txt
  groupby("SN")
  findnode("s100")
  EOF
  strangepg some.gfa < commands.txt
  ```

## Expert Tips

- **Coarsening Control**: Use the `-T` flag to set the autocollapse threshold or disable it entirely if the graph is small enough for direct rendering.
- **Interactive Manipulation**: Nodes can be moved manually during the live layout process to guide the force-directed algorithm toward a desired orientation.
- **Memory Efficiency**: strangepg is designed for low memory overhead; if encountering performance issues on extremely large files, ensure you are using the latest build from source as the tool is under heavy development.
- **Coloring**: Use the embedded language to define custom color palettes based on node tags or path information in rGFA files.

## Reference documentation
- [strangepg README](./references/github_com_qwx9_strangepg.md)