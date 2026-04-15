---
name: rearr
description: The rearr tool analyzes CRISPR-sequencing data to identify complex genomic rearrangements and chimeric alignments. Use when user asks to identify genomic rearrangements, perform chimeric alignment, demultiplex CRISPR-seq reads, or remove duplicates from sequencing data.
homepage: https://github.com/ljw20180420/sx_lcy
metadata:
  docker_image: "quay.io/biocontainers/rearr:1.0.11--h9948957_0"
---

# rearr

## Overview
The `rearr` tool is a specialized bioinformatics package designed for the high-throughput analysis of CRISPR-sequencing data. It excels at identifying complex genomic rearrangements and chimeric alignments that standard aligners might miss. It provides a complete workflow from raw FASTQ processing—including duplicate removal and sgRNA-specific demultiplexing—to chimeric alignment and post-process visualization.

## Core CLI Usage

### Installation and Environment
The primary way to access the `rearr` command line is through Bioconda or Apptainer (formerly Singularity) to ensure all dependencies (Python, R, and C++ components) are correctly configured.

```bash
# Installation via Conda
conda install bioconda::rearr

# Running via Apptainer (Recommended for stability)
apptainer run docker://ghcr.io/ljw20180420/rearr:latest rearrangement -h
```

### Common Command Patterns
The main executable is `rearrangement`. Use the following patterns for standard CRISPR-seq workflows:

*   **Basic Alignment**: Perform chimeric alignment on processed reads.
    ```bash
    rearrangement align --input reads.fastq --reference genome.fa --output results/
    ```
*   **Demultiplexing**: Separate reads based on sgRNA markers or library indices.
    ```bash
    rearrangement demultiplex --fastq input.fastq --markers sgrna_list.txt
    ```

### Web Interface and Visualization
For users requiring a graphical overview of the workflow or interactive Shiny apps for post-processing:

1.  **Launch Local WebUI**: Requires Docker Compose.
    ```bash
    git clone https://github.com/ljw20180420/rearr.git
    cd rearr
    ./docker-images/compose.sh
    ```
2.  **Access Points**:
    *   Main Workflow: `http://localhost:80/workflow/`
    *   Visualization Apps: `http://localhost:80/shiny/`
    *   Task Monitoring: `http://localhost:80/flower/`

## Expert Tips
*   **Duplicate Removal**: Always run the duplicate removal step within the WebUI or via the `sx` module before alignment to reduce computational overhead and false signal inflation.
*   **Interactive Shell**: If debugging specific alignment parameters, use `apptainer shell docker://ghcr.io/ljw20180420/rearr:latest` to enter the container environment directly.
*   **Memory Management**: For large CRISPR libraries, monitor memory usage closely as the tool currently loads suffix arrays into memory for alignment speed.

## Reference documentation
- [rearr GitHub Repository](./references/github_com_ljw20180420_rearr.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_rearr_overview.md)