---
name: workflow-constructed-from-history-eodie-sentinel
description: This workflow processes Sentinel-2 satellite imagery and parcel geometries using the EODIE toolkit to extract object-based time series information. Use this skill when you need to monitor vegetation dynamics or analyze land cover changes across specific geographic parcels using multi-temporal satellite data.
homepage: https://gitlab.com/fgi_nls/public/EODIE
metadata:
  docker_image: "N/A"
---

# workflow-constructed-from-history-eodie-sentinel

## Overview

This workflow demonstrates the practical application of the [EODIE](https://toolshed.g2.bx.psu.edu/view/climate/eodie/) toolkit for extracting object-based time series information from Earth Observation data. It specifically focuses on processing Sentinel-2 imagery to generate vegetation indices and statistical summaries for defined geographic areas.

The process takes three primary inputs: a Sentinel-2 Level-2A data package, a world tiles reference file, and a vector file containing the target parcels. These inputs are processed through the EODIE tool to calculate metrics such as NDVI, enabling the analysis of environmental changes or agricultural performance over time.

The workflow produces two main outputs: a comprehensive statistics file containing the extracted time series data and a detailed logfile for execution tracking. This setup is licensed under the [MIT License](https://opensource.org/licenses/MIT) and is tagged for use in earth-observation, timeseries analysis, and ndvi monitoring.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | S2B_MSIL2A_20200626T095029_N0214_R079_T34VFN_20200626T123234.tar | data_input | Sentinel2 input data. This input dataset corresponds to the data itself while sentinel2_tiles_world would be the corresponding shapefile for the tile. |
| 1 | sentinel2_tiles_world | data_input | This input dataset corresponds to the Sentinel-2 tile shapefile, originally provided by https://fromgistors.blogspot.com/2016/10/how-to-identify-sentinel-2-granule.html, |
| 2 | test_parcels_32635 | data_input | This input dataset is a shapefile corresponding the the area of interest e.g. on which statistics such as NDVI will be computed. |


Ensure input data includes the Sentinel-2 imagery in `.tar` format alongside the necessary tile reference and parcel vector files such as Shapefiles or GeoJSON. While individual datasets are used here, organizing multiple satellite scenes into a dataset collection can streamline batch processing for larger time series analysis. Refer to the `README.md` for specific coordinate system requirements and detailed parameter configurations for the EODIE tool. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | EODIE | toolshed.g2.bx.psu.edu/repos/climate/eodie/eodie/1.0.2 | This step corresponds to EODIE tool itself. It is run with a set of inputs and option to generate statistics over the region of interest (passed as input). the output is a list (one for each type of statistics e.g. ndvi, etc.). A logfile is also generated. |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | EODIE statistics | csv_files |
| 3 | logfile | logfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Workflow_constructed_from_history__EODIE_Sentinel.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Workflow_constructed_from_history__EODIE_Sentinel.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Workflow_constructed_from_history__EODIE_Sentinel.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Workflow_constructed_from_history__EODIE_Sentinel.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Workflow_constructed_from_history__EODIE_Sentinel.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Workflow_constructed_from_history__EODIE_Sentinel.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)