---
name: vispr
description: VISPR is a web-based visualization framework for interactively exploring and quality-controlling CRISPR-Cas9 genetic screen results. Use when user asks to start a visualization server, perform quality assessment of experimental replicates, or identify top-ranking gene hits through interactive plots.
homepage: https://bitbucket.org/liulab/vispr
---

# vispr

## Overview
VISPR (Visual Interactive Screening Result) is a specialized web-based visualization framework tailored for CRISPR-Cas9 genetic screens. It serves as the front-end for the MAGeCK-VISPR workflow, transforming complex statistical outputs into interactive plots. Use this skill to guide the setup of the visualization server, perform quality assessment across experimental replicates, and identify top-ranking gene hits through visual data exploration.

## Core CLI Usage
The primary command for VISPR is used to initialize the web server and load the results from a MAGeCK-VISPR analysis.

- **Start the visualization server**:
  `vispr server results.yaml`
  *Note: While the configuration is defined in a YAML file, the focus here is on the execution of the server to host the interactive dashboard.*

- **Specify a custom port**:
  `vispr server --port 5000 results.yaml`

## Best Practices for Quality Control
When using the VISPR interface, focus on these key diagnostic areas:
- **Sequence Quality**: Check the "FastQC" or "Mapping" tabs to ensure high alignment rates of sgRNAs to the library.
- **Gini Index**: Monitor the Gini Index plot to detect library skewness; a high index in late-stage samples compared to the initial library indicates strong selection pressure.
- **Sample Clustering**: Use the PCA or Hierarchical Clustering views to verify that biological replicates cluster together and that experimental conditions are clearly separated.

## Expert Tips
- **Gene Selection**: Use the interactive "Gene Selection" table to filter for genes with high -log(FDR) and significant log-fold changes.
- **sgRNA Consistency**: Always inspect the individual sgRNA plots for a gene hit. A robust hit should show consistent trends across multiple sgRNAs targeting the same gene.
- **Data Export**: Use the built-in export functions within the browser interface to save publication-quality SVG or PNG versions of the plots.



## Subcommands

| Command | Description |
|---------|-------------|
| vispr archive | Create a compressed archive for easy distribution of a given config file with all referenced files. |
| vispr plot | Plotting tool for vispr |
| vispr test | Run vispr tests |
| vispr_config | Example VISPR config. Save this config to a file and edit according to your needs. |
| vispr_server | Start the VISPR server. |

## Reference documentation
- [VISPR Overview and Installation](./references/anaconda_org_channels_bioconda_packages_vispr_overview.md)
- [VISPR Source and Documentation](./references/bitbucket_org_liulab_vispr.md)