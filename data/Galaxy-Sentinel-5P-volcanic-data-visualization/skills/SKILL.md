---
name: sentinel5-volcanic-data
description: This Galaxy workflow processes Copernicus Sentinel-5P satellite data using an interactive notebook and Panoply to visualize the atmospheric impact of volcanic activity. Use this skill when you need to analyze trace gas concentrations or aerosol distributions resulting from volcanic eruptions to assess their environmental consequences.
homepage: https://eurosciencegateway.eu/
metadata:
  docker_image: "N/A"
---

# sentinel5-volcanic-data

## Overview

This workflow facilitates the analysis and visualization of atmospheric impacts resulting from volcanic activity. By leveraging data from the [Copernicus Sentinel-5P](https://sentinel.esa.int/web/sentinel/missions/sentinel-5p) mission, users can track trace gases and pollutants emitted during eruptions to better understand their environmental consequences.

The process begins with the **Copernicus Data Space Ecosystem** interactive notebook, which allows for the direct acquisition and preprocessing of satellite datasets. This stage is essential for filtering specific temporal and spatial parameters related to volcanic events before further analysis.

Once the data is prepared, the workflow employs **Panoply**, a specialized interactive tool for plotting geo-referenced arrays. This enables the creation of high-quality visualizations and maps that illustrate the distribution and concentration of volcanic emissions in the atmosphere.

This resource is shared under a [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) license, making it a versatile tool for researchers and students interested in Earth observation and environmental monitoring.

## Inputs and data preparation

_None listed._


When preparing your inputs, ensure Sentinel-5P products are in NetCDF (.nc) format to maintain full compatibility with the Panoply visualization tool. Utilizing data collections is highly effective for managing multiple atmospheric observations or time-series orbits simultaneously within the Copernicus interactive environment. Please consult the README.md for exhaustive details on data retrieval protocols and specific parameter configurations. Additionally, you may use `planemo workflow_job_init` to create a `job.yml` for streamlined job configuration and testing.

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
planemo run Sentinel 5P data visualisation.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Sentinel 5P data visualisation.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Sentinel 5P data visualisation.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Sentinel 5P data visualisation.ga -o job.yml`
- Lint: `planemo workflow_lint Sentinel 5P data visualisation.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Sentinel 5P data visualisation.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)