---
name: mageck-vispr
description: MAGeCK-VISPR generates interactive web-based visualizations and quality control reports for CRISPR/Cas9 screening data processed by the MAGeCK pipeline. Use when user asks to visualize screening results, set up configuration files for VISPR, run the visualization server, or generate static quality control reports.
homepage: https://bitbucket.org/liulab/mageck-vispr
---


# mageck-vispr

## Overview
MAGeCK-VISPR is a specialized companion tool for the MAGeCK pipeline. It transforms raw screening data and MAGeCK analysis outputs into interactive, web-based visualizations. Use this skill to guide the setup of configuration files, execution of the VISPR server, and the generation of comprehensive QC reports that help identify screen outliers, library bias, and significant gene hits.

## Core Workflow and CLI Patterns

### 1. Configuration Setup
VISPR requires a configuration file (typically `config.yaml`) to define the study metadata, fastq files, and library design.
- **Essential Fields**: Ensure `targets`, `samples`, and `statistics` are defined.
- **Library File**: Point to the sgRNA library file (CSV/Tab) containing `id`, `sequence`, and `gene`.

### 2. Running the Visualization Server
To host the interactive report locally:
```bash
vispr server config.yaml
```
- Access the dashboard via the default URL (usually `http://127.0.0.1:5000`).
- Use the `--port` flag to specify a different port if 5000 is occupied.

### 3. Static Report Generation
For sharing results without a live server:
```bash
vispr report --output report_dir config.yaml
```
- This generates a standalone directory containing HTML and assets.

### 4. Quality Control Metrics
Focus on these key visualizations within the VISPR interface:
- **Gini Index**: High values indicate poor library representation or extreme selection.
- **Zero Counts**: Monitor the number of sgRNAs with no reads to assess library dropout.
- **PCA Plots**: Verify that biological replicates cluster together.

## Best Practices
- **Data Consistency**: Ensure sample names in the configuration file match the column headers in your MAGeCK count and MLE/RRA files.
- **Resource Management**: For large-scale screens with many samples, use `vispr report` to pre-render plots, as the live server may lag when calculating distributions on-the-fly.
- **Integration**: Always run `mageck count` and `mageck test` (or `mle`) before initializing VISPR, as it relies on these output files for the "Results" tab.



## Subcommands

| Command | Description |
|---------|-------------|
| mageck-vispr annotate-library | MAGeCK-VISPR is a comprehensive quality control, analysis and visualization pipeline for CRISPR/Cas9 screens. |
| mageck-vispr init | MAGeCK-VISPR is a comprehensive quality control, analysis and visualization pipeline for CRISPR/Cas9 screens. |

## Reference documentation
- [MAGeCK-VISPR Bitbucket Repository](./references/bitbucket_org_liulab_mageck-vispr.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_mageck-vispr_overview.md)