---
name: dia_analysis_msstats
description: "This proteomics workflow processes PyProphet export tables, comparison matrices, and sample annotations using MSstats to perform differential abundance analysis. Use this skill when you need to identify differentially expressed proteins in DIA mass spectrometry data and visualize results through volcano plots and quality control metrics."
homepage: https://workflowhub.eu/workflows/1458
---

# DIA_analysis_MSstats

## Overview

This workflow is designed for the statistical analysis of Data-Independent Acquisition (DIA) proteomics data, specifically following the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) protocols. It utilizes the [MSstats](https://toolshed.g2.bx.psu.edu/repos/galaxyp/msstats/msstats/3.20.1.0) package to perform protein-level quantification and differential abundance testing from mass spectrometry results.

The pipeline requires three primary inputs: a PyProphet export tabular file, a comparison matrix, and a sample annotation file. The core [MSstats](https://toolshed.g2.bx.psu.edu/repos/galaxyp/msstats/msstats/3.20.1.0) tool processes these inputs to generate a suite of analytical outputs, including processed data tables, quality control plots, volcano plots, and detailed comparison results.

In the final stages, the workflow applies post-processing filters to isolate specific subsets of data. Using Grep and filtering tools, it extracts *E. coli* specific results and generates a histogram to visualize the distribution of the filtered data. This makes the workflow particularly effective for benchmarking or training exercises involving spiked-in proteomes.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | PyProphet export tabular | data_input |  |
| 1 | Comparison matrix | data_input |  |
| 2 | Sample annot MSstats | data_input |  |


Ensure all inputs, including the PyProphet export, comparison matrix, and sample annotation, are uploaded as tabular files with consistent column headers. While these are typically handled as individual datasets, verify that the sample annotation file accurately maps to the filenames listed in the PyProphet export to avoid processing errors. Refer to the `README.md` for specific column requirements and formatting examples necessary for the MSstats comparison matrix. You can use `planemo workflow_job_init` to generate a `job.yml` for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | MSstats | toolshed.g2.bx.psu.edu/repos/galaxyp/msstats/msstats/3.20.1.0 |  |
| 4 | Select | Grep1 |  |
| 5 | Filter | Filter1 |  |
| 6 | Histogram | toolshed.g2.bx.psu.edu/repos/devteam/histogram/histogram_rpy/1.0.4 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | processed_data | processed_data |
| 3 | comparisonplot | comparisonplot |
| 3 | volcanoplot | volcanoplot |
| 3 | comparison_result | comparison_result |
| 3 | qcplot | qcplot |
| 4 | Select_Ecoli | out_file1 |
| 5 | Filter_Ecoli | out_file1 |
| 6 | Histogram_Ecoli | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-dia-msstats-training-export-tabular.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-dia-msstats-training-export-tabular.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-dia-msstats-training-export-tabular.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-dia-msstats-training-export-tabular.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-dia-msstats-training-export-tabular.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-dia-msstats-training-export-tabular.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
