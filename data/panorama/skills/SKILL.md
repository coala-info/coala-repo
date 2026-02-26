---
name: panorama
description: PANORAMA is a software suite for the large-scale comparison and structural analysis of partitioned pangenome graphs. Use when user asks to detect biological systems using HMM models, compare genomic spots across species, generate system distribution heatmaps, or align and cluster gene families across pangenomes.
homepage: https://github.com/labgem/panorama
---


# panorama

## Overview
PANORAMA (Pangenome-based Analysis of Biological Systems) is a specialized software suite for the large-scale comparison of partitioned pangenome graphs. It allows researchers to move beyond simple gene presence/absence matrices by incorporating the structural context of pangenomes. Use this tool to detect complex biological systems using HMM models, compare genomic "spots" across different species, and generate visual heatmaps of system distribution.

## Input Preparation
The primary input for most PANORAMA commands is a two-column TSV file (typically named `pangenomes.tsv`).

| Name | Path |
| :--- | :--- |
| Pangenome1 | /absolute/path/to/pangenome1.h5 |
| Pangenome2 | /absolute/path/to/pangenome2.h5 |

**Expert Tip**: Always use absolute paths in your TSV file to prevent execution errors when running commands from different working directories.

## Core Workflows

### 1. Biological System Detection
To identify specific biological systems (like secretion systems or defense mechanisms) across your pangenomes:

```bash
panorama pansystems \
  -p pangenomes.tsv \
  --hmm hmm_list.tsv \
  -m models_list.tsv \
  -s source_name \
  -o output_dir \
  --projection \
  --association all \
  --partition
```
*   `--projection`: Projects detected systems onto the pangenome graph.
*   `--partition`: Considers the pangenome partition (persistent, shell, cloud) during detection.

### 2. Pangenome Comparison
After detection, compare the distribution of systems or genomic spots.

**Comparing Systems (with Heatmap):**
```bash
panorama compare_systems \
  --pangenomes pangenomes.tsv \
  --models defense_systems.tsv \
  --sources defense_finder \
  --output results_dir \
  --heatmap \
  --threads 8
```

**Comparing Conserved Spots:**
```bash
panorama compare_spots \
  --pangenomes pangenomes.tsv \
  --output spots_results \
  --gfrr_metrics min_gfrr \
  --gfrr_cutoff 0.8 0.8
```

### 3. Preprocessing: Alignment and Clustering
Before comparison, you may need to align or cluster gene families across different pangenomes.

*   **All-against-all Alignment:**
    ```bash
    panorama align --pangenomes pangenomes.tsv --output align_out --align_identity 0.5 --threads 8
    ```
*   **Fast Clustering (Linclust):**
    ```bash
    panorama cluster --pangenomes pangenomes.tsv --output cluster_out --method linclust --cluster_identity 0.8
    ```

## Utility and Inspection
Use the `info` command to validate your pangenome files and generate interactive reports before starting heavy computations.

```bash
panorama info -i pangenome_list.tsv -o reports_dir --status --content
```

## Best Practices
*   **Resource Management**: Use the `--threads` flag in `align`, `cluster`, and `compare` commands to significantly speed up processing on multi-core systems.
*   **Data Integrity**: Run `panorama info` with the `--status` flag to ensure all `.h5` files are valid PPanGGOLiN outputs and contain the expected genomic data.
*   **Clustering Thresholds**: When using `panorama cluster`, an identity threshold of 0.8 is standard for species-level comparisons, but consider lowering it for cross-species analysis.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_labgem_PANORAMA.md)
- [Anaconda Package Details](./references/anaconda_org_channels_bioconda_packages_panorama_overview.md)