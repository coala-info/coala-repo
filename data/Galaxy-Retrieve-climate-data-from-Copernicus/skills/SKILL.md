---
name: retrieve-climate-data-from-copernicus
description: "This Galaxy workflow retrieves climate datasets from the Copernicus Climate Data Store using an API request file as input. Use this skill when you need to programmatically download large-scale meteorological or environmental datasets for climate modeling and impact assessment."
homepage: https://workflowhub.eu/workflows/1625
---

# Retrieve climate data from Copernicus

## Overview

This workflow automates the retrieval of climate datasets from the [Copernicus Climate Data Store (CDS)](https://cds.climate.copernicus.eu/). It provides a streamlined interface for researchers to access vast repositories of environmental and climate data directly within the Galaxy ecosystem, facilitating reproducible data acquisition for climate science.

The process requires a single input: an API Request file containing the specific parameters needed to identify the desired dataset, such as variables, time ranges, and geographical coordinates. The core operation is performed by the [Copernicus Climate Data Store tool](https://toolshed.g2.bx.psu.edu/view/climate/c3s/), which communicates with the CDS API to process the request and download the relevant files.

Upon completion, the workflow generates two primary outputs: the retrieved climate data file and a copy of the API request used. This ensures that the data sourcing process is transparent and easily documented for future research or [GTN](https://training.galaxyproject.org/) training purposes.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | API Request file | data_input |  |


The primary input for this workflow is a JSON or text-based API request file containing the specific parameters required by the Copernicus Climate Data Store. Ensure you provide this as a single dataset rather than a collection to avoid processing errors during the data retrieval step. For comprehensive details on obtaining your API credentials and formatting the request syntax, refer to the `README.md` file. You may also use `planemo workflow_job_init` to create a `job.yml` for streamlined local execution and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Copernicus Climate Data Store | toolshed.g2.bx.psu.edu/repos/climate/c3s/c3s/0.1.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | ofilename | ofilename |
| 1 | request | request |


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
