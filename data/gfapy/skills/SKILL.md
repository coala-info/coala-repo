---
name: gfapy
description: Gfapy is a Python library for parsing, manipulating, and navigating sequence assembly graphs in GFA1 and GFA2 formats. Use when user asks to load GFA files, traverse graph topology, modify assembly segments and links, or convert between GFA versions.
homepage: https://github.com/ggonnella/gfapy
---

# gfapy

## Overview

Gfapy is a specialized Python library designed to interface with the Graphical Fragment Assembly (GFA) specifications (both GFA1 and GFA2). It provides a high-level object-oriented interface to represent sequence graphs, allowing for the programmatic manipulation of segments, links, containments, and paths. This skill should be used to automate bioinformatics workflows involving sequence assembly data, such as filtering assembly graphs, calculating graph statistics, or converting between GFA versions.

## Core Usage Patterns

### Initializing and Loading Graphs
Gfapy allows loading from existing files or creating graphs from scratch.

```python
import gfapy

# Load an existing GFA file (supports GFA1 and GFA2)
gfa = gfapy.Gfa.from_file("assembly.gfa")

# Create an empty GFA object
new_gfa = gfapy.Gfa()
```

### Accessing Graph Elements
Elements are accessible via collections on the Gfa object.

*   **Segments**: `gfa.segments`
*   **Links**: `gfa.links` (GFA1) or `gfa.edges` (GFA2)
*   **Containments**: `gfa.containments`
*   **Paths**: `gfa.paths`
*   **Headers**: `gfa.header`

### Graph Traversal
One of the primary strengths of gfapy is the ability to navigate the graph topology through segment objects.

```python
# Find a specific segment by name
segment = gfa.segment_dict["seq1"]

# Get all links connected to this segment
for link in segment.links:
    print(f"Connected to: {link.other_side(segment).name}")

# Get only outgoing links
for link in segment.dovetails_out:
    print(f"Target: {link.to_segment.name}")
```

### Manipulating the Graph
You can add or remove elements dynamically. Gfapy handles the underlying string formatting and validation.

```python
# Add a new segment
gfa.add_line("S\tseq3\tATGC")

# Remove a segment (and its associated links)
gfa.rm(gfa.segment_dict["seq1"])

# Renumber segments or modify tags
for segment in gfa.segments:
    segment.set_tag("KC", 50) # Add/Update K-mer count tag
```

## Best Practices and Expert Tips

1.  **Dialect Selection**: If working with specific GFA subsets like rGFA (Reference GFA), initialize the Gfa object with the appropriate dialect: `gfapy.Gfa(dialect="rgfa")`.
2.  **Validation**: Gfapy performs validation during parsing. If you encounter malformed lines, use try-except blocks around `add_line` or `from_file` to catch `gfapy.NotFoundError` or `gfapy.ValueError`.
3.  **Memory Efficiency**: For very large assembly graphs, be aware that gfapy loads the entire graph into memory as Python objects. If memory is a constraint, consider pre-filtering the GFA file using CLI tools before loading into gfapy.
4.  **Custom Tags**: Gfapy supports custom tags. You can access them directly as attributes if they follow the standard `XX:Z:value` format.
5.  **GFA1 to GFA2**: While gfapy handles both, they have different record types (e.g., Links vs. Edges). Always check `gfa.version` before performing version-specific logic.



## Subcommands

| Command | Description |
|---------|-------------|
| gfapy-convert | Convert a GFA file to the other specification version |
| gfapy-mergelinear | Merge linear paths in a GFA graph |
| gfapy-validate | Validate a GFA file |

## Reference documentation
- [Gfapy README](./references/github_com_ggonnella_gfapy_blob_master_README.rst.md)
- [Gfapy Repository Overview](./references/github_com_ggonnella_gfapy.md)