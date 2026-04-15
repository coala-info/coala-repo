---
name: maxquant-msstatstmt-training
description: This proteomics workflow processes MS dataset collections, experimental design templates, and annotation files using MaxQuant and MSstatsTMT to analyze tandem mass tag data. Use this skill when you need to perform protein identification, quality control, and statistical differential expression analysis on multiplexed TMT mass spectrometry datasets.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# maxquant-msstatstmt-training

## Overview

This workflow provides a standardized pipeline for the quantitative analysis of Tandem Mass Tag (TMT) proteomics data, following established [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) methodologies. It integrates two primary software suites—MaxQuant and MSstatsTMT—to transition from raw mass spectrometry data to statistically significant biological insights.

The process begins with [MaxQuant](https://www.maxquant.org/), which performs protein identification and quantification using an input dataset collection and an experimental design template. This stage generates critical outputs including `proteinGroups` and `evidence` files, while also producing a `ptxqc_report` to assess the technical quality of the MS runs.

In the final stage, [MSstatsTMT](https://msstats.org/msstatstmt/) processes the MaxQuant results alongside a required annotation file to perform protein-level significance analysis. The workflow automates the generation of statistical comparison tables and high-quality visualizations, such as volcano plots and group comparison plots, allowing researchers to identify differentially expressed proteins across experimental conditions.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input Dataset Collection | data_collection_input |  |
| 1 | Experimental design template | data_input |  |
| 2 | MSstats annotation file | data_input |  |


Ensure your mass spectrometry raw files are organized into a dataset collection to facilitate efficient batch processing through the MaxQuant tool. Both the experimental design template and the MSstats annotation file must be provided in tabular format, ensuring that column headers strictly follow the naming conventions required for TMT quantification. For a comprehensive breakdown of metadata requirements and specific parameter configurations, refer to the `README.md` file. You can also use `planemo workflow_job_init` to generate a `job.yml` file for automated job submission.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | MaxQuant | toolshed.g2.bx.psu.edu/repos/galaxyp/maxquant/maxquant/1.6.17.0+galaxy2 |  |
| 4 | MSstatsTMT | toolshed.g2.bx.psu.edu/repos/galaxyp/msstatstmt/msstatstmt/2.0.0+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | evidence | evidence |
| 3 | proteinGroups | proteinGroups |
| 3 | ptxqc_report | ptxqc_report |
| 3 | log | log |
| 3 | mqpar | mqpar |
| 4 | out_group_comp_plot | out_group_comp_plot |
| 4 | out_group_volcano_plot | out_group_volcano_plot |
| 4 | out_group_comp | out_group_comp |
| 4 | out_qc_plot | out_qc_plot |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run main-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run main-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run main-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init main-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint main-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `main-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)