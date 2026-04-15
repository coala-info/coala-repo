---
name: garnet
description: GarNet maps transcription factor binding motifs within open chromatin regions to genes to identify regulatory drivers of gene expression. Use when user asks to build genomic reference files, map epigenetic peaks to genes, or perform transcription factor regression analysis.
homepage: https://github.com/fraenkel-lab/GarNet
metadata:
  docker_image: "quay.io/biocontainers/garnet:0.4.5--py35_0"
---

# garnet

## Overview
GarNet is a specialized bioinformatics tool designed to link transcription factors to gene expression changes by analyzing their binding motifs within open chromatin regions. You should use this skill to guide the multi-step process of mapping epigenetic peaks to genes and performing linear regression to determine if TF binding strength significantly correlates with downstream expression levels. The tool relies on BedTools for genomic intersections and utilizes motif data from cisBP and gene annotations from RefSeq.

## GarNet Workflow and Best Practices

### 1. Reference Construction
Before mapping experimental data, you must build a reference file containing genomic annotations.
- **Method**: `construct_garnet_file`
- **Input**: Requires TF motif files (cisBP format) and genome annotation files (RefSeq).
- **Expert Tip**: You can allow multiple motif files to contribute to a single GarNet reference file. Ensure your motif files do not contain headers, as this is a known requirement for the parser.

### 2. Peak Mapping
This step intersects your experimental epigenetic regions with the constructed reference.
- **Method**: `map_peaks`
- **Input**: A BED file of epigenetic peaks (e.g., ATAC-seq or DNase-seq "open" regions).
- **Logic**: The tool maps peaks to the nearest genes and identifies which TF motifs reside within those peaks.
- **Requirement**: Ensure `BedTools` is installed and accessible in the system PATH, as GarNet uses it for all genomic intersection calculations.

### 3. TF Regression Analysis
The final step identifies which TFs are likely drivers of the biological state.
- **Method**: `TF_regression`
- **Input**: The mapped peaks file (from step 2) and a differential gene expression profile (RNA-seq).
- **Statistical Logic**: For each TF, GarNet performs a linear regression to see if the change in gene expression is dependent on the strength of the TF binding motif.
- **Output**: TFs are assigned scores based on the significance (p-value) and the slope of the regression. A high score indicates a TF is a likely regulator in the system.

## Technical Requirements and Environment
- **Dependencies**: GarNet requires `numpy`, `pandas`, `statsmodels`, and `pybedtools`. For generating visual reports, `matplotlib` and `jinja2` must be available.
- **Platform Support**: Primarily supports `linux-64` and `macos-64`.
- **Installation**: Use `pip install garnet` or `conda install -c bioconda garnet`.

## Common Troubleshooting
- **Tkinter Errors**: If running in a headless environment (like a remote server) and encountering import errors, ensure a backend like 'Agg' is set for matplotlib.
- **BedTools Versioning**: GarNet depends heavily on `pybedtools` wrapping `BedTools`. If intersections fail, verify that `bedtools` is correctly installed via `conda` or `brew`.

## Reference documentation
- [GarNet GitHub Repository](./references/github_com_fraenkel-lab_GarNet.md)
- [Bioconda GarNet Overview](./references/anaconda_org_channels_bioconda_packages_garnet_overview.md)