---
name: skmer
description: Skmer estimates genomic distances and identifies samples from low-pass sequencing data using k-mer profiles. Use when user asks to perform genome skimming, create a reference library from genomic files, query samples against a library, or compute distance matrices for phylogenetic analysis.
homepage: https://github.com/shahab-sarmashghi/Skmer
---


# skmer

## Overview

Skmer is a specialized tool designed for "genome skimming"—the process of using low-pass sequencing data to identify samples and estimate evolutionary distances. By utilizing k-mer profiles (via Mash and Jellyfish), Skmer bypasses the computationally expensive steps of assembly and alignment. It is uniquely capable of correcting for sequencing errors and low depth of coverage, providing accurate genomic distance estimates even from sparse data. The tool outputs distance matrices that can be directly used for phylogenetic tree reconstruction.

## CLI Usage and Best Practices

### Creating a Reference Library
The `reference` command is the starting point for most workflows. It processes a directory of genomic files and creates a searchable library.

*   **Basic Command**: `skmer reference <input_directory> -l <library_name>`
*   **Parallelization**: Use `-p` to specify the number of CPU cores.
    *   Example: `skmer reference ref_dir -p 8 -l my_library`
*   **Phylogenetic Preparation**: If you intend to build a tree, always use the `-t` flag to apply the Jukes-Cantor (JC) transformation.
    *   Example: `skmer reference ref_dir -t -o jc_distances`

### Querying and Identification
Use the `query` command to compare a new sample against an existing library.

*   **Search**: `skmer query <query_file> <library_path>`
*   **Add to Library**: Use the `-a` flag to process the query and automatically append it to the reference library for future use.
    *   Example: `skmer query new_sample.fastq my_library -a`

### Computing Distances
If you have multiple processed libraries or want to re-calculate distances from an existing library:

*   **Command**: `skmer distance <library_path> -o <output_prefix>`
*   **Transformation**: Apply `-t` here if it wasn't applied during the reference step to get mutation rates.

## Expert Tips and Parameters

*   **K-mer Size (`-k`)**: The default is 31 (the maximum supported by the underlying Mash tool). 
    *   **Tip**: Do not use k-mer sizes smaller than 21, as random k-mer matches will begin to skew distance estimates.
*   **Sketch Size (`-s`)**: The default is 10,000,000.
    *   **Tip**: Reducing the sketch size saves disk space and memory but significantly reduces the accuracy of distance estimation for closely related species.
*   **Input Preparation**:
    *   Skmer requires uncompressed files (`.fastq`, `.fq`, `.fa`, `.fasta`).
    *   For paired-end reads, it is highly recommended to merge overlapping pairs using a tool like BBMerge before running Skmer to improve k-mer count accuracy.
*   **Assembly vs. Skims**: Skmer automatically detects if an input is an assembly based on sequence length. If an assembly is detected, the coverage and error correction steps are skipped for that specific sample.



## Subcommands

| Command | Description |
|---------|-------------|
| skmer | skmer: error: argument {commands}: invalid choice: 'Run' (choose from 'reference', 'subsample', 'correct', 'distance', 'query') |
| skmer subsample | Performs subsample on a library of reference genome-skims or assemblies |
| skmer_correct | Performs correction of subsampled distance matrices obtained for reference genome-skims or assemblies |
| skmer_distance | Compute the distance matrix for a processed library |
| skmer_query | Compare an input genome-skim or assembly against a reference library |
| skmer_reference | Process a library of reference genome-skims or assemblies |

## Reference documentation
- [Skmer README](./references/github_com_shahab-sarmashghi_Skmer_blob_master_README.md)
- [Skmer Setup and Dependencies](./references/github_com_shahab-sarmashghi_Skmer_blob_master_setup.py.md)