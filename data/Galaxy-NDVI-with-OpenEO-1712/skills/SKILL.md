---
name: ndvi-with-openeo
description: This Galaxy workflow calculates the Normalized Difference Vegetation Index using satellite imagery from the Copernicus Data Space Ecosystem processed through OpenEO and visualized with Holoviz. Use this skill when you need to monitor vegetation health, assess crop productivity, or analyze land cover changes over time using cloud-based Earth observation data.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# ndvi-with-openeo

## Overview

This workflow demonstrates how to calculate the Normalized Difference Vegetation Index (NDVI) using the [openEO](https://openeo.org/) API within the Galaxy ecosystem. It leverages cloud-based Earth observation data to monitor vegetation health and density, allowing researchers to process large-scale satellite imagery without the need for local data storage.

The analysis is performed through a series of interactive tools, starting with the [Copernicus Data Space Ecosystem](https://dataspace.copernicus.eu/) notebook. This environment allows users to programmatically access Sentinel-2 data and execute openEO processing chains. The workflow then utilizes [HoloViz](https://holoviz.org/) to generate interactive visualizations, enabling a detailed exploration of the resulting spatial datasets.

Developed as part of the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/), this resource is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/). It serves as a practical template for integrating cloud-native remote sensing workflows with interactive Jupyter-based analysis and advanced visualization tools.

## Inputs and data preparation

_None listed._


Ensure your area of interest is formatted as a GeoJSON file and identify the specific Sentinel-2 collections required for cloud-side processing. Distinguish between local Galaxy datasets used for visualization in Holoviz and the remote collections accessed via the OpenEO interface. Consult the README.md for exhaustive documentation on authentication credentials and specific parameter settings. For automated execution, consider using `planemo workflow_job_init` to create a `job.yml` file.

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