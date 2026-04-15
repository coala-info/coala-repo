---
name: metawatt
description: Metawatt compares and analyzes energy transition scenarios from various sources. Use when user asks to compare different energy transition scenarios, analyze data related to electricity transition pathways, or understand energy scenarios from French agencies.
homepage: https://github.com/edhelas/metawatt
metadata:
  docker_image: "quay.io/biocontainers/metawatt:3.5.3--boost1.64_0"
---

# metawatt

Compares and analyzes energy transition scenarios from various sources (ADEME, RTE, negaWatt, etc.).
  Use when Claude needs to:
  - Compare different energy transition scenarios.
  - Analyze data related to electricity transition pathways.
  - Understand or visualize energy scenarios from French agencies.
---
## Overview

Metawatt is a tool designed for comparing and analyzing energy transition scenarios, particularly those from French organizations like ADEME, RTE, and negaWatt. It allows users to visualize and understand the differences and implications of various energy pathways.

## Usage Instructions

Metawatt is primarily a command-line tool. While the provided documentation focuses on its web interface and GitHub repository, the core functionality revolves around comparing and visualizing energy scenario data.

### Core Functionality

The primary purpose of Metawatt is to ingest and compare data from different energy scenario providers. This involves:

1.  **Data Ingestion**: Metawatt likely processes data files that define various energy scenarios. The exact format of these input files is not detailed in the provided documentation, but they would typically contain parameters, projections, and metrics for each scenario.
2.  **Comparison and Visualization**: The tool then generates visualizations and comparative analyses based on this data. This allows users to see trends, differences, and potential outcomes across scenarios.

### Expert Tips and Best Practices

*   **Understand the Data Sources**: Familiarize yourself with the organizations whose scenarios Metawatt uses (ADEME, RTE, negaWatt). Understanding their methodologies and data sources will provide crucial context for interpreting Metawatt's outputs.
*   **Focus on Scenario Definitions**: When working with Metawatt, pay close attention to how each scenario is defined. The differences in assumptions, technologies, and policy targets will be the key drivers of the observed outcomes.
*   **Leverage GitHub for Insights**: The GitHub repository (`edhelas/metawatt`) is the best source for understanding the tool's development, recent updates, and potential issues.
    *   **Commits**: Reviewing the commit history (`github_com_edhelas_metawatt_commits_main.md`) can reveal recent data updates, bug fixes, and new features related to specific energy scenarios or data sources.
    *   **Issues**: The issues section (`github_com_edhelas_metawatt_issues.md`) can provide insights into known problems, feature requests, and discussions about data accuracy or scenario interpretations.
*   **Installation**: For local use, refer to the installation instructions on bioconda (`anaconda_org_channels_bioconda_packages_metawatt_overview.md`) or potentially through other package managers if available. The `conda install bioconda::metawatt` command is the primary method mentioned.

### Command-Line Usage (Inferred)

While specific CLI commands are not provided, a tool of this nature would typically involve commands for:

*   **Loading/Importing Scenarios**: A command to specify the data files or sources to be loaded.
*   **Comparing Scenarios**: A command to select specific scenarios for comparison.
*   **Generating Visualizations**: A command to output charts or reports.

Given the focus on comparison and visualization, expect commands that allow selection of scenarios and output formats.

## Reference documentation

- [Metawatt Overview on Anaconda.org](./references/anaconda_org_channels_bioconda_packages_metawatt_overview.md)
- [Metawatt GitHub Repository](./references/github_com_edhelas_metawatt.md)
- [Metawatt Commits History](./references/github_com_edhelas_metawatt_commits_main.md)
- [Metawatt Issues on GitHub](./references/github_com_edhelas_metawatt_issues.md)