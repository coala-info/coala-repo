---
name: paplot
description: Paplot converts genomic data text files into interactive, browser-based visualization reports. Use when user asks to generate mutation reports, visualize structural variants, create quality control charts, or analyze mutational signatures.
homepage: https://github.com/Genomon-Project/paplot.git
metadata:
  docker_image: "quay.io/biocontainers/paplot:0.5.6--pyh5e36f6f_0"
---

# paplot

## Overview

Paplot (Post Analysis PLOT) is a specialized visualization tool for genomic data that converts static text files into interactive, browser-based graphs. Use this skill to automate the creation of comprehensive reports for sequencing projects. It is particularly effective for identifying trends in sample quality, mapping structural variants across chromosomes, and analyzing mutational profiles across large cohorts.

## Command Line Usage

The basic syntax for paplot follows a standard pattern:
`paplot <subcommand> <input_path> <output_dir> <project_name> [options]`

#

## Configuration and Customization

Paplot relies on a configuration file (`paplot.cfg`) to map input columns to plot elements and customize visual styles.

### Key Configuration Sections

- **[style]**: Define global paths and remarks.
- **[result_format_x]**: Map CSV column headers to paplot variables (e.g., `col_gene = Gene_Symbol`).
- **[qc_chart_x]**: Define specific stacks, colors, and titles for QC graphs.
- **[mutation]**: Set gene limits, group colors, and tooltip formats.

### Customizing Tooltips

Use the `tooltip_format` options in the config file to display specific metadata when hovering over plot elements.
- Example: `tooltip_format = [{chr1}] {break1:,}; [{chr2}] {break2:,} {type}`
- Supported placeholders include `{id}`, `{gene}`, `{group}`, and coordinate values like `{start}` or `{break1}`.

## Expert Tips

- **Custom Configs**: Always use the `-c` or `--config_file` flag to point to a project-specific configuration if your CSV headers do not match the defaults.
- **Project Organization**: Use a consistent `project_name` across different subcommands to ensure all reports are indexed together in the output directory.
- **Wildcard Inputs**: When processing signatures or pmsignatures, wrap the input path in quotes if using wildcards (e.g., `"data/*.json"`) to ensure the shell passes the pattern correctly to paplot.
- **Browser Compatibility**: Reports are optimized for modern browsers (Firefox, Chrome). If a report fails to render, check the console for path errors related to the generated Javascript files.



## Subcommands

| Command | Description |
|---------|-------------|
| paplot ca | paplot ca tool for generating reports |
| paplot index | Generate index for paplot output |
| paplot mutation | Generate mutation reports using paplot |
| paplot pmsignature | paplot pmsignature tool for generating reports |
| paplot qc | Quality control reporting tool for paplot |
| paplot signature | paplot signature tool for generating mutational signature reports |

## Reference documentation

- [Main README and Usage Guide](./references/github_com_Genomon-Project_paplot_blob_master_README.md)
- [CLI Argument Specifications](./references/github_com_Genomon-Project_paplot_blob_master_paplot.md)
- [Configuration File Template and Parameters](./references/github_com_Genomon-Project_paplot_blob_master_paplot.cfg.md)