---
name: epik
description: EPIK performs rapid, alignment-free phylogenetic placement of query sequences onto a reference tree using informative k-mers. Use when user asks to place sequences into a phylogeny, build a phylo-k-mer database, or perform alignment-free evolutionary placement.
homepage: https://github.com/phylo42/epik
metadata:
  docker_image: "quay.io/biocontainers/epik:0.2.0--h077b44d_2"
---

# epik

## Overview

EPIK (Evolutionary Placement with Informative K-mers) is a specialized tool for rapid phylogenetic placement that bypasses the need for query-to-reference alignment. It works by matching k-mers from query sequences against a pre-computed database of "phylo-k-mers" associated with specific branches of a reference tree. The workflow involves two distinct phases: building a database from a reference alignment and tree using the companion tool IPK, and then performing the placement using EPIK.

## Core Workflow

### 1. Database Preparation (IPK)
Before placement, you must generate a phylo-k-mer database (`.ipk`) using the `ipk.py` utility.

```bash
ipk.py build --refalign reference.fasta --reftree tree.rooted.newick --states [nucl|amino] --workdir ./output_dir --model [GTR|LG|etc]
```

*   **--states**: Use `nucl` for DNA or `amino` for proteins.
*   **--model**: Specify the phylogenetic model (e.g., GTR for DNA, LG or WAG for proteins).

### 2. Sequence Placement (EPIK)
Once the `.ipk` database is ready, use `epik.py` to place your query sequences.

```bash
epik.py place -i DB.ipk -s [nucl|amino] -o ./results_dir queries.fasta
```

## CLI Best Practices and Parameters

### Memory Management
EPIK allows for strict control over RAM usage, which is critical when working with large k-mer databases.
*   **--max-ram**: Set a hard limit on memory consumption (e.g., `--max-ram 4G` or `--max-ram 512M`). This is mutually exclusive with `--mu`.
*   **--mu**: A filtering parameter (0.0 to 1.0] that determines the proportion of the database to keep in memory. Use this if you want to prioritize specific informative k-mers over others to save space.

### Performance Optimization
*   **--threads**: Specify the number of parallel threads. Ensure EPIK was compiled with OpenMP support (standard in Bioconda/Pixi versions) to utilize multiple cores.
*   **--omega**: This threshold controls the sensitivity of the k-mer matching. While the default is usually sufficient, increasing it can sometimes improve placement for highly divergent sequences at the cost of speed.

### Output Handling
EPIK produces `.jplace` files, which is the standard format for phylogenetic placements.
*   The output directory specified by `-o` must exist or the tool will attempt to create it.
*   To visualize or manipulate the results, use the `gappa` toolset (e.g., `gappa examine` or `gappa visualize`), which is the recommended post-analysis companion for EPIK.

## Expert Tips
*   **Alignment-Free Advantage**: Because EPIK is alignment-free, it is particularly robust against query sequences that are difficult to align, such as those containing sequencing errors or those from highly variable regions.
*   **Database Reusability**: The `.ipk` database is tied to the reference tree and alignment. You only need to build it once for a specific study system; it can then be used to place millions of different query sequences across multiple runs.
*   **Environment Isolation**: Due to strict C++ dependencies (specifically `libboost`), always run EPIK in a dedicated Conda or Pixi environment to avoid library version conflicts.

## Reference documentation
- [EPIK GitHub Repository](./references/github_com_phylo42_EPIK.md)