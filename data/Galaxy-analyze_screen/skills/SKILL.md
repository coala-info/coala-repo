---
name: analyze_screen
description: "This Galaxy workflow processes HeLa fluorescence siRNA screen images and rules through a feature extraction subworkflow and collection collapsing tools. Use this skill when you need to quantify cellular phenotypes and analyze high-throughput imaging data from siRNA knockdown experiments in HeLa cell lines."
homepage: https://workflowhub.eu/workflows/1512
---

# analyze_screen

## Overview

This workflow is designed to analyze HeLa fluorescence siRNA screens, facilitating high-content imaging data processing within the Galaxy ecosystem. It is based on methodologies often featured in [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) tutorials for bioimage analysis, providing a structured approach to quantifying cellular phenotypes from large image datasets.

The pipeline requires two primary inputs: a data collection of fluorescence images and a set of rules for organizing the metadata. The core of the analysis is performed by a `feature_extraction` subworkflow, which processes the raw images to identify cellular structures and extract relevant morphological or intensity-based features.

In the final stage, the workflow employs the `Collapse Collection` tool to aggregate the extracted features from individual images into a single, consolidated dataset. This output provides a comprehensive summary of the screen, ready for downstream statistical evaluation or hit identification.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | input images | data_collection_input |  |
| 1 | rules | data_input |  |


Ensure your fluorescence images are organized into a dataset collection to facilitate batch processing through the feature extraction subworkflow. The rules input typically requires a tabular file defining the metadata mapping for the screen. For comprehensive instructions on preparing your specific image formats and rule syntax, refer to the `README.md` file. You can automate the creation of your input configuration by using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | feature_extraction | (subworkflow) |  |
| 3 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run analyze-screen.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run analyze-screen.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run analyze-screen.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init analyze-screen.ga -o job.yml`
- Lint: `planemo workflow_lint analyze-screen.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `analyze-screen.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
