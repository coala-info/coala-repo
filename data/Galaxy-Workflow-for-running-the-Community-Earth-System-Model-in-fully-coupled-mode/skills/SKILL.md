---
name: workflow-for-running-a-fully-coupled-cesm-b1850-f19_g17
description: "This climate modeling workflow executes a fully coupled Community Earth System Model simulation using B1850 configuration data and user namelists, followed by data extraction and xarray-based map plotting. Use this skill when you need to simulate pre-industrial climate conditions to analyze global atmospheric and oceanic interactions through coupled Earth system modeling."
homepage: https://workflowhub.eu/workflows/364
---

# Workflow for running a fully coupled CESM B1850 f19_g17

## Overview

This Galaxy workflow automates the execution of the Community Earth System Model (CESM) in a fully coupled configuration using the B1850 component set at f19_g17 resolution. It is specifically designed for climate and Earth System Modeling (ESM) research, providing a structured environment to run complex simulations that would otherwise require extensive manual configuration.

The process begins by ingesting a compressed input dataset and user-defined namelist files to initialize the [CESM](https://toolshed.g2.bx.psu.edu/repos/climate/cesm/cesm/2.1.3+galaxy0) tool. The workflow manages the simulation lifecycle, generating a comprehensive suite of outputs including history files, restart data, and diagnostic log files.

Following the model run, the workflow performs automated post-processing by extracting specific datasets from the results. It utilizes [xarray-based tools](https://toolshed.g2.bx.psu.edu/repos/ecology/xarray_metadata_info/xarray_metadata_info/0.15.1) to generate metadata tables and [visual map plots](https://toolshed.g2.bx.psu.edu/repos/ecology/xarray_mapplot/xarray_mapplot/0.18.2+galaxy0) from the NetCDF output, allowing for immediate inspection of the climate model's spatial data.

For detailed setup instructions and configuration parameters, refer to the README.md in the Files section. This workflow is released under the MIT license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | inputdata_cesm_2.1.3_B1850_f19_g17.tar | data_input | Input dataset for running this version of the fully coupled CESM model. |
| 1 | user_nl_cam_rs | data_input | User namelist for CAM (Atmosphere) restarts. |


Ensure the primary input is a `.tar` archive containing the specific CESM input data, while the namelist file should be provided as a plain text dataset. Although this workflow processes individual datasets, you may find it useful to organize large-scale climate runs using collections to manage multiple history or restart files more efficiently. Refer to the `README.md` for comprehensive instructions on configuring the CESM environment and specific namelist parameters. You can automate the configuration of these inputs by using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | CESM | toolshed.g2.bx.psu.edu/repos/climate/cesm/cesm/2.1.3+galaxy0 | Tool for running CESM in fully coupled mode. |
| 3 | Extract dataset | __EXTRACT_DATASET__ |  |
| 4 | NetCDF xarray Metadata Info | toolshed.g2.bx.psu.edu/repos/ecology/xarray_metadata_info/xarray_metadata_info/0.15.1 |  |
| 5 | NetCDF xarray map plotting | toolshed.g2.bx.psu.edu/repos/ecology/xarray_mapplot/xarray_mapplot/0.18.2+galaxy0 | Visualize the first dataset (date/time) from the generated output file. |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | history files | history_files |
| 2 | work directory | work |
| 2 | restart files | restart |
| 2 | restart info | rinfo |
| 2 | case_info | case_info |
| 2 | logfiles | logs_files |
| 3 | input dataset(s) (extracted element) | output |
| 4 | metadata table of the netCDF file | output |
| 5 | maps | output_dir |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Workflow_for_running_a_fully_coupled_CESM_B1850_f19_g17.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Workflow_for_running_a_fully_coupled_CESM_B1850_f19_g17.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Workflow_for_running_a_fully_coupled_CESM_B1850_f19_g17.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Workflow_for_running_a_fully_coupled_CESM_B1850_f19_g17.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Workflow_for_running_a_fully_coupled_CESM_B1850_f19_g17.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Workflow_for_running_a_fully_coupled_CESM_B1850_f19_g17.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
