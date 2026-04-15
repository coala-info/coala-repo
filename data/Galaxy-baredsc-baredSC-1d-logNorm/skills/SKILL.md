---
name: single-cell-mixture-analysis-baredsc-1d-log-normalized-model
description: This workflow applies the baredSC algorithm to log-normalized single-cell expression data to fit and combine one-dimensional Gaussian mixture models for a specific gene of interest. Use this skill when you need to identify distinct cellular subpopulations or characterize expression heterogeneity within a population by statistically determining the optimal number of Gaussian components.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# single-cell-mixture-analysis-baredsc-1d-log-normalized-model

## Overview

This Galaxy workflow implements the [baredSC](https://github.com/mbaudis/baredSC) algorithm to analyze single-cell gene expression through one-dimensional Gaussian mixture models. By processing log-normalized data, the workflow fits multiple models ranging from one to a user-specified maximum number of Gaussian components. This approach allows for the precise identification of cell subpopulations and provides a statistical framework to determine the optimal number of components within heterogeneous populations.

The pipeline automates the generation of parameter lists, executes the [baredSC 1d](https://toolshed.g2.bx.psu.edu/repos/iuc/baredsc_1d/baredsc_1d/1.1.3+galaxy0) tool for each configuration, and utilizes [baredSC_combine_1d](https://toolshed.g2.bx.psu.edu/repos/iuc/baredsc_combine_1d/baredsc_combine_1d/1.1.3+galaxy0) to merge the results into a unified output. Users provide a tabular dataset containing raw expression values and specify the gene of interest along with the maximum log-normalized value for probability density function (PDF) exploration.

Key outputs include comprehensive QC plots, effective sample size (Neff) calculations, and combined PDF plots that visualize the distribution of gene expression across the cell population. This workflow is particularly useful for researchers looking to move beyond simple clustering by applying rigorous Bayesian inference to single-channel expression data. The project is released under the MIT license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Tabular with raw expression values | data_input | The dataset must have a first row with row names. Among them should be 'nCount_RNA' and the gene you want to get PDF of. |
| 1 | Gene name | parameter_input | Must be included in the first row of the tabular |
| 2 | Maximum value in logNorm | parameter_input | Maximum value to explore in logNorm |
| 3 | Maximum number of Gaussians to study | parameter_input | Usually 4 is enough |


Ensure your input is a tabular file where each row represents a cell and includes a header with column names, specifically requiring an 'nCount_RNA' column alongside your gene of interest. Use the provided R snippet to correctly format your Seurat object data into a compatible text file before uploading. When configuring parameters, verify that the maximum log-normalization value is high enough for the probability density function to reach zero. For comprehensive details on parameter selection and data formatting, refer to the README.md file. You can use `planemo workflow_job_init` to generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | generate_param_list_one_to_number | (subworkflow) |  |
| 5 | baredSC 1d | toolshed.g2.bx.psu.edu/repos/iuc/baredsc_1d/baredsc_1d/1.1.3+galaxy0 |  |
| 6 | Combine multiple 1D Models | toolshed.g2.bx.psu.edu/repos/iuc/baredsc_combine_1d/baredsc_combine_1d/1.1.3+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | baredsc_qc_plots | qc_plots |
| 5 | baredsc_neff | neff |
| 5 | baredsc_numpy | output |
| 6 | combined_pdf | pdf |
| 6 | combined_plot | plot |
| 6 | combined_other_outputs | other_outputs |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run baredSC-1d-logNorm.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run baredSC-1d-logNorm.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run baredSC-1d-logNorm.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init baredSC-1d-logNorm.ga -o job.yml`
- Lint: `planemo workflow_lint baredSC-1d-logNorm.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `baredSC-1d-logNorm.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)