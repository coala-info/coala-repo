---
name: corgi
description: corgi (Classifier for ORganelle Genomes Inter alia) is a deep-learning tool designed to identify and classify organelle sequences from genomic data.
homepage: https://pypi.org/project/bio-corgi/
---

# corgi

## Overview

corgi (Classifier for ORganelle Genomes Inter alia) is a deep-learning tool designed to identify and classify organelle sequences from genomic data. It leverages PyTorch and Lightning to provide a high-performance command-line interface for bioinformatics workflows, specifically targeting the detection of mitochondrial and plastid DNA which can often be difficult to distinguish in complex metagenomic samples.

## Installation

Install the package using one of the following methods:

- **Pip**: `pip install bio-corgi` (Note: Do not use `pip install corgi` as it is an unrelated package).
- **Conda**: `conda install bioconda::corgi`

## Command Line Usage

### Basic Classification
To run predictions on a sequence file and output the results to a CSV:
`corgi --input <input_file> --output-csv <output_file.csv>`

### Supported Input Formats
The tool automatically detects and processes the following formats (uncompressed or GZipped):
- FASTA (`.fasta`, `.fa`)
- FASTQ (`.fastq`, `.fq`)
- GenBank (`.gb`, `.gbk`)
- Remote URLs (e.g., `https://example.com/data.fasta`)

### Model Training and Utilities
For advanced users looking to train custom models or use auxiliary tools:
`corgi-tools --help`

## Best Practices and Tips

- **Input Flexibility**: You can pass a direct URL to the `--input` flag, allowing you to process data hosted on public repositories without downloading it manually first.
- **Output Analysis**: The resulting CSV contains classification probabilities. Use these to filter high-confidence organelle contigs before downstream assembly or annotation.
- **Environment**: Ensure you are using Python 3.10, 3.11, or 3.12, as version 3.13 is currently not supported.
- **Help Command**: Use `corgi --help` to see additional parameters for batch size or hardware acceleration (GPU usage) if supported by your environment.

## Reference documentation

- [bioconda / corgi Overview](./references/anaconda_org_channels_bioconda_packages_corgi_overview.md)
- [bio-corgi PyPI Project Description](./references/pypi_org_project_bio-corgi.md)
- [bio-corgi 0.5.1 Release Details](./references/pypi_org_project_bio-corgi_0.5.1.md)