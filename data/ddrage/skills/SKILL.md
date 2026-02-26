---
name: ddrage
description: This tool simulates sequencing reads from ddRADseq datasets. Use when user asks to simulate sequencing reads for analyzing and validating ddRADseq experimental designs.
homepage: https://bitbucket.org/genomeinformatics/rage
---


# ddrage

yaml
name: ddrage
description: Simulator for generating FASTQ reads from ddRADseq datasets. Use when you need to simulate sequencing reads for analyzing and validating ddRADseq experimental designs, with a ground truth YAML file for validation.
```

## Overview

The `ddrage` tool is a simulator designed for double digest restriction site associated DNA sequencing (ddRADseq) experiments. It generates simulated sequencing reads in FASTQ format, which can then be used for downstream analysis and validation against a provided ground truth YAML file. This is particularly useful for testing bioinformatics pipelines or exploring the impact of different experimental parameters on sequencing data.

## Usage Instructions

### Installation

To install `ddrage` using Conda:

```bash
conda install bioconda::ddrage
```

### Basic Simulation

The core functionality of `ddrage` involves simulating reads based on a configuration. The primary command requires specifying input parameters to define the simulation.

A typical command structure involves:

1.  **Specifying the reference genome or sequence:** This is often done with an option like `--ref` or `--genome`.
2.  **Defining restriction enzymes:** Use options like `--enzyme1` and `--enzyme2` to specify the enzymes used in the ddRADseq protocol.
3.  **Setting sequencing parameters:** This includes read length (`--readlen`), number of reads to generate (`--nreads`), and potentially other parameters like error rates or adapter sequences.
4.  **Outputting FASTQ files:** Specify the output file for the simulated reads, often with an option like `--out`.
5.  **Providing a ground truth file:** For validation, use an option like `--gtf` to point to the ground truth YAML file.

**Example Command Structure (Illustrative - actual options may vary based on tool version and specific needs):**

```bash
ddrage --ref path/to/your/genome.fasta \
       --enzyme1 EcoRI \
       --enzyme2 MseI \
       --readlen 100 \
       --nreads 1000000 \
       --out simulated_reads.fastq \
       --gtf ground_truth.yaml
```

### Key Parameters and Considerations

*   **`--ref` / `--genome`**: Path to the reference genome FASTA file. Ensure this is a valid and complete reference for your simulation.
*   **`--enzyme1`, `--enzyme2`**: The restriction enzymes used in the ddRADseq protocol. These are critical for defining the cut sites and thus the fragments that will be sequenced.
*   **`--readlen`**: The length of each simulated sequencing read.
*   **`--nreads`**: The total number of reads to generate for the simulation.
*   **`--out`**: The output filename for the generated FASTQ file.
*   **`--gtf`**: Path to the ground truth YAML file. This file contains information about the simulated fragments, their origins, and other metadata, crucial for validating the simulation.
*   **Adapter sequences**: Depending on the `ddrage` version and configuration, you might need to specify adapter sequences used in the library preparation. Consult the tool's documentation for specific options.
*   **Error simulation**: For more realistic simulations, explore options related to simulating sequencing errors, which are common in real sequencing data.

### Expert Tips

*   **Start with a small-scale simulation:** Before running large simulations, test your command with a smaller number of reads (`--nreads`) and potentially a subset of your reference genome to quickly iterate on parameters and ensure the command is correctly structured.
*   **Validate your ground truth file:** Ensure your `ground_truth.yaml` file is correctly formatted and contains all necessary information for validation. Errors in the GTF can lead to misleading validation results.
*   **Understand ddRADseq principles:** A good understanding of how ddRADseq works (enzyme choice, fragment size distribution, etc.) will help you set more appropriate simulation parameters in `ddrage`.
*   **Check tool version documentation:** Command-line options and their behavior can change between versions. Always refer to the specific documentation for the version of `ddrage` you have installed for the most accurate information.

## Reference documentation

- [Overview](./references/anaconda_org_channels_bioconda_packages_ddrage_overview.md)
- [Bitbucket](./references/bitbucket_org_genomeinformatics_rage.md)