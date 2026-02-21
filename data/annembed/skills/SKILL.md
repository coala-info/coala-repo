---
name: annembed
description: `annembed` is a scalable, non-linear dimension reduction algorithm specifically optimized for large-scale biological data.
homepage: https://github.com/jean-pierreBoth/gsearch
---

# annembed

## Overview
`annembed` is a scalable, non-linear dimension reduction algorithm specifically optimized for large-scale biological data. It functions as an ultra-fast alternative to UMAP and t-SNE. In practice, it is frequently used as a core component of the `gsearch` genomic search suite to transform high-dimensional k-mer sketches into interpretable embeddings. Use this skill to handle the installation and execution of embedding workflows for microbial genomes and other massive biological datasets.

## Installation
The tool can be installed via Bioconda or compiled from source using Cargo for maximum performance.

**Conda (Stable):**
```bash
conda install bioconda::annembed
```

**Cargo (Developmental/High Performance):**
To enable hardware acceleration (Intel MKL), use the following feature flags:
```bash
cargo install gsearch --features annembed_intel-mkl,simdeez_f --force
```

## Common CLI Patterns
`annembed` is typically invoked as a subcommand within the `gsearch` utility.

### Basic Embedding Command
To generate an approximate nearest neighbor embedding:
```bash
gsearch ann [OPTIONS]
```

### Workflow Integration
The embedding process usually follows the construction of a Hierarchical Navigable Small World (HNSW) graph. A typical workflow involves:

1.  **Building the Database:**
    Use `tohnsw` to sketch genomes and build the graph structure that `ann` will utilize.
    ```bash
    gsearch --pio 2000 --nbthreads 24 tohnsw -d ./genome_folder -k 21 -s 18000 -n 128 --algo optdens
    ```

2.  **Generating the Embedding:**
    Run the `ann` command on the resulting database to produce the UMAP-like visualization coordinates.

## Tool-Specific Best Practices
- **Parallelization:** Use the `--nbthreads` global option to specify the number of threads for sketching and graph traversal.
- **I/O Optimization:** For large datasets (e.g., >50,000 genomes), use the `--pio` flag to control parallel I/O processing.
- **Algorithm Selection:** When building the underlying graph for the embedding, `optdens` (Optimal Densification) is generally recommended for better accuracy with high-dimensional genomic data.
- **Memory Management:** If using the Cargo-installed version, ensure the `annembed_intel-mkl` feature is enabled to leverage optimized math libraries for large-scale matrix operations.

## Reference documentation
- [annembed - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_annembed_overview.md)
- [GSearch: Ultra-fast and Scalable Genome Search](./references/github_com_jean-pierreBoth_gsearch.md)