---
name: brooklyn_plot
description: "This tool identifies gene co-expression and transcriptional bursting patterns in single-cell RNA sequencing data. Use when user asks to analyze RNA-seq data for gene co-expression patterns and transcriptional bursting, or to generate Brooklyn plots."
homepage: https://github.com/arunhpatil/brooklyn/
---


# brooklyn_plot

yaml
name: brooklyn_plot
description: >-
  Tool for gene co-expression and transcriptional bursting pattern recognition in
  single-cell/nucleus RNA-sequencing data. Use when analyzing RNA-seq data to
  identify gene co-expression patterns and transcriptional bursting, particularly
  when generating Brooklyn plots for visualization.
```
## Overview
The `brooklyn_plot` tool is designed for analyzing single-cell and single-nucleus RNA sequencing data. It helps researchers identify patterns of gene co-expression and transcriptional bursting by performing pairwise gene comparisons and generating a visualization known as a Brooklyn plot. This tool is particularly useful for understanding how genes interact and regulate each other within complex biological systems at a single-cell level.

## Usage Instructions

The `brooklyn_plot` tool is primarily used via its command-line interface. It takes gene expression data as input and outputs co-expression patterns and visualizations.

### Core Functionality

The main purpose of `brooklyn_plot` is to:
1.  Perform pairwise gene comparisons (Pearson correlation) across the genome.
2.  Identify co-expression patterns.
3.  Generate a Brooklyn plot for visualization of these patterns.

### Installation

To install `brooklyn_plot`, use conda:
```bash
conda install bioconda::brooklyn_plot
```

### Basic Usage

While specific command-line arguments are not detailed in the provided documentation, the general workflow involves providing your RNA sequencing data (likely in a format compatible with Python/R analysis, such as `.h5ad` or similar) to the tool. The tool then processes this data to generate the desired outputs.

**Example (Conceptual - actual command may vary):**

```bash
brooklyn_plot --input_data path/to/your/rna_seq_data.h5ad --output_dir ./brooklyn_results
```

### Key Considerations

*   **Data Input:** Ensure your input data is in a format that `brooklyn_plot` can process. The documentation implies compatibility with standard single-cell RNA sequencing data formats.
*   **Output:** The primary output is a visualization (Brooklyn plot) and potentially tabular data detailing gene co-expression.
*   **Documentation:** For detailed command-line arguments, options, and specific data format requirements, refer to the official documentation: [https://brooklyn-plot.readthedocs.io/](https://brooklyn-plot.readthedocs.io/)

## Reference documentation
- [GitHub Repository](https://github.com/arunhpatil/brooklyn)
- [Bioconda Overview](https://anaconda.org/bioconda/brooklyn_plot)