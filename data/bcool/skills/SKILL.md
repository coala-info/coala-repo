---
name: bcool
description: "BCOOL improves the accuracy of NGS reads by aligning them to a de Bruijn graph to correct sequencing errors. Use when user asks to correct sequencing artifacts in NGS data, improve read accuracy for downstream assembly, or filter noise from genomic reads using graph alignment."
homepage: https://github.com/Malfoy/BCOOL
---


# bcool

## Overview
BCOOL (de Bruijn graph cOrrectiOn from graph aLignment) is a specialized tool for improving the accuracy of NGS reads. It functions by constructing a de Bruijn graph from the input data and then aligning the original reads back to this graph. By leveraging the graph's connectivity and abundance information, BCOOL can distinguish between true genomic variations and sequencing artifacts, providing a corrected set of reads that typically results in better downstream assembly contiguity and accuracy.

## Installation and Environment
The most reliable way to use BCOOL is via Bioconda, which handles its complex dependencies (Bcalm2, Bgreat2, Btrim, and Ntcard).

```bash
conda install bioconda::bcool
```

If building from source, ensure you have GCC >= 4.9.1, CMAKE >= 3.3, and Python 3. Use the `-t` flag during installation to speed up compilation:
```bash
./install.sh -t 8
```

## Common CLI Patterns

### Basic Correction
The simplest execution requires an input file and an output directory.
```bash
Bcool.py -u reads.fastq -o output_directory
```

### High-Performance Execution
For large datasets, always specify the thread count to utilize multi-core processors.
```bash
Bcool.py -u reads.fastq -o output_directory -t 20
```

### Manual K-mer Selection
By default, BCOOL uses `ntcard` to estimate the optimal k-mer size. If you have a specific k-mer size required for your assembly strategy, set it manually:
```bash
Bcool.py -u reads.fastq -o output_directory -k 63
```

## Expert Tips and Parameter Tuning

### Graph Cleaning and Filtering
BCOOL uses two levels of filtering to remove noise from the graph:
- **K-mer filtering (`-s`)**: K-mers appearing fewer than `s` times are excluded from the initial graph construction. Increase this for high-coverage data to reduce memory usage and noise (default: 2).
- **Unitig filtering (`-S`)**: Unitigs with an average abundance lower than `S` are removed before correction. This is the primary mechanism for removing "tips" and "bubbles" caused by errors (default: 5).

### Alignment Sensitivity
- **Anchor Size (`-a`)**: This defines the seed size for alignment. Lowering this value (e.g., `-a 31`) increases sensitivity for highly erroneous reads but significantly decreases throughput. Increasing it (e.g., `-a 51`) speeds up the process but may miss corrections in high-error regions (default: 41).
- **Mapping Effort (`-e`)**: Controls how many seeds are tested. For maximum sensitivity, leave as "all". For faster processing on very deep coverage, you can set a specific integer limit.
- **Mismatches (`-m`)**: Adjust the number of allowed mismatches for an alignment to be considered valid.

### Troubleshooting Output
If the `reads_corrected.fa` file is empty, check the following:
1. **K-mer Abundance**: If your sequencing depth is low, the default filtering (`-s 2`, `-S 5`) might be too aggressive, causing the graph to be empty. Try lowering these values.
2. **Memory/Disk Space**: BCOOL generates intermediate graph files (via Bcalm2) which can be quite large. Ensure the working directory has sufficient space.

## Reference documentation
- [bcool - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_bcool_overview.md)
- [GitHub - Malfoy/BCOOL: de Bruijn graph cOrrectiOn from graph aLignment](./references/github_com_Malfoy_BCOOL.md)