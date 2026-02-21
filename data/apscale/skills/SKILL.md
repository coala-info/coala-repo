---
name: apscale
description: apscale (Advanced Pipeline for Simple yet Comprehensive AnaLysEs) is a Python-based command-line tool designed to streamline DNA metabarcoding workflows.
homepage: https://github.com/DominikBuchner/apscale
---

# apscale

## Overview

apscale (Advanced Pipeline for Simple yet Comprehensive AnaLysEs) is a Python-based command-line tool designed to streamline DNA metabarcoding workflows. It automates complex bioinformatic tasks by wrapping specialized tools like `vsearch`, `cutadapt`, and `swarm`. The pipeline is structured around a strict project directory system and utilizes an Excel-based configuration method, making it accessible for researchers who need a reproducible way to move from demultiplexed gzipped reads to final ESV/OTU tables.

## Project Initialization and Structure

Apscale operates within a specific directory hierarchy. Always begin by creating a new project folder to generate the required structure.

```bash
# Create a new project directory
apscale --create_project <PROJECT_NAME>
```

The command creates a folder containing subdirectories numbered `01` through `12`. 
- **Input Placement**: If starting with raw data, place files in `01_raw_data/data`. If starting with demultiplexed data, place them in `02_demultiplexing/data`.
- **Note**: Apscale does not handle demultiplexing. Ensure reads are already demultiplexed and gzipped before starting the pipeline.

## Configuration via Settings.xlsx

Upon project creation, a `Settings.xlsx` file is generated in the project root. This is the primary method for configuring the pipeline.

- **General Settings**: Use the `0_general_settings` tab to define CPU core usage and gzip compression levels (default is 6).
- **Primers**: You must provide the primer sequences in the respective module tabs.
- **Fragment Length**: Specify the expected fragment length (excluding primers) for quality filtering.
- **Module Specifics**: Each module (PE merging, trimming, denoising, etc.) has its own tab for fine-tuning parameters.

## Execution Patterns

Apscale can be run as a full suite or as individual modules.

### Full Workflow
To run the entire analysis (merging, trimming, filtering, and denoising) in one command:

```bash
# Run from within the project folder
apscale --run_apscale

# Run by providing the path to the project folder
apscale --run_apscale /path/to/project
```

### Individual Modules
If you need to re-run a specific step or process data incrementally, use the individual module flags (viewable via `apscale -h`). Common modules include:
- `--pe_merging`
- `--primer_trimming`
- `--quality_filtering`
- `--denoising`
- `--swarm_clustering`

## Expert Tips and Best Practices

- **Dependency Check**: Before running, verify that `vsearch`, `swarm`, and `cutadapt` are correctly installed and accessible in your system PATH by running `vsearch --version`, `swarm --version`, and `cutadapt --version`.
- **Compression Trade-offs**: If processing speed is a priority, lower the compression level in `Settings.xlsx`. If disk space is limited, increase it to 9.
- **Memory Management**: By default, apscale uses all available cores minus two. If running on a shared cluster or performing other heavy tasks, manually lower the 'cores to use' value in the Excel settings.
- **Output**: Final results, including ESV/OTU tables and a comprehensive project report, are stored in the `11_read_table` and `12_analyze` folders.

## Reference documentation
- [apscale GitHub README](./references/github_com_DominikBuchner_apscale.md)
- [apscale Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_apscale_overview.md)