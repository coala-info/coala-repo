---
name: visualization-of-rna-seq-results-with-volcano-plot
description: "This transcriptomics workflow processes differential expression results and specific gene lists using the Volcano Plot tool to generate comprehensive PDF visualizations. Use this skill when you need to identify statistically significant gene expression changes and visualize the relationship between fold change and p-values across experimental conditions."
homepage: https://workflowhub.eu/workflows/1709
---

# Visualization Of RNA-Seq Results With Volcano Plot

## Overview

This workflow is designed to visualize differential expression (DE) analysis results by generating high-quality volcano plots. It provides a streamlined way to transform tabular transcriptomics data into graphical representations that highlight statistically significant gene expression changes, specifically plotting the relationship between fold change and statistical significance.

The process requires two primary inputs: a dataset containing DE results and a list of specific genes to be highlighted on the plot. Using the [Volcano Plot tool](https://toolshed.g2.bx.psu.edu/repos/iuc/volcanoplot/volcanoplot/0.0.7), the workflow executes multiple steps to refine the visualization, allowing users to easily identify up-regulated and down-regulated genes based on user-defined p-value and fold-change thresholds.

The final output is a PDF document containing the visualized data, suitable for publication or further analysis. Developed as part of the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) transcriptomics resources, this workflow is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | DE results | data_input | Differentially expressed results file (genes in rows, and 4 required columns: raw P values, adjusted P values (FDR), log fold change and gene labels) |
| 1 | Volcano genes | data_input | Genes of interest file (list of genes to be plotted in volcano) |


Ensure your differential expression results are provided in tabular format (TSV or CSV) with clearly defined columns for log2 fold change and p-values. While these inputs are usually handled as individual datasets, you may utilize collections if you are visualizing multiple experimental comparisons at once. The optional volcano genes input should be a text file containing specific gene identifiers you wish to label or highlight. Please consult the `README.md` for exhaustive documentation on required column headers and specific tool parameters. For automated testing or execution, consider using `planemo workflow_job_init` to create a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Volcano Plot | toolshed.g2.bx.psu.edu/repos/iuc/volcanoplot/volcanoplot/0.0.7 |  |
| 3 | Volcano Plot | toolshed.g2.bx.psu.edu/repos/iuc/volcanoplot/volcanoplot/0.0.7 |  |
| 4 | Volcano Plot | toolshed.g2.bx.psu.edu/repos/iuc/volcanoplot/volcanoplot/0.0.7 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | volcano_pdf | plot |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run visualization-of-rna-seq-results-with-volcano-plot.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run visualization-of-rna-seq-results-with-volcano-plot.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run visualization-of-rna-seq-results-with-volcano-plot.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init visualization-of-rna-seq-results-with-volcano-plot.ga -o job.yml`
- Lint: `planemo workflow_lint visualization-of-rna-seq-results-with-volcano-plot.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `visualization-of-rna-seq-results-with-volcano-plot.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
