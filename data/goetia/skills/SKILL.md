---
name: goetia
description: Goetia is a specialized bioinformatics toolset designed for the on-line analysis of genomic sequences.
homepage: https://github.com/camillescott/goetia
---

# goetia

## Overview
Goetia is a specialized bioinformatics toolset designed for the on-line analysis of genomic sequences. It focuses on streaming de Bruijn graph (dBG) algorithms, allowing for graph compaction and sketching while using minimal memory and processing data in a single pass. By utilizing streaming methods, it enables researchers to analyze large datasets without the need to store massive intermediate graph structures, making it particularly useful for real-time data processing and resource-constrained environments.

## Installation and Setup
The preferred method for installing goetia is via the Bioconda channel.

```bash
conda install -c bioconda goetia
```

For development or building from source, use the provided Makefile:
```bash
git clone https://github.com/camillescott/goetia
cd goetia
make create-dev-env
conda activate goetia-dev
make install
```

## Common CLI Patterns
Goetia provides several subcommands for different graph operations. While the library is often used via Python bindings, the CLI supports core streaming tasks.

### Sketching and Distance Calculation
Goetia integrates with sketching techniques (similar to sourmash) to provide streaming distance calculations.
- Use `--scaled` to define the compression ratio for sketching.
- Use `--stat_type` to specify the metric for distance calculations.

### Compact de Bruijn Graph (cdbg) Construction
The `cdbg` subcommand is used for building compacted graphs from streaming data.
- **Real-time tracking**: Use the built-in processors to monitor graph growth and unitig fragmentation.
- **Metrics saving**: Use the `--save-metrics` option to output performance and graph statistics to a JSON file.

### Benchmarking and Utilities
The `hash-stream` subcommand is available for baseline hashing and benchmarking dBG construction performance.
```bash
goetia hash-stream <input_fastx>
```

## Expert Tips
- **Python Integration**: Goetia uses `cppyy` for automatic Python bindings. If the CLI does not expose a specific C++ feature, you can import the library directly in Python: `import goetia`.
- **Memory Management**: Because goetia is designed for streaming, it is highly efficient. However, when working with very high-cardinality datasets, monitor the saturation levels reported in the status messages to ensure the probabilistic structures (if used) remain accurate.
- **Reproducibility**: When running tests or randomized algorithms, goetia uses `pytest-randomly`. Note the seed reported in the output (e.g., `Using --randomly-seed=12345`) to reproduce specific runs.
- **Unitig Extraction**: The library provides an `extract_unitigs` function that returns walks through the graph, which is more efficient than traditional batch extraction for streaming data.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_camillescott_goetia.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_goetia_overview.md)