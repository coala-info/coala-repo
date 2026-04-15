---
name: dimet
description: DIMet is a bioinformatics pipeline for the downstream analysis and visualization of tracer metabolomics data. Use when user asks to compare metabolic states between conditions, track labeling dynamics over time, or perform differential analysis on isotopologue distributions and metabolite pools.
homepage: https://github.com/cbib/DIMet.git
metadata:
  docker_image: "quay.io/biocontainers/dimet:0.2.4--pyhdfd78af_1"
---

# dimet

## Overview
DIMet is a specialized bioinformatics pipeline designed for the downstream analysis of tracer metabolomics data. It enables researchers to compare metabolic states between different experimental conditions or track labeling dynamics over time. The tool is specifically designed to work with data that has already been corrected for natural isotopologue abundance (e.g., via TraceGroomer). It supports three primary data types: isotopologue distributions, mean enrichment (fractional contribution), and total metabolite pools.

## Installation and Setup
DIMet requires a Unix-based environment (Linux or MacOS) and Python 3.9+.

*   **Conda (Recommended):** `conda install bioconda::dimet`
*   **Pip:** `pip install dimet`
*   **Containerized:** Use `docker pull quay.io/biocontainers/dimet:0.1.4` for reproducible environments.

## Core Functional Workflows
The tool is organized into two primary functional domains located within the source package:

1.  **Data Processing (`dimet.processing`):** Contains scripts for high-level analysis, including differential comparisons and time-series calculations.
2.  **Visualization (`dimet.visualization`):** Contains scripts for generating publication-quality figures and Metabolograms for pathway-based integration.

## Expert Tips and Best Practices
*   **Pre-processing Requirement:** DIMet is not a raw data processor. Ensure your input files have undergone natural abundance correction. If your data is not yet formatted or normalized, use the companion tool **TraceGroomer** before attempting to use DIMet.
*   **Input Types:** Clearly define which measure you are analyzing, as DIMet handles isotopologues, fractional contributions, and total abundances differently in its statistical models.
*   **Data Organization:** DIMet relies on a specific folder structure and configuration files. Before running analysis scripts, verify that your directory layout matches the requirements specified in the project's internal data initialization classes (`dimet.data`).
*   **Pathway Integration:** For biological interpretation, use the visualization module to generate Metabolograms, which map your isotope-labeling results onto metabolic pathways.

## Reference documentation
- [GitHub - cbib/DIMet](./references/github_com_cbib_DIMet.md)
- [bioconda / dimet - Anaconda.org](./references/anaconda_org_channels_bioconda_packages_dimet_overview.md)