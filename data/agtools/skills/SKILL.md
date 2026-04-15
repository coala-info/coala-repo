---
name: agtools
description: agtools is a toolkit for manipulating assembly graph files and performing topological queries for metagenomic analysis. Use when user asks to generate graph metrics, filter segments, clean GFA files against FASTA sequences, rename elements for concatenation, or extract connected components.
homepage: https://github.com/Vini2/agtools
metadata:
  docker_image: "quay.io/biocontainers/agtools:1.0.2--py313hdfd78af_0"
---

# agtools

## Overview

agtools is a specialized toolkit designed to bridge the gap between raw assembly graph files and downstream metagenomic analysis. It provides both a Command-Line Interface (CLI) for rapid file manipulation and a Python API for complex topological queries. It is particularly useful for handling Graphical Fragment Assembly (GFA) files, allowing users to "clean" graphs against FASTA sequences, rename elements for concatenation, and identify structural features like circular plasmids or bacteriophage candidates.

## CLI Usage and Best Practices

The `agtools` CLI is the primary entry point for batch processing and file preparation.

### Essential Commands
- **`stats`**: Generates both graph-based (node degree, components) and sequence-based (N50, L50, GC%) metrics.
- **`filter`**: Removes segments shorter than a specified length (`-l`). Note that this also removes all associated links, paths, and walks to maintain graph integrity.
- **`clean`**: Synchronizes a GFA file with a FASTA file. It removes segments missing from the FASTA and populates missing sequences in the GFA `S` tags.
- **`component`**: Extracts only the subgraph connected to a specific segment ID (`-s`).
- **`rename`**: Prepends a prefix to all segment, path, and walk IDs. **Crucial step** before using `concat` to avoid ID collisions.

### Common Workflow: Preparing Multiple Samples
When merging graphs from different assembly runs:
1. Run `agtools rename -g sample1.gfa -p S1 -o ./` for each sample.
2. Run `agtools concat -g S1_sample1.gfa -g S2_sample2.gfa -o ./merged/`.

## Python API Integration

For advanced analysis, use the `UnitigGraph` and `ContigGraph` classes.

### Loading Graphs
```python
from agtools.core.unitig_graph import UnitigGraph
from agtools.assemblers import spades, megahit, flye

# Standard GFA
ug = UnitigGraph.from_gfa("assembly.gfa")

# Assembler-specific contig graphs (handles naming nuances)
cg = spades.get_contig_graph("graph.gfa", "contigs.fasta", "contigs.paths")
```

### Topological Analysis Patterns
- **Finding Neighbors**: `ug.get_neighbors("segment_id")` returns adjacent segment names.
- **Connected Components**: `ug.get_connected_components()` returns lists of internal IDs, useful for binning contigs by connectivity.
- **Sequence Retrieval**: `ug.get_segment_sequence("name")` uses byte offsets to retrieve DNA without loading the entire graph into memory.
- **Oriented Graphs**: To perform pathfinding or cycle detection, build a directed graph where each segment has two nodes (`+` and `-`). Use `ug.oriented_links` to populate edges.

## Expert Tips
- **Memory Efficiency**: agtools uses byte offsets for sequence access. When working with large metagenomes, prefer `get_segment_sequence()` over manual FASTA parsing.
- **Graph Simplification**: The `ecount` (edge count) in agtools may differ from `lcount` (link lines) because agtools simplifies the graph by removing multiple edges and self-loops for standard graph operations.
- **Format Conversion**: Use `fastg2gfa` or `asqg2gfa` to standardize inputs before performing analysis, as most `agtools` functions are optimized for GFA1.



## Subcommands

| Command | Description |
|---------|-------------|
| agtools asqg2gfa | Convert ASQG file to GFA format |
| agtools clean | Clean a GFA file based on segments in a FASTA file |
| agtools component | Extract a component containing a given segment |
| agtools concat | Concatenate two or more GFA files |
| agtools fastg2gfa | Convert FASTG file to GFA format |
| agtools filter | Filter segments from GFA file |
| agtools gfa2adj | Get adjacency matrix of the assembly graph |
| agtools gfa2dot | Convert GFA file to DOT format (GraphViz) |
| agtools gfa2fasta | Get segments in FASTA format |
| agtools rename | Rename segments, paths and walks in a GFA file |
| agtools stats | Compute statistics about the graph |

## Reference documentation
- [agtools CLI Reference](./references/agtools_readthedocs_io_en_latest_cli.md)
- [agtools API Documentation](./references/agtools_readthedocs_io_en_latest_api.md)
- [Assembler-specific Examples](./references/agtools_readthedocs_io_en_latest_assemblerexamples.md)
- [Example Applications (Binning, Plasmids, Phages)](./references/agtools_readthedocs_io_en_latest_exampleapplications.md)
- [File Formats (GFA, FASTG, ASQG, DOT)](./references/agtools_readthedocs_io_en_latest_fileformats.md)