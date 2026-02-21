---
name: niemagraphgen
description: NiemaGraphGen (NGG) is a suite of C++ executables designed to generate various types of random and deterministic graphs.
homepage: https://github.com/niemasd/NiemaGraphGen
---

# niemagraphgen

## Overview
NiemaGraphGen (NGG) is a suite of C++ executables designed to generate various types of random and deterministic graphs. It is optimized for "global-scale" simulations where the number of nodes can reach billions. Because it avoids storing the graph in memory, it is best used in data streaming pipelines where the output is piped into a file, a compression utility, or a downstream analysis script.

## Installation and Setup
The tool is available via Bioconda or Docker, which are the recommended methods for quick deployment.

- **Conda**: `conda install -c bioconda niemagraphgen`
- **Docker**: `docker pull niemasd/niemagraphgen`
- **Source**: Clone the repository and run `make`. Note that the integer size (32-bit vs 64-bit) and output format (FAVITES vs Compact) are determined at compile-time via flags in the `Makefile`.

## Command Line Usage
Each graph model is implemented as a separate executable prefixed with `ngg_`.

### Available Generators
- `ngg_barabasi_albert`: Scale-free networks using preferential attachment.
- `ngg_erdos_renyi`: Random graphs with a fixed edge probability.
- `ngg_newman_watts_strogatz`: Small-world networks.
- `ngg_complete`: Fully connected graphs.
- `ngg_barbell`: Two complete graphs connected by a path.
- `ngg_cycle` / `ngg_path` / `ngg_ring_lattice`: Basic structural topologies.

### Common CLI Patterns
To view specific arguments for any generator, use the `-h` flag:
```bash
ngg_barabasi_albert -h
```

**Basic Generation (FAVITES format)**:
```bash
ngg_complete 100 > complete_n100.tsv
```

**Streaming to Compression**:
For large simulations, always pipe to a compressor to save disk space:
```bash
ngg_barabasi_albert -n 1000000 -m 2 | gzip > scale_free.tsv.gz
```

## Best Practices and Expert Tips
- **Memory Efficiency**: NGG is designed to have a near-zero memory footprint regardless of graph size. If you encounter memory issues, ensure you are not trying to load the resulting file into a non-streaming tool.
- **Output Formats**:
    - **FAVITES (Default)**: A tab-separated text format. Easy to read but large.
    - **Compact (Binary)**: Significantly smaller. Requires a specific parsing logic (see the Wiki reference for Python/NetworkX loading scripts).
- **Node Limits**: By default, NGG uses 32-bit unsigned integers, supporting up to ~4.29 billion nodes. If you need to simulate a population larger than the Earth's, you must recompile with the `-DNGG_UINT_64` flag.
- **Pipeline Integration**: Since NGG writes to `stdout`, it is ideal for use with `xargs` or parallel processing scripts to generate multiple replicates of a network simultaneously.

## Reference documentation
- [NiemaGraphGen Main Repository](./references/github_com_niemasd_NiemaGraphGen.md)
- [NiemaGraphGen Wiki and Cookbook](./references/github_com_niemasd_NiemaGraphGen_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_niemagraphgen_overview.md)