---
name: tadlib
description: TADLib is a bioinformatics library for identifying and quantifying structural patterns such as Topologically Associating Domains in Hi-C interaction matrices. Use when user asks to detect hierarchical TADs, calculate aggregation preference, or analyze nested chromatin organization within cooler data files.
homepage: https://github.com/XiaoTaoWang/TADLib/
---


# tadlib

## Overview

TADLib is a specialized bioinformatics library for quantifying and identifying structural patterns within Hi-C interaction matrices. It provides two primary analytical frameworks: Aggregation Preference (AP), which measures the density of significant interactions within a domain to reflect structural heterogeneity, and Hierarchical TAD (HiTAD), which uses iterative optimization to detect nested layers of chromatin organization (TADs and sub-TADs). The library is built to comply with 4DN standards, primarily utilizing the cooler data format.

## Tool-Specific Best Practices

### Data Input and Formats
*   **Standardize on Cooler**: Since version 0.4.0, TADLib uses `.cool` as the default data format. Ensure input files are in this format to maintain compatibility with 4DN standards.
*   **URI Path Syntax**: When specifying input datasets in `.cool` files, use the double-colon syntax to point to specific resolutions or groups within the file.
    *   Example pattern: `path/to/data.cool::/resolutions/10000`
*   **Directionality Index (DI)**: For certain domain calling workflows, ensure the cooler file contains or can generate Directionality Indices, as these are often used by the underlying `domaincaller` module.

### Hierarchical TAD (HiTAD) Detection
*   **Multi-Scale Analysis**: Use HiTAD when the biological question involves nested structures. It is designed to find optimal domains that globally separate intra-chromosomal interactions rather than just identifying local insulations.
*   **Dataset Argument**: When running the `hitad` command, use the `-d` or `--datasets` flag to specify the input cooler URI. 
*   **Optimization**: HiTAD uses an iterative optimization procedure; ensure your compute environment can handle the iterative load for high-resolution matrices.

### Aggregation Preference (AP) Calculation
*   **Quantifying Density**: Use the AP method to compare the "aggregation degree" of interactions between different cell types or conditions.
*   **Functional Correlation**: AP is a strong proxy for transcriptional remodeling; use it when investigating how structural rearrangements correlate with gene expression changes.

### Visualization and Heatmaps
*   **TAD Overlays**: When generating heatmaps, ensure the TAD/loop coordinates are correctly mapped to the resolution of the heatmap to avoid alignment issues.
*   **Empty Plots**: If visualization results in empty plots, verify that the chromosome names in your TAD coordinate file exactly match the names in the `.cool` file metadata.

## Common CLI Patterns

*   **Specifying Datasets**: Most TADLib scripts require the dataset path to be explicitly defined.
    ```bash
    hitad --datasets sample.cool::/bins/10000 --out_file results.txt
    ```
*   **Handling Chromosomes**: For genome-wide analysis, the tool may struggle with extremely small or scaffold-level chromosomes. It is a best practice to filter for standard nuclear chromosomes (e.g., chr1-22, X, Y) before processing.



## Subcommands

| Command | Description |
|---------|-------------|
| domaincaller | Detect minimum domains using adaptive DI |
| hitad | A highly sensitive and reproducible hierarchical domain caller. |

## Reference documentation
- [GitHub Repository Overview](./references/github_com_XiaoTaoWang_TADLib.md)
- [Issue Tracker (CLI Argument Context)](./references/github_com_XiaoTaoWang_TADLib_issues.md)