---
name: analyse-argo-data
description: "This oceanography workflow retrieves Argo float data and processes it using the Pangeo ecosystem and xarray tools for visualization in Ocean Data View. Use this skill when you need to analyze vertical ocean profiles or temporal variations in seawater properties to understand marine environmental changes."
homepage: https://workflowhub.eu/workflows/1436
---

# Analyse Argo data

## Overview

This workflow provides a streamlined pipeline for oceanographic research, specifically designed to process and visualize Argo float data. It leverages the [Pangeo Ecosystem](https://pangeo.io/) within Galaxy to automate the retrieval of datasets using the [Argo data access](https://toolshed.g2.bx.psu.edu/repos/ecology/argo_getdata/argo_getdata/0.1.15+galaxy0) tool, ensuring researchers can efficiently source high-quality NetCDF files.

Once the data is acquired, the workflow utilizes a series of xarray-based tools to inspect and manipulate the datasets. It extracts critical coordinate and metadata information and employs a timeseries extractor to isolate specific oceanographic variables. This processing stage prepares the data for rigorous analysis by ensuring all spatial and temporal parameters are correctly defined.

The final stage of the workflow integrates the [Ocean Data View (ODV)](https://odv.awi.de/) interactive tool for advanced visualization. This allows users to explore vertical profiles, sections, and time-series plots directly within the Galaxy environment. This resource is particularly useful for Earth-system sciences and is featured in the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/), provided under a [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) license.

## Inputs and data preparation

_None listed._


Ensure you use NetCDF format for all input and intermediate files to maintain compatibility with the xarray and ODV tools. Organizing your Argo profiles into a dataset collection is highly recommended to streamline batch processing across the metadata and extraction steps. For comprehensive guidance on specific tool parameters and data selection criteria, please refer to the README.md file. You can also use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Argo data access | toolshed.g2.bx.psu.edu/repos/ecology/argo_getdata/argo_getdata/0.1.15+galaxy0 |  |
| 1 | NetCDF xarray Coordinate Info | toolshed.g2.bx.psu.edu/repos/ecology/xarray_coords_info/xarray_coords_info/2022.3.0+galaxy0 |  |
| 2 | NetCDF xarray Metadata Info | toolshed.g2.bx.psu.edu/repos/ecology/xarray_metadata_info/xarray_metadata_info/2022.3.0+galaxy0 |  |
| 3 | NetCDF timeseries Extractor | toolshed.g2.bx.psu.edu/repos/ecology/timeseries_extraction/timeseries_extraction/2022.3.0+galaxy0 |  |
| 4 | ODV | interactive_tool_odv |  |


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
