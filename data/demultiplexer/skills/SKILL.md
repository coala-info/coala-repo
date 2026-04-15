---
name: demultiplexer
description: Demultiplexer sorts Illumina FASTQ files into sample-specific files by identifying inline tags or primer sequences within the read data. Use when user asks to demultiplex complex datasets, sort reads based on inline barcodes, or process sequencing data where standard index-based demultiplexing is insufficient.
homepage: https://github.com/DominikBuchner/demultiplexer
metadata:
  docker_image: "quay.io/biocontainers/demultiplexer:1.2.1--pyhdfd78af_0"
---

# demultiplexer

## Overview

`demultiplexer` is a Python-based utility designed to handle complex Illumina datasets where standard index-based demultiplexing is insufficient. It targets "inline" tags or specific primer sequences that reside within the actual read data rather than the index header. The tool processes FASTQ files by identifying these patterns at the start or end of reads and sorting them into sample-specific files based on a user-defined tagging scheme. While it includes a GUI for initial configuration, it provides a Python API for high-performance execution on servers or within automated pipelines.

## Installation

Install the tool via pip or bioconda:

```bash
pip install demultiplexer
# OR
conda install bioconda::demultiplexer
```

## Core Workflow

The tool relies on two configuration files typically generated via its GUI. Once these files exist, you can execute the demultiplexing process via a Python script or interpreter.

### 1. Required Configuration Files
*   **Primer Set (`.txt`)**: Defines the specific sequences (tags/primers) used in the library preparation.
*   **Tagging Scheme (`.xlsx`)**: An Excel file mapping specific primer combinations to sample names and input file paths.

### 2. Python API Usage
To run the tool on a server or in a headless environment, use the `main_cl` function:

```python
from demultiplexer.demultiplexing import main_cl

main_cl(
    primerset='path/to/Tutorial_primerset.txt',
    tagging_scheme='path/to/Tutorial_scheme.xlsx',
    output_folder='/path/to/output/dir',
    tag_removal=True,  # Set to True to strip the tags from the resulting reads
    cores_to_use=4     # Optional: defaults to (all available cores - 1)
)
```

## Expert Tips and Best Practices

*   **Case Sensitivity**: Ensure all primer sequences in your `primerset` file are in **UPPER CASE**. Lowercase sequences may cause the tool to fail to recognize matches, leading to empty output files.
*   **Path Portability**: If you generate the Tagging Scheme Excel file on a local machine (GUI) and move it to a server (CLI), you must open the Excel file and update the file paths to match the server's directory structure.
*   **File Pairing**: The tool automatically detects forward and reverse read pairs. Ensure your input files use consistent naming conventions for pairs, such as `_r1`/`_r2`, `_1`/`_2`, or `_A`/`_B`.
*   **Tag Removal Logic**: 
    *   Set `tag_removal=True` if you are using inline barcodes that are no longer needed for downstream analysis.
    *   Set `tag_removal=False` if the tags are part of the functional primer/adapter sequence that you intend to remove using a dedicated trimming tool (like Cutadapt) later in your pipeline.
*   **Resource Management**: By default, the tool attempts to use almost all CPU capacity (`N-1` cores). In shared HPC environments, always explicitly define `cores_to_use` to match your job allocation.

## Reference documentation

- [GitHub Repository Overview](./references/github_com_DominikBuchner_demultiplexer.md)
- [Known Issues and Troubleshooting](./references/github_com_DominikBuchner_demultiplexer_issues.md)