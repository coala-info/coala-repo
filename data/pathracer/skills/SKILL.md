---
name: pathracer
description: PathRacer aligns profile HMMs to assembly graphs to reconstruct complete sequences across fragmented segments. Use when user asks to align HMMs to GFA or FASTG graphs, identify full-length genes in metagenomic data, or traverse assembly paths to recover fragmented sequences.
homepage: http://cab.spbu.ru/software/pathracer/
---


# pathracer

## Overview
PathRacer is a specialized alignment tool designed to bridge the gap between profile HMMs and fragmented assembly graphs. Unlike traditional tools that align HMMs to linear contigs, PathRacer traverses the edges of an assembly graph (GFA/FASTG) to reconstruct complete sequences that might be split across different segments. It is particularly effective for identifying full-length genes in complex metagenomic data where assembly continuity is low.

## Usage Guidelines

### Core Workflow
1.  **Input Preparation**: Ensure you have an assembly graph in `.gfa` or `.fastg` format and a profile HMM (e.g., from Pfam or TIGRFAMs).
2.  **Translation**: For amino acid HMMs, PathRacer performs on-the-fly codon translation of the graph edges.
3.  **Path Extraction**: The tool identifies the most probable paths through the graph that satisfy the HMM constraints.

### Common CLI Patterns
While specific flags vary by version, the standard execution follows this structure:
```bash
pathracer --graph assembly_graph.gfa --hmm profile.hmm --outdir output_directory
```

### Best Practices
- **Graph Quality**: Use PathRacer on assembly graphs before aggressive scaffolding, as the connectivity information in the graph is what allows the tool to recover fragmented sequences.
- **HMM Selection**: Use high-quality, specific profile HMMs to reduce computational complexity when traversing large, complex graphs.
- **Metagenomics**: This tool is highly recommended for "dark matter" analysis in metagenomes where target genes are frequently broken by assembly gaps.

## Reference documentation
- [PathRacer Overview](./references/anaconda_org_channels_bioconda_packages_pathracer_overview.md)