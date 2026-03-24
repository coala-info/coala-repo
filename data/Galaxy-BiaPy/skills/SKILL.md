---
name: biapy
description: "This bioimaging workflow processes test data and ground truth using a predefined BiaPy YAML configuration to generate post-processed predictions and 3D image renderings. Use this skill when you need to apply deep learning models to biological image datasets for automated analysis and require high-quality 3D visualizations of the resulting predictions."
homepage: https://workflowhub.eu/workflows/2088
---

# BiaPy

## Overview

This workflow facilitates the execution of [BiaPy](https://biapy.readthedocs.io/en/latest/) within the Galaxy ecosystem, specifically designed for bioimage analysis tasks. It utilizes a predefined YAML configuration file to manage model selection and parameters, streamlining the process of applying deep learning models to imaging datasets.

The pipeline requires three primary inputs: a collection of test data, a corresponding collection of image ground truth for evaluation, and the BiaPy YAML configuration file. The core processing is handled by the BiaPy tool, which performs the specified imaging tasks—such as segmentation or detection—based on the provided configuration.

Following the analysis, the workflow generates post-processed predictions and utilizes the `libcarna_render` tool to create 3D visualizations of the results. The final outputs include the processed image data and an interactive HTML report for data exploration. This workflow is tagged for [Imaging](https://galaxyproject.org/use/imaging/) and [GTN](https://training.galaxyproject.org/) use, licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input the test data | data_collection_input | Dataset to test your model on |
| 1 | Input a BiaPy YAML configuration file | data_input | A BiaPy YAML pre-configured file |
| 2 | Input the image ground truth | data_collection_input | Ground truth for the input test data |


Ensure your test data and ground truth are organized into Galaxy data collections containing supported image formats like TIFF or PNG to match the workflow's collection input requirements. The BiaPy configuration must be provided as a valid YAML file that specifies the model architecture and training parameters. Refer to the included README.md for comprehensive details on parameter tuning and specific data structure requirements. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Build a workflow with BiaPy | toolshed.g2.bx.psu.edu/repos/iuc/biapy/biapy/3.6.8+galaxy0 |  |
| 4 | Render 3-D image data | toolshed.g2.bx.psu.edu/repos/imgteam/libcarna_render/libcarna_render/0.2.0+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | predictions_post_proc | predictions_post_proc |
| 4 | html | html |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run biapy.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run biapy.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run biapy.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init biapy.ga -o job.yml`
- Lint: `planemo workflow_lint biapy.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `biapy.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
