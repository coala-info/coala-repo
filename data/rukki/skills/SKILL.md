---
name: rukki
description: Rukki is a graph-processing tool designed to reconstruct long, haplotype-resolved scaffolds from assembly graphs.
homepage: https://github.com/marbl/rukki
---

# rukki

## Overview
Rukki is a graph-processing tool designed to reconstruct long, haplotype-resolved scaffolds from assembly graphs. It is primarily used as a companion to the Verkko assembler. By analyzing parental-specific markers and graph topology, rukki assigns nodes to maternal or paternal classes, identifies homozygous regions, and performs heuristic searches to generate continuous haplotype paths.

## CLI Usage and Patterns

### Basic Trio-Binning Workflow
The primary command for haplotype extraction requires a graph and a marker count file.

```bash
rukki trio \
  -g assembly_graph.gfa \
  -m marker_counts.tsv \
  -p output_paths.tsv
```

### Key Input Requirements
- **Graph (-g):** GFA format. While sequences are optional, the tool utilizes node coverage tags (`RC:i:`, `FC:i:`, or `ll:f:`) for path heuristics.
- **Markers (-m):** A TSV file where the first three columns are `node_name`, `maternal_count`, and `paternal_count`.

### Common Options and Flags
- **Aggressive Path Filling:** Use `--try-fill-bubbles` to enable more aggressive filling of ambiguous regions. This is generally recommended for more complete scaffolds.
- **Output Format:** By default, paths are formatted as `node1+,node2-`. Use `--gaf-format` to output in GAF path format (`>node1<node2`).
- **Node Assignments:** Use `--final-assign node_assign.tsv` to output a file detailing the final classification (MATERNAL, PATERNAL, or HOMOZYGOUS) for every node used in the paths.

## Expert Tips and Best Practices
- **Gap Estimation:** Rukki can scaffold across gaps. If an estimate is available, it uses it; otherwise, it defaults to a 5kb gap (minimum 1kb). These gaps appear in the output as `[NXXXN]`.
- **Homozygous Nodes:** The tool attempts to identify nodes belonging to both haplotypes. If the graph has missing connections, rukki prevents the re-use of long nodes unless they are explicitly assigned as homozygous.
- **Handling Ambiguity:** Rukki is designed to handle tandem repeat expansions and complex bubble structures. If a path cannot be uniquely determined, it can either scaffold across the region or force-pick a path based on the provided heuristics.
- **Unassigned Paths:** Every node in the graph is guaranteed to be covered by at least one output path. Single nodes that cannot be assigned to a haplotype are labeled as `NA`.

## Reference documentation
- [Rukki GitHub Repository](./references/github_com_marbl_rukki.md)
- [Bioconda Rukki Overview](./references/anaconda_org_channels_bioconda_packages_rukki_overview.md)