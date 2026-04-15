---
name: microview
description: MicroView generates interactive HTML reports and dashboards from taxonomic classification data. Use when user asks to create a summary report from Kraken or Kaiju results, visualize taxonomic data, or perform grouped analysis using a metadata table.
homepage: https://github.com/jvfe/microview
metadata:
  docker_image: "quay.io/biocontainers/microview:0.11.0--py312h031d066_0"
---

# microview

## Overview
MicroView is a reporting utility designed to bridge the gap between raw taxonomic classification data and interpretable insights. It processes output files from common bioinformatic classifiers to create a centralized, interactive HTML dashboard. This skill provides the necessary command-line patterns to generate these reports, whether you are scanning a directory of results or using a structured metadata table to define experimental groups and contrasts.

## Core Usage Patterns

### Basic Report Generation
To generate a report from a directory containing Kraken or Kaiju output files:
```bash
microview -t <directory_path>
```
*   **Default Output**: Creates `microview_report.html` in the current directory.
*   **Input Detection**: The tool automatically identifies supported result formats within the specified path.

### Grouped Analysis with Metadata
For complex experiments involving multiple conditions or groups, use a CSV mapping file:
```bash
microview -df contrast_table.csv -o custom_report.html
```
**CSV Structure Requirements**:
The metadata file must include a header and follow this format:
- `sample`: Filename or path to the result file.
- `group`: The experimental condition or category (e.g., "control", "treated").

### Key CLI Options
- `-t, --taxonomy`: Path to the directory containing taxonomic results.
- `-df, --dataframe`: Path to a CSV file defining samples and groups for comparative analysis.
- `-o, --output`: Specify a custom filename for the resulting HTML report.

## Expert Tips
- **Environment Setup**: MicroView is available via Bioconda. If the tool is missing, it can be installed using `conda install bioconda::microview`.
- **Data Preparation**: Ensure all result files in a directory use consistent formatting (e.g., all Kraken-style) to avoid parsing errors during aggregation.
- **Interactive Exploration**: The generated HTML report is self-contained. It can be shared and opened in any modern web browser without requiring additional dependencies or a web server.

## Reference documentation
- [MicroView GitHub Repository](./references/github_com_dalmolingroup_MicroView.md)
- [Bioconda MicroView Overview](./references/anaconda_org_channels_bioconda_packages_microview_overview.md)