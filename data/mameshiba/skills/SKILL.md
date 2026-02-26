---
name: mameshiba
description: mameshiba is a lightweight distribution of the Shiba framework designed for the systematic identification of differential RNA splicing events. Use when user asks to identify differential splicing events, perform transcript assembly, or run the core Shiba splicing analysis pipeline.
homepage: https://github.com/Sika-Zheng-Lab/Shiba
---


# mameshiba

## Overview
mameshiba is a streamlined, minimal distribution of the Shiba computational framework. It is designed specifically for the systematic identification of differential RNA splicing (DSEs) across various platforms. While the full Shiba suite handles complex transcript assembly and single-cell workflows, mameshiba provides the essential dependencies required to run the core splicing analysis pipeline. It utilizes a four-step process involving transcript assembly, event identification, read counting, and statistical validation via Fisher's exact test.

## Installation
To set up the lightweight environment, use the following Conda command:

```bash
conda create -n mameshiba -c conda-forge -c bioconda mameshiba
conda activate mameshiba
```

*Note: If Excel-formatted outputs are required, you must manually install `styleframe==4.1` via pip.*

## Command Line Usage
The primary interface for mameshiba is the `shiba.py` script invoked with the `--mame` flag.

### Basic Execution
Run the core splicing analysis by specifying the number of threads and your configuration file:

```bash
shiba.py --mame -p [threads] [config_file]
```

### Parameters
- `--mame`: Activates the lightweight version of the Shiba pipeline.
- `-p`: Specifies the number of processor cores to use for parallel tasks like read counting and assembly.

## Workflow Steps
When running mameshiba, the tool executes the following procedural logic:
1. **Transcript Assembly**: Uses StringTie to assemble transcripts from provided RNA-seq reads.
2. **Splicing Event Identification**: Detects alternative mRNA splicing events from the assembled transcripts.
3. **Read Counting**: Employs RegTools and featureCounts to quantify reads mapped to identified junctions.
4. **Statistical Analysis**: Performs Fisher's exact test to determine differential splicing events between conditions.

## Expert Tips
- **Resource Management**: Always specify the `-p` flag to match your environment's CPU availability, as transcript assembly and read counting are computationally intensive.
- **Long-Read Support**: Although mameshiba is a minimal package, the underlying Shiba logic supports long-read RNA-seq data. Ensure your input files and configuration reflect the correct sequencing platform.
- **Visualization**: For downstream visualization of the splicing results, the companion tool `shiba2sashimi` is recommended to generate sashimi plots of identified events.

## Reference documentation
- [mameshiba - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_mameshiba_overview.md)
- [GitHub - Sika-Zheng-Lab/Shiba: A versatile method for systematic identification of differential RNA splicing across platforms](./references/github_com_Sika-Zheng-Lab_Shiba.md)