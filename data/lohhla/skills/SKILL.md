---
name: lohhla
description: This tool evaluates Human Leukocyte Antigen (HLA) loss from next-generation sequencing data. Use when user asks to analyze sequencing data to assess HLA loss, identify HLA allele dropout, or quantify HLA allele reduction.
homepage: https://bitbucket.org/mcgranahanlab/lohhla
metadata:
  docker_image: "quay.io/biocontainers/lohhla:20171108--hdfd78af_3"
---

# lohhla

yaml
name: lohhla
description: A computational tool to evaluate HLA loss using next-generation sequencing data. Use when Claude needs to analyze next-generation sequencing data to assess Human Leukocyte Antigen (HLA) loss. This includes tasks related to identifying and quantifying HLA allele dropout or loss.
```

## Overview

The `lohhla` tool is designed for analyzing next-generation sequencing (NGS) data to detect and evaluate the loss of Human Leukocyte Antigen (HLA) alleles. It helps in identifying instances where HLA alleles might be missing or significantly reduced in abundance within a sample.

## Usage Instructions

The `lohhla` tool is typically used via its command-line interface (CLI). While specific command structures can vary, the general approach involves providing input sequencing data and specifying parameters for analysis.

### Core Functionality

`lohhla` processes NGS data to identify HLA allele loss. This is crucial for applications in immunology, transplantation, and cancer research where HLA typing and its integrity are important.

### Common CLI Patterns and Tips

*   **Input Data**: Ensure your input sequencing data is in a compatible format (e.g., FASTQ, BAM). Consult the tool's documentation for exact requirements.
*   **Output**: The tool will likely generate reports or files detailing the identified HLA alleles and any instances of loss or dropout. Familiarize yourself with the output format to easily interpret the results.
*   **Parameter Tuning**: For optimal results, experiment with different parameters related to read mapping, allele calling thresholds, and statistical significance. Refer to the tool's detailed documentation for a comprehensive list of available options.
*   **Reference Genomes**: `lohhla` may require reference HLA allele sequences. Ensure you have the correct and up-to-date reference files available.

### Example Usage (Conceptual)

While specific commands are not provided in the source documentation, a typical workflow might look like this:

```bash
lohhla --input <path/to/your/sequencing_data.bam> --output <output_directory> --hla_alleles <path/to/hla_alleles.fasta> --threshold 0.05
```

*   `--input`: Specifies the path to your sequencing data file.
*   `--output`: Defines the directory where results will be saved.
*   `--hla_alleles`: Points to the reference file containing HLA allele sequences.
*   `--threshold`: Sets a significance threshold for calling HLA loss.

**Note**: The exact command-line arguments and their syntax may differ. Always refer to the official `lohhla` documentation for precise usage instructions.

## Reference documentation

- [lohhla Overview (Anaconda.org)](./references/anaconda_org_channels_bioconda_packages_lohhla_overview.md)
- [lohhla Bitbucket Repository](./references/bitbucket_org_mcgranahanlab_lohhla.md)