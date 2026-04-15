---
name: ndvi-with-openeo
description: This workflow processes satellite imagery from the Copernicus Data Space Ecosystem using OpenEO to calculate the Normalized Difference Vegetation Index and generates interactive time-series visualizations with Holoviz. Use this skill when you need to monitor vegetation health over time or analyze seasonal changes in land cover using Earth observation data.
homepage: https://eurosciencegateway.eu/
metadata:
  docker_image: "N/A"
---

# ndvi-with-openeo

## Overview

This workflow demonstrates how to process and visualize NDVI (Normalized Difference Vegetation Index) time series data using the [Copernicus Data Space Ecosystem](https://dataspace.copernicus.eu/). It leverages the OpenEO API to query, process, and aggregate satellite imagery directly within a Galaxy interactive environment, streamlining the transition from raw data to analytical insights.

The process begins with an interactive Jupyter notebook tailored for the Copernicus ecosystem, where users can define their area of interest and calculate vegetation indices over a specific temporal range. The resulting datasets are then passed to the [HoloViz](https://holoviz.org/) interactive tool, which provides a suite of Python libraries designed for creating dynamic, high-level visualizations of complex temporal changes.

Licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/), this workflow serves as a practical template for researchers looking to integrate cloud-based Earth Observation data processing with advanced visualization tools. It effectively bridges the gap between large-scale data retrieval and interactive exploratory data analysis.

## Inputs and data preparation

_None listed._


Ensure you identify the correct Sentinel-2 collection IDs within the Copernicus Data Space Ecosystem to distinguish between raw satellite collections and your processed NDVI datasets. Use NetCDF or Zarr file formats to maintain multidimensional metadata, which is essential for seamless time-series rendering in Holoviz. Refer to the `README.md` for comprehensive environment setup and specific parameter configurations required for these interactive tools. You may also use `planemo workflow_job_init` to create a `job.yml` for streamlining the input definitions.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Copernicus Data Space Ecosystem | interactive_tool_copernicus_notebook |  |
| 1 | Holoviz | interactive_tool_holoviz |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run From NDVI data with OpenEO to time series visualisation with Holoviews.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run From NDVI data with OpenEO to time series visualisation with Holoviews.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run From NDVI data with OpenEO to time series visualisation with Holoviews.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init From NDVI data with OpenEO to time series visualisation with Holoviews.ga -o job.yml`
- Lint: `planemo workflow_lint From NDVI data with OpenEO to time series visualisation with Holoviews.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `From NDVI data with OpenEO to time series visualisation with Holoviews.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)