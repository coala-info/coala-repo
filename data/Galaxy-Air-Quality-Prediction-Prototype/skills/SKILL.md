---
name: emep-wps-wrf
description: This workflow processes atmospheric and surface GRIB data using the WRF Preprocessing System and the Weather Research and Forecasting model to generate high-resolution meteorological simulations. Use this skill when you need to produce precise meteorological driving fields for air quality assessments or regional weather forecasting based on global atmospheric datasets.
homepage: https://workflowhub.eu/workflows/380
metadata:
  docker_image: "N/A"
---

# emep-wps-wrf

## Overview

This Galaxy workflow automates the execution of the Weather Research and Forecasting (WRF) model and its Preprocessing System (WPS). It is designed to streamline the transition from raw meteorological data to high-resolution atmospheric simulations, specifically supporting air quality prediction prototypes. The pipeline manages the complex dependencies between data extraction, interpolation, and numerical integration.

The process begins by initializing the environment and linking atmospheric (ATM) and surface (SFC) Grib data using provided VTables and namelists. The workflow then executes the `ungrib` component to extract meteorological fields, followed by `metgrid` to interpolate these fields onto the simulation domain defined by the input Geofile. These steps ensure that the raw data is correctly formatted and spatially aligned for the simulation.

In the final stages, the workflow runs the `real.exe` initialization program to generate vertically interpolated boundary and initial conditions. This leads to the execution of the `wrf.exe` tool, which performs the core numerical weather prediction. The primary outputs include comprehensive `wrfout` data files and detailed execution logs, providing the meteorological foundation required for subsequent environmental modeling.

Key inputs include Grib data collections, static geographic data, and specific configuration namelists for each stage of the WPS/WRF suite. For detailed setup instructions and configuration parameters, please refer to the [README.md](README.md) in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Grib ATM | data_collection_input |  |
| 1 | Grib ATM Namelist | data_input |  |
| 2 | VTable ATM | data_input |  |
| 3 | Grib SFC | data_collection_input |  |
| 4 | Grib SFC Namelist | data_input |  |
| 5 | VTable SFC | data_input |  |
| 6 | Geofile | data_input |  |
| 8 | Metgrid Namelist | data_input |  |
| 9 | Real Namelist | data_input |  |
| 11 | WRF namelist | data_input |  |


Ensure that atmospheric and surface meteorological data are uploaded as data collections containing GRIB files, while namelists, VTables, and the Geofile should be provided as individual datasets. All namelist files must be carefully configured to match your specific simulation domain and time steps to ensure compatibility across the ungrib, metgrid, and real stages. Refer to the `README.md` for comprehensive details on parameterizing these inputs and managing the directory structures required by the underlying CWL tools. You can streamline the execution setup by using `planemo workflow_job_init` to generate a `job.yml` template for these inputs.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 7 | create_metgrid_dir.cwl | create_metgrid_dir.cwl |  |
| 10 | create_run_dir.cwl | create_run_dir.cwl |  |
| 12 | link_grib_tool.cwl | link_grib_tool.cwl |  |
| 13 | link_grib_tool.cwl | link_grib_tool.cwl |  |
| 14 | ungrib.cwl | ungrib.cwl |  |
| 15 | ungrib.cwl | ungrib.cwl |  |
| 16 | metgrid.cwl | metgrid.cwl |  |
| 17 | real.cwl | real.cwl |  |
| 18 | wrf.cwl | wrf.cwl |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 7 | metdir | metdir |
| 10 | rundir | rundir |
| 12 | grib_dir | grib_dir |
| 13 | grib_dir | grib_dir |
| 14 | logfile | logfile |
| 14 | procfiles | procfiles |
| 15 | procfiles | procfiles |
| 15 | logfile | logfile |
| 16 | logfile | logfile |
| 16 | metfiles | metfiles |
| 18 | output_wrfout | output_wrfout |
| 18 | output_logs | output_logs |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-EMEP_WPS_WRF.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-EMEP_WPS_WRF.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-EMEP_WPS_WRF.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-EMEP_WPS_WRF.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-EMEP_WPS_WRF.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-EMEP_WPS_WRF.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)