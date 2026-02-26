---
name: tadlib
description: TADLib is a bioinformatics library used to identify and quantify chromatin interaction patterns and Topologically Associating Domains from Hi-C data. Use when user asks to detect hierarchical TADs and sub-TADs, calculate aggregation preference metrics, or perform single-level domain calling on chromatin contact matrices.
homepage: https://github.com/XiaoTaoWang/TADLib/
---


# tadlib

## Overview

TADLib is a specialized bioinformatics library designed to explore and quantify chromatin interaction patterns within Topologically Associating Domains (TADs). It transforms raw Hi-C data into structural insights by identifying how DNA is organized in 3D space. The tool is primarily used to investigate the relationship between genome structure and biological functions, such as transcriptional remodeling and replication timing.

The library provides two core methodologies:
1.  **Aggregation Preference (AP):** A quantitative metric that measures the density of significant chromatin interactions within a TAD to capture its structural heterogeneity.
2.  **Hierarchical TAD (HiTAD):** An iterative optimization workflow that detects nested domain hierarchies, including TADs and sub-TADs, by separating intra-chromosomal interactions.

## Installation and Setup

TADLib is best installed via the Bioconda channel to manage its dependencies (such as `cooler` and `pomegranate`):

```bash
conda install -c bioconda tadlib
```

## Core Workflows and CLI Usage

### Data Requirements
Since version 0.4.0, TADLib uses the `.cool` format as its default data standard to comply with 4DN standards. Ensure your Hi-C contact matrices are converted to `.cool` or `.mcool` before processing.

### Hierarchical TAD Detection (HiTAD)
The `hitad` command is the primary entry point for detecting multi-level domains. It uses an objective function to globally separate interactions.

**Common Pattern:**
```bash
hitad -d <dataset_path.cool> -o <output_prefix> [options]
```

*   **Key Argument:** `-d` or `--datasets` is required to specify the input chromatin interaction data.
*   **Optimization:** HiTAD performs an iterative procedure; for high-resolution data, ensure sufficient computational resources are available for the optimization steps.

### Aggregation Preference (AP) Calculation
Use the AP module to measure the "aggregation degree" of interactions. This is particularly useful when comparing different cell types to see how structural rearrangements correlate with gene expression.

### Single-level TAD Calling
For standard, non-hierarchical domain identification, the `domaincaller` module provides traditional insulation-based or directionality index (DI) methods.

## Expert Tips and Best Practices

*   **Format Conversion:** If working with older Hi-C formats (like HiCPro or vanilla text matrices), use the `cooler` suite to convert them to `.cool` before using TADLib.
*   **Resolution Selection:** For `hitad`, the choice of resolution (bin size) in your `.cool` file significantly impacts the sensitivity of sub-TAD detection. 10kb to 40kb resolutions are typically recommended for mammalian genomes.
*   **Handling Small Chromosomes:** Be aware that extremely small chromosomes or scaffolds may need to be excluded or handled separately to avoid indexing errors during the HMM training or optimization phases.
*   **Visualizing Results:** TADLib outputs domain coordinates in standard formats (often BED-like). These can be loaded into heatmaps or genome browsers to verify that the detected loops and TAD boundaries align with the visual interaction signal.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_XiaoTaoWang_TADLib.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_tadlib_overview.md)
- [Known Issues and CLI Arguments](./references/github_com_XiaoTaoWang_TADLib_issues.md)