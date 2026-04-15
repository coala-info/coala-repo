---
name: clm-fates_-alp1-simulation-5-years
description: This workflow executes a five-year CLM-FATES terrestrial ecosystem simulation using input datasets and restart files via the CTSM/FATES-EMERALD tool, followed by xarray data processing and ggplot2 visualization. Use this skill when you need to model vegetation demographics and land-surface interactions over a multi-year period to analyze ecosystem dynamics and carbon cycling.
homepage: https://workflowhub.eu/workflows/65
metadata:
  docker_image: "N/A"
---

# clm-fates_-alp1-simulation-5-years

## Overview

This workflow executes a five-year land surface and vegetation simulation using the [CTSM/FATES-EMERALD](https://toolshed.g2.bx.psu.edu/repos/climate/ctsm_fates/ctsm_fates/2.0.1) model. It is designed to process ecological data for the ALP1 site, requiring an initial input dataset and a restart file to define the starting state of the Community Terrestrial Systems Model (CTSM) and the Functionally Assembled Terrestrial Ecosystem Simulator (FATES).

Following the core simulation, the workflow performs automated post-processing of the resulting NetCDF files. It utilizes [xarray metadata](https://toolshed.g2.bx.psu.edu/repos/ecology/xarray_metadata_info/xarray_metadata_info/0.15.1) and [selection tools](https://toolshed.g2.bx.psu.edu/repos/ecology/xarray_select/xarray_select/0.15.1) to extract and subset specific variables from the history files. Text processing steps are also included to format or replace data strings as needed for downstream analysis.

The final outputs include a comprehensive set of model logs (ATM, LND, ROF, and CESM), updated restart files, and history datasets. To facilitate immediate interpretation of the simulation results, the workflow generates a visual summary using a [ggplot2 scatterplot](https://toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/2.2.1+galaxy2), allowing researchers to evaluate the modeled ecosystem dynamics over the five-year period.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input dataset for CLM-FATES | data_input |  |
| 1 | CLM-FATES restart file | data_input |  |


Ensure all input datasets and restart files are provided in NetCDF format to maintain compatibility with the CTSM/FATES-EMERALD tool. If you are processing multiple forcing files, organizing them into a dataset collection can significantly simplify the workflow execution. For comprehensive instructions on parameterization and specific site configurations, please refer to the detailed README.md. You may also use `planemo workflow_job_init` to generate a `job.yml` file for streamlined execution.

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
planemo run CLM-FATES_ALP1_simulation_5years.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run CLM-FATES_ALP1_simulation_5years.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run CLM-FATES_ALP1_simulation_5years.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init CLM-FATES_ALP1_simulation_5years.ga -o job.yml`
- Lint: `planemo workflow_lint CLM-FATES_ALP1_simulation_5years.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `CLM-FATES_ALP1_simulation_5years.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)