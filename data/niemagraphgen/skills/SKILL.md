---
name: niemagraphgen
description: "NiemaGraphGen generates massive graphs by streaming edges directly to standard output to minimize memory usage. Use when user asks to generate large-scale networks, simulate graph models like Barabási–Albert or Erdős–Rényi, or stream graph data into a processing pipeline."
homepage: https://github.com/niemasd/NiemaGraphGen
---


# niemagraphgen

## Overview

NiemaGraphGen (NGG) is a suite of high-performance C++ executables designed to generate massive graphs without storing the entire structure in memory. By streaming edges directly to standard output, it enables the simulation of global-scale contact networks that would otherwise exceed system RAM. It is particularly useful for researchers needing to feed graph data into a pipeline for real-time processing or compression.

## Command Line Usage

The toolset consists of several individual executables prefixed with `ngg_`. Each corresponds to a specific graph model.

### Common Executables
- `ngg_barabasi_albert`: Scale-free networks using preferential attachment.
- `ngg_erdos_renyi`: Random graphs where each edge has a fixed probability.
- `ngg_newman_watts_strogatz`: Small-world networks.
- `ngg_complete`: Fully connected graphs.
- `ngg_cycle` / `ngg_path` / `ngg_ring_lattice`: Basic structural topologies.
- `ngg_barbell`: Two complete graphs connected by a path.

### Basic Patterns
To generate a graph, run the specific model executable followed by its required parameters. Use the `-h` or `--help` flag on any executable to see specific parameter requirements.

```bash
# Generate a complete graph with 100 nodes
ngg_complete 100 > complete_n100.tsv

# Generate a Barabási–Albert graph (n=1000, m=2)
ngg_barabasi_albert -n 1000 -m 2 > ba_graph.tsv
```

### Streaming and Compression
Because NGG is designed for data streaming, the most efficient way to handle large outputs is to pipe them directly to a compression utility or the next tool in your analysis pipeline.

```bash
# Stream a large Erdős–Rényi graph directly to gzip
ngg_erdos_renyi -n 1000000 -p 0.0001 | gzip > large_graph.tsv.gz
```

## Output Formats

### FAVITES Format (Default)
The default output is a tab-separated format compatible with the FAVITES framework:
- `NODE\t[ID]`
- `EDGE\t[U]\t[V]`

### Compact Binary Format
If the tool was compiled with the `OUTCOMPACT` flag, it produces a binary stream:
1. **Header (1 byte):** Indicates integer size (0=1 byte, 1=2 bytes, 2=4 bytes, 3=8 bytes).
2. **Node Count:** Total nodes in the graph.
3. **Edges:** Pairs of integers representing connected nodes.

## Expert Tips

1. **Memory Efficiency:** NGG does not store the graph. If you are running out of memory, the bottleneck is likely the downstream tool consuming the output, not NGG itself.
2. **Integer Limits:** By default, most builds use 32-bit integers (supporting ~4.2 billion nodes). If you need to simulate larger populations, ensure the tool is compiled with `NGG_UINT_64`.
3. **Parameter Sensitivity:** For models like `ngg_newman_watts_strogatz`, ensure your parameters (n, k, p) are mathematically valid for the algorithm to prevent empty or malformed outputs.
4. **Python Integration:** When loading NGG output into NetworkX or similar libraries, use a line-by-line generator to maintain the memory-efficient benefits of the streaming architecture.



## Subcommands

| Command | Description |
|---------|-------------|
| ngg_barabasi_albert | NiemaGraphGen v1.0.6 (FAVITES Output Format) (32-bit) (Barabasi-Albert) |
| ngg_barbell | NiemaGraphGen v1.0.6 (FAVITES Output Format) (32-bit) (Barbell Graph) |
| ngg_complete | NiemaGraphGen v1.0.6 (FAVITES Output Format) (32-bit) (Complete Graph) |
| ngg_cycle | NiemaGraphGen v1.0.6 (FAVITES Output Format) (32-bit) (Cycle Graph) |
| ngg_erdos_renyi | Generates a graph using the Erdos-Renyi model. |
| ngg_newman_watts_strogatz | Generates a Newman-Watts-Strogatz graph. |
| ngg_path | NiemaGraphGen v1.0.6 (FAVITES Output Format) (32-bit) (Path Graph) |
| ngg_ring_lattice | Generates a ring lattice graph. |

## Reference documentation
- [NiemaGraphGen GitHub Repository](./references/github_com_niemasd_NiemaGraphGen.md)
- [NiemaGraphGen Wiki and Cookbook](./references/github_com_niemasd_NiemaGraphGen_wiki.md)