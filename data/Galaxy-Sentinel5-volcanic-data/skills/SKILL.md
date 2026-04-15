---
name: sentinel5-volcanic-data
description: This Galaxy workflow processes Copernicus Sentinel 5P satellite data to analyze the atmospheric impact of volcanic activity using the Copernicus Data Space Ecosystem notebook and Panoply visualization tool. Use this skill when you need to monitor volcanic sulfur dioxide emissions or visualize the dispersion of atmospheric pollutants resulting from volcanic eruptions.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# sentinel5-volcanic-data

## Overview

This workflow is designed to analyze the atmospheric impact of volcanic activity using high-resolution satellite imagery. It leverages data from the [Copernicus Sentinel 5P](https://sentinel.esa.int/web/sentinel/missions/sentinel-5p) mission, which is specifically equipped to monitor trace gases and pollutants such as sulfur dioxide and aerosols resulting from eruptions.

The process begins with the [Copernicus Data Space Ecosystem](https://dataspace.copernicus.eu/) interactive notebook, where users can query, filter, and process raw satellite datasets. Once the relevant data is prepared, the workflow transitions to [Panoply](https://www.giss.nasa.gov/tools/panoply/), a specialized visualization tool used to generate geo-referenced plots and inspect the spatial distribution of volcanic emissions.

Developed as part of the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/), this workflow provides a streamlined, reproducible path from raw data acquisition to professional visualization. It is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) and serves as a practical resource for environmental monitoring and atmospheric research.

## Inputs and data preparation

_None listed._


Ensure your input data is in NetCDF format to maintain compatibility with the Panoply visualization tool and the Copernicus notebook environment. When processing multiple satellite granules, organize your files into a dataset collection to streamline the workflow execution across the interactive tools. Refer to the included README.md for comprehensive instructions on configuring the necessary credentials for the Copernicus Data Space Ecosystem. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated testing and parameter management.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Copernicus Data Space Ecosystem | interactive_tool_copernicus_notebook |  |
| 1 | Panoply | interactive_tool_panoply |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

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