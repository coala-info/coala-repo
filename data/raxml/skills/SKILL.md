---
name: raxml
description: RAxML is a high-performance tool for phylogenetic tree inference using Maximum Likelihood. Use when user asks to perform phylogenetic analysis, infer Maximum Likelihood trees, conduct rapid bootstrapping, or run partitioned evolutionary analyses on large datasets.
homepage: http://sco.h-its.org/exelixis/web/software/raxml/index.html
metadata:
  docker_image: "quay.io/biocontainers/raxml:8.2.13--h7b50bb2_3"
---

# raxml

## Overview
RAxML (Randomized Axelerated Maximum Likelihood) is a high-performance tool for phylogenetic analysis of large datasets. It is specifically optimized for Maximum Likelihood (ML) tree inference and provides specialized algorithms for rapid bootstrapping and evolutionary placement. This skill provides guidance on command-line configuration, substitution model selection, and resource estimation to ensure efficient and accurate phylogenetic reconstructions.

## Core Command-Line Patterns

### Standard ML Tree Search
To perform a simple ML search on a DNA alignment:
`raxmlHPC -m GTRGAMMA -p 12345 -s alignment.phy -n result_name`

### Rapid Bootstrap and ML Search
The `-f a` flag performs a rapid bootstrap analysis and a search for the best-scoring ML tree in a single run:
`raxmlHPC -f a -m GTRGAMMA -p 12345 -x 12345 -# 100 -s alignment.phy -n bootstrap_result`
*   `-x`: Random seed for the rapid bootstrap.
*   `-#`: Number of bootstrap replicates (or use `autoMRE` for convergence testing).

### Partitioned Analysis
For multi-gene alignments, use a partition file with the `-q` flag:
`raxmlHPC -m GTRGAMMA -p 12345 -q partitions.txt -s alignment.phy -n partitioned_run`
*   **Partition File Format**: `DNA, gene1 = 1-500` (one per line).

## Model Selection and Optimization

### DNA Models
*   **GTRGAMMA**: Standard model for most DNA analyses.
*   **GTRCAT**: Use for very large datasets (>50 taxa). It is faster and uses less memory than GAMMA while maintaining high accuracy for topology.

### Protein Models
*   Use the `ProteinModelSelection.pl` script to determine the best-scoring amino acid (AA) substitution model (e.g., LG, WAG, JTT) before running the full analysis.
*   Example: `raxmlHPC -m PROTGAMMALG -p 12345 -s protein_alignment.phy -n protein_tree`

## Memory Estimation
Before running large datasets, estimate memory consumption using these formulas (where *n* is taxa and *m* is distinct patterns):

*   **DNA + GAMMA**: `(n-2) * m * 128 bytes`
*   **DNA + CAT**: `(n-2) * m * 32 bytes`
*   **AA + GAMMA**: `(n-2) * m * 640 bytes`
*   **AA + CAT**: `(n-2) * m * 160 bytes`

## Expert Tips
*   **Binary Alignments**: For faster processing of large alignments, convert PHYLIP files to binary format using the `-f e` option.
*   **Bootstrap Convergence**: Instead of picking an arbitrary number of replicates, use `-I autoMRE` to let RAxML determine when enough replicates have been generated based on the majority-rule consensus tree.
*   **Branch Lengths**: To re-estimate branch lengths on a fixed topology using bootstrap replicates, use the `bsBranchLengths.pl` helper script.
*   **Thread Optimization**: Use the Pthreads version (`raxmlHPC-PTHREADS`) for multi-core machines. Generally, assign 1 thread per 500-1000 alignment patterns for optimal scaling.



## Subcommands

| Command | Description |
|---------|-------------|
| raxmlHPC | RAxML (Randomized Axelerated Maximum Likelihood) is a program for phylogenetic tree inference using maximum likelihood. |
| raxmlHPC-PTHREADS | RAxML version 8.2.12 |

## Reference documentation
- [RAxML Software Page](./references/cme_h-its_org_exelixis_web_software_raxml_index.html.md)