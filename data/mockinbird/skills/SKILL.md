---
name: mockinbird
description: This tool provides a fully automatic and reproducible PAR-CLIP analysis pipeline. Use when user asks to process PAR-CLIP data, identify RNA-protein interactions, align reads, discover motifs, or predict binding sites.
homepage: https://github.com/soedinglab/mockinbird
---

# mockinbird

yaml
name: mockinbird
description: A fully automatic and reproducible PAR-CLIP analysis pipeline. Use when you need to process and analyze PAR-CLIP data to identify RNA-protein interactions, specifically for tasks involving sequence alignment, motif discovery, and binding site prediction.
---
## Overview

mockinbird is a bioinformatics pipeline designed for the automated and reproducible analysis of PAR-CLIP (Photoactivatable-Ribonucleoside-Enhanced Crosslinking and Immunoprecipitation) data. It streamlines the process of identifying RNA-protein interactions by analyzing sequencing reads to pinpoint crosslinking sites. This tool is particularly useful for researchers working with PAR-CLIP experiments who need to process raw sequencing data, identify binding sites, and perform downstream analysis like motif discovery.

## Usage Instructions

mockinbird is typically installed via Conda and run from the command line. The core functionality involves processing PAR-CLIP sequencing reads to identify crosslinking sites.

### Installation

The recommended installation method is using Conda:

```bash
conda create -n mockinbird -c bioconda -c conda-forge python=3.6 mockinbird
```

### Basic Usage

The primary command for running mockinbird is `mockinbird`. While specific command-line arguments can be extensive and depend on the exact analysis steps, the general workflow involves providing input files and configuration parameters.

**General Command Structure:**

```bash
mockinbird [options] <input_files>
```

**Key Considerations and Tips:**

*   **Input Files:** mockinbird expects sequencing reads as input, typically in FASTQ format. The exact naming and number of input files may vary depending on whether you are processing single-end or paired-end data.
*   **Configuration:** The pipeline often relies on a configuration file (e.g., in YAML format) to specify parameters for various analysis steps, such as adapter trimming, alignment, and peak calling. Refer to the tool's documentation for the structure and options of this configuration file.
*   **Reproducibility:** The pipeline is designed for reproducibility. Ensure you record the exact command-line arguments and configuration file used for your analysis.
*   **Output:** mockinbird generates various output files, including aligned reads, identified binding sites (peaks), and potentially motif analysis results. The specific output files and their formats will be detailed in the tool's documentation.
*   **Documentation:** For detailed information on all available options, configuration parameters, and specific analysis modules, consult the official mockinbird documentation. The documentation provides comprehensive guidance on setting up and running the pipeline for different experimental designs.

**Example (Conceptual - actual arguments may vary):**

```bash
mockinbird --config config.yaml --reads reads_R1.fastq.gz reads_R2.fastq.gz --output_dir ./results
```

This is a conceptual example. Always refer to the official documentation for the precise command-line syntax and available options.



## Subcommands

| Command | Description |
|---------|-------------|
| mockinbird flip_mate | flip the strand of the second read. Used for generating a normalizing pileup from a paired-end sequenced library |
| mockinbird postprocess | start postprocessing pipeline using a config script |
| mockinbird_preprocess | start preprocessing pipeline using a config script |

## Reference documentation

- [mockinbird: A fully automatic and reproducible PAR-CLIP analysis pipeline](./references/github_com_soedinglab_mockinbird.md)