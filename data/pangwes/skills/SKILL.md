---
name: pangwes
description: PANGWES performs genome-wide epistasis studies by analyzing pangenome-spanning unitig correlations within a de Bruijn graph framework. Use when user asks to construct colored compacted de Bruijn graphs, calculate mutual information between unitigs, determine shortest path distances in single genome subgraphs, or visualize epistasis results with Manhattan plots.
homepage: https://github.com/jurikuronen/PANGWES
metadata:
  docker_image: "quay.io/biocontainers/pangwes:0.3.0_alpha--h9948957_1"
---

# pangwes

## Overview

PANGWES (Pangenome-spanning Epistasis and Co-selection Analysis) is a suite of C++ tools designed to perform Genome-Wide Epistasis Studies (GWES) using de Bruijn graphs. Instead of relying on a single reference genome, it analyzes the entire pangenome by representing sequences as unitigs. The workflow involves constructing a colored compacted de Bruijn graph (cdBG), identifying highly correlated unitig pairs via mutual information, and filtering these pairs based on their physical distance within individual genome subgraphs to distinguish true epistasis from simple genetic linkage.

## Core Workflow and CLI Patterns

The PANGWES pipeline consists of five primary stages. Ensure all dependencies (`cuttlefish`, `SpydrPick`) are installed and available in your PATH.

### 1. Graph Construction
Build a colored compacted de Bruijn graph from a list of genome assemblies using `cuttlefish`.

```bash
# Build the graph
./cuttlefish build --list assemblies_list.txt \
                   --kmer-len 61 \
                   --output cdbg_k61 \
                   --work-dir /tmp \
                   --threads 8
```

### 2. GFA Parsing
Convert the Graphical Fragment Assembly (GFA) output into a format compatible with the PANGWES analysis tools.

```bash
# Parse GFA1 to generate .unitigs, .edges, and .paths files
./gfa1_parser cdbg_k61.gfa1 cdbg_k61
```

### 3. Mutual Information Calculation
Use `SpydrPick` to calculate mutual information (MI) scores. This identifies candidate unitig pairs that show strong co-occurrence patterns.

```bash
# Calculate MI scores for top candidate pairs
./SpydrPick --alignmentfile cdbg_k61.fasta \
            --maf-threshold 0.05 \
            --mi-values 50000000 \
            --threads 8 \
            --verbose
```

### 4. Graph Distance Calculation
Calculate the shortest path distances between candidate unitig pairs within single genome subgraphs (SGGs). This step is critical for filtering out linked variants.

```bash
# Calculate distances
unitig_distance --unitigs-file cdbg_k61.unitigs \
                --edges-file cdbg_k61.edges \
                --k-mer-length 61 \
                --sgg-paths-file cdbg_k61.paths \
                --queries-file cdbg.*spydrpick_couplings*edges \
                --threads 8 \
                --queries-one-based \
                --run-sggs-only \
                --output-stem cdbg \
                --verbose
```

### 5. Visualization
Generate a Manhattan plot to visualize the GWES results.

```bash
# Draw the Manhattan plot
Rscript gwes_plot.r [input_results] [output_file]
```

## Best Practices and Tips

- **K-mer Selection**: A k-mer length of 61 is a common starting point for bacterial pangenomes, but this should be adjusted based on the complexity and repeat content of the target species.
- **Memory Management**: `cuttlefish` and `unitig_distance` can be memory-intensive. Use the `--work-dir` flag to point to a high-speed SSD or scratch space for temporary files.
- **Thread Optimization**: Most tools in the suite support multi-threading. Match the `--threads` count to your available CPU cores to significantly reduce processing time for large pangenomes.
- **Input Formatting**: The `assemblies_list.txt` file should contain absolute paths to your FASTA/GFA files, one per line.
- **Distance Filtering**: When interpreting results, unitig pairs with high MI scores but low graph distances are likely physically linked (e.g., on the same operon), while those with high MI scores and high graph distances (or on different components) are stronger candidates for true epistasis.



## Subcommands

| Command | Description |
|---------|-------------|
| /usr/local/bin/gfa1_parser | Parser for GFA1 files |
| Rscript | A binary front-end to R, for use in scripting applications. |
| SpydrPick | MI-ARACNE genome-wide co-evolution analysis. |
| pangwes_unitig_distance | Calculate unitig distances in graphs and single genome graphs, with tools for determining outliers. |

## Reference documentation
- [PANGWES README](./references/github_com_jurikuronen_PANGWES_blob_main_README.md)
- [Unitig Distance Tool Details](./references/github_com_jurikuronen_PANGWES_tree_main_unitig_distance.md)