---
name: unifeb
description: `unifeb` embeds ecological datasets into low-dimensional space using UniFrac distances and Approximate Nearest Neighbor graphs. Use when user asks to embed ecological datasets, visualize ecological data, perform UniFrac analysis, or perform hierarchical embedding.
homepage: https://github.com/jianshu93/unifeb.git
metadata:
  docker_image: "quay.io/biocontainers/unifeb:0.1.1--h3ab6199_0"
---

# unifeb

## Overview
The `unifeb` tool implements a highly scalable embedding algorithm that combines UniFrac distances with Approximate Nearest Neighbor (ANN) graphs. By leveraging Earth Mover's Distance-based UniFrac and the `annembed` algorithm, it allows for the visualization of massive ecological datasets in low-dimensional space (typically 2D or 3D). It is particularly effective for high-throughput sequencing projects where evolutionary history must be accounted for in the community comparison.

## Installation and Setup
The tool is primarily available for Linux-64 systems.

- **Conda (Recommended):** `conda install -c bioconda -c conda-forge unifeb`
- **Binary:** Download the release from GitHub, unzip, and `chmod a+x ./unifeb`.

## Core CLI Usage
The basic workflow requires a Newick tree and a feature table (samples as columns, features as rows).

### Basic Embedding
```bash
unifeb -t tree.tre -f feature_table.txt -o embedded.csv hnsw
```

### Weighted vs. Unweighted UniFrac
By default, `unifeb` performs unweighted UniFrac. To account for abundance:
```bash
unifeb --weighted -t tree.tre -f feature_table.txt -o embedded.csv hnsw
```

### Advanced Graph Parameters
The `hnsw` subcommand controls the Approximate Nearest Neighbor graph construction:
- `--nbconn`: Number of connections per node (e.g., 48).
- `--ef`: Size of the dynamic candidate list for construction (e.g., 400).
- `--knbn`: Number of neighbors for the embedding (e.g., 15).

Example with optimized parameters for quality:
```bash
unifeb -t ASVs.tre -f counts.txt -o output.csv \
  hnsw --nbconn 48 --ef 400 --knbn 15 --scale_modify_f 0.25
```

## Expert Tips and Best Practices
- **Data Consistency**: Ensure every taxa/ID in your feature table exists as a leaf or tip in the Newick tree. Discrepancies will cause execution errors.
- **Scaling for Large Data**: For datasets with millions of samples, use the `--batch` and `--nbsample` options to manage gradient descent memory and speed.
- **Hierarchical Embedding**: If the dataset has deep structure, set `-l` (layer) > 0 to enable a hierarchical approach, which can improve the global structure of the embedding.
- **Dimensionality**: While the default is 2 (`-d 2`), you can specify higher dimensions for downstream clustering or 3D visualization.
- **Performance**: `unifeb` is written in Rust and is significantly faster than Python-based UniFrac implementations. If running on a cluster, ensure you provide sufficient threads as the HNSW graph construction is parallelized.

## Reference documentation
- [UniFrac Embedding via Approximate Nearest Neighbor Graph](./references/github_com_jianshu93_unifeb.md)