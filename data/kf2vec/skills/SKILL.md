---
name: kf2vec
description: kf2vec transforms raw genomic sequences into numerical vectors based on k-mer frequencies for phylogenetic representation learning. Use when user asks to extract k-mer frequencies, partition phylogenetic trees, compute distance matrices, or train classifiers to place query sequences within a phylogeny.
homepage: https://github.com/noraracht/kf2vec
metadata:
  docker_image: "quay.io/biocontainers/kf2vec:1.0.62--pyh5e193fb_0"
---

# kf2vec

## Overview

The `kf2vec` tool transforms raw genomic sequences into numerical vectors based on k-mer frequencies. It provides a complete workflow for genomic representation learning, including k-mer counting (via Jellyfish), phylogenetic tree manipulation (via TreeSwift and TreeCluster), and the training of neural network classifiers to place unknown query sequences within a known backbone phylogeny. Use this skill to handle high-dimensional sequence data for comparative genomics and evolutionary biology tasks.

## Installation and Setup

Install via Bioconda for the most stable environment:

```bash
conda create -n kf2vec_env python=3.11
conda activate kf2vec_env
conda install -c bioconda kf2vec
```

## Core CLI Workflows

### 1. K-mer Frequency Extraction
Convert raw sequence files (.fasta, .fastq, .fa, .fna) into normalized frequency vectors (.kf files).

```bash
kf2vec get_frequencies -input_dir $INPUT_DIR -output_dir $OUTPUT_DIR -k 7 -p $NUM_PROCESSORS
```
- **Best Practice**: Use the `-p` flag to enable multi-processing for large datasets.
- **Tip**: Use `-pseudocount` to add 0.5 to counts before normalization to handle zero-frequency k-mers.
- **Tip**: Use `-raw_cnt` if you require absolute counts instead of normalized frequencies.

### 2. Phylogenetic Tree Partitioning
For large trees (>4000 leaves), split the phylogeny into manageable subtrees.

```bash
kf2vec divide_tree -size 850 -tree $INPUT_PHYLOGENY
```
- **Recommendation**: While the default size is 850, adjust this based on the total leaf count to ensure subtrees are large enough for meaningful training but small enough for computational efficiency.

### 3. Distance Matrix Computation
Generate ground truth distances for the backbone phylogeny.

```bash
kf2vec get_distances -tree $INPUT_PHYLOGENY -subtrees $FILE.subtrees
```

### 4. Model Training and Classification
Train a classifier to assign query sequences to the partitioned subtrees.

**Training:**
```bash
kf2vec train_classifier -input_dir $KF_DIR -subtrees $FILE.subtrees -e 2000 -o $MODEL_OUTPUT
```
- **Parameters**: Default hidden layer size is 2048; batch size is 16. Increase epochs (`-e`) if the model fails to converge.

**Classification:**
```bash
kf2vec classify -input_dir $QUERY_KF_DIR -model $MODEL_DIR -o $RESULTS_DIR
```
- **Output**: Produces `classes.out`, a tab-delimited file containing the assigned subtree and probability scores for all classes.

## Expert Tips

- **Scaling**: Use `kf2vec scale_tree -tree $TREE -factor $VAL` to adjust branch lengths if the distance metrics require normalization across different datasets.
- **Memory Management**: When training on very large k-mer sets (e.g., k > 8), monitor RAM usage as the frequency vectors grow exponentially ($4^k$).
- **Workflow Order**: Always run `get_frequencies` first for both backbone and query sets before attempting training or classification.

## Reference documentation

- [kf2vec GitHub Repository](./references/github_com_noraracht_kf2vec.md)
- [Bioconda kf2vec Package Overview](./references/anaconda_org_channels_bioconda_packages_kf2vec_overview.md)