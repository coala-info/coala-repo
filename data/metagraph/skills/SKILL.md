---
name: metagraph
description: MetaGraph is a high-performance genomic indexing framework used to build, annotate, and query massive de Bruijn graphs from large-scale sequence data. Use when user asks to build de Bruijn graphs, annotate graphs with source information, transform annotations into efficient formats, query sequences against an index, or assemble unitigs.
homepage: https://github.com/ratschlab/metagraph
---


# metagraph

## Overview
MetaGraph is a high-performance genomic indexing framework designed for petabase-scale sequence data. It utilizes succinct data structures to represent massive de Bruijn graphs with trillions of nodes and millions of annotation labels. This skill provides the procedural knowledge required to build graphs, annotate them with source information, transform those annotations for efficiency, and perform high-speed sequence queries or alignments.

## Installation and Environment
MetaGraph is available via Bioconda or Docker.

- **Conda**: `conda install -c bioconda -c conda-forge metagraph`
- **Docker**: `docker pull ghcr.io/ratschlab/metagraph:master`
- **Alphabets**: The default `metagraph` binary uses the DNA alphabet {A,C,G,T}. For other alphabets, use:
  - `metagraph_DNA5` for {A,C,G,T,N}
  - `metagraph_Protein` for amino acids

## Core Workflow Patterns

### 1. Graph Construction
Build a de Bruijn graph from FASTA/FASTQ files or KMC k-mer counters.

```bash
# Basic build
metagraph build -k 20 -p 30 --mem-cap-gb 10 -o graph_output input_data/*.fasta.gz

# Build with disk swap to limit RAM usage
metagraph build -k 20 -p 30 --mem-cap-gb 10 --disk-swap /tmp/swap_dir -o graph_output input_data/*.fasta.gz
```

### 2. Annotation
Map sequences or labels onto the constructed graph.

```bash
# Annotate using filenames as labels
metagraph annotate -i graph_output.dbg --anno-filename -o annotation_output input_data/*.fa
```

### 3. Annotation Transformation
Convert raw column-compressed annotations into more efficient formats like Multi-BRWT (Bit-Sliced Range Weaving Tree) for faster querying.

```bash
# Step A: Cluster columns (requires linkage file)
metagraph transform_anno -o linkage.txt --linkage --greedy --subsample 1000 -p 16 annotation_output.column.annodbg

# Step B: Construct Multi-BRWT
metagraph transform_anno --anno-type brwt --linkage-file linkage.txt -o final_index -p 16 annotation_output.column.annodbg
```

### 4. Querying and Alignment
Search for sequences within the annotated graph.

```bash
# Query for label presence (e.g., 80% k-mer match threshold)
metagraph query -i graph.dbg -a final_index.brwt.annodbg --min-kmers-fraction-label 0.8 query_sequences.fa

# Align sequences to the graph
metagraph align -i graph.dbg query_sequences.fa
```

### 5. Assembly
Extract sequences or unitigs from the graph.

```bash
# Assemble unitigs
metagraph assemble -i graph.dbg -o assembled_unitigs.fa --unitigs
```

## Expert Tips and Best Practices

- **Memory Management**: Always set `--mem-cap-gb` to prevent the process from being killed by the OS OOM (Out Of Memory) killer. If the dataset exceeds RAM, use `--disk-swap`.
- **Parallelization**: Use `-p` or `--parallel` to specify the number of threads. MetaGraph is highly optimized for multi-core systems.
- **K-mer Selection**: For most genomic applications, $k=21$ to $k=31$ is standard. Smaller $k$ values increase graph connectivity but may introduce ambiguity.
- **Batch Operations**: MetaGraph prefers batched operations. When querying, provide a single file containing all query sequences rather than running the command multiple times.
- **Cleaning Graphs**: Use the cleaning algorithms to remove sequencing errors (low-abundance k-mers) before annotation to significantly reduce index size.

## Reference documentation
- [MetaGraph GitHub Repository](./references/github_com_ratschlab_metagraph.md)
- [Bioconda MetaGraph Package](./references/anaconda_org_channels_bioconda_packages_metagraph_overview.md)