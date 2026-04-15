---
name: ndvi-with-openeo
description: This Galaxy workflow calculates the Normalized Difference Vegetation Index (NDVI) using the Copernicus Data Space Ecosystem interactive notebook and Holoviz for data visualization. Use this skill when you need to monitor vegetation health or analyze land cover changes using satellite imagery processed through the OpenEO API.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# ndvi-with-openeo

## Overview

This workflow demonstrates how to calculate the Normalized Difference Vegetation Index (NDVI) using the [OpenEO](https://openeo.org/) API within the Galaxy environment. It leverages cloud-based Earth Observation data to process large-scale satellite imagery efficiently, allowing researchers to analyze vegetation health without the need for local data storage or heavy manual processing.

The analysis is performed through an interactive Jupyter notebook environment provided by the [Copernicus Data Space Ecosystem](https://dataspace.copernicus.eu/). Users can programmatically access Sentinel-2 data, apply the NDVI formula, and manage data cubes. The workflow then utilizes [Holoviz](https://holoviz.org/) to generate interactive visualizations, enabling a detailed exploration of the spatial and temporal changes in vegetation.

Developed as part of the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/), this resource is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/). It serves as a practical template for integrating cloud-native geospatial analysis into reproducible Galaxy pipelines.

## Inputs and data preparation

_None listed._


Ensure you have your Copernicus Data Space Ecosystem credentials ready, as this workflow utilizes interactive notebooks to process Sentinel-2 imagery via the OpenEO API. While individual datasets can be processed, organizing your spatial queries into collections within the interactive environment optimizes the performance of large-scale NDVI calculations. Refer to the included README.md for comprehensive instructions on configuring the interactive tool environments and specific authentication steps. You may also use `planemo workflow_job_init` to generate a `job.yml` file for streamlined parameter management and automated testing.

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
planemo run ndvi-with-openeo.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run ndvi-with-openeo.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run ndvi-with-openeo.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init ndvi-with-openeo.ga -o job.yml`
- Lint: `planemo workflow_lint ndvi-with-openeo.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `ndvi-with-openeo.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)