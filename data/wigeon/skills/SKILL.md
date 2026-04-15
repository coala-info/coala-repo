---
name: wigeon
description: Manages and analyzes biological data, particularly related to genomics and bioinformatics. Use when user asks to analyze genomic sequences, process biological datasets, interact with bioinformatics databases or tools, or perform custom biological data manipulations.
homepage: https://github.com/alexmaybar/wigeonDB
metadata:
  docker_image: "biocontainers/wigeon:v20101212dfsg1-2-deb_cv1"
---

# wigeon

Manages and analyzes biological data, particularly related to genomics and bioinformatics.
  Use when Claude needs to perform tasks such as:
  - Analyzing genomic sequences.
  - Processing biological datasets.
  - Interacting with bioinformatics databases or tools.
  - Performing custom biological data manipulations.
  This skill is specifically for the 'wigeon' bioinformatics tool.
---
## Overview

The wigeon tool is designed for the analysis and manipulation of biological data, with a focus on genomics and bioinformatics workflows. It provides functionalities for processing biological sequences, interacting with relevant databases, and executing custom analytical tasks within the bioinformatics domain.

## Usage Instructions

Wigeon is a command-line tool. Its primary function is to process and analyze biological data.

### Core Commands and Patterns

While specific commands are not detailed in the provided documentation, typical bioinformatics tools often follow these patterns:

*   **Data Input**: Wigeon likely accepts input files in standard bioinformatics formats (e.g., FASTA, FASTQ, VCF, BAM). Specify input files using flags like `-i` or `--input`.
*   **Output Specification**: Define output files using flags like `-o` or `--output`.
*   **Analysis Type**: Commands will vary based on the type of analysis. Examples might include:
    *   Sequence alignment
    *   Variant calling
    *   Genome annotation
    *   Data filtering and manipulation
*   **Parameter Tuning**: Many commands will have specific parameters to control the analysis. Consult the tool's documentation for detailed options.

### Expert Tips

*   **Understand Input Formats**: Ensure your input data is in a format compatible with wigeon. Incorrect formats will lead to errors.
*   **Consult Documentation**: For detailed command syntax, available options, and specific use cases, always refer to the official wigeon documentation. The provided documentation does not contain specific CLI examples for wigeon, so external documentation is crucial.
*   **Version Management**: If wigeon is part of a larger bioinformatics suite (like those found on bioconda), be mindful of version compatibility with other tools in your pipeline.

## Reference documentation
- [Overview of wigeon on Anaconda.org](./references/anaconda_org_channels_bioconda_packages_wigeon_overview.md)