---
name: ggcat
description: "GGCAT constructs and queries compacted and colored de Bruijn graphs from genomic sequencing data. Use when user asks to build a compacted de Bruijn graph, create colored graphs for multi-sample analysis, or query sequences for k-mer presence."
homepage: https://github.com/algbio/ggcat
---


# ggcat

## Overview

GGCAT (compacted and colored de Bruijn graph construction and querying) is a high-performance bioinformatics tool designed to process raw sequencing reads or existing graphs into a unified, compacted representation. It excels at handling "colors" (metadata labels for different input sources), allowing users to track which k-mers belong to which samples. This skill provides the procedural knowledge to execute graph construction, perform k-mer queries, and optimize memory and thread usage for large genomic datasets.

## Core Workflows

### 1. Building a Compacted de Bruijn Graph (cDBG)

To build a standard graph from FASTA/FASTQ files:
```bash
ggcat build -k <k_value> -j <threads> <input_files> -o <output_file.fasta.lz4>
```

**Best Practices:**
- **K-mer Length (`-k`)**: Choose based on your organism's complexity (e.g., 31 is common for bacterial genomes).
- **Multiplicity (`-s`)**: Use `-s 1` to keep all k-mers, or the default `-s 2` to filter out potential sequencing errors (singletons).
- **Input Lists**: For many files, use `-l <file_list.txt>` where each line is a path to an input file.

### 2. Colored Graph Construction

Use colors to distinguish between different datasets (e.g., different species or samples) within the same graph.

**Automatic Coloring:**
Adding `-c` uses filenames as color names.

**Custom Coloring:**
Create a tab-separated mapping file (`map.txt`):
```text
SampleA	reads_1.fq
SampleA	reads_2.fq
SampleB	genome_v2.fa
```
Build using the mapping:
```bash
ggcat build -k <k_value> -c -d map.txt -o <output.fasta.lz4>
```

### 3. Querying Sequences

Search for k-mer presence in a built graph. The `k` value must match the construction value.

**Uncolored Query:**
```bash
ggcat query -k <k_value> <input-graph.fasta.lz4> <query.fasta>
```

**Colored Query:**
```bash
ggcat query --colors -k <k_value> <input-graph.fasta.lz4> <query.fasta>
```
*Note: GGCAT expects a `.colors.dat` file with the same base name as the graph in the same directory.*

### 4. Advanced Output Modes

GGCAT supports specialized unitig representations to reduce storage or facilitate downstream analysis:
- **Links (`-e`)**: Generates BCALM2-style connections between unitigs.
- **Matchtigs (`-g`)**: Computes a minimum plain-text representation of k-mer sets (greedy matchtigs).
- **Eulertigs (`--eulertigs`)**: Computes a representation without k-mer repetitions.
- **GFA Output**: Use `--gfa-v1` or `--gfa-v2` for graphical formats instead of FASTA.

## Performance Optimization

- **Memory Management**: Use `-m <GB>` to suggest a memory limit. For high-memory systems, use `-p` (prefer-memory) to keep data in RAM as long as possible before spilling to disk.
- **Temporary Files**: Use `-t <dir>` to point to a fast NVMe drive for temporary storage, as GGCAT performs significant I/O during the bucketing phase.
- **Threading**: Scale `-j` to the number of available physical cores.



## Subcommands

| Command | Description |
|---------|-------------|
| build | Builds a k-mer graph from input files. |
| dump-colors | Dumps the colors from a colormap file. |
| matches | ggcat-matches 2.0.0 |
| query | Query a graph with k-mers |

## Reference Documentation
- [GGCAT GitHub README](./references/github_com_algbio_ggcat_blob_main_README.md)
- [GGCAT Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ggcat_overview.md)