---
name: veryfasttree
description: VeryFastTree infers phylogenetic trees from sequence alignments using a highly optimized FastTree-2 algorithm. Use when user asks to infer phylogenetic trees, optimize performance, handle large datasets, ensure deterministic results, or use specific evolutionary models.
homepage: https://github.com/citiususc/veryfasttree
metadata:
  docker_image: "quay.io/biocontainers/veryfasttree:4.0.5--h9948957_0"
---

# veryfasttree

## Overview

VeryFastTree is a highly-tuned implementation of the FastTree-2 algorithm designed for modern multi-core processors. It maintains the same phases, heuristics, and topological accuracy as FastTree-2 but utilizes OpenMP parallelization and SIMD vectorization (SSE, AVX2, AVX512) to achieve significant speedups. Unlike the original parallel version of FastTree-2, VeryFastTree is deterministic by default. It serves as a drop-in replacement, accepting the same command-line arguments while adding specific optimizations for thread management and memory efficiency.

## Common CLI Patterns

### Basic Usage
VeryFastTree follows the same syntax as FastTree-2. By default, it expects protein alignments.
```bash
# Infer a tree for a protein alignment
VeryFastTree alignment.fasta > tree.nwk

# Infer a tree for a nucleotide alignment
VeryFastTree -nt alignment.fasta > tree.nwk
```

### Performance Optimization
The primary advantage of VeryFastTree is its parallel execution capabilities.
```bash
# Specify the number of threads (default is all available cores)
VeryFastTree -threads 16 -nt alignment.fasta > tree.nwk

# Use the -slow option for a more exhaustive search (equivalent to FastTree -slow)
VeryFastTree -threads 32 -slow -nt alignment.fasta > tree.nwk
```

### Handling Ultra-Large Datasets
For massive alignments where RAM is a bottleneck, use disk-based computing to reduce peak memory usage.
```bash
# Enable disk computing to save memory
VeryFastTree -threads 64 -disk-computing -nt massive_alignment.fasta > tree.nwk
```

### Input Formats and Compression
VeryFastTree natively supports several formats and can read compressed files directly.
```bash
# Read a Gzip-compressed Phylip file
VeryFastTree -nt alignment.phy.gz > tree.nwk

# Read from a NEXUS file
VeryFastTree -nt alignment.nex > tree.nwk
```

## Expert Tips

- **Drop-in Compatibility**: You can typically replace `FastTree` or `FastTreeMP` in any existing pipeline with `VeryFastTree` without changing other arguments.
- **Determinism**: VeryFastTree is deterministic by default, meaning the same input and thread count will produce the same tree. If you prioritize absolute maximum speed over reproducibility, you can experiment with `-non-deterministic`.
- **Memory Management**: If you encounter "memory overflow" or "out of memory" errors on datasets with >100,000 sequences, always enable the `-disk-computing` flag.
- **Hardware Acceleration**: The tool automatically detects hardware features like AVX2 or AVX512. If compiling from source, ensure `USE_NATIVE=ON` is set in CMake to optimize for your specific CPU architecture.
- **Model Selection**: Use `-lg` or `-wags` for protein alignments to use the LG or WAG models respectively, just as in FastTree-2.

## Reference documentation
- [VeryFastTree GitHub Repository](./references/github_com_citiususc_veryfasttree.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_veryfasttree_overview.md)