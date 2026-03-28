---
name: panorama
description: PANORAMA is a bioinformatics suite for large-scale comparison of pangenomes using partitioned pangenome graphs to identify conserved genomic spots and biological systems. Use when user asks to detect biological systems using HMM models, compare conserved spots across species, or align and cluster gene families across different pangenomes.
homepage: https://github.com/labgem/panorama
---

# panorama

## Overview
PANORAMA is a specialized bioinformatics suite designed for the large-scale comparison of pangenomes. It leverages the partitioned pangenome graph approach—originally popularized by PPanGGOLiN—to identify and compare biological systems (like defense systems or metabolic pathways) and conserved genomic "spots" across different species or strains. It is particularly useful for researchers looking to move beyond simple gene-to-gene comparisons toward a more structural, graph-based understanding of genomic evolution and functional conservation.

## Core CLI Workflows

### 1. Input Preparation
Most PANORAMA commands require a pangenome list file (typically `pangenomes.tsv`). This file must contain two columns: the pangenome name and the absolute path to its corresponding `.h5` file.

| Name | Path |
| :--- | :--- |
| Species_A | /data/pangenomes/species_a.h5 |
| Species_B | /data/pangenomes/species_b.h5 |

### 2. Biological System Detection
Use the `pansystems` command to detect specific biological systems using HMM models.

```bash
panorama pansystems \
  -p pangenomes.tsv \
  --hmm hmm_list.tsv \
  -m models_list.tsv \
  -s source_name \
  -o output_dir \
  --projection \
  --partition
```
*   **Expert Tip**: Use `--projection` to map systems from the pangenome graph back to individual genomes.
*   **Expert Tip**: Use `--partition` to restrict detection to specific pangenome partitions (e.g., persistent vs. shell genes).

### 3. Pangenome Comparison
Once systems or spots are detected, use the comparison modules to find similarities across your dataset.

**Comparing Conserved Spots:**
```bash
panorama compare_spots \
  --pangenomes pangenomes.tsv \
  --output spots_results \
  --gfrr_metrics min_gfrr \
  --gfrr_cutoff 0.8 0.8 \
  --threads 8
```

**Comparing Biological Systems:**
```bash
panorama compare_systems \
  --pangenomes pangenomes.tsv \
  --models system_models.tsv \
  --sources source_name \
  --output systems_results \
  --heatmap
```

### 4. Gene Family Alignment and Clustering
Before comparison, gene families across different pangenomes must be normalized via alignment or clustering.

*   **Alignment (High Sensitivity)**: Use `panorama align` for all-against-all protein sequence alignment.
*   **Clustering (High Speed)**: Use `panorama cluster` with the `linclust` method for large datasets.

```bash
panorama cluster \
  --pangenomes pangenomes.tsv \
  --output cluster_out \
  --method linclust \
  --cluster_identity 0.8 \
  --threads 16
```

## Utility Commands
*   **Quick Summary**: Use `panorama info -i pangenomes.tsv -o report_dir --content` to generate interactive HTML reports summarizing the contents of your `.h5` pangenome files.
*   **Path Management**: Always prefer absolute paths in your TSV files to prevent "file not found" errors during multi-step workflows.



## Subcommands

| Command | Description |
|---------|-------------|
| panorama | Panorama tool for various bioinformatics tasks. |
| panorama | Panorama utility for various bioinformatics tasks. |
| panorama align | Perform sequence alignment between pangenome gene families using MMseqs2 with support for both inter-pangenome and all-against-all alignment modes. |
| panorama annotation | Perform annotation of pangenomes using various sources like tables or HMM profiles. |
| panorama cluster | Perform gene family clustering across multiple pangenomes using MMseqs2 with support for both fast (linclust) and sensitive (cluster) clustering methods. |
| panorama compare_spots | Compare and identify conserved spots across multiple pangenomes. This analysis identifies genomic regions that are conserved across different pangenomes based on gene family similarity and optionally analyzes systems relationships within these regions. |
| panorama compare_systems | Compare genomic systems among pangenomes using GFRR metrics |
| panorama pansystems | PANORAMA (0.6.0) is an opensource bioinformatic tools under CeCILL FREE SOFTWARE LICENSE AGREEMENT |
| panorama systems | PANORAMA (0.6.0) is an opensource bioinformatic tools under CeCILL FREE SOFTWARE LICENSE AGREEMENT |
| panorama utils | Create input files used by PANORAMA |
| panorama write | Write annotation/metadata assigned to gene families in pangenomes |
| panorama write_systems | Write systems from pangenomes |
| panorama_info | Extract status, content, parameters, and metadata information from pangenome HDF5 files and export as interactive HTML reports. |

## Reference documentation
- [PANORAMA GitHub README](./references/github_com_labgem_PANORAMA_blob_main_README.md)
- [PANORAMA User Guide](./references/panorama_readthedocs_io_latest_user_user_guide.html.md)
- [System Detection Guide](./references/panorama_readthedocs_io_latest_user_detection.html.md)
- [Pangenome Comparison Guide](./references/panorama_readthedocs_io_latest_user_compare_systems.html.md)