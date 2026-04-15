---
name: chromograph
description: Chromograph transforms raw genomic data into PNG visualizations such as ideograms and coverage plots. Use when user asks to generate chromosomal ideograms, visualize coverage depth, plot regions of autozygosity, or visualize uniparental disomy.
homepage: https://github.com/Clinical-Genomics/chromograph
metadata:
  docker_image: "quay.io/biocontainers/chromograph:1.3.1--pyhdfd78af_2"
---

# chromograph

## Overview
Chromograph is a specialized Python-based tool for transforming raw genomic data into intuitive PNG visualizations. It is particularly useful for clinical genomics workflows where researchers need to visualize chromosomal abnormalities, coverage depth, or specific genetic regions like those found in UPD or autozygosity studies. The tool can be used both as a standalone command-line utility and as a Python library.

## CLI Usage Patterns

### Core Operations
Every command requires at least one operation flag. Multiple operations can be combined in a single call.

*   **Ideograms**: Generate chromosomal ideograms from a cytoband BED file.
    `chromograph --ideogram cytoband.bed --outd ./plots`
*   **Coverage**: Visualize depth of coverage from WIG files.
    `chromograph --coverage sample.wig --rgb #FF0000 --outd ./plots`
*   **Autozygosity (ROH)**: Plot regions of autozygosity.
    `chromograph --autozyg rhocall.bed --outd ./plots`
*   **UPD Visualization**: Plot UPD sites or regions.
    `chromograph --sites upd_sites.bed --regions upd_regions.bed --outd ./plots`

### Output Customization
*   **Image Size**: Use `--small`, `--medium`, or `--large` to control the output resolution (DPI).
*   **Consolidation**: Use `-x` or `--combine` to merge all generated graphs into a single output file instead of separate files per chromosome.
*   **Normalization**: Use `-n` or `--norm` to normalize WIG/coverage data for better comparison across samples.
*   **Consistency**: Use `-e` or `--euploid` to ensure a full set of chromosomal files is generated, even if some data files are empty.

## Data Format Requirements

| Data Type | Format | Required Columns |
| :--- | :--- | :--- |
| **Ideogram** | BED | `chrom`, `start`, `end`, `name`, `gStain` |
| **UPD Regions** | BED | `chrom`, `start`, `end`, `updType` |
| **Coverage** | WIG | `chrom`, `coverage`, `pos` |

## Library Integration
For integration into Python scripts, use the `chromograph` module directly:

```python
import chromograph as chrm

# Plotting an ideogram
chrm.plot_ideogram("path/to/cytoband.bed", 'combine', outdir="output_path")

# Plotting Regions of Heterozygosity (ROH) with normalization
chrm.plot_roh("path/to/file.bed", 'combine', 'normalize', outdir="output_path", step=5000)
```

## Expert Tips
*   **Step Size**: The default step size is 5000. Adjust this using `--step` if your WIG files have a different fixed step size to ensure accurate plotting.
*   **Color Coding**: When plotting coverage, use the `-k` flag with a hex code (e.g., `-k #0000FF`) to match the output to specific branding or clinical reporting standards.
*   **Memory Management**: For very large datasets, you can adjust the Matplotlib chunk size using `-u` or `--chunk` (default is 10000) to prevent rendering errors.

## Reference documentation
- [Chromograph GitHub Repository](./references/github_com_Clinical-Genomics_chromograph.md)
- [Chromograph Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_chromograph_overview.md)