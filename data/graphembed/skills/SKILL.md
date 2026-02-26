---
name: graphembed
description: Graphembed transforms complex graph structures into low-dimensional vector representations for downstream machine learning tasks. Use when user asks to embed large-scale networks, perform link prediction, or identify dense node groups through graph decomposition.
homepage: https://github.com/jean-pierreBoth/graphembed
---


# graphembed

## Overview
graphembed is a specialized toolset designed for efficient and robust network embedding. It transforms complex graph structures into low-dimensional vector representations, making them suitable for downstream machine learning tasks. The tool is particularly effective for large-scale data, such as social networks or citation graphs, offering algorithms that balance computational speed with structural accuracy. It supports directed and undirected graphs with weighted edges and includes built-in utilities for validating embedding quality through link prediction.

## Core Embedding Methods

### NodeSketch (Recursive Sketching)
Use this method for maximum efficiency on massive graphs (e.g., millions of nodes).
- **Mechanism**: Uses multi-hop neighborhood identification via sensitive hashing (ProbMinHash).
- **Distance Metric**: The resulting discrete embedding vectors use Jaccard distance.
- **Best For**: Symmetric embeddings where speed is critical. It can also be extended for asymmetric directed graphs.

### ATP (Asymmetric Transitivity Preserving)
Use this method when the directionality and transitivity of edges are critical.
- **Mechanism**: Based on the Adamic-Adar matricial representation and randomized Singular Value Decomposition (SVD).
- **Output**: Produces left singular vectors (representing source nodes) and right singular vectors (representing target nodes).
- **Similarity**: Uses dot product similarity rather than a standard norm.

## CLI Usage and Best Practices

### General Workflow
1. **Data Preparation**: Ensure input graphs are in CSV or TSV format. 
   - **Tip**: If using datasets from Windows environments, use `dos2unix` to fix End-of-Line (EOL) characters before processing.
2. **Execution**: Use the `embed` binary provided by the package.
3. **Validation**: Use the built-in validation module to assess quality via Area Under the Curve (AUC) metrics with random edge deletion.

### Performance Optimization
- **Linear Algebra**: When compiling from source, use the `openblas-system` feature for significantly faster matricial operations:
  ```bash
  cargo build --release --features="openblas-system"
  ```
- **Dimension Selection**: For SVD-based embeddings (ATP), monitor the decay of eigenvalues. Stop increasing dimensions once the eigenvalues no longer decrease significantly.

### Graph Decomposition
Beyond embedding, use the `structure` module for "density-friendly" decomposition. This is useful for:
- Identifying maximally dense groups of nodes.
- Assessing if internal community edges are consistently shorter in the embedding space than edges crossing community boundaries.

## Expert Tips
- **Directed vs. Undirected**: Treating a directed graph as undirected during embedding can significantly degrade link prediction AUC. Always use the asymmetric options for directed social or citation networks.
- **Memory Management**: For extremely large graphs like Orkut (100M+ edges), NodeSketch is preferred over SVD-based methods due to its lower memory footprint and faster execution (approx. 5 minutes on modern hardware).
- **Label Support**: If your graph has discrete labels on nodes or edges, utilize the `gkernel` module, which extends the hashing strategy to handle labeled data.

## Reference documentation
- [graphembed Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_graphembed_overview.md)
- [graphembed GitHub Documentation](./references/github_com_jean-pierreBoth_graphembed.md)