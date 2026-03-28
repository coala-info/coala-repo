---
name: lightstringgraph
description: LightStringGraph constructs memory-efficient string graphs from sequencing data using the Burrows-Wheeler Transform. Use when user asks to prepare BWT indices, identify read overlaps, perform transitive reduction, or convert string graphs to ASQG format.
homepage: http://lsg.algolab.eu
---

# lightstringgraph

## Overview
LightStringGraph is a specialized suite for constructing string graphs from sequencing data with a low memory footprint. It leverages the Burrows-Wheeler Transform (BWT) to identify overlaps between reads without explicitly storing all overlaps in memory. This skill provides the procedural steps to prepare input data, generate the necessary BWT indices using BEETL, and execute the core LightStringGraph components (`lsg`, `redbuild`, and `graph2asqg`) to produce an assembly-ready graph.

## Workflow and CLI Usage

### 1. Input Preparation
The tool requires a FASTA file containing both the original reads and their reverse complements.
- **Requirement**: If `reads.fa` has $n$ reads, the input file must have $2n$ reads where indices $n+1$ to $2n$ are the reverse complements of $1$ to $n$.

### 2. BWT Indexing (External Dependency)
Before running LightStringGraph, you must generate a BWT index using the AlgoLab fork of BEETL.
```bash
beetl-bwt -i combined_reads.fa -o BWT_PREFIX --output-format=ASCII --generate-lcp --generate-end-pos-file
```

### 3. Overlap Graph Construction (`lsg`)
Identifies overlaps based on a minimum threshold ($\tau$).
```bash
lsg -B BWT_PREFIX -T <Tau> -C <CycNum>
```
- `-T <Tau>`: Minimum overlap length.
- `-C <CycNum>`: Maximum number of BWT cycles. Usually set to `read_length - Tau`.
- **Troubleshooting**: If `lsg` fails with a logic error, increase the system open file descriptor limit (`ulimit -n 2048`) and delete any `*.tmplsg.*` temporary files.

### 4. Transitive Reduction (`redbuild`)
Removes redundant edges to simplify the graph.
```bash
redbuild -b BWT_PREFIX -r combined_reads.fa -m <CycNum+1>
```

### 5. Conversion to ASQG (`graph2asqg`)
Converts the internal format to the standard Assembly String Graph (ASQG) format used by assemblers like SGA.
```bash
graph2asqg -b BWT_PREFIX -r combined_reads.fa -l <readLength> > output.asqg
```

## Best Practices
- **Memory Management**: LightStringGraph is designed for efficiency, but the BWT generation step (BEETL) is the primary bottleneck. Ensure sufficient disk space for the ASCII BWT and LCP files.
- **Parameter Tuning**: Setting $\tau$ (Tau) too low will significantly increase the number of edges and computation time. A common starting point is 50-70% of the read length.
- **File Cleanup**: The tool generates several intermediate `.tmplsg` files. Always clear these between different runs on the same prefix to avoid data corruption.



## Subcommands

| Command | Description |
|---------|-------------|
| graph2asqg | Converts a string graph to ASQG format. |
| lsg | Light String Graph tool |
| redbuild | Builds a light string graph. |

## Reference documentation
- [LightStringGraph Overview](./references/lsg_algolab_eu_index.md)