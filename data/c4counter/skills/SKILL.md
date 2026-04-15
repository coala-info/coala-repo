---
name: c4counter
description: c4counter identifies and characterizes human C4 gene copies and structural variations from sequence data. Use when user asks to count C4A and C4B genes, detect HERV-K(C4) insertions, or visualize the C4 locus structure.
homepage: https://github.com/irunonayran/c4counter.git
metadata:
  docker_image: "quay.io/biocontainers/c4counter:0.0.2--pyhdfd78af_0"
---

# c4counter

## Overview
c4counter is a specialized bioinformatics tool designed to characterize the complex human C4 locus. It automates the identification of C4 gene copies and their structural variations from sequence data. By leveraging `minimap2` for alignment, it classifies regions into C4A or C4B types and detects the HERV-K(C4) insertion, providing both a numerical summary and a visual representation of the locus structure.

## Usage Instructions

### Prerequisites
- **minimap2**: This tool is a hard dependency for sequence mapping. If you installed c4counter via `pip`, you must install `minimap2` separately. If installed via `conda`, the dependency is handled automatically.

### Basic Workflow
1.  **Prepare Input**: Ensure your input is a FASTA file containing human HLA or C4 genomic regions.
2.  **Run Analysis**: Execute the tool by passing the FASTA file to the `c4counter` command.
3.  **Review Results**:
    *   **Terminal Output**: The tool returns the count and specific types of C4 regions identified (e.g., C4A with HERV, C4B without HERV).
    *   **Visual Output**: The tool automatically generates a file named `c4.svg` in the working directory, providing a graphical map of the detected regions.

### Best Practices
- **Input Specificity**: For the most accurate results, provide FASTA files that are pre-filtered or targeted to the HLA/C4 genomic region rather than whole-genome files.
- **Environment Management**: Use a Conda environment for installation to ensure that `minimap2` and Python dependencies are correctly linked and version-compatible.
- **Output Handling**: Since the tool generates a fixed filename (`c4.svg`), ensure you move or rename the SVG output between runs if processing multiple samples in the same directory to prevent overwriting.

## Reference documentation
- [c4counter GitHub Repository](./references/github_com_irunonayran_c4counter.md)
- [c4counter Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_c4counter_overview.md)