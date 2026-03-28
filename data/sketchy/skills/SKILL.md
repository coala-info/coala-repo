---
name: sketchy
description: Sketchy performs rapid genomic neighbor typing and lineage calling by comparing query sequences against reference sketches using MinHash. Use when user asks to predict genotypes from reads, create genomic sketches, or identify the closest lineage of a sequence.
homepage: https://github.com/esteinig/sketchy
---

# sketchy

# Sketchy

## Overview
`sketchy` is a high-performance bioinformatics tool written in Rust that implements genomic neighbor typing. It allows for rapid lineage calling and genotyping by comparing query sequences against species-wide reference sketches using MinHash. It is specifically optimized for real-time applications, such as Nanopore sequencing, where it can provide accurate predictions from as few as tens to hundreds of reads.

## Usage and Best Practices

### Core Workflow
The primary function of `sketchy` is to query a set of reads or an assembly against a pre-computed reference sketch to find the "closest neighbor" and inherit its metadata (genotype, resistance profile, etc.).

### Key Parameters and Optimization
*   **Sketch Size (`-s`)**: 
    *   Use `s = 1000` for rapid, low-resource screening. This is the default for most lightweight applications.
    *   Use `s = 10000` for higher performance and better resolution, though memory and CPU requirements scale linearly with this size.
*   **K-mer Size (`-k`)**: The standard k-mer size for bacterial applications in `sketchy` is typically `16`.
*   **Top Matches (`--top`)**: Always use the `--top` flag when querying. Inspecting the top several matches provides a better understanding of the confidence of the prediction and helps identify if the query is equidistant between multiple reference lineages.

### Performance Tips
*   **Low Coverage Input**: `sketchy` is highly effective with minimal data. You do not need a full assembly; raw Nanopore reads can be streamed or provided directly to get an early indication of the lineage.
*   **Species Suitability**: The tool performs best on species with stable lineages. For species with extremely high rates of homologous recombination, genotype inference may be less certain.
*   **Resource Management**: Because it is written in Rust, `sketchy` is memory-efficient. Small sketches allow it to run on standard laptops or even field-deployable devices.

### Common CLI Patterns
While specific subcommands depend on the version, the general pattern involves:
1.  **Building**: Creating a reference sketch from a collection of assemblies and a genotype file.
2.  **Querying**: Running query sequences against the `.msh` (sketch) and `.txt` (genotype) files.

```bash
# Example installation via Cargo
cargo install sketchy

# General query pattern (conceptual)
sketchy query <reference.msh> <query.fastq> --top 5
```



## Subcommands

| Command | Description |
|---------|-------------|
| sketchy check | Check match between sketch and genotype file |
| sketchy info | List sketch genome order, sketch build parameters |
| sketchy predict | Predict genotypes from reads or read streams |
| sketchy shared | Compute shared hashes between two sketches |
| sketchy sketch | Create a sketch from input sequences |

## Reference documentation
- [GitHub Repository README](./references/github_com_esteinig_sketchy_blob_master_README.md)
- [Cargo Configuration](./references/github_com_esteinig_sketchy_blob_master_Cargo.toml.md)