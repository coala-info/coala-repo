---
name: xarray_map_plotting_workflow
description: This workflow processes NetCDF climate data using CDO operations and Xarray tools to extract metadata and generate geospatial map visualizations. Use this skill when you need to analyze spatial distributions of climate variables like air temperature and create high-quality map plots from multidimensional environmental datasets.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# xarray_map_plotting_workflow

## Overview

This workflow provides a standardized pipeline for the visualization of climate data, specifically designed to process NetCDF files such as air temperature records. It automates the transition from raw multidimensional data to geospatial map plots, making it a valuable tool for researchers in ecology and climate science.

The process begins by extracting essential coordinate and metadata information using [Xarray](https://docs.xarray.dev/) tools. It then incorporates [CDO (Climate Data Operators)](https://code.mpimet.mpg.de/projects/cdo/) to perform data manipulation and operations, ensuring the datasets are correctly formatted and subsetted for analysis.

In the final stages, the workflow utilizes Xarray's mapping capabilities to generate visual representations of the processed climate variables. This allows for the efficient creation of spatial plots that are critical for interpreting atmospheric trends and environmental changes. This workflow is licensed under the [MIT License](https://opensource.org/licenses/MIT) and aligns with [GTN](https://training.galaxyproject.org/) standards for climate data analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | air_temperature_at_2_metres.nc | data_input | Upload the dataset : air temperatures at 2  metres , from the 'remote datasets' |


Ensure your input data is in NetCDF (.nc) format to allow the Xarray and CDO tools to correctly extract metadata and coordinate information. While the workflow is designed for individual datasets, you may use data collections to batch process multiple climate variables or time slices. Refer to the README.md for specific guidance on coordinate mapping and parameter configurations required for accurate map plotting. For streamlined execution, you can use `planemo workflow_job_init` to generate a `job.yml` file for your input parameters.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | NetCDF xarray Coordinate Info | toolshed.g2.bx.psu.edu/repos/ecology/xarray_coords_info/xarray_coords_info/0.20.2+galaxy0 |  |
| 2 | NetCDF xarray Metadata Info | toolshed.g2.bx.psu.edu/repos/ecology/xarray_metadata_info/xarray_metadata_info/0.15.1 |  |
| 3 | CDO Operations | toolshed.g2.bx.psu.edu/repos/climate/cdo_operations/cdo_operations/2.0.0+galaxy0 |  |
| 4 | CDO Operations | toolshed.g2.bx.psu.edu/repos/climate/cdo_operations/cdo_operations/2.0.0+galaxy0 |  |
| 5 | NetCDF xarray Metadata Info | toolshed.g2.bx.psu.edu/repos/ecology/xarray_metadata_info/xarray_metadata_info/0.15.1 |  |
| 6 | NetCDF xarray map plotting | toolshed.g2.bx.psu.edu/repos/ecology/xarray_mapplot/xarray_mapplot/0.20.2+galaxy0 |  |
| 7 | NetCDF xarray map plotting | toolshed.g2.bx.psu.edu/repos/ecology/xarray_mapplot/xarray_mapplot/0.20.2+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | output_dir | output_dir |
| 2 | output | output |
| 2 | info | info |
| 3 | output_files | output_files |
| 4 | output_files | output_files |
| 5 | output | output |
| 5 | info | info |
| 6 | output_dir | output_dir |
| 6 | version | version |
| 7 | output_dir | output_dir |
| 7 | version | version |


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