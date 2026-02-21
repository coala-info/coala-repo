---
name: sketchy
description: Sketchy is a high-performance bioinformatics tool designed for the rapid identification of bacterial strains and their associated traits.
homepage: https://github.com/esteinig/sketchy
---

# sketchy

## Overview

Sketchy is a high-performance bioinformatics tool designed for the rapid identification of bacterial strains and their associated traits. By utilizing MinHash-based "genomic neighbor typing," it compares query sequences against a database of reference sketches to find the closest matches. This approach is "hypothesis-agnostic," meaning it can query species-wide references without prior assumptions about the sample. It is exceptionally well-suited for real-time applications, as it can often provide accurate lineage predictions from as few as tens or hundreds of sequencing reads.

## Installation

The tool is available via Bioconda or Cargo:

```bash
# Using Conda
conda install -c bioconda sketchy

# Using Cargo
cargo install sketchy
```

## Core Workflows and CLI Patterns

### 1. Managing Reference Databases
Sketchy relies on pre-computed sketches of reference genomes. You can download existing databases or build your own.

*   **Download pre-built sketches**: Use the `pull` command to retrieve curated databases for common pathogens (e.g., *S. aureus*, *K. pneumoniae*).
    ```bash
    sketchy pull --full
    ```
*   **Build custom sketches**: Create a new reference index from a collection of assemblies and a genotype file.
    ```bash
    sketchy build -f assemblies.txt -g genotypes.tsv -o my_reference.sketch
    ```

### 2. Lineage and Genotype Inference
The primary command for analyzing reads is `sketchy run` (or the main execution entry point).

*   **Standard analysis**: Run a set of reads against a reference sketch.
    ```bash
    sketchy run -r reads.fastq.gz -s reference.sketch
    ```
*   **Real-time/Top matches**: When working with very few reads, use the `--top` flag to inspect the best matches in the reference sketch for immediate feedback.
    ```bash
    sketchy run -r reads.fastq.gz -s reference.sketch --top 5
    ```

### 3. Parameter Optimization
*   **Sketch Size (`-s`)**: The default sketch size is often `1000` for speed and low resource usage. For higher resolution or complex species, increase this to `10000`. Note that resource requirements scale linearly with sketch size.
*   **K-mer Size (`-k`)**: Typically set to `16` for bacterial pathogens, but can be adjusted based on the specific genomic diversity of the target species.

## Best Practices

*   **Low Read Count**: Do not wait for high coverage. Sketchy is designed to provide insights from the first few hundred reads of a Nanopore run.
*   **Species Limitations**: Be cautious when using Sketchy for species with extremely high rates of homologous recombination, as the neighbor-typing heuristic may be less accurate.
*   **Resource Management**: For mobile or field computing, stick to a sketch size of `1000` to minimize memory and CPU overhead.
*   **Genotype Files**: Ensure your genotype files (used during `build`) are correctly formatted TSV files where the first column matches the assembly identifiers in your reference set.

## Reference documentation
- [Genomic neighbor typing of bacterial pathogens using MinHash](./references/github_com_esteinig_sketchy.md)
- [sketchy - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_sketchy_overview.md)