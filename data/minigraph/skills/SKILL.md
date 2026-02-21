---
name: minigraph
description: Minigraph is a specialized tool for constructing and interacting with sequence graphs.
homepage: https://github.com/lh3/minigraph
---

# minigraph

## Overview

Minigraph is a specialized tool for constructing and interacting with sequence graphs. Unlike traditional mappers that align to a linear reference, minigraph allows for the incremental addition of new sequences into a graph structure (rGFA format) and the mapping of sequences against these complex structures. It is designed for efficiency, capable of handling dozens of human-scale assemblies to represent genomic diversity. It functions as both a mapper (producing GAF/PAF output) and a graph generator (producing rGFA output).

## Common CLI Patterns

### Sequence-to-Graph Mapping
To map sequences against an existing graph (GFA/rGFA format):
```bash
minigraph -cx lr graph.gfa query.fa > out.gaf
```
*   **-x**: Preset. Use `lr` for long reads or `asm` for assembly-to-graph mapping.
*   **-c**: Enables base alignment (recommended for higher quality).
*   **Output**: GAF (Graph Alignment Format) is a superset of PAF where the 6th column encodes the graph path.

### Incremental Graph Generation
To build a pangenome graph from multiple samples:
```bash
minigraph -cxggs -t16 ref.fa sample1.fa sample2.fa > out.gfa
```
*   **-g**: Enables graph generation mode.
*   **-s**: Output in rGFA (reference-stable GFA) format.
*   **-t**: Number of threads.
*   **Note**: The first input (`ref.fa`) acts as the backbone. Subsequent files should be whole-genome assemblies.

### Structural Variation (SV) Calling
To identify the specific path/allele an assembly takes through graph bubbles:
```bash
minigraph -cxasm --call -t16 graph.gfa sample-asm.fa > sample.bed
```
*   **--call**: Triggers the calling of paths through bubbles.
*   **Output**: A BED-like file where the last field contains the alignment path, length, and mapping strand.

## Expert Tips and Best Practices

*   **Input Assumptions**: For graph generation (`-g`), minigraph assumes input samples are whole-genome assemblies. Using raw reads or files containing multiple individuals will result in most alignments being filtered out because minigraph looks for 1-to-1 orthogonal regions.
*   **Base Alignment**: Always include the `-c` option during graph generation. While it increases computation time, it significantly improves the quality of the resulting graph by providing base-level accuracy.
*   **Reference Stability**: The rGFA format produced by `-s` ensures the initial reference coordinates remain stable, making it easier to project graph-based variations back to standard linear coordinates.
*   **Post-processing with gfatools**:
    *   **Extract Bubbles**: Use `gfatools bubble graph.gfa > var.bed` to find all potential SV sites.
    *   **Convert to FASTA**: Use `gfatools gfa2fa -s graph.gfa > out.fa` to extract the sequences represented in the graph.
*   **Memory and Performance**: Minigraph is highly optimized. It can construct a graph from 90 human assemblies in approximately two days using 24 CPU cores.

## Reference documentation
- [Minigraph GitHub Repository](./references/github_com_lh3_minigraph.md)
- [Bioconda Minigraph Overview](./references/anaconda_org_channels_bioconda_packages_minigraph_overview.md)