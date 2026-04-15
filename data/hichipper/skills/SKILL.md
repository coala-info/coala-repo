---
name: hichipper
description: hichipper is a preprocessing and quality control pipeline that transforms aligned HiChIP data into high-confidence DNA loops. Use when user asks to process HiChIP data, call DNA loops, assess library quality, or identify interaction anchors from restriction fragment information.
homepage: https://github.com/aryeelab/hichipper
metadata:
  docker_image: "quay.io/biocontainers/hichipper:0.7.7--py_0"
---

# hichipper

## Overview
hichipper is a preprocessing and quality control pipeline specifically designed for HiChIP data. It transforms aligned reads into high-confidence DNA loops by integrating restriction fragment locations and peak information. The tool is particularly effective for assessing library quality with low read counts (as few as 1 million reads) and producing output compatible with downstream differential analysis tools like diffloop.

## Core Workflow and Best Practices

### Installation
The recommended method for installing hichipper is via Bioconda to ensure all dependencies (including R and Python components) are correctly configured.
`conda install bioconda::hichipper`

### Input Requirements
To run a hichipper analysis, you must prepare the following components:
- **HiC-Pro Output**: Aligned read files generated from a prior HiC-Pro run.
- **Manifest File**: A configuration file that coordinates the paths to your samples, restriction fragment files, and optional peak files.
- **Restriction Fragment Files**: Genomic locations of restriction sites (e.g., MboI, HindIII).
- **Peaks (Optional)**: You can provide "gold-standard" peaks from ChIP-Seq or allow hichipper to call peaks directly from the HiChIP data using its background detection algorithm.

### Execution Patterns
The primary execution involves passing the manifest file to the hichipper executable. Ensure that all paths defined within your manifest are either absolute or correctly relative to the execution directory.

- **Library Quality Assessment**: Use hichipper on shallow-sequenced libraries to check vital statistics before committing to full-depth sequencing.
- **Loop Calling**: Utilize the restriction fragment-aware mode to increase read density in potential loop regions, which improves the sensitivity of interaction detection.
- **Peak Inference**: If ChIP-Seq data is unavailable for your specific cell type, use the internal background detection algorithm to identify anchors for loop calling.

### Quality Control and Output
After execution, hichipper generates a `qcReports` folder containing `.html` files.
- **Interactive Tables**: Use these to evaluate loop strength and confidence metrics.
- **Benchmarking**: Compare your library's vital statistics against known high-quality datasets (available in the package's reference folders) to identify issues like poor in situ ligation.
- **Downstream Analysis**: The loop outputs are formatted for direct import into visualization tools or differential interaction packages.

### Troubleshooting Common Issues
- **File Architecture**: Ensure the HiC-Pro output directory structure is preserved, as hichipper looks for specific subfolders (e.g., `hic_results` or `bowtie_results`).
- **R Dependencies**: If QC report generation fails, verify that `Rscript` is in your PATH and that the `tidyverse` package is installed within your R environment.
- **Path Handling**: Recent versions support absolute file paths in the manifest, which is recommended to avoid "file not found" errors during multi-sample processing.

## Reference documentation
- [hichipper Overview](./references/anaconda_org_channels_bioconda_packages_hichipper_overview.md)
- [hichipper GitHub Repository](./references/github_com_aryeelab_hichipper.md)
- [Restriction Fragment Files](./references/github_com_aryeelab_hichipper_tree_master_RestrictionFragmentFiles.md)