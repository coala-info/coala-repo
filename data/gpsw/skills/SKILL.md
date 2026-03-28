---
name: gpsw
description: "Tool for analyzing Global Protein Stability (GPS) Profiling data. Use when user asks to process and analyze GPS data to study protein stability or degron identification."
homepage: https://github.com/niekwit/gps-orfeome
---

# gpsw

yaml
name: gpsw
description: |
  Tool for analyzing Global Protein Stability (GPS) Profiling data.
  Use when you need to process and analyze GPS data, typically generated from genetic screens, to study protein stability or degron identification at a large scale.
  This skill is suitable for users who have GPS profiling data and require a robust workflow for its analysis.
```
## Overview
GPSW is a powerful tool designed for the analysis of Global Protein Stability (GPS) Profiling data. It acts as a wrapper around a Snakemake workflow, enabling large-scale, unbiased study of protein stability and degron identification. Use GPSW when you have raw GPS profiling data and need to perform comprehensive analysis to understand protein behavior.

## Usage Instructions

GPSW is installed via Conda. The primary interaction with GPSW is through its command-line interface, which orchestrates the underlying Snakemake workflow.

### Installation

To install GPSW, use Conda:

```bash
conda install bioconda::gpsw
```

### Basic Workflow

The core functionality of GPSW involves running the analysis workflow on your GPS profiling data. While specific command-line arguments are not detailed in the provided documentation, the general approach involves invoking the `gpsw` command, likely followed by parameters specifying input data and desired output.

**General Command Structure (Illustrative):**

```bash
gpsw --input <path_to_input_data> --output <path_to_output_directory> [other_options]
```

*   **`--input`**: Specifies the path to your GPS profiling data files. The exact format of these files is not detailed but is expected to be compatible with the workflow.
*   **`--output`**: Defines the directory where the analysis results will be saved.

### Key Considerations and Tips

*   **Snakemake Backend**: GPSW utilizes Snakemake for its workflow management. This implies that the underlying analysis steps are containerized and reproducible.
*   **Data Requirements**: Ensure your input data is correctly formatted and organized before running the analysis. Refer to the project's documentation for specific data format requirements.
*   **Configuration**: Advanced users might need to configure aspects of the Snakemake workflow. While direct configuration details are not provided, understanding Snakemake's configuration practices (e.g., `config.yaml` files) might be beneficial for customization.
*   **Post-Analysis Tools**: The project also mentions "post-analysis scripts" for further analysis and figure generation, available in a separate repository (`gps-orfeome-tools`). This suggests that GPSW's primary role is the core data processing, with additional tools available for downstream tasks.



## Subcommands

| Command | Description |
|---------|-------------|
| gpsw | GPSW: A tool for analysing and processing Global Protein Stability Profiling data. |
| gpsw_fetch | Fetch GPSW code from a specific release from https://github.com/niekwit/gps-orfeome. |
| gpsw_run | Run the GPSW pipeline and create report. |

## Reference documentation
- [GPSW Overview on Anaconda.org](./references/anaconda_org_channels_bioconda_packages_gpsw_overview.md)
- [GPSW GitHub Repository](./references/github_com_niekwit_gps-orfeome.md)