---
name: nanoqc
description: `nanoqc` is a specialized quality control tool for long-read sequencing data, particularly from Oxford Nanopore Technologies (ONT).
homepage: https://github.com/wdecoster/nanoQC
---

# nanoqc

## Overview
`nanoqc` is a specialized quality control tool for long-read sequencing data, particularly from Oxford Nanopore Technologies (ONT). While standard tools like FastQC are optimized for short-read data, `nanoqc` addresses the unique characteristics of long reads by generating interactive Plotly-based visualizations. It is primarily used to evaluate base call quality distributions at the start and end of reads, helping researchers determine if specific regions of the library are underperforming or if technical artifacts are present.

## Installation
The tool can be installed via bioconda or pip:
```bash
conda install -c bioconda nanoqc
# OR
pip install nanoQC
```

## Command Line Usage
The basic syntax for `nanoqc` is:
```bash
nanoQC [-o OUTDIR] [-l MINLEN] fastq
```

### Common Patterns
*   **Basic QC**: Run with default settings on a gzipped FASTQ file.
    ```bash
    nanoQC sample_data.fastq.gz
    ```
*   **Specify Output**: Direct the HTML report and associated files to a specific directory.
    ```bash
    nanoQC -o ./qc_reports sample_data.fastq.gz
    ```
*   **Filter by Length**: Only include reads of a certain length and define the plotting window.
    ```bash
    nanoQC -l 1000 sample_data.fastq.gz
    ```

## Expert Tips and Best Practices
*   **Understanding the `-l` Parameter**: This is the most critical argument. The value provided for `--minlen` (default is often 200) serves two purposes:
    1.  It filters out any reads shorter than this value.
    2.  It determines the length of the sequence plotted. The tool plots exactly half of the `minlen` value from the beginning of the read and half from the end (e.g., `-l 1000` plots the first 500bp and the last 500bp).
*   **Input Format**: Ensure your input is in FASTQ format. While the tool handles `.gz` compression, it does not support FASTA files.
*   **Interactive Reports**: The output is an HTML file. Since recent versions (v0.9.0+) use Plotly instead of Bokeh, the plots are highly interactive; you can zoom into specific base positions to inspect quality drops.
*   **Memory Management**: For extremely large FASTQ files, ensure you have sufficient RAM as the tool processes read data to generate the distribution plots. If the process is killed, try subsampling your FASTQ file first.

## Reference documentation
- [nanoQC GitHub Repository](./references/github_com_wdecoster_nanoQC.md)
- [nanoqc Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_nanoqc_overview.md)