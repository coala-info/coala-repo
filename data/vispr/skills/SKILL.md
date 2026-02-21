---
name: vispr
description: VISPR (VIsualization of CRISPR screens) provides a specialized framework for the interactive exploration of CRISPR/Cas9 screening data.
homepage: https://bitbucket.org/liulab/vispr
---

# vispr

## Overview
VISPR (VIsualization of CRISPR screens) provides a specialized framework for the interactive exploration of CRISPR/Cas9 screening data. It acts as a companion to the MAGeCK pipeline, transforming raw statistical outputs into comprehensive quality control reports and gene-level visualizations. Use this tool to assess library representation, evaluate sample clustering, and identify top-ranked hits through an automated analysis workflow.

## Core Workflow and CLI Usage

### Initializing a Project
To begin a VISPR analysis, you must first create a configuration file that defines your experimental design, including samples, controls, and MAGeCK result paths.

```bash
vispr init my_experiment
```
This command generates a template configuration file (usually `config.yaml`) which must be edited to point to your fastq files or MAGeCK count/mle/test outputs.

### Running the Pipeline
Once the configuration is defined, execute the workflow to generate the visualization database.

```bash
vispr run config.yaml
```
*   **Tip**: Ensure `mageck` is in your PATH, as VISPR calls it internally if starting from raw counts.
*   **Resource Management**: For large screens, use the `--cores` flag to parallelize the MAGeCK processing steps.

### Launching the Visualization Server
After the run completes, start the interactive web interface to explore the results.

```bash
vispr server results.db
```
By default, the server runs on `http://127.0.0.1:5000`. You can specify a different port using `--port`.

## Best Practices for CRISPR Analysis
*   **Input Validation**: Before running `vispr run`, verify that your sample names in the config file match the column headers in your MAGeCK count tables exactly.
*   **Quality Control Focus**: Use the "Sample Statistics" and "Individual sgRNA" views in the server to identify samples with low Gini indices or high zero-count rates, which may indicate poor library preparation.
*   **Gene Selection**: When exploring hits, prioritize genes that show consistency across multiple sgRNAs. VISPR’s visualization helps distinguish between a single high-performing guide and a true biological hit where all guides shift in the same direction.

## Reference documentation
- [VISPR Project Overview](./references/anaconda_org_channels_bioconda_packages_vispr_overview.md)
- [VISPR Source and Documentation](./references/bitbucket_org_liulab_vispr.md)