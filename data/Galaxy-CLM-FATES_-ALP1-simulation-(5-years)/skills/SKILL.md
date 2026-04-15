---
name: clm-fates_-alp1-simulation-5-years
description: This climate workflow executes a five-year simulation using the Functionally Assembled Terrestrial Ecosystem Simulator (FATES) and CTSM/FATES-EMERALD tool to process terrestrial ecosystem datasets and restart files. Use this skill when you need to analyze long-term vegetation dynamics, land-atmosphere interactions, or terrestrial carbon cycle responses within a specific climate scenario.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# clm-fates_-alp1-simulation-5-years

## Overview

This workflow performs a 5-year simulation using the [Functionally Assembled Terrestrial Ecosystem Simulator (FATES)](https://fates-docs.readthedocs.io/en/latest/) integrated with the Community Land Model (CLM). It is designed to model complex terrestrial ecosystem processes by utilizing an initial input dataset and a restart file to initialize or continue specific climate scenarios.

The core simulation is executed via the [CTSM/FATES-EMERALD](https://toolshed.g2.bx.psu.edu/repos/climate/ctsm_fates/ctsm_fates/2.0.1) tool. Following the model run, the workflow employs a series of post-processing steps, including dataset extraction and the use of xarray-based tools to inspect NetCDF metadata and select specific variables. This ensures that the high-dimensional output from the climate model is correctly parsed and filtered for analysis.

In the final stages, the workflow performs text processing and data cleaning to prepare the results for visualization. It generates a variety of outputs, including comprehensive model logs (ATM, LND, ROF, CPL), history files, and diagnostic scatterplots created with [ggplot2](https://toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/2.2.1+galaxy2). These results provide a detailed view of ecosystem dynamics and land-atmosphere interactions over the simulated period.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input dataset for CLM-FATES | data_input |  |
| 1 | CLM-FATES restart file | data_input |  |


Ensure that the primary input dataset and the restart file are provided in NetCDF format to maintain compatibility with the CTSM/FATES-EMERALD tool. While the initial inputs are individual datasets, the workflow produces history file collections that are subsequently processed by xarray tools for metadata extraction and visualization. For comprehensive instructions on parameterizing the ALP1 simulation and preparing the forcing data, refer to the README.md file. You may also use `planemo workflow_job_init` to create a `job.yml` for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | CTSM/FATES-EMERALD | toolshed.g2.bx.psu.edu/repos/climate/ctsm_fates/ctsm_fates/2.0.1 |  |
| 3 | Extract Dataset | __EXTRACT_DATASET__ |  |
| 4 | NetCDF xarray Metadata Info | toolshed.g2.bx.psu.edu/repos/ecology/xarray_metadata_info/xarray_metadata_info/0.15.1 |  |
| 5 | NetCDF xarray Selection | toolshed.g2.bx.psu.edu/repos/ecology/xarray_select/xarray_select/0.15.1 |  |
| 6 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.3 |  |
| 7 | Scatterplot with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/2.2.1+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | rinfo | rinfo |
| 2 | work | work |
| 2 | rof_log | rof_log |
| 2 | cpl_log | cpl_log |
| 2 | cesm_log | cesm_log |
| 2 | atm_log | atm_log |
| 2 | restart | restart |
| 2 | lnd_log | lnd_log |
| 2 | case_info | case_info |
| 2 | history_files | history_files |
| 3 | input dataset(s) (extracted element) | output |
| 4 | info | info |
| 4 | output | output |
| 5 | simpleoutput | simpleoutput |
| 6 | outfile | outfile |
| 7 | output1 | output1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run clm-fates-alp1-simulation-5years.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run clm-fates-alp1-simulation-5years.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run clm-fates-alp1-simulation-5years.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init clm-fates-alp1-simulation-5years.ga -o job.yml`
- Lint: `planemo workflow_lint clm-fates-alp1-simulation-5years.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `clm-fates-alp1-simulation-5years.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)