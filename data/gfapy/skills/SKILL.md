---
name: gfapy
description: gfapy is a Python library for parsing, manipulating, and analyzing Graphical Fragment Assembly data in GFA1 and GFA2 formats. Use when user asks to load or save GFA files, traverse assembly graph topology, merge linear paths, or convert between GFA specifications.
homepage: https://github.com/ggonnella/gfapy
---


# gfapy

## Overview
gfapy is a flexible Python library specifically designed for handling Graphical Fragment Assembly (GFA) data. It bridges the gap between raw text-based assembly files and programmatic graph analysis. Use this skill when you need to automate the editing of assembly graphs, such as merging linear paths, filtering segments by length or coverage, or converting between GFA1 and GFA2 specifications. It is particularly useful for bioinformaticians working with assembly, variation, or splicing graphs.

## Core Python Usage Patterns

### Loading and Saving
Gfapy automatically detects whether a file is GFA1 or GFA2.
```python
import gfapy

# Load a graph from a file (supports .gz if recently updated)
gfa = gfapy.Gfa.from_file("assembly.gfa")

# Create an empty graph and add lines manually
gfa = gfapy.Gfa()
gfa.add_line("H\tVN:Z:1.0")
gfa.add_line("S\t1\tACGT")

# Save the graph
gfa.to_file("output.gfa")
```

### Accessing Graph Elements
Elements are accessible via collections on the Gfa object.
- **Segments**: `gfa.segments` (Access by ID: `gfa.segment_dict['id']`)
- **Edges**: `gfa.edges` (Includes Links and Containments in GFA1)
- **Paths**: `gfa.paths`
- **Headers**: `gfa.header`

### Graph Traversal
To navigate the graph, use the connectivity methods on segment objects:
- `segment.dovetails`: Returns links representing overlaps between segments.
- `segment.connectivity`: Returns all edges connected to the segment.
- `segment.neighbors`: Returns segments connected to the current one.

### Manipulation and Editing
Gfapy allows for structural changes to the graph:
- **Removing elements**: `gfa.rm(element_object)` or `gfa.rm("line_id")`.
- **Merging Paths**: Use `merge_linear_paths()` to simplify graphs by collapsing non-branching sequences.
- **Renaming**: Use `segment.rename("new_name")` to update the segment ID and all associated references in links/paths automatically.

## Expert Tips and Best Practices
- **Validation**: Gfapy performs validation during parsing. If you encounter `gfapy.error.NotFoundError`, ensure that all segment IDs referenced in links actually exist in the S-lines of the file.
- **Custom Tags**: Gfapy supports custom tags (e.g., `S 1 ACGT LN:i:4 xx:Z:custom`). You can access these as attributes: `segment.xx`.
- **Memory Management**: For very large graphs, sequence strings can consume significant RAM. If you only need the graph topology, consider scripts that strip sequences before loading, or use the library to iterate through lines without storing the full Gfa object if the task allows.
- **Canonical Representation**: When comparing links, use `link.is_canonical()` to check if the link is in a standard orientation, which helps in deduplicating edges.

## Common CLI Tools
If gfapy is installed via pip or conda, several utility scripts are typically available in the environment:
- `gfapy-convert`: Convert between GFA1 and GFA2.
- `gfapy-mergelinear`: Simplifies the graph by merging linear components.
- `gfapy-validate`: Checks if a GFA file conforms to the specification.

## Reference documentation
- [Gfapy GitHub Repository](./references/github_com_ggonnella_gfapy.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_gfapy_overview.md)