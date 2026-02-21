---
name: kmtricks
description: kmtricks is a modular framework specialized in handling k-mer data across massive collections of sequencing reads.
homepage: https://github.com/tlemane/kmtricks
---

# kmtricks

## Overview
kmtricks is a modular framework specialized in handling k-mer data across massive collections of sequencing reads. While traditional k-mer counters are often optimized for single-sample processing, kmtricks excels at integrating data from multiple samples to build abundance or membership matrices. It is particularly useful for rescuing low-abundance k-mers that appear across different datasets, providing a more comprehensive view of shared genomic content.

## Installation
Install kmtricks via Bioconda:
```bash
conda install bioconda::kmtricks
```

## Core Pipeline Modules
The kmtricks workflow is modular. For complex matrix construction, the process typically follows this sequence:

1.  **repart**: Partitions the input data to enable parallel processing.
2.  **superk**: Generates super-kmers to optimize downstream counting.
3.  **count**: Performs the actual k-mer counting within the partitions.
4.  **merge**: Aggregates the partitioned counts into the final output format (matrix or Bloom filters).

Other utility modules include:
*   **aggregate/combine**: For managing and merging intermediate results.
*   **dump**: For extracting data from constructed matrices or filters.
*   **infos**: Provides system and version information for debugging.

## Operational Best Practices
*   **Multi-Sample Optimization**: Use kmtricks when your primary goal is merging information across many samples. For simple k-mer counting of a single file, traditional counters like KMC may be faster.
*   **Resource Planning**: kmtricks requires significant disk space. Expect to use between 20% and 100% of the total gzipped input size for intermediate files and final outputs.
*   **Low-Abundance Rescue**: Leverage kmtricks when you need to preserve k-mers that have low individual sample frequency but appear consistently across the dataset.
*   **Troubleshooting**: If a run fails, check for `kmtricks_backtrace.log` in the working directory. Always run `kmtricks infos` when reporting issues to provide environment context.
*   **Debug Mode**: If encountering segmentation faults, use the `kmtricks-debug` binary provided in the conda package for more verbose error reporting.

## Reference documentation
- [kmtricks Main Repository](./references/github_com_tlemane_kmtricks.md)
- [kmtricks Wiki Overview](./references/github_com_tlemane_kmtricks_wiki.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_kmtricks_overview.md)