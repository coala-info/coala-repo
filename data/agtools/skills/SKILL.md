---
name: agtools
description: The provided text does not contain help information or usage instructions; it is an error log from a container runtime (Apptainer/Singularity) indicating a failure to build the image due to lack of disk space.
homepage: https://github.com/Vini2/agtools
---

# agtools

## Overview
`agtools` is a Python-based framework specifically built for the manipulation and analysis of assembly graphs, with a primary focus on the Graphical Fragment Assembly (GFA) format. It bridges the gap between different assembly tools by providing conversion utilities and allows researchers to simplify complex graphs through filtering and component extraction. Use this skill to streamline metagenomic workflows, extract specific genomic neighborhoods, or generate adjacency matrices for custom graph theory applications.

## Common CLI Patterns

### Format Conversion
Convert various assembly graph formats to GFA or visualization formats:
- **FASTG to GFA**: `agtools fastg2gfa input.fastg output.gfa`
- **ASQG to GFA**: `agtools asqg2gfa input.asqg output.gfa`
- **GFA to GraphViz DOT**: `agtools gfa2dot input.gfa output.dot`

### Graph Manipulation and Extraction
- **Extract Component**: Isolate a specific connected component containing a target segment:
  `agtools component --segment <SEGMENT_ID> input.gfa --output component.gfa`
- **Filter Segments**: Remove specific segments from the graph:
  `agtools filter --segments <SEG_ID1,SEG_ID2> input.gfa --output filtered.gfa`
- **Clean Graph**: Synchronize a GFA file with a FASTA file (keeping only segments present in the FASTA):
  `agtools clean --fasta sequences.fasta input.gfa --output cleaned.gfa`

### Analysis and Export
- **Statistics**: Generate a summary of the graph (nodes, edges, N50, etc.):
  `agtools stats input.gfa`
- **Sequence Extraction**: Convert GFA segments back to FASTA format:
  `agtools gfa2fasta input.gfa output.fasta`
- **Adjacency Matrix**: Export the graph structure for mathematical analysis:
  `agtools gfa2adj input.gfa output.csv`

## Best Practices
- **Component Extraction**: When investigating a specific gene or contig of interest, use the `component` command to reduce the graph size to only the relevant neighborhood, making visualization much clearer.
- **Renaming**: Use `agtools rename` to standardize segment IDs across different assembly versions or tools to maintain consistency in multi-step pipelines.
- **Graph Cleaning**: Always run `agtools clean` if you have performed external filtering on your contig sequences to ensure the assembly graph accurately reflects the current state of your data.

## Reference documentation
- [agtools GitHub Repository](./references/github_com_Vini2_agtools.md)
- [agtools Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_agtools_overview.md)