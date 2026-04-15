---
name: marti
description: MARTi processes and analyzes metagenomic sequencing data in real time to provide taxonomic profiles and antimicrobial resistance insights. Use when user asks to analyze streaming Nanopore data, generate taxonomic classifications, detect AMR genes, or visualize metagenomic results through a web-based GUI.
homepage: https://github.com/richardmleggett/MARTi
metadata:
  docker_image: "quay.io/biocontainers/marti:0.9.29--hdfd78af_0"
---

# marti

## Overview
MARTi (Metagenomic Analysis in Real Time) is a specialized suite designed to process and analyze metagenomic sequencing data as it is generated. While optimized for the streaming nature of Nanopore sequencing, it is also effective for offline analysis of existing datasets. It automates the workflow from raw data to visualization, providing taxonomic profiles and AMR insights through a dedicated engine and a web-based GUI.

## Installation and Setup
MARTi is primarily distributed via Bioconda. Ensure your environment is configured with the necessary channels before installation.

```bash
# Install MARTi via conda
conda install bioconda::marti
```

## Configuration and Metadata
Before running an analysis, MARTi requires a configuration file. Use the built-in flag to generate a template that includes the necessary metadata blocks.

- **Generate Template**: Run `marti -writeconfig` to create a configuration file. This will include empty metadata blocks (or multiple blocks if the run is barcoded) and comments explaining the required fields.
- **Metadata Requirements**: Ensure the metadata blocks are correctly filled to allow the GUI to properly group and display sample information.

## Core Components and Workflow
MARTi operates using two main components: the **Engine** and the **GUI**.

1.  **The Engine**: This is the backend process that monitors folders for new FASTQ files, triggers classifiers, and generates JSON output (e.g., `amr.json`).
2.  **Classifiers**: MARTi acts as an orchestrator for several external tools. Ensure the following are installed and accessible in your PATH if you intend to use them:
    *   **Kraken2**: High-speed taxonomic classification.
    *   **Centrifuge**: Memory-efficient classification.
    *   **BLAST**: Traditional sequence alignment for high-sensitivity searches.
3.  **AMR Analysis**: MARTi includes specific logic for Antimicrobial Resistance detection, producing standardized JSON reports for downstream visualization.

## Expert Tips and Best Practices
- **Real-Time Monitoring**: Point the MARTi engine to the output directory of your sequencer (e.g., the `fastq_pass` folder of a MinKNOW run) to begin analysis immediately as files are written.
- **Job Scheduling**: For large datasets or high-throughput environments, MARTi utilizes a `SimpleJobScheduler` to manage concurrent classification tasks. Monitor the logs to ensure Kraken2 or Centrifuge jobs are completing successfully; the engine is designed to abort if these critical dependencies fail.
- **Resource Management**: Metagenomic analysis is resource-intensive. When using Kraken2 or BLAST, ensure the host system has sufficient RAM for the database being utilized.
- **GUI Visualization**: Use the MARTi GUI to view results in real-time. It provides stacked bar charts and other interactive visualizations based on the JSON data produced by the engine.

## Reference documentation
- [MARTi Overview on Anaconda](./references/anaconda_org_channels_bioconda_packages_marti_overview.md)
- [MARTi GitHub Repository](./references/github_com_richardmleggett_MARTi.md)
- [MARTi Tags and Versioning](./references/github_com_richardmleggett_MARTi_tags.md)