---
name: howdesbt
description: HowDeSBT indexes and searches large collections of k-mer sets from sequencing experiments using an efficient Sequence Bloom Tree data structure. Use when user asks to create Bloom filters from raw sequences, cluster filters into a tree topology, build a searchable index, or query sequences against a collection of experiments.
homepage: https://github.com/medvedevgroup/HowDeSBT
---

# howdesbt

## Overview

HowDeSBT is an advanced implementation of the Sequence Bloom Tree (SBT) data structure designed for efficient storage and searching of k-mer sets across thousands of sequencing experiments. It utilizes a "How-Determined" (HowDe) bit-splitting strategy to reduce the redundancy of information stored in the tree, resulting in smaller index sizes and faster query performance compared to original SBT implementations. Use this tool when you need to index large collections of FASTQ/FASTA files and search them for specific transcript or sequence matches.

## Core Workflow

The standard HowDeSBT pipeline consists of four primary stages.

### 1. Create Bloom Filters (makebf)
Convert raw sequence data or k-mer counts into Bloom filter representations.
- Use `howdesbt makebf` to process input files.
- Ensure k-mer size (k) matches across all filters in the tree.
- Define the Bloom filter size (m) based on the expected number of unique k-mers to control the false positive rate.

### 2. Determine Tree Topology (cluster)
Organize the individual Bloom filters into a hierarchical tree structure.
- Use `howdesbt cluster` to group similar Bloom filters together.
- This step generates a topology file (usually `.tree` or `.topology`) that defines the parent-child relationships.
- Proper clustering is critical for query pruning and performance.

### 3. Build the Index (build)
Construct the actual SBT index based on the clustered topology.
- Use `howdesbt build` to calculate the internal nodes of the tree.
- This stage implements the HowDe split, determining which bits are "determined" by children and moving them up the tree to save space.

### 4. Query the Tree (query)
Search for sequences against the built index.
- Use `howdesbt query` to search for k-mers from a query file.
- Adjust the threshold (theta) to define the fraction of k-mers that must match for a sample to be considered "present."

## Command Reference

Access built-in documentation directly from the CLI:
- `howdesbt ?`: List all available subcommands.
- `howdesbt ?<subcommand>`: View detailed help for a specific command (e.g., `howdesbt ?makebf`).

### Common Patterns

**Building a Bloom Filter:**
```bash
howdesbt makebf --k=20 --hashes=1 --bits=100M input.fastq out.bf
```

**Clustering Filters:**
```bash
howdesbt cluster --list=bf_list.txt --out=topology.tree
```

**Building the Tree:**
```bash
howdesbt build --tree=topology.tree --outdir=sbt_index/
```

**Querying:**
```bash
howdesbt query sbt_index/root.bf queries.fasta --threshold=0.9
```

## Expert Tips

- **K-mer Counting**: While `makebf` can handle raw files, for very large datasets, pre-counting k-mers with Jellyfish and then converting to Bloom filters can be more efficient.
- **Memory Management**: The `build` and `query` commands can be memory-intensive. Ensure your system has enough RAM to hold the necessary bit vectors, or use the `--lowmem` options if available in your version.
- **Threshold Selection**: A threshold (theta) of 0.7 to 0.9 is standard for transcript discovery, allowing for some sequencing errors or minor variations.
- **Dependency Check**: Ensure `jellyfish`, `sdsl-lite`, and `CRoaring` are correctly linked in your environment, as HowDeSBT relies on these for k-mer handling and bit vector compression.



## Subcommands

| Command | Description |
|---------|-------------|
| cluster | determine a tree topology by clustering bloom filters |
| howdesbt_makebf | convert a sequence file to a bloom filter |

## Reference documentation
- [HowDeSBT README](./references/github_com_medvedevgroup_HowDeSBT_blob_master_README.md)
- [HowDeSBT Tutorial](./references/github_com_medvedevgroup_HowDeSBT_tree_master_tutorial.md)