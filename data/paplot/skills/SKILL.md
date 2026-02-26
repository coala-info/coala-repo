---
name: paplot
description: Paplot transforms genomic analysis text data into interactive HTML reports for visualizing cancer genomics datasets. Use when user asks to generate QC reports, visualize chromosomal aberrations, create mutation matrices, or display mutational signatures.
homepage: https://github.com/Genomon-Project/paplot.git
---


# paplot

## Overview
The `paplot` tool transforms raw genomic analysis text data into interactive HTML reports. It is particularly effective for visualizing complex cancer genomics datasets, allowing researchers to explore mutations and structural variations through a web browser. Use this skill to construct the correct CLI commands for different report types and to understand the required input formats and output structures.

## Core Command Patterns

The basic syntax for all `paplot` report generation is:
`paplot <subcommand> <input> <output_dir> <project_name> [options]`

### Report Types and Subcommands

- **QC Report (`qc`)**: Visualizes sequencing quality metrics.
  - *Input*: CSV file containing QC metrics.
  - *Example*: `paplot qc data.csv ./results my_project`

- **Chromosomal Aberration (`ca`)**: Displays structural variations and rearrangements.
  - *Input*: CSV file with chromosomal break points.
  - *Example*: `paplot ca ca_data.csv ./results my_project`

- **Mutation Matrix (`mutation`)**: Creates a grid view of mutations across samples and genes.
  - *Input*: CSV file of mutation calls.
  - *Example*: `paplot mutation mut_data.csv ./results my_project`

- **Mutational Signature (`signature`)**: Visualizes mutational processes.
  - *Input*: JSON files (supports wildcards for multiple files).
  - *Example*: `paplot signature "path/to/data/*.json" ./results my_project`

- **pmsignature (`pmsignature`)**: Specifically for reports generated via the `pmsignature` R/Python package.
  - *Input*: JSON files.
  - *Example*: `paplot pmsignature "pmsig_data/*.json" ./results my_project`

## Expert Tips & Best Practices

- **Wildcard Handling**: When passing multiple JSON files to `signature` or `pmsignature` commands, always wrap the input path in quotes (e.g., `"data/*.json"`) to ensure the shell passes the pattern correctly to the tool.
- **Configuration Customization**: Use the `--config_file` flag to point to a custom `paplot.cfg`. This is essential for changing colors, thresholds, or specific plot behaviors without modifying the source code.
- **Report Metadata**: Enhance the generated reports by using the `--title`, `--overview`, and `--remarks` flags. This information is embedded directly into the HTML header and index page, which is critical for long-term project tracking.
- **Output Navigation**: `paplot` creates a directory structure. To view the results, always look for the `index.html` file in the root of the specified `<output_dir>`.
- **Environment**: Ensure Python 2.7+ is available. While the tool generates HTML, the generation process itself requires a Python environment where `paplot` is installed via conda or source.

## Reference documentation
- [GitHub - Genomon-Project/paplot](./references/github_com_Genomon-Project_paplot.md)