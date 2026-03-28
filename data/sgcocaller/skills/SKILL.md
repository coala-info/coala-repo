---
name: sgcocaller
description: "This tool constructs personalized haplotypes and calls crossover events in single-cell DNA sequencing data from gametes. Use when user asks to analyze single-cell DNA sequencing data from gametes to identify haplotypes and crossover events."
homepage: https://gitlab.svi.edu.au/biocellgen-public/sgcocaller
---

# sgcocaller

yaml
name: sgcocaller
description: |
  Personalized haplotype construction and crossover calling in single-cell DNA sequenced gamete cells.
  Use when you need to analyze single-cell DNA sequencing data from gametes to identify haplotypes and crossover events.
  This tool is particularly useful for researchers studying meiosis and genetic recombination.
```
## Overview
The sgcocaller tool is designed for advanced analysis of single-cell DNA sequencing data from gametes. It specializes in constructing personalized haplotypes and accurately calling crossover events, which are crucial for understanding genetic recombination and meiosis. This skill should be invoked when dealing with datasets that require detailed insights into the genetic makeup and recombination patterns within individual gametes.

## Usage Instructions

sgcocaller is a command-line tool. The primary function involves providing input data and specifying parameters for haplotype construction and crossover calling.

### Installation

Install sgcocaller via conda:
```bash
conda install bioconda::sgcocaller
```

### Core Functionality

The tool's main purpose is to process single-cell DNA sequencing data to identify haplotypes and crossover points. While specific command-line arguments are not detailed in the provided documentation, the general workflow would involve:

1.  **Input Data**: Providing the path to your single-cell DNA sequencing data. This data is expected to be in a format compatible with genomic analysis tools.
2.  **Parameter Configuration**: Adjusting parameters to tailor the analysis to your specific dataset and research questions. This might include settings related to:
    *   Haplotype phasing
    *   Crossover detection sensitivity
    *   Minimum read depth or quality thresholds
    *   Output format specifications

### Expert Tips and Best Practices

*   **Data Quality**: Ensure your single-cell DNA sequencing data is pre-processed and quality-controlled to achieve reliable results. Low-quality data can lead to inaccurate haplotype construction and crossover calls.
*   **Parameter Tuning**: Experiment with different parameter settings to optimize the performance of sgcocaller for your specific experimental conditions and biological questions. Refer to the tool's documentation (if available) for detailed explanations of each parameter.
*   **Version Control**: Keep track of the sgcocaller version used for your analysis, as updates may introduce changes in algorithms or output formats. The latest version available on bioconda is 0.3.9.
*   **Computational Resources**: Be mindful of the computational resources required, especially for large datasets. Haplotype construction and crossover calling can be computationally intensive.



## Subcommands

| Command | Description |
|---------|-------------|
| sgcocaller | sgcocaller is a tool for phasing and analyzing single-cell DNA sequencing data. |
| sgcocaller | sgcocaller phase command |
| sgcocaller | sgcocaller swphase [options] <gtMtxFile> <phasedSnpAnnotFile> <referenceVCF> <out_prefix> |
| sgcocaller | sgcocaller sxo [options] <SNPPhaseFile> <phaseOutputPrefix> <barcodeFile> <out_prefix> |
| sgcocaller | sgcocaller xo [options] <BAM> <VCF> <barcodeFile> <out_prefix> |

## Reference documentation
- [sgcocaller Overview](https://anaconda.org/bioconda/sgcocaller)
- [sgcocaller GitLab Repository](https://gitlab.svi.edu.au/biocellgen-public/sgcocaller)