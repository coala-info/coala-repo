---
name: feature_extraction
description: This imaging workflow processes 2D input images through filtering, thresholding, and label map conversion to extract and filter quantitative features based on user-defined rules. Use this skill when you need to segment objects from microscopy or scientific images and perform automated quantitative analysis of their morphological or intensity-based characteristics.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# feature_extraction

## Overview

This workflow performs automated image analysis and feature extraction on 2D images. It begins by applying a [standard 2D filter](https://toolshed.g2.bx.psu.edu/repos/imgteam/2d_simple_filter/ip_filter_standard/1.12.0+galaxy1) to the input image, followed by an [automated thresholding](https://toolshed.g2.bx.psu.edu/repos/imgteam/2d_auto_threshold/ip_threshold/0.18.1+galaxy3) step to generate a binary image.

The binary output is converted into a label map to identify individual objects within the frame. The workflow then extracts initial features and applies specific [filter rules](https://toolshed.g2.bx.psu.edu/repos/imgteam/2d_filter_segmentation_by_features/ip_2d_filter_segmentation_by_features/0.0.1-4) to refine the segmentation, ensuring that only objects meeting the defined criteria are retained for the final analysis.

The final outputs consist of a refined label map and a detailed set of [extracted image features](https://toolshed.g2.bx.psu.edu/repos/imgteam/2d_feature_extraction/ip_2d_feature_extraction/0.18.1+galaxy0). This workflow is designed for Imaging research and is associated with the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/), provided under an MIT license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | input image | data_input |  |
| 1 | filter rules | data_input |  |


Ensure the input image is in a compatible format such as TIFF or PNG, while the filter rules should be provided as a tabular file. If you are processing multiple images, consider using a dataset collection to streamline the workflow execution. For comprehensive configuration details and parameter explanations, please refer to the `README.md` file. You can also use `planemo workflow_job_init` to generate a `job.yml` for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Filter 2-D image | toolshed.g2.bx.psu.edu/repos/imgteam/2d_simple_filter/ip_filter_standard/1.12.0+galaxy1 |  |
| 3 | Threshold image | toolshed.g2.bx.psu.edu/repos/imgteam/2d_auto_threshold/ip_threshold/0.18.1+galaxy3 |  |
| 4 | Convert binary image to label map | toolshed.g2.bx.psu.edu/repos/imgteam/binary2labelimage/ip_binary_to_labelimage/0.5+galaxy0 |  |
| 5 | Extract image features | toolshed.g2.bx.psu.edu/repos/imgteam/2d_feature_extraction/ip_2d_feature_extraction/0.18.1+galaxy0 |  |
| 6 | Filter label map by rules | toolshed.g2.bx.psu.edu/repos/imgteam/2d_filter_segmentation_by_features/ip_2d_filter_segmentation_by_features/0.0.1-4 |  |
| 7 | Extract image features | toolshed.g2.bx.psu.edu/repos/imgteam/2d_feature_extraction/ip_2d_feature_extraction/0.18.1+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 6 | output | output |
| 7 | output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run feature-extraction.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run feature-extraction.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run feature-extraction.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init feature-extraction.ga -o job.yml`
- Lint: `planemo workflow_lint feature-extraction.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `feature-extraction.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)