---
name: adas
description: ADAS is a specialized toolkit for managing and searching large-scale biological sequence databases using locality-sensitive hashing and graph-based indexing. Use when user asks to build a sequence database index, search for similar sequences, update an existing index, perform sequence alignment via chaining, or extract nearest neighbors.
homepage: https://github.com/jianshu93/adas
---

# adas

## Overview
ADAS (Advanced Database Search) is a specialized toolkit for managing and searching large-scale biological sequence databases. It leverages locality-sensitive hashing (MinHash) and graph-based indexing (HNSW) to provide rapid similarity searches for long sequences where traditional alignment methods are computationally prohibitive. It is particularly effective for estimating edit distances and performing seed-chain-extend alignments.

## Core Workflow

### 1. Build a Sequence Database
Initialize a searchable HNSW index from a FASTA file.
```bash
adas-build -i sequences.fa -k 8 -s 512 -t 8 --max_nb_connection 128 --hnsw-ef 800
```
*   **-k, --kmer-size**: Must be ≤ 14 (default: 8).
*   **-s, --sketch-size**: Higher values increase accuracy but grow index size (default: 512).
*   **--hnsw-ef**: Controls search accuracy during construction (default: 1600).
*   **--max_nb_connection**: Maximum degree of nodes in the graph (default: 256).

### 2. Search Query Sequences
Query new sequences against a pre-built index directory.
```bash
adas-search -i query.fa -b ./index_dir -n 128 -t 8
```
*   **-b, --hnsw**: Path to the directory containing the `.hnsw` and metadata files.
*   **-n, --nbng**: Number of nearest neighbors to return (default: 128).

### 3. Update an Existing Index
Add new sequences to an existing database without rebuilding from scratch.
```bash
adas-insert -i new_sequences.fa -b ./index_dir -t 4
```

### 4. Sequence Alignment via Chaining
Perform approximate alignment using anchor chaining between a reference and query.
```bash
adas-chain -r reference.fa -q query.fa -o alignment_results.paf -t 8
```

### 5. Extract Graph Neighbors
Retrieve the K-nearest neighbors for every sequence already present in the database.
```bash
adas-knn -b ./index_dir -o neighbors.txt -n 32
```

## Expert Tips and Best Practices

*   **Memory Management**: For massive datasets, adjust `--hnsw-capacity`. The default is 50 million sequences.
*   **Accuracy vs. Speed**: If search results are poor, increase `--hnsw-ef` during the build phase or decrease `--scale_modify_f` (valid range [0.2, 1.0]). A lower scale factor (e.g., 0.25) can improve sensitivity for highly divergent sequences.
*   **K-mer Selection**: Use smaller k-mers (e.g., 6-8) for highly divergent sequences and larger k-mers (up to 14) for closely related sequences to reduce noise.
*   **Index Portability**: An ADAS index consists of multiple files in the output directory. Always point `-b` or `--hnsw` to the directory, not a specific file.
*   **Thread Scaling**: Sketching is CPU-intensive. Scale `-t` based on available physical cores for linear speedup during the build and search phases.



## Subcommands

| Command | Description |
|---------|-------------|
| adas-build | Build Hierarchical Navigable Small World Graphs (HNSW) with MinHash sketching |
| adas-chain | Long Reads Alignment via Anchor Chaining |
| adas-insert | Insert into Pre-built Hierarchical Navigable Small World Graphs (HNSW) Index |
| adas-knn | Extract K Nearest Neighbors (K-NN) from HNSW graph. |
| adas-search | Search against Pre-built Hierarchical Navigable Small World Graphs (HNSW) Index |

## Reference documentation
- [ADAS README](./references/github_com_jianshu93_adas_blob_main_README.md)
- [Project Metadata](./references/github_com_jianshu93_adas_blob_main_Cargo.toml.md)