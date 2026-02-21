---
name: karyopype
description: karyopype is a Python-based tool designed for the rapid visualization of genomic data on a chromosomal scale.
homepage: http://github.com/jakevc/karyopype
---

# karyopype

## Overview

karyopype is a Python-based tool designed for the rapid visualization of genomic data on a chromosomal scale. It simplifies the process of overlaying specific genomic intervals—such as ChIP-seq peaks, variants, or custom regions of interest—onto standard chromosome maps. By providing a high-level interface to map BED files directly onto ideograms, it allows researchers to move from raw coordinates to a publication-ready genome-wide distribution plot with minimal code.

## Installation

Install the package via Bioconda or pip:

```bash
conda install -c bioconda karyopype
# OR
pip install karyopype
```

## Core Usage Patterns

### Python API (Recommended)
The most flexible way to use karyopype is within a Jupyter notebook or a Python script.

```python
import karyopype.karyopype as kp

# Plot a single set of genomic regions
kp.plot_karyopype("hg38", "/path/to/regions.bed")

# Plot multiple datasets to compare distributions
# This automatically adds a legend for the different files
kp.plot_karyopype("hg38", ["/path/to/set1.bed", "/path/to/set2.bed"])
```

### Command Line Execution
For quick generation of plots without writing a full script, use a Python one-liner:

```bash
python -c 'import karyopype.karyopype as kp; kp.plot_karyopype("hg38", "data.bed", savefig=True)'
```

## Expert Tips and Best Practices

- **Genome Builds**: Ensure the genome string (e.g., "hg38", "hg19", "mm10") matches the coordinates in your BED file.
- **File Formatting**: Input files must be valid BED format (tab-separated). If your BED file uses a non-standard separator, ensure it is pre-processed to be tab-delimited.
- **Saving Outputs**: When working in non-interactive environments (like a remote server), always set `savefig=True` to ensure the plot is written to disk in the current working directory.
- **Comparing Datasets**: When passing a list of BED files, karyopype assigns different colors to each set. This is highly effective for visualizing the overlap or exclusion of different epigenetic marks or transcription factor binding sites.
- **Memory Management**: For extremely large BED files (millions of rows), consider subsampling or merging overlapping regions before plotting to improve rendering speed, as the tool is optimized for regional visualization rather than base-pair resolution sequencing depth.

## Reference documentation
- [karyopype Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_karyopype_overview.md)
- [karyopype GitHub Documentation](./references/github_com_jakevc_karyopype.md)