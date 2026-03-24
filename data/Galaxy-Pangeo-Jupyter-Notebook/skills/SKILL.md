---
name: pangeo-jupyter-notebook
description: "This Galaxy workflow launches an interactive Pangeo Jupyter Notebook environment tailored for geosciences and climate science using the Xarray library. Use this skill when you need to analyze large-scale multidimensional environmental datasets or perform high-performance computations on big data in the atmospheric and oceanic sciences."
homepage: https://workflowhub.eu/workflows/1423
---

# Pangeo Jupyter Notebook

## Overview

This workflow provides an interactive environment for geosciences and climate data analysis within Galaxy. It specifically implements the [GTN Pangeo Notebook](https://training.galaxyproject.org/training-material/topics/statistics/tutorials/pangeo-notebook/tutorial.html) tutorial, which serves as an introduction to using Xarray for handling multi-dimensional arrays and large-scale datasets.

The workflow utilizes the `interactive_tool_pangeo_notebook` to launch a Jupyter instance pre-configured with the Pangeo software stack. This environment is optimized for big-data processing, allowing users to leverage tools like Dask and Xarray to analyze complex climate models and geospatial data directly within the Galaxy interface.

Upon execution, the workflow generates a functional Jupyter Notebook as its primary output. This setup is ideal for researchers in the geosciences who require scalable computing resources and reproducible workflows for data visualization and statistical analysis under an MIT license.

## Inputs and data preparation

_None listed._


For optimal performance in this climate-focused workflow, provide input data in NetCDF or Zarr formats to fully utilize Xarray’s multidimensional processing features within the interactive environment. Use data collections rather than individual datasets when handling large-scale ensemble outputs or time-series observations to streamline the notebook's data loading process. Refer to the README.md for exhaustive details on environment configuration and specific library dependencies. You may also use `planemo workflow_job_init` to create a `job.yml` for standardized execution and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Interactive Pangeo Notebook | interactive_tool_pangeo_notebook |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | jupyter_notebook | jupyter_notebook |


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
