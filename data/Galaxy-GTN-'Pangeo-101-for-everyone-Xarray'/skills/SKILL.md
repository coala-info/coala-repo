---
name: gtn-pangeo-101-for-everyone-xarray
description: This workflow processes Copernicus CAMS NetCDF air quality data using Xarray tools to perform spatial selections, coordinate transformations, and generate visualizations such as map plots and climate stripes. Use this skill when you need to analyze atmospheric particulate matter concentrations over specific geographic regions and create time-series or spatial forecast visualizations from multidimensional climate datasets.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# gtn-pangeo-101-for-everyone-xarray

## Overview

This workflow provides an introductory demonstration of using Xarray within Galaxy for climate data analysis, specifically designed for the [Pangeo](https://pangeo.io/) community and the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/). It processes Copernicus Atmosphere Monitoring Service (CAMS) NetCDF data to teach users how to manipulate multidimensional arrays, inspect metadata, and handle coordinate information in a cloud-native ecosystem.

The pipeline performs several data manipulation tasks, including extracting specific datasets, selecting temporal slices, and performing Xarray operations to subset geographic regions. By focusing on PM2.5 concentration data, the workflow demonstrates how to transition from raw atmospheric datasets to refined, analysis-ready information.

Visualization is a key component of this workflow. It generates a variety of outputs, including 2D map plots of Europe and Italy, 1D time-series scatterplots using `ggplot2`, and "climate stripes" for specific locations like Naples. Advanced steps utilize `GraphicsMagick` to create image montages that visualize forecast trends over multiple time steps.

Licensed under the [MIT license](https://opensource.org/licenses/MIT), this resource serves as a foundational template for researchers working with Earth observation data. It highlights the integration of specialized ecology and climate tools within Galaxy to simplify complex geospatial workflows.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | plot first time e.g. index=0 | parameter_input | Which index to plot. Default is the first one e.g. 0 |
| 1 | CAMS-PM2_5-20211222.netcdf | data_input | netCDF input (4 days forecast) of PM2.5 from Copernicus Atmosphere Monitoring Service https://ads.atmosphere.copernicus.eu/#!/home  As an example https://doi.org/10.5281/zenodo.5805953 |
| 2 | plot forecast time 2 days 12:00 UTC | parameter_input | Which index to plot. Default is the first one e.g. 60 |
| 3 | time=5 | parameter_input | Select time index 5 for plotting |
| 4 | time=6 | parameter_input | Select time index 6 for plotting |
| 5 | time=3 | parameter_input | Select time index 3 for plotting |
| 6 | time=2 | parameter_input | Select time index 2 for plotting |
| 7 | time=7 | parameter_input | Select time index 7 for plotting |
| 8 | time=1 | parameter_input | Select time index 1 for plotting |
| 9 | time=4 | parameter_input | Select time index 4 for plotting |
| 10 | time=0 | parameter_input | Select time index 9 for plotting |


This workflow primarily processes NetCDF data, so ensure your input files are correctly formatted as `.netcdf` or `.nc` to be compatible with the Xarray tool suite. While the workflow uses individual datasets for initial coordinate and metadata extraction, it leverages collection merging for batch image montage generation, making it efficient for time-series visualization. You should provide specific integer values for the time index parameters to correctly slice the multidimensional arrays during the extraction and plotting steps. For a comprehensive guide on parameter settings and data structures, refer to the `README.md` file. You can also use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 11 | NetCDF xarray Coordinate Info | toolshed.g2.bx.psu.edu/repos/ecology/xarray_coords_info/xarray_coords_info/0.18.2+galaxy0 |  |
| 12 | NetCDF xarray Metadata Info | toolshed.g2.bx.psu.edu/repos/ecology/xarray_metadata_info/xarray_metadata_info/0.15.1 |  |
| 13 | Extract dataset | __EXTRACT_DATASET__ |  |
| 14 | Extract dataset | __EXTRACT_DATASET__ |  |
| 15 | Extract dataset | __EXTRACT_DATASET__ | This step is used to extract time from all the coordinates. |
| 16 | NetCDF xarray operations | toolshed.g2.bx.psu.edu/repos/ecology/xarray_netcdf2netcdf/xarray_netcdf2netcdf/0.18.2+galaxy0 |  |
| 17 | NetCDF xarray operations | toolshed.g2.bx.psu.edu/repos/ecology/xarray_netcdf2netcdf/xarray_netcdf2netcdf/0.18.2+galaxy0 |  |
| 18 | NetCDF xarray operations | toolshed.g2.bx.psu.edu/repos/ecology/xarray_netcdf2netcdf/xarray_netcdf2netcdf/0.18.2+galaxy0 |  |
| 19 | NetCDF xarray map plotting | toolshed.g2.bx.psu.edu/repos/ecology/xarray_mapplot/xarray_mapplot/0.18.2+galaxy0 | Map of PM2.5 for the reference date and time. |
| 20 | NetCDF xarray map plotting | toolshed.g2.bx.psu.edu/repos/ecology/xarray_mapplot/xarray_mapplot/0.18.2+galaxy0 | one map plot for the entire region (here Europe) and for day 2 12:00 UTC. |
| 21 | NetCDF xarray Selection | toolshed.g2.bx.psu.edu/repos/ecology/xarray_select/xarray_select/0.15.1 |  |
| 22 | NetCDF xarray Coordinate Info | toolshed.g2.bx.psu.edu/repos/ecology/xarray_coords_info/xarray_coords_info/0.18.2+galaxy0 |  |
| 23 | NetCDF xarray Coordinate Info | toolshed.g2.bx.psu.edu/repos/ecology/xarray_coords_info/xarray_coords_info/0.18.2+galaxy0 |  |
| 24 | NetCDF xarray Metadata Info | toolshed.g2.bx.psu.edu/repos/ecology/xarray_metadata_info/xarray_metadata_info/0.15.1 |  |
| 25 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.1 |  |
| 26 | Scatterplot with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/2.2.1+galaxy2 |  |
| 27 | Extract dataset | __EXTRACT_DATASET__ |  |
| 28 | Extract dataset | __EXTRACT_DATASET__ |  |
| 29 | climate stripes | toolshed.g2.bx.psu.edu/repos/climate/climate_stripes/climate_stripes/1.0.1 |  |
| 30 | NetCDF xarray map plotting | toolshed.g2.bx.psu.edu/repos/ecology/xarray_mapplot/xarray_mapplot/0.18.2+galaxy0 |  |
| 31 | NetCDF xarray map plotting | toolshed.g2.bx.psu.edu/repos/ecology/xarray_mapplot/xarray_mapplot/0.18.2+galaxy0 |  |
| 32 | NetCDF xarray map plotting | toolshed.g2.bx.psu.edu/repos/ecology/xarray_mapplot/xarray_mapplot/0.18.2+galaxy0 |  |
| 33 | NetCDF xarray map plotting | toolshed.g2.bx.psu.edu/repos/ecology/xarray_mapplot/xarray_mapplot/0.18.2+galaxy0 |  |
| 34 | NetCDF xarray map plotting | toolshed.g2.bx.psu.edu/repos/ecology/xarray_mapplot/xarray_mapplot/0.18.2+galaxy0 |  |
| 35 | NetCDF xarray map plotting | toolshed.g2.bx.psu.edu/repos/ecology/xarray_mapplot/xarray_mapplot/0.18.2+galaxy0 |  |
| 36 | NetCDF xarray map plotting | toolshed.g2.bx.psu.edu/repos/ecology/xarray_mapplot/xarray_mapplot/0.18.2+galaxy0 |  |
| 37 | NetCDF xarray map plotting | toolshed.g2.bx.psu.edu/repos/ecology/xarray_mapplot/xarray_mapplot/0.18.2+galaxy0 |  |
| 38 | NetCDF xarray map plotting | toolshed.g2.bx.psu.edu/repos/ecology/xarray_mapplot/xarray_mapplot/0.18.2+galaxy0 |  |
| 39 | NetCDF xarray map plotting | toolshed.g2.bx.psu.edu/repos/ecology/xarray_mapplot/xarray_mapplot/0.18.2+galaxy0 |  |
| 40 | NetCDF xarray map plotting | toolshed.g2.bx.psu.edu/repos/ecology/xarray_mapplot/xarray_mapplot/0.18.2+galaxy0 |  |
| 41 | NetCDF xarray map plotting | toolshed.g2.bx.psu.edu/repos/ecology/xarray_mapplot/xarray_mapplot/0.18.2+galaxy0 |  |
| 42 | NetCDF xarray map plotting | toolshed.g2.bx.psu.edu/repos/ecology/xarray_mapplot/xarray_mapplot/0.18.2+galaxy0 |  |
| 43 | NetCDF xarray map plotting | toolshed.g2.bx.psu.edu/repos/ecology/xarray_mapplot/xarray_mapplot/0.18.2+galaxy0 |  |
| 44 | NetCDF xarray map plotting | toolshed.g2.bx.psu.edu/repos/ecology/xarray_mapplot/xarray_mapplot/0.18.2+galaxy0 |  |
| 45 | NetCDF xarray map plotting | toolshed.g2.bx.psu.edu/repos/ecology/xarray_mapplot/xarray_mapplot/0.18.2+galaxy0 |  |
| 46 | NetCDF xarray map plotting | toolshed.g2.bx.psu.edu/repos/ecology/xarray_mapplot/xarray_mapplot/0.18.2+galaxy0 |  |
| 47 | Merge collections | __MERGE_COLLECTION__ |  |
| 48 | Merge collections | __MERGE_COLLECTION__ |  |
| 49 | Image Montage | toolshed.g2.bx.psu.edu/repos/bgruening/graphicsmagick_image_montage/graphicsmagick_image_montage/1.3.31+galaxy1 | We have 8 plots, one for each forecast time for the first forecast day betwwen 100:00 and 17:00 UTC and we applied a mask e.g. only plot values great than 30 um/m3. |
| 50 | Image Montage | toolshed.g2.bx.psu.edu/repos/bgruening/graphicsmagick_image_montage/graphicsmagick_image_montage/1.3.31+galaxy1 | We have 8 plots, one for each forecast time. We take the forecast on day 1 between 10:00 and 17:00 UTC |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 11 | output_dir | output_dir |
| 13 | output | output |
| 14 | output | output |
| 15 | input dataset(s) (extracted element) | output |
| 16 | output_netcdf | output_netcdf |
| 17 | output_netcdf | output_netcdf |
| 18 | output_netcdf | output_netcdf |
| 19 | PM2.5 reference date Europe | output_dir |
| 20 | PM2.5 fc 2 days 12:00 UTC Europe | output_dir |
| 26 | 1D plot PM2.5 over Naples (4 days forecast) | output1 |
| 27 | output | output |
| 28 | output | output |
| 29 | PM2.5 stripes Naples for 4 days forecast from reference date | ofilename |
| 40 | output_dir | output_dir |
| 49 | PM2.5 (values > 30 um/m3)  fc 10:00 - 17:00 UTC over Italy | output |
| 50 | PM2.5 fc 10:00 - 17:00 UTC over Italy | output |


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