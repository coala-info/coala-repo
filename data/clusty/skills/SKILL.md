---
name: clusty
description: Clusty is a high-performance clustering engine designed to handle massive datasets by utilizing sparse distance matrices.
homepage: https://github.com/refresh-bio/clusty
---

# clusty

## Overview
Clusty is a high-performance clustering engine designed to handle massive datasets by utilizing sparse distance matrices. It transforms pairwise relationship data into discrete groups or cluster representatives. You should use this skill when you have a large TSV/CSV table of pairwise distances or similarities and need to apply standard clustering heuristics (like CD-HIT or UCLUST) or graph-based community detection (Leiden) at scale.

## Installation
Clusty is available via Bioconda or as precompiled binaries.
```bash
conda install bioconda::clusty
```

## Core CLI Usage
The basic syntax requires an input distance file and a path for the output assignments:
```bash
clusty [options] <distances> <assignments>
```

### Common Algorithm Patterns

*   **Single Linkage (Connected Components):**
    Use this to find all objects connected by any path of similarity.
    ```bash
    clusty --algo single --similarity input.ani output.clusters
    ```

*   **UCLUST-style Clustering:**
    Accepts pairwise connections above a specific threshold and outputs cluster representatives.
    ```bash
    clusty --algo uclust --similarity --min ani 0.70 --out-representatives input.ani output.uclust
    ```

*   **CD-HIT (Greedy Incremental):**
    Useful for collapsing redundant sequences at high identity.
    ```bash
    clusty --algo cd-hit --similarity --min ani 0.95 --id-cols id1 id2 --distance-col ani input.ani output.cdhit
    ```

*   **Leiden Algorithm:**
    For community detection in graphs. Note that as of v1.3.0, the graph construction is finer.
    ```bash
    clusty --algo leiden --leiden-resolution 0.7 --leiden-iterations 2 input.tsv output.leiden
    ```

## Parameters and Options

| Option | Description |
| :--- | :--- |
| `--algo` | Choose from `single`, `complete`, `uclust`, `set-cover`, `cd-hit`, or `leiden`. |
| `--id-cols <c1> <c2>` | Specify names of columns containing object IDs (default: first two columns). |
| `--distance-col <name>` | Specify the column name for distances/similarities (default: third column). |
| `--similarity` | Treat input values as similarities in [0,1] range (default is distance). |
| `--percent-similarity` | Treat input values as percentages in [0,100] range. |
| `--min <col> <val>` | Filter: only accept connections where the specified column is ≥ threshold. |
| `--max <col> <val>` | Filter: only accept connections where the specified column is ≤ threshold. |
| `--objects-file <file>` | Include objects that have no pairwise connections in the input distance file. |
| `-t <int>` | Number of threads (default: 4). |

## Expert Tips and Best Practices

*   **Leiden Versioning:** If you are trying to reproduce results from Clusty versions prior to v1.3.0 using the Leiden algorithm, you must divide your `--leiden-resolution` value by 2. The newer version uses single edges instead of bidirectional connections, making the default clustering coarser at the same resolution.
*   **Memory Management:** For extremely large datasets, ensure you are using v1.1.0 or later, which includes significant memory optimizations for object identifiers and distance structures.
*   **Input Sorting:** When using `--objects-file`, provide a TSV/CSV where the first column contains object names sorted decreasingly by representativeness for better clustering logic in greedy algorithms.
*   **Numeric IDs:** If your input file uses integers as identifiers instead of strings, use the `--numeric-ids` flag to improve processing speed and reduce memory overhead.
*   **Output Format:** By default, Clusty outputs a TSV. Use `--out-csv` if your downstream pipeline requires comma-separated values.

## Reference documentation
- [Clusty GitHub Repository](./references/github_com_refresh-bio_clusty.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_clusty_overview.md)