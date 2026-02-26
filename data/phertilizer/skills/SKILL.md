---
name: phertilizer
description: Phertilizer reconstructs clonal trees from ultra-low coverage single-cell DNA sequencing data by integrating variant and binned read counts. Use when user asks to infer tumor evolutionary history, prepare variant and binned read count input files, or execute the clonal tree inference algorithm.
homepage: https://github.com/elkebir-group/phertilizer
---


# phertilizer

## Overview

Phertilizer is a specialized tool for reconstructing clonal trees from ultra-low coverage single-cell DNA sequencing (scDNA-seq) data. It overcomes the challenges of sparse data by integrating variant read counts with binned read count data (often used for copy number analysis) to infer the most likely evolutionary history of a tumor. Use this skill to guide the preparation of input files, execution of the inference algorithm, and interpretation of the resulting clonal hierarchies.

## Input Data Requirements

Phertilizer requires two specific text-based input files. Ensure cell identifiers are consistent across both.

*   **Variant Read Counts (-f/--file):** A tab or comma-separated file **without** headers.
    *   Columns: `chromosome`, `snv_index`, `cell_id`, `alternate_base`, `variant_reads`, `total_reads`.
*   **Binned Read Counts (--bin_count_data):** A tab or comma-separated file **with** headers.
    *   Columns: `cell` (must match variant file IDs), followed by bin identifiers (e.g., `bin1`, `bin2`, ...).

## Common CLI Patterns

### Basic Inference
Run a standard analysis with default parameters, specifying output files for the tree visualization and cluster mappings.
```bash
phertilizer -f variant_counts.tsv \
  --bin_count_data binned_read_counts.csv \
  --tree output_tree.png \
  -n cell_clusters.csv \
  -m snv_clusters.csv
```

### High-Sensitivity Search
For complex subclonal structures, increase the number of restarts and iterations to better explore the likelihood landscape.
```bash
phertilizer -f variant_counts.tsv \
  --bin_count_data binned_read_counts.csv \
  -s 5 -j 50 \
  --post_process \
  --tree_text tree_edges.txt
```

### Dimensionality Control
By default, Phertilizer uses UMAP on binned counts. If your input binned data is already reduced (e.g., PCA components or specific embeddings), use the `--no-umap` flag.
```bash
phertilizer -f variant_counts.tsv \
  --bin_count_data reduced_embeddings.csv \
  --no-umap \
  --tree output_tree.png
```

## Expert Tips and Best Practices

*   **Error Rate Calibration:** Use the `-a` or `--alpha` flag to set the per-base read error rate. The default is often sufficient, but tuning this based on your specific sequencing platform can improve genotype calls.
*   **Post-Processing:** Always include the `--post_process` flag when the final tree structure is the primary goal, as it refines the cell assignments to the inferred tree nodes.
*   **Handling Large Datasets:** If the number of SNVs is extremely high, consider filtering for high-confidence variants or increasing `--min_obs` to ensure partitions have enough data for reliable inference.
*   **Tree Enumeration:** Use `--tree_list` to save a pickle file containing all candidate clonal trees generated during the run, which is useful for assessing model uncertainty.
*   **Visualization:** The `--tree` parameter generates a `.png` via Graphviz. Ensure `pygraphviz` is installed in your environment to utilize this feature.

## Reference documentation
- [Phertilizer Overview](./references/anaconda_org_channels_bioconda_packages_phertilizer_overview.md)
- [Phertilizer GitHub Repository](./references/github_com_elkebir-group_phertilizer.md)