---
name: targetdb
description: TargetDB is a bioinformatics tool that integrates multi-source data to identify, prioritize, and visualize the druggability of potential drug targets. Use when user asks to generate druggability reports for single genes or lists, perform binding pocket analysis, or create spider plots for target prioritization.
homepage: https://github.com/sdecesco/targetDB
---


# targetdb

## Overview
TargetDB is a bioinformatics tool designed to streamline the identification and prioritization of drug targets. It integrates data from multiple public sources—including ChEMBL, UniProt, and PubMed—to provide a unified view of a target's druggability. The tool supports single-target analysis, batch list processing, and visual prioritization via spider plots. It also incorporates structural analysis by using `fpocket` to identify and score potential binding sites.

## Installation and Setup
TargetDB requires a local SQLite database containing human genome data and ChEMBL information.

1.  **Environment**: It is recommended to run the tool within a Python virtual environment (Python >= 3.4).
2.  **Dependencies**: Install core requirements via `pip install -r requirements.txt`. External tools `blast` and `fpocket` must be installed and available in the system PATH for similarity searches and pocket detection.
3.  **Configuration**: On first run, the tool prompts for:
    *   Path to the SQLite database file.
    *   Output directories for list and detailed target reports.
    *   An email address (required for PubMed API access).
    *   Settings are stored in `~/.targetdb/config.ini`.

## Command Line Usage
The primary entry point for the application is the `druggability_report.py` script, which launches the graphical user interface (GUI).

```bash
# Standard execution to launch the GUI
python targetDB/druggability_report.py
```

### Operational Modes
*   **Single Mode**: Generates a detailed report for an individual gene symbol (e.g., BACE1).
*   **List Mode**: Processes a text file containing a list of gene symbols. This is ideal for prioritizing targets from omics studies or consortium data (e.g., AMP-AD lists).
*   **Spider Plot**: Creates a multi-parameter visualization to compare target strengths and weaknesses across different druggability metrics.

## Expert Tips and Best Practices
*   **Database Updates**: Always use the most recent version of the TargetDB SQLite database to ensure UniProt IDs and ChEMBL bioactivity data are current.
*   **Binding Pocket Analysis**: Note that `fpocket` integration is only supported on Linux and Mac. Windows users will not be able to perform automated binding site detection.
*   **PubMed Integration**: If you do not provide an email address during configuration, the tool will skip the literature search component, which may result in incomplete "Target Novelty" or "Disease Association" scores.
*   **Custom Prioritization**: When using List Mode, you can adjust the weights of different parameters (e.g., medicinal chemistry vs. structural biology focus) to influence the final MPO (Multi-Parameter Optimization) score.

## Reference documentation
- [TargetDB GitHub Repository](./references/github_com_sdecesco_targetDB.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_targetdb_overview.md)