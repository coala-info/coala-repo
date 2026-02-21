---
name: twopaco
description: TwoPaCo (Two-Pass Compacted de Bruijn graph constructor) is a high-performance tool designed to build compacted de Bruijn graphs from large sets of complete genomes.
homepage: https://github.com/medvedevgroup/TwoPaCo
---

# twopaco

## Overview
TwoPaCo (Two-Pass Compacted de Bruijn graph constructor) is a high-performance tool designed to build compacted de Bruijn graphs from large sets of complete genomes. It utilizes a memory-efficient two-pass algorithm involving Bloom filters to identify junction k-mers. The workflow typically involves two steps: generating a binary graph representation with `twopaco` and then converting that binary into a human-readable or standard bioinformatics format (GFA1, GFA2, or DOT) using `graphdump`.

## Command Line Usage

### Graph Construction (twopaco)
The primary command generates a binary file (default: `de_bruijn.bin`).

```bash
twopaco -f <filter_size> -k <k_value> <input_files.fasta>
```

**Core Parameters:**
- `-k, --kvalue`: The k-mer size (vertex size). Must be an **odd** integer.
- `-f`: The Bloom filter size, expressed as $2^f$ bits. This is the most critical parameter for performance.
- `--filtermemory`: An alternative to `-f`, specifying memory in GB (e.g., `--filtermemory 16`).
- `-t, --threads`: Number of threads to use (default is 1).
- `-r, --rounds`: Number of passes. Use `1` for maximum speed. Increase if memory is insufficient.
- `-o, --outfile`: Specify a custom name for the binary output.

### Format Conversion (graphdump)
To use the graph in other tools, convert the binary output to GFA or DOT.

```bash
# Convert to GFA1 (standard for pangenomics)
graphdump de_bruijn.bin -f gfa1 -k <k_value> -s <input_genomes.fasta> > output.gfa

# Convert to DOT (for Graphviz visualization)
graphdump de_bruijn.bin -f dot -k <k_value> > output.dot
```

## Expert Tips and Best Practices

### Memory Management
The Bloom filter size (`-f`) directly dictates memory usage and speed. If `-f` is too low, the program will slow down significantly due to false positives.
- **Rule of Thumb**: Set `-f` so that $2^f / 8$ bytes equals the maximum RAM you want to allocate.
- **Recommended `-f` values**:
  - 16 GB RAM: `-f 36`
  - 32 GB RAM: `-f 37`
  - 64 GB RAM: `-f 38`
- If the program still exceeds memory limits, increase the number of rounds (`-r`).

### K-mer Selection
- TwoPaCo uses `k` as the vertex size and `k+1` as the edge size.
- Ensure `k` is odd to avoid complications with reverse complements.
- The default `k` is 25. For complex eukaryotic genomes, higher values are often required to resolve repeats.

### Temporary Files
TwoPaCo generates temporary files during the construction process. By default, these are placed in the current working directory. For large runs, ensure the location has high-speed I/O (like an SSD) and sufficient space:
```bash
twopaco -k 31 -f 36 --tmpdir /path/to/fast/scratch/ input.fasta
```

### Visualization
For small graphs or specific genomic regions, use the DOT format and convert it to an image using Graphviz:
```bash
dot -Tpng output.dot -o graph_visualization.png
```
Note: The graph is a union of both strands. Blue edges represent the main strand, while red edges represent the reverse strand.

## Reference documentation
- [TwoPaCo GitHub Repository](./references/github_com_medvedevgroup_TwoPaCo.md)
- [Bioconda TwoPaCo Overview](./references/anaconda_org_channels_bioconda_packages_twopaco_overview.md)