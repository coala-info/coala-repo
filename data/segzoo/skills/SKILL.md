---
name: segzoo
description: Segzoo automates the interpretation and visualization of genomic segmentations produced by Segway by integrating multiple analysis tools and reference data. Use when user asks to interpret genomic segmentations, generate summary visualizations of Segway results, or translate numeric labels into descriptive biological tracks.
homepage: https://github.com/hoffmangroup/segzoo
metadata:
  docker_image: "quay.io/biocontainers/segzoo:1.0.13--pyhdfd78af_0"
---

# segzoo

## Overview
Segzoo is a specialized tool designed to streamline the interpretation of genomic segmentations produced by Segway. It automates the execution of multiple analysis tools (such as segtools and bedtools), manages the downloading of necessary genomic reference data, and generates a comprehensive summary visualization. This skill provides the procedural knowledge to configure analyses, manage data in restricted environments, and customize output labels and tracks.

## Installation and Environment
The recommended way to install Segzoo is via the mamba package manager to ensure all dependencies (segtools, bedtools, and Python libraries) are correctly resolved.

```bash
mamba create -c bioconda -n segzooenv segzoo -y
mamba activate segzooenv
```

## Core CLI Usage
The primary command requires a segmentation file (typically a compressed BED file) and optionally the GMTK parameters from Segway training.

### Basic Analysis
```bash
segzoo segway.bed.gz --parameters params.params -o my_results
```

### High-Performance Computing (HPC) Workflow
For clusters where compute nodes lack internet access, use the two-step download/execute pattern:
1. **Download (on login node):**
   ```bash
   segzoo segway.bed.gz --download-only --prefix ./genomic_data
   ```
2. **Execute (on compute node):**
   ```bash
   segzoo segway.bed.gz --prefix ./genomic_data -j 8
   ```

### Common Arguments
- `--parameters`: Path to `params.params` to include GMTK training parameters in the final plot.
- `--species` / `--build`: Specify the genome (default: `Homo_sapiens` / `hg38`).
- `-j`: Number of CPU cores to utilize.
- `--normalize-gmtk`: Apply row-wise normalization to the GMTK parameters table.
- `--dendrogram`: Perform hierarchical clustering on the GMTK parameters.

## Label and Track Translation (MNE Files)
To replace cryptic numeric labels (e.g., "0", "1") or raw track names with descriptive text (e.g., "Quiescent", "TSS"), use an MNE file.

**MNE File Format (Tab-delimited):**
The file must contain a header with `old`, `new`, and `type`.

| old | new | type |
| :--- | :--- | :--- |
| 0 | Quiescent | label |
| 1 | TSS | label |
| H3K4me3_peaks | H3K4me3 | track |

**Execution:**
```bash
segzoo segway.bed.gz --mne labels.tab
```

## Output Structure
Upon completion, the output directory (default: `outdir`) contains:
- `data/`: Raw analysis results from underlying tools.
- `results/`: Processed tables used for the final visualization.
- `plots/`: The summary visualization (PDF/PNG) showing heatmaps of segment overlaps with gene biotypes and learned parameters.

## Expert Tips
- **Custom Biotypes:** By default, Segzoo focuses on protein-coding and lincRNA. To include other biotypes, you must modify the `gene_biotypes.py` file within the Segzoo installation directory.
- **Visualization Tweaks:** For fine-grained control over the final figure's appearance, modify the variables in `visualization.py` located in the installation folder.
- **Memory Management:** When running on large segmentations, ensure the `-j` parameter matches your available memory, as some underlying `segtools` operations can be memory-intensive.

## Reference documentation
- [Segzoo Introduction and Usage](./references/github_com_hoffmangroup_segzoo.md)