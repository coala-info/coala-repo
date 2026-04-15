---
name: bifrost
description: Bifrost builds, updates, and queries compacted and colored de Bruijn graphs for large-scale genomic sequence analysis. Use when user asks to build a compacted de Bruijn graph, update an existing graph with new sequences, or query sequences against a colored graph.
homepage: https://github.com/pmelsted/bifrost
metadata:
  docker_image: "quay.io/biocontainers/bifrost:1.3.5--h5ca1c30_3"
---

# bifrost

## Overview

Bifrost is a high-performance bioinformatics tool designed to manage de Bruijn graphs through compaction and coloring. It transforms raw sequence data into a compacted representation where non-branching paths are merged into unitigs, significantly reducing the graph size. The "coloring" feature allows you to track which k-mers belong to which input samples, making it a powerful engine for comparative genomics and rapid sequence lookup across massive datasets.

## Core CLI Patterns

### Building a Graph
The `build` command is used to create a new compacted de Bruijn graph.

*   **From Reads (Filtering enabled):** K-mers with only one occurrence are discarded to reduce noise.
    ```bash
    Bifrost build -s reads.fastq.gz -o output_prefix -t 8
    ```
*   **From References (No filtering):** All k-mers are kept.
    ```bash
    Bifrost build -r genomes.fasta -o output_prefix -t 8
    ```
*   **Colored Graph:** Associate k-mers with their source files.
    ```bash
    Bifrost build -s sample1.fa -s sample2.fa -c -o colored_graph
    ```

### Updating a Graph
Add new sequences to an existing graph without rebuilding from scratch.
```bash
Bifrost update -g existing_graph.gfa -s new_reads.fastq -o updated_graph
```

### Querying a Graph
Search for sequences or k-mers within a constructed graph.
```bash
Bifrost query -g graph.gfa -q query_sequences.fasta -o query_results
```

## Expert Tips and Best Practices

*   **Input Lists:** For hundreds or thousands of files, do not list them individually. Create a text file containing one file path per line and pass it to `-s` or `-r`.
*   **K-mer Length Constraints:** By default, Bifrost supports a maximum k-mer size of 31. If your analysis requires larger k-mers (e.g., $k=63$), you must recompile Bifrost from source using the `-DMAX_KMER_SIZE=64` flag.
*   **Graph Cleaning:** Use `-i` (clip-tips) to remove short dead-ends and `-d` (del-isolated) to remove small disconnected components. This is highly recommended when building graphs from noisy sequencing reads.
*   **Memory Optimization:** Increasing the k-mer size increases memory usage (e.g., $k=31$ uses 8 bytes per k-mer, while $k=63$ uses 16 bytes). Adjust the Bloom filter bits (`-B`) if you encounter high false-positive rates during construction, though the default (24) is usually sufficient.
*   **Output Formats:** 
    *   Use `.gfa` for compatibility with visualization tools like Bandage.
    *   Use `-b` (`.bfg` format) for a Bifrost-specific binary format that is faster to load for subsequent updates or queries.
*   **Parallelism:** Always specify the number of threads with `-t` to match your hardware, as Bifrost is designed for high-concurrency environments.

## Reference documentation

- [Bifrost GitHub README](./references/github_com_pmelsted_bifrost.md)
- [Bifrost Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_bifrost_overview.md)