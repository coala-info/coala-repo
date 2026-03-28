---
name: graphembed
description: The graphembed tool generates low-dimensional embeddings for large-scale graphs with weighted edges while supporting symmetric and asymmetric structural analysis. Use when user asks to embed massive datasets, preserve asymmetric transitivity in directed networks, perform link prediction validation, or identify dense node groups through core decomposition.
homepage: https://github.com/jean-pierreBoth/graphembed
---

# graphembed

## Overview

The `graphembed` tool is a Rust-based library and executable designed for efficient embedding of graphs with positively weighted edges. It is particularly well-suited for massive datasets, such as the Orkut graph (3M nodes, 100M edges), which it can process in minutes. The tool supports both symmetric and asymmetric embeddings, allowing for the preservation of transitivity in directed networks. Beyond embedding, it provides structural analysis through core decomposition to identify maximally dense groups of nodes.

## Command Line Usage

The primary interface is the `embed` binary. Use the following patterns for common tasks:

### NodeSketch Embedding (Symmetric/Asymmetric)
NodeSketch uses recursive sketching based on `probminhash` to identify multi-hop neighborhoods.

- **Basic Symmetric Embedding**:
  `embed nodesketch --data <input_file> --dim 200 --hop 5 --decay 0.3`
- **Asymmetric (Directed) Embedding**:
  `embed nodesketch --data <input_file> --dim 500 --hop 2 --decay 0.25 --asymmetric`

### ATP (Asymmetric Transitivity Preserving)
ATP uses Adamic-Adar matricial representation and randomized SVD to preserve asymmetric relationships.

- **Rank-based SVD**:
  `embed atp rank --data <input_file> --rank 200 --nbiter 5`
- **Precision-based SVD**:
  `embed atp precision --data <input_file> --rank 100 --bkiter 3`

### Validation and Link Prediction
To assess embedding quality, `graphembed` can perform link prediction by randomly deleting a fraction of edges and calculating the Area Under the Curve (AUC).

- **Run with Validation**:
  `embed nodesketch --data <input_file> --dim 200 --validate --ratio 0.15`

## Expert Tips and Best Practices

- **Algorithm Selection**: 
  - Use **NodeSketch** for speed on massive graphs and when Jaccard distance is a suitable similarity measure.
  - Use **ATP** when preserving asymmetric transitivity (source vs. target roles) is critical, utilizing the dot product as the similarity measure.
- **Hyperparameter Tuning**:
  - **Decay**: In NodeSketch, the decay coefficient reduces edge weight as the search moves further from the source node. Lower decay (e.g., 0.1-0.2) focuses on local structure; higher decay (0.4-0.5) captures broader neighborhood context.
  - **Dimensions**: For ATP, increasing dimensions is beneficial as long as the corresponding eigenvalues continue to decrease significantly.
- **Data Preparation**: Ensure input files are in CSV or TSV format. If working on Linux with files generated on Windows, run `dos2unix` to prevent line-ending issues.
- **Performance**: For maximum performance, compile with specific BLAS features:
  `cargo build --release --features="openblas-system"`
- **Structural Analysis**: Use the `structure` module for density-friendly decomposition to verify if communities are preserved in the embedding space (internal edges should typically be shorter than boundary-crossing edges).



## Subcommands

| Command | Description |
|---------|-------------|
| graphembed embedding | Graph/Network Embedding |
| graphembed validation | Graph/Network Embedding with Accuracy Benchmark |

## Reference documentation

- [Graphembed README](./references/github_com_jean-pierreBoth_graphembed_blob_master_README.md)
- [Embedding Results and Benchmarks](./references/github_com_jean-pierreBoth_graphembed_blob_master_resultats.md)
- [Orkut Graph Analysis](./references/github_com_jean-pierreBoth_graphembed_blob_master_orkut.md)