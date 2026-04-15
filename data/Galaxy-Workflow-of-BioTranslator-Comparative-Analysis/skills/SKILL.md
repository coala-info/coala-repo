---
name: workflow-of-biotranslator-comparative-analysis
description: This workflow performs a comparative analysis of gene sets using the BioTranslator tool to generate a distance matrix and a heatmap. Use this skill when you need to quantify and visualize the biological similarities or functional distances between multiple groups of genes to identify patterns across different experimental conditions.
homepage: https://workflowhub.eu/workflows/193
metadata:
  docker_image: "N/A"
---

# workflow-of-biotranslator-comparative-analysis

## Overview

This Galaxy workflow facilitates the comparative analysis of biological data using the BioTranslator framework. It is designed to process input sets of genes to identify relationships, similarities, or functional overlaps across different biological contexts or datasets.

The core of the pipeline utilizes the `comparative_analysis` tool, which performs computational comparisons on the provided gene sets. By leveraging BioTranslator's capabilities, the workflow translates complex biological information into a format suitable for direct quantitative comparison.

The execution results in two primary outputs: a Distances Matrix and a Heatmap. The matrix provides the raw numerical distances between the analyzed sets, while the heatmap offers a visual representation of these relationships, allowing for quick identification of clusters or significant biological patterns.

For detailed setup instructions and parameter configurations, please refer to the [README.md](./README.md) file located in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input sets of genes | data_input | Input file format: Tab or csv delimited file with a specific gene set in each column. The header is used for gene set labels. |


Ensure your input sets of genes are formatted as tabular or text files containing gene identifiers compatible with the BioTranslator tool. While individual datasets work, using a dataset collection is recommended for managing multiple gene sets efficiently during the comparative analysis step. Refer to the README.md file for comprehensive details on specific parameter configurations and expected identifier formats. You can use planemo workflow_job_init to generate a job.yml file for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Comparative Analysis | comparative_analysis | The algorithm consists of two sequential tasks:   1. Pathway Analysis of the input gene sets, using the selected ontology  2. Comparison of the derived semantic sets, using the topology of ontological graph  Outputs:  1. The distance matrix in tsv format 2. A heatmap (png format) which illustrates the agglomerative clustering of input sets, based on the respective semantic distances |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | Distances Matrix | ds |
| 1 | Heatmap | hm |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Workflow_of_BioTranslator_Comparative_Analysis.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Workflow_of_BioTranslator_Comparative_Analysis.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Workflow_of_BioTranslator_Comparative_Analysis.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Workflow_of_BioTranslator_Comparative_Analysis.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Workflow_of_BioTranslator_Comparative_Analysis.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Workflow_of_BioTranslator_Comparative_Analysis.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)