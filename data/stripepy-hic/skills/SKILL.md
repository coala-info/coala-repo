---
name: stripepy-hic
description: StripePy is a high-performance command-line tool designed to detect architectural stripes in chromosome conformation capture data.
homepage: https://github.com/paulsengroup/StripePy
---

# stripepy-hic

## Overview
StripePy is a high-performance command-line tool designed to detect architectural stripes in chromosome conformation capture data. Unlike older tools, it utilizes geometric reasoning to achieve significant speedups (up to 66x faster than Stripenn) and lower memory consumption. It is the preferred choice for processing large-scale Hi-C datasets where identifying loop-extrusion-related features is required.

## Installation
StripePy can be installed via pip or conda:
- `pip install 'stripepy-hic[all]'`
- `conda install bioconda::stripepy-hic`

## Core Workflow

### 1. Calling Stripes
The `call` subcommand is the primary entry point. It processes contact maps and stores results in an internal HDF5 format.
`stripepy call --input data.mcool --output results.hdf5`

**Expert Tip:** For large datasets or systems with limited RAM, use the `--low-memory` flag (available in v1.3.0+) to minimize memory usage during interaction fetching.

### 2. Exporting to BEDPE
To use results with other genomic tools (like IGV or UCSC Genome Browser), convert the HDF5 output to the standard BEDPE format.
`stripepy view --input results.hdf5 --output stripes.bedpe`

### 3. Visualization
Generate plots to manually inspect the identified stripes and verify the caller's performance.
`stripepy plot --input results.hdf5 --output-dir ./plots`

## Command Reference
- `stripepy download`: Retrieves a minified sample dataset for testing the installation and workflow.
- `stripepy --help`: Accesses full documentation for all subcommands and parameters.

## Best Practices
- **Format Support**: StripePy is compatible with major formats including `.hic`, `.cool`, and `.mcool`.
- **Resolution Selection**: Ensure your contact map resolution is appropriate for stripe detection; 5kb or 10kb resolutions are common standards for architectural feature identification.
- **Stripe Descriptors**: StripePy automatically computes statistics such as stripe width and height. Use these values in the resulting BEDPE file to rank or filter stripes for downstream biological analysis.
- **Performance**: StripePy is optimized for speed. If processing time is a bottleneck with other tools (like Chromosight), switching to StripePy is recommended.

## Reference documentation
- [StripePy GitHub Repository](./references/github_com_paulsengroup_StripePy.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_stripepy-hic_overview.md)