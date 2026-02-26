---
name: arborist
description: Arborist ranks candidate tumor phylogenetic trees by calculating the evidence lower bound using single-cell sequencing data. Use when user asks to rank candidate trees, identify the most likely clonal architecture, or assign cells to specific clones.
homepage: https://github.com/VanLoo-lab/Arborist
---


# arborist

## Overview

Arborist is a specialized bioinformatics tool that helps researchers identify the most likely evolutionary history of a tumor. While bulk sequencing often results in multiple valid phylogenetic trees (clone trees), Arborist uses single-cell data to calculate the evidence lower bound (ELBO) for each candidate tree. This allows for a statistically grounded ranking of phylogenies, helping to determine the true clonal architecture and cell-to-clone assignments.

## Input Requirements

Arborist requires three specific input files to function:

1.  **Read Counts (-R):** A CSV containing `snv`, `cell`, `total`, and `alt` columns.
2.  **SNV Clusters (-Y):** A headerless CSV with two columns: `snv_id` and `cluster_label`.
3.  **Candidate Trees (-T):** A text file containing one or more trees. Each tree must start with a header containing `#` (e.g., `# Tree 1`) followed by parent-child integer pairs.

## Common CLI Patterns

### Basic Tree Ranking
To rank a set of candidate trees and output the results to a CSV:
```bash
arborist -R counts.csv -Y clusters.csv -T trees.txt --ranking results_ranking.csv
```

### Handling Missing Normal Cells
If your candidate trees do not explicitly include a "normal" root node (common in bulk inference), use the `--add-normal` flag to automatically append a normal clone to the root:
```bash
arborist -R counts.csv -Y clusters.csv -T trees.txt --add-normal --ranking ranking.csv
```

### Generating Downstream Analysis Files
To extract the best tree and assign individual cells to specific clones:
```bash
arborist -R counts.csv -Y clusters.csv -T trees.txt \
  --tree best_tree.txt \
  --cell-assign cell_assignments.csv \
  --snv-assign snv_assignments.csv \
  --draw best_tree_viz.pdf
```

## Expert Tips

*   **Node Consistency:** Ensure that the cluster labels in your SNV clustering file (-Y) match the node identifiers used in your tree file (-T).
*   **Sequencing Error:** The default sequencing error rate (`--alpha`) is often sufficient, but for very low-pass data or specific platforms, adjusting this parameter can significantly impact the ELBO calculation.
*   **Unseen SNVs:** If an SNV is present in the read counts but missing from the clustering file, Arborist initializes it with a uniform prior across all clusters.
*   **Performance:** For large datasets with many candidate trees, use the `-j` flag to specify the number of threads for parallel processing of tree fits.

## Reference documentation

- [Arborist GitHub Repository](./references/github_com_VanLoo-lab_Arborist.md)
- [Arborist Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_arborist_overview.md)