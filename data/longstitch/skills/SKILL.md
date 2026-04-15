---
name: longstitch
description: LongStitch corrects and scaffolds genome assemblies using long sequencing reads. Use when user asks to correct genome assemblies, scaffold genome assemblies, improve genome assembly quality, or refine genome assembly contiguity.
homepage: https://bcgsc.ca/resources/software/longstitch
metadata:
  docker_image: "quay.io/biocontainers/longstitch:1.0.5--hdfd78af_1"
---

# longstitch

yaml
name: longstitch
description: A genome assembly correction and scaffolding pipeline using long reads. Use when needing to improve the quality of genome assemblies generated from long sequencing reads by correcting errors and adding structural information. This is particularly useful for de novo assembly projects where read errors or gaps can hinder downstream analysis.
```

## Overview
LongStitch is a powerful pipeline designed to enhance genome assemblies derived from long sequencing reads. It addresses common issues in de novo assembly, such as base-level errors and structural gaps, by employing a multi-stage approach that includes initial assembly correction and subsequent scaffolding. This process leads to more contiguous and accurate genome reconstructions, crucial for various genomic research applications.

## Usage Instructions

LongStitch is a command-line tool. The primary workflow involves providing an initial assembly and long-read sequencing data.

### Core Command Structure

The general structure for running LongStitch is as follows:

```bash
longstitch -a <assembly.fasta> -l <long_reads.fastq.gz> -o <output_directory> [options]
```

### Key Parameters

*   `-a, --assembly`: Path to the initial genome assembly in FASTA format. This is the assembly that LongStitch will correct and scaffold.
*   `-l, --long_reads`: Path to the long sequencing reads in FASTQ format (gzipped is supported). These reads are used for error correction and scaffolding.
*   `-o, --output_dir`: Directory where all output files will be saved.

### Stages and Options

LongStitch operates in up to three stages:

1.  **Initial Assembly Correction (Tigmint-long)**: This stage corrects base-level errors in the input assembly.
    *   To explicitly control this stage or its parameters, refer to the LongStitch documentation for Tigmint-long specific options. Often, this stage runs by default if not explicitly disabled.

2.  **Incremental Scaffolding (ntLink)**: This stage uses the corrected assembly and long reads to build longer contiguous sequences (scaffolds) by identifying overlaps.
    *   `--ntlink_threads <int>`: Number of threads to use for ntLink.
    *   `--ntlink_memory <int>`: Memory limit for ntLink in GB.

3.  **Incremental Scaffolding (ARKS-long)**: A second scaffolding stage that further refines and extends scaffolds.
    *   `--arks_threads <int>`: Number of threads to use for ARKS-long.
    *   `--arks_memory <int>`: Memory limit for ARKS-long in GB.

### Advanced Usage and Tips

*   **Resource Management**: LongStitch can be resource-intensive. Carefully manage the number of threads (`--ntlink_threads`, `--arks_threads`) and memory (`--ntlink_memory`, `--arks_memory`) based on your available computational resources.
*   **Output Files**: The output directory will contain corrected assemblies, scaffolds, and potentially intermediate files. The primary output of interest is usually the final scaffolded FASTA file.
*   **Citation**: If you use LongStitch in your research, please cite:
    Coombe L, Li JX, Lo T, Wong J, Nikolic V, Warren RL and Birol I. LongStitch: high-quality genome assembly correction and scaffolding using long reads. BMC Bioinformatics 22, 534 (2021). https://doi.org/10.1186/s12859-021-04451-7

## Reference documentation
- [LongStitch Overview](./references/bcgsc_ca_resources_software_longstitch.md)
- [LongStitch on Bioconda](./references/anaconda_org_channels_bioconda_packages_longstitch_overview.md)