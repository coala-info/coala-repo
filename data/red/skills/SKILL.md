---
name: red
description: Red is a bioinformatics tool for the automated de-novo discovery and masking of genomic repeats using machine learning. Use when user asks to identify repetitive elements, mask genomes, or annotate genomic repeats.
homepage: http://toolsmith.ens.utulsa.edu
metadata:
  docker_image: "quay.io/biocontainers/red:2018.09.10--h9948957_3"
---

# red

## Overview
Red is a specialized bioinformatics tool used for the automated discovery of genomic repeats. Unlike library-based methods, it uses a machine learning-based approach to identify repetitive elements de-novo. This skill provides the necessary CLI patterns for installing and executing Red on Linux environments to mask or annotate genomes.

## Installation
The tool is primarily distributed via Bioconda. Ensure you have a functional Conda or Mamba environment.

```bash
conda install -c bioconda red
```

## Usage Patterns
Red typically requires an input directory containing genome files (FASTA format) and an output directory for the results.

### Basic Repeat Detection
To run Red with default parameters on a set of genomic sequences:
```bash
Red -gnm <input_directory> -out <output_directory>
```

### Common CLI Options
- `-gnm`: Path to the directory containing the input genome files (FASTA).
- `-out`: Path to the directory where the masked genomes and repeat coordinates will be saved.
- `-msk`: (Optional) Specify masking options if the default behavior needs adjustment.
- `-frm`: (Optional) Change the output format of the detected repeats.

## Best Practices
- **Input Preparation**: Ensure all FASTA files are in a single directory, as Red processes directories rather than individual files.
- **Resource Allocation**: Red is designed for speed and can handle large genomes; however, ensure sufficient disk space in the output directory for masked versions of the input files.
- **Platform Compatibility**: Note that the latest versions are optimized for `linux-64`. If working on macOS, you may need to use an older version (2015.05.22) or a containerized environment.

## Reference documentation
- [Red Overview](./references/anaconda_org_channels_bioconda_packages_red_overview.md)