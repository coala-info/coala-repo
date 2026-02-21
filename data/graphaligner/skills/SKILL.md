---
name: graphaligner
description: GraphAligner is a specialized tool designed to map long genomic reads to graph-based reference structures.
homepage: https://github.com/maickrau/GraphAligner
---

# graphaligner

## Overview

GraphAligner is a specialized tool designed to map long genomic reads to graph-based reference structures. Unlike linear aligners, it navigates the nodes and edges of a genome graph (GFA or VG formats) to find the optimal path for a sequence. It employs a seed-and-extend strategy using bitvector-banded dynamic programming, which allows it to handle high error rates while maintaining efficiency across complex graph topologies.

## Common CLI Patterns

### Basic Alignment
The most common use case involves aligning a set of reads to a GFA graph using a preset:
```bash
GraphAligner -g graph.gfa -f reads.fastq -a alignments.gaf -x vg
```

### Working with Different Graph Types
Use the `-x` parameter to select optimized presets for your specific graph structure:
*   **Variation Graphs:** `-x vg` (Optimized for relatively simple graphs with small variants).
*   **de Bruijn Graphs:** `-x dbg` (Optimized for complex, dense assembly graphs).

### Input and Output Options
*   **Multiple Input Files:** Pass multiple read files using repeated `-f` flags:
    `GraphAligner -g graph.gfa -f sample1.fa -f sample2.fa -a out.gaf -x vg`
*   **Compressed Inputs:** Supports `.fasta.gz` and `.fastq.gz` directly.
*   **Output Formats:**
    *   `.gaf`: Standard Graph Alignment Format (recommended).
    *   `.gam`: Binary format compatible with the `vg` toolkit.
    *   `.json`: JSON representation of alignments.

## Expert Tuning and Best Practices

### Seeding Strategies
While minimizers are the default, you can increase sensitivity for difficult mappings:
*   **MUMs (Maximal Unique Matches):** Use `--seeds-mum-count -1` to use all MUMs as seeds.
*   **MEMs (Maximal Exact Matches):** Use `--seeds-mem-count -1` for all MEMs.
*   **Seed Caching:** When aligning multiple read sets to the same graph, save time by caching the index:
    `--seeds-mxm-cache-prefix my_index_name`

### Alignment Quality Control
*   **Identity Thresholds:** Use `--precise-clipping` to filter by identity. Recommended values:
    *   **ONT (Oxford Nanopore):** `0.75`
    *   **HiFi (PacBio):** `0.90`
    *   **Assembly-to-Assembly:** `0.95`
*   **Secondary Alignments:** Control multimapping with `--multimap-score-fraction [0-1]`. Lower values include more secondary alignments.

### Performance Optimization
*   **Threading:** Use `-t` to specify the number of alignment threads. Note that GraphAligner uses two additional threads for I/O.
*   **Tangle Effort:** In highly complex or cyclic graphs, the aligner may slow down. Adjust `--tangle-effort` to limit the time spent in complex subgraphs; if the band grows beyond this limit, the aligner will commit to the current best prefix and move on.
*   **Bandwidth:** The default bandwidth is usually sufficient. Increasing it beyond 35 is generally not recommended as it significantly increases runtime without proportional gains in accuracy for most graphs.

## Reference documentation
- [GraphAligner GitHub Repository](./references/github_com_maickrau_GraphAligner.md)
- [GraphAligner Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_graphaligner_overview.md)