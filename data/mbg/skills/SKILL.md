---
name: mbg
description: MBG constructs a sparse de Bruijn graph from high-fidelity long reads using minimizers and homopolymer compression. Use when user asks to build a genomic assembly graph, generate a unitigified GFA from HiFi reads, or resolve repeats using a multiplex de Bruijn graph.
homepage: https://github.com/maickrau/MBG
metadata:
  docker_image: "quay.io/biocontainers/mbg:1.0.17--h06902ac_0"
---

# mbg

## Overview
MBG (Minimizer based sparse de Bruijn Graph constructor) is a specialized assembler designed for high-fidelity long-read data. It processes sequences by applying homopolymer compression, selecting syncmers as nodes, and connecting them based on read adjacency. This approach produces a unitigified graph in GFA format. Use this tool when you need a memory-efficient graph representation of genomic data, particularly when working with reads that have low per-base error rates but potential homopolymer length variation.

## Core CLI Usage
The basic command structure requires defining the k-mer size, window size, and abundance thresholds.

```bash
MBG -i input_reads.fa -o output_graph.gfa -k 1501 -w 1450 -a 1 -u 3
```

### Key Parameters
- `-k`: K-mer size. Must be odd and at least 31.
- `-w`: Window size. Must be $\le k-30$.
- `-a`: Minimum k-mer abundance. Filters out k-mers with coverage below this value (Default: 1).
- `-u`: Minimum unitig abundance. Filters out unitigs with average coverage below this value (Default: 2).
- `-t`: Number of threads.

## Expert Tips and Best Practices

### Input Selection
- **Recommended**: PacBio HiFi/CCS reads or ONT duplex reads.
- **Not Recommended**: PacBio CLR or standard ONT reads (high raw error rates interfere with the sparse DBG logic).
- **Multiple Inputs**: Use multiple `-i` flags to include several files (supports `.fa`, `.fq`, `.bam`, and gzipped versions).

### Parameter Tuning for Resolution
- **Repeat Resolution**: All repeats shorter than $k$ are separated. Repeats longer than $k+w$ are collapsed. Repeats between these lengths may be separated or collapsed depending on syncmer selection.
- **Multiplex DBG**: Use `-r <max_k>` to enable the multiplex DBG algorithm, which increases k-mer size up to the specified value to resolve complex regions.
- **Error Cleaning**: Use `-R <value>` to remove low-coverage k-mers when $k < R$. This is effective for removing sequencing errors in the early stages of graph construction.

### Error Masking Modes
Control how the tool handles homopolymers and microsatellites using `--error-masking`:
- `hpc` (Default): Masks homopolymer errors and calls consensus on run lengths.
- `msat`: Calls consensus on microsatellites (repeat motifs up to 6bp).
- `no`: Disables masking entirely.

### Advanced Graph Outputs
- **Blunt Graphs**: Use `--blunt` to produce a graph without edge overlaps. Note that this cannot be used with `-r` or `--output-sequence-paths`. It is recommended to clean blunt graphs with `vg` afterward.
- **Sequence Paths**: Use `--output-sequence-paths <file.gaf>` to get the alignments of input sequences to the graph in GAF format.
- **Linear References**: If building a graph from a linear reference genome rather than reads, use `--include-end-kmers` to prevent clipping at chromosome ends.

## Reference documentation
- [MBG GitHub Repository](./references/github_com_maickrau_MBG.md)
- [Bioconda MBG Package](./references/anaconda_org_channels_bioconda_packages_mbg_overview.md)