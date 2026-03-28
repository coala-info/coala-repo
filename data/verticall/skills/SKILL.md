---
name: verticall
description: Verticall reconstructs the vertical evolutionary history of bacteria by identifying and excluding horizontally acquired DNA sequences from genomic datasets. Use when user asks to identify vertical inheritance patterns, mask horizontal gene transfer in alignments, or generate distance matrices for large-scale bacterial phylogenetics.
homepage: https://github.com/rrwick/Verticall
---

# verticall

## Overview

Verticall is a specialized tool designed to reconstruct the vertical evolutionary history of bacteria by identifying and excluding horizontally acquired DNA sequences. Unlike tools like Gubbins or ClonalFrameML, Verticall scales to thousands of genomes and handles diverse datasets spanning multiple species. It operates primarily on genome assemblies, using pairwise alignments to distinguish between vertical inheritance and horizontal acquisition based on sequence divergence patterns.

## Core Workflows

### 1. Distance Tree Workflow (Diverse Datasets)
Best for datasets with significant variation or multiple species where a single reference-based alignment is impractical.

1.  **Pairwise Comparison**: Run all-against-all comparisons of your assemblies.
    ```bash
    verticall pairwise -i assemblies_dir/ -o pairwise_results.tsv
    ```
2.  **Generate Matrix**: Create a distance matrix using the vertical-only genomic distances.
    ```bash
    verticall matrix -i pairwise_results.tsv -o distance_matrix.dist
    ```
3.  **Build Tree**: Use an external tool like RapidNJ or FastME to build a tree from the `.dist` file.

### 2. Alignment Tree Workflow (Large/Closely Related Datasets)
Best for thousands of closely related isolates where a whole-genome pseudo-alignment (e.g., from Snippy or SKA) is available.

1.  **Reference Comparison**: Compare every assembly against a single reference.
    ```bash
    verticall pairwise -i assemblies_dir/ -r reference.fasta -o reference_comparisons.tsv
    ```
2.  **Mask Alignment**: Use the comparison results to "paint" and mask horizontal regions in your alignment.
    ```bash
    verticall mask -i reference_comparisons.tsv -a full_alignment.fasta -o masked.fasta
    ```
3.  **Build ML Tree**: Use IQ-TREE, RAxML-NG, or FastTree on the `masked.fasta` file.

## Command Reference & Best Practices

### verticall pairwise
*   **Input Requirements**: Assemblies must be in FASTA format. Sample names are derived from filenames.
*   **Ambiguous Bases**: Verticall does not support ambiguous bases (N). Use `verticall repair` first if your assemblies contain them.
*   **Performance**: For large datasets in the distance workflow, use `--index_only` first to build indices, then run the full comparison to allow for better parallelization.

### verticall mask
*   **--exclude_reference**: Use this flag if you do not want the reference sequence included in the final output alignment.
*   **--exclude_invariant**: Removes constant sites, significantly speeding up downstream Maximum Likelihood tree construction for large datasets.

### verticall repair
*   Use this utility to prepare assemblies by splitting contigs at ambiguous bases, ensuring compatibility with the main Verticall pipeline.
    ```bash
    verticall repair -i raw_assemblies/ -o repaired_assemblies/
    ```

## Expert Tips
*   **Assembly Quality**: While Verticall works with fragmented assemblies, higher N50 values generally improve the accuracy of recombination detection.
*   **Gubbins vs. Verticall**: If your dataset is very small and extremely closely related, Gubbins may provide finer resolution. Use Verticall when Gubbins fails to scale or when sequence divergence is too high for traditional tools.
*   **Interpreting TSV**: The `mean_vertical_distance` column in the pairwise TSV is the most reliable metric for vertical-only divergence, as it ignores regions identified as horizontal or unaligned.



## Subcommands

| Command | Description |
|---------|-------------|
| verticall mask | mask horizontal regions from a whole-genome pseudo-alignment |
| verticall pairwise | pairwise analysis of assemblies |
| verticall repair | repair assembly for use in Verticall |
| verticall summary | summarise regions for one assembly |
| verticall view | view plots for a single assembly pair |
| verticall_matrix | produce a PHYLIP distance matrix |

## Reference documentation
- [Home](./references/github_com_rrwick_Verticall_wiki.md)
- [Quick start](./references/github_com_rrwick_Verticall_wiki_Quick-start.md)
- [Distance tree workflow](./references/github_com_rrwick_Verticall_wiki_Distance-tree-workflow.md)
- [Alignment tree workflow](./references/github_com_rrwick_Verticall_wiki_Alignment-tree-workflow.md)
- [Verticall pairwise](./references/github_com_rrwick_Verticall_wiki_Verticall-pairwise.md)
- [Verticall mask](./references/github_com_rrwick_Verticall_wiki_Verticall-mask.md)
- [Verticall repair](./references/github_com_rrwick_Verticall_wiki_Verticall-repair.md)