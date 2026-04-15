---
name: fastcov
description: fastcov is a high-performance utility that transforms indexed BAM files into visual coverage plots or CSV data. Use when user asks to generate genomic coverage plots, visualize depth across specific regions, or export alignment coverage to CSV format.
homepage: https://github.com/RaverJay/fastcov
metadata:
  docker_image: "quay.io/biocontainers/fastcov:0.1.3--hdfd78af_0"
---

# fastcov

## Overview
fastcov is a high-performance Python utility designed to transform indexed BAM files into visual coverage plots. It leverages parallel processing to handle multiple samples efficiently and uses the Seaborn library to produce high-quality outputs. Whether you need a quick look at a specific gene locus or a log-scaled overview of a viral genome, fastcov provides a streamlined command-line interface to move from alignment data to visualization without the overhead of a full genome browser.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::fastcov
```

## Common CLI Patterns

### Basic Coverage Plot
Generate a default PDF plot (`fastcov_output.pdf`) using the first reference found in the first BAM file:
```bash
fastcov.py sample1.bam sample2.bam
```

### Target Specific Regions
Specify a genomic position using the format `<ref_name>[:<start>-<stop>]`. Coordinates are 1-based and inclusive.
*   **Specific range**: `fastcov.py -p chr1:1000-2000 sample.bam`
*   **From start to point**: `fastcov.py -p chr1:-500 sample.bam`
*   **From point to end**: `fastcov.py -p chr1:500- sample.bam`
*   **Whole chromosome**: `fastcov.py -p chr1 sample.bam`

### Visual Customization
*   **Logarithmic Scale**: Use `-l` to apply a log scale to the y-axis, which is useful for samples with highly variable depth (e.g., RNA-seq or viral amplicons).
    ```bash
    fastcov.py -l -o log_coverage.png sample.bam
    ```
*   **Output Format**: The output format is determined by the file extension provided to the `-o` flag (e.g., .pdf, .png, .jpg).

### Data Extraction
If you need the raw numbers instead of a plot, use the CSV output options:
*   **Save to file**: `fastcov.py -c data.csv sample.bam`
*   **Stream to stdout**: `fastcov.py -c - sample.bam`
*   **Clean data (no headers)**: `fastcov.py -c data.csv --csv_no_header sample.bam`

## Expert Tips
*   **Index Requirement**: fastcov requires indexed BAM files. Ensure your `.bam` files have corresponding `.bai` files in the same directory before running.
*   **Parallel Processing**: The tool automatically processes multiple input BAM files in parallel. When working with many samples, ensure your environment has sufficient CPU cores to take advantage of this.
*   **Reference Fallback**: If you do not provide the `-p` argument, fastcov defaults to the first reference sequence it encounters. For multi-contig assemblies (like a whole human genome), always specify the region to avoid unexpected or overly large plots.
*   **Combining Outputs**: By default, specifying `-c` (CSV output) disables the plot. To get both the data and the image in one command, explicitly provide the `-o` flag alongside `-c`.

## Reference documentation
- [fastcov GitHub Repository](./references/github_com_RaverJay_fastcov.md)
- [Bioconda fastcov Package Overview](./references/anaconda_org_channels_bioconda_packages_fastcov_overview.md)