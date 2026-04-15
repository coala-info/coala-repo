---
name: plassembler
description: Plassembler automates the recovery and assembly of plasmids from bacterial genomes using hybrid or long-read sequencing data. Use when user asks to assemble plasmids, recover extrachromosomal elements, or perform hybrid assembly of bacterial sequences.
homepage: https://github.com/gbouras13/plassembler
metadata:
  docker_image: "quay.io/biocontainers/plassembler:1.8.2--pyhdfd78af_0"
---

# plassembler

## Overview

Plassembler is a specialized tool designed to automate the recovery and assembly of plasmids in bacterial genomes. By utilizing hybrid sequencing data, it overcomes the limitations of using either long or short reads alone, providing a fast and reliable way to identify extrachromosomal elements. It is particularly effective when used after chromosome recovery or as part of an automated assembly pipeline to ensure small or complex plasmids are not missed.

## Installation and Setup

Plassembler is primarily distributed via Bioconda. Before running assemblies, you must download the required database.

```bash
# Install via conda
conda install -c bioconda plassembler

# Download the mandatory database
plassembler download -d <database_directory>
```

## Common CLI Patterns

### Hybrid Assembly (Long + Short Reads)
The standard workflow for hybrid data requires long reads, paired-end short reads, and an estimated chromosome length.

```bash
plassembler run \
    -d <database_directory> \
    -l <long_read_fastq> \
    -1 <short_read_R1_fastq> \
    -2 <short_read_R2_fastq> \
    -c <estimated_chromosome_length_in_bp> \
    -o <output_directory>
```

### Long-Read Only Assembly
As of version 1.3.0, Plassembler supports assembly using only long reads (ONT or PacBio).

```bash
plassembler run \
    -d <database_directory> \
    -l <long_read_fastq> \
    -c <estimated_chromosome_length_in_bp> \
    -o <output_directory>
```

## Expert Tips and Best Practices

*   **Chromosome Estimation**: The `-c` (estimated chromosome length) parameter is critical for the tool to distinguish between chromosomal fragments and potential plasmids. Ensure this value is as accurate as possible based on the target species.
*   **Pre-processing**: For manual, high-quality "gold standard" assemblies, use **Trycycler** to recover the chromosome first, then use Plassembler to capture the plasmids.
*   **Automation**: If you are processing a large number of genomes, use **Hybracter**. Hybracter is a comprehensive pipeline that has Plassembler built-in, providing a more streamlined experience for batch processing.
*   **Resource Management**: Use the `--threads` flag to specify the number of CPU cores, as the assembly process (particularly the mapping and polishing stages) is computationally intensive.
*   **Intermediate Files**: If you need to troubleshoot or inspect the assembly graph, check the output directory for the `.gfa` files generated during the process.



## Subcommands

| Command | Description |
|---------|-------------|
| plassembler assembled | Runs assembled mode |
| plassembler download | Downloads Plassembler DB |
| plassembler long | Plassembler with long reads only |
| plassembler run | Runs Plassembler |
| plassembler_citation | Please cite plassembler in your paper using: |

## Reference documentation
- [plassembler README](./references/github_com_gbouras13_plassembler_blob_main_README.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_plassembler_overview.md)