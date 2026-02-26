---
name: reads2graph
description: reads2graph constructs graphs from sequencing reads where nodes represent unique sequences and edges represent a defined edit distance. Use when user asks to build a read graph, identify sequence relationships based on edit distance, or perform efficient pairwise read comparisons using minimizer bucketing.
homepage: https://github.com/Jappy0/reads2graph
---


# reads2graph

## Overview
The `reads2graph` tool provides an efficient mechanism for building graphs where nodes represent unique sequencing reads and edges represent a defined edit distance (typically 1 or 2). By utilizing minimizer bucketing and order min hash (gOMH), it avoids the $O(N^2)$ complexity of brute-force pairwise comparisons, making it suitable for large-scale sequencing datasets.

## Installation and Setup
The tool is primarily distributed via Bioconda for Linux-64 platforms.

```bash
# Recommended installation via Conda
conda install -c bioconda -c conda-forge reads2graph
```

*Note: If installing from source, ensure a C++20 compatible compiler (g++ 13.2.0+) and dependencies (SeqAn3, Boost, Sharg) are present in the environment.*

## Core CLI Usage
The basic command structure requires an input FASTA/FASTQ file, an output directory, and specific bucketing parameters.

### Recommended Execution Pattern
For most short-read datasets, use the `minimizer_gomh` mode without segmentation for the best balance of speed and sensitivity.

```bash
reads2graph --bucketing_mode minimizer_gomh \
            --segmentation false \
            -i input_reads.fasta \
            -o ./output_dir/ \
            -x 2 \
            -n 1 \
            -p 64 \
            --alpha 1
```

### Key Parameters
- `-i, --input`: Path to the input sequencing file (e.g., `.fasta`, `.umi.fasta`).
- `-o, --output`: Directory where the resulting graph edges and logs will be saved.
- `-x, --max_edit_distance`: The maximum edit distance to consider for an edge (commonly 1 or 2).
- `-p, --threads`: Number of CPU cores. **Critical**: Always specify this explicitly to ensure parallel execution.
- `--bucketing_mode`: 
    - `minimizer_gomh`: Recommended for general use.
    - `miniception_gomh`: Alternative using the miniception algorithm for bucketing.
- `--segmentation`: Set to `false` for standard short reads; `true` can be used for specific minimizer bucketing strategies but is generally slower.

## Expert Tips & Best Practices
- **Parallelization**: The tool does not automatically detect all available cores efficiently in all HPC environments. Always use the `-p` flag to match your allocated resources.
- **Memory Management**: While efficient, constructing graphs for extremely high-diversity libraries may require significant RAM. Monitor memory usage when processing files with >10M unique reads.
- **Input Preparation**: Ensure input files are de-duplicated or contain unique sequences if the goal is a collapsed read graph, though the tool handles unique read identification internally.
- **Environment Conflicts**: Avoid mixing a Bioconda installation with a source-code build in the same Conda environment to prevent GLIBCXX or dependency resolution errors.

## Reference documentation
- [reads2graph GitHub Repository](./references/github_com_JappyPing_reads2graph.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_reads2graph_overview.md)