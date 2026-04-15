---
name: graphbin2
description: GraphBin2 refines metagenomic binning results by using assembly graph topology and coverage information to improve contig assignments. Use when user asks to refine metagenomic bins, resolve ambiguous contig assignments, or perform binning refinement using assembly graphs from SPAdes, MEGAHIT, or Flye.
homepage: https://github.com/metagentools/GraphBin2
metadata:
  docker_image: "quay.io/biocontainers/graphbin2:1.3.3--pyh7e72e81_0"
---

# graphbin2

## Overview

GraphBin2 is a specialized tool for metagenomic bin-refinement. While standard binning tools typically assign a contig to a single bin, GraphBin2 utilizes the assembly graph's topology and coverage information to propagate labels and identify contigs that may belong to multiple species. It is designed to be used after an initial binning step (e.g., from MetaBAT2, MaxBin2, or CONCOCT) to resolve ambiguous assignments and improve the overall accuracy of the metagenomic assembly.

## Installation and Setup

The recommended way to install GraphBin2 is via Bioconda:

```bash
conda install bioconda::graphbin2
```

Alternatively, it can be installed via pip:

```bash
pip install graphbin2
```

## Common CLI Patterns

GraphBin2 requires specific inputs based on the assembler used to generate the assembly graph.

### SPAdes Version
Use this pattern when working with short-read assemblies from SPAdes.
```bash
graphbin2 --assembler spades \
  --graph /path/to/assembly_graph_with_scaffolds.gfa \
  --contigs /path/to/contigs.fasta \
  --paths /path/to/contigs.paths \
  --binned /path/to/initial_binning_result.csv \
  --abundance /path/to/abundance.tsv \
  --output /path/to/output_folder
```

### MEGAHIT Version
MEGAHIT generates a `final.gfa` file which is required for the refinement process.
```bash
graphbin2 --assembler megahit \
  --graph /path/to/final.gfa \
  --contigs /path/to/final.contigs.fa \
  --binned /path/to/initial_binning_result.csv \
  --abundance /path/to/abundance.tsv \
  --output /path/to/output_folder
```

### metaFlye Version (Long-reads)
Note: Support for Flye is experimental. Long-read graphs may be sparse, which can limit the effectiveness of label propagation.
```bash
graphbin2 --assembler flye \
  --graph /path/to/assembly_graph.gfa \
  --contigs /path/to/assembly.fasta \
  --paths /path/to/assembly_info.txt \
  --binned /path/to/initial_binning_result.csv \
  --abundance /path/to/abundance.tsv \
  --output /path/to/output_folder
```

## Expert Tips and Best Practices

- **Initial Binning Format**: Ensure your initial binning results are in a two-column CSV format (ContigID, BinID) without headers.
- **Abundance Data**: The abundance file should be a TSV file. Ensure that the contig names in the abundance file exactly match the names in the FASTA and GFA files.
- **Graph Connectivity**: The tool's performance relies heavily on the connectivity of the assembly graph. If the graph is highly fragmented, the refinement may be less effective.
- **Overlapped Binning**: One of GraphBin2's primary advantages is its ability to assign a single contig to multiple bins. This is particularly useful for conserved sequences or mobile genetic elements shared between species.
- **Assembler Specifics**:
    - For **SPAdes**, the `.paths` file is crucial as it maps contigs to the edges in the assembly graph.
    - For **Flye**, the `assembly_info.txt` file serves a similar purpose to the paths file.

## Reference documentation

- [GraphBin2 GitHub Repository](./references/github_com_metagentools_GraphBin2.md)
- [Bioconda GraphBin2 Overview](./references/anaconda_org_channels_bioconda_packages_graphbin2_overview.md)