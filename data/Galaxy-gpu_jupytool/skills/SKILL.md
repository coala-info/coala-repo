---
name: gpu_jupytool
description: "This Galaxy workflow processes tabular test data and labels using filtering and cutting tools before launching a GPU-enabled interactive Jupyter Notebook for machine learning tasks. Use this skill when you need to perform computationally intensive machine learning analysis or model training that requires GPU acceleration within an interactive notebook environment."
homepage: https://workflowhub.eu/workflows/1579
---

# gpu_jupytool

## Overview

This workflow provides a specialized environment for machine learning tasks by integrating GPU-accelerated computing with interactive development. Tagged for [GTN](https://training.galaxyproject.org/) (Galaxy Training Network), it is designed to facilitate high-performance data analysis and model prototyping within the Galaxy ecosystem.

The pipeline begins by processing input datasets, including an initial IPynb notebook, test rows, and corresponding labels. It utilizes standard data manipulation tools, specifically **Filter** and **Cut**, to refine and format the input data before it is passed into the interactive environment.

The core of the workflow is the **GPU enabled Interactive Jupyter Notebook for Machine Learning**. This tool allows users to execute code in a high-performance workspace, leveraging GPU resources for intensive computations. The workflow produces several key outputs, including the modified Jupyter notebook, a collection of generated results, and the processed data files from the filtering and cutting steps.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | IPynb notebook | data_input |  |
| 2 | test_rows | data_input |  |
| 3 | test_rows_labels | data_input |  |


Ensure the input notebook is provided in `.ipynb` format, while the test data and labels should be uploaded as tabular datasets or CSVs to ensure compatibility with the filtering and machine learning tools. Although the primary inputs are individual datasets, the workflow utilizes an output collection to manage the various results generated during the interactive session. For comprehensive instructions on configuring the GPU environment and specific library dependencies, refer to the `README.md` file. You can streamline the preparation of these inputs by using `planemo workflow_job_init` to create a template `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Filter | Filter1 |  |
| 4 | GPU enabled Interactive Jupyter Notebook for Machine Learning | interactive_tool_ml_jupyter_notebook |  |
| 5 | Cut | Cut1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | out_file1 | out_file1 |
| 4 | output_collection | output_collection |
| 4 | jupyter_notebook | jupyter_notebook |
| 5 | out_file1 | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run gpu-jupyterlab-as-jupytool.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run gpu-jupyterlab-as-jupytool.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run gpu-jupyterlab-as-jupytool.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init gpu-jupyterlab-as-jupytool.ga -o job.yml`
- Lint: `planemo workflow_lint gpu-jupyterlab-as-jupytool.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `gpu-jupyterlab-as-jupytool.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
