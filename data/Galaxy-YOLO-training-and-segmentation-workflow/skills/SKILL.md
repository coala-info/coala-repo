---
name: yolo-training-and-segmentation-workflow
description: "This bioimage analysis workflow processes image collections and YOLO class files using histogram equalization, AnyLabeling for interactive annotation, and YOLO for model training and segmentation. Use this skill when you need to perform automated object detection or segmentation on biological images by annotating custom datasets and training a YOLO-based model for precise feature analysis."
homepage: https://workflowhub.eu/workflows/1840
---

# YOLO training and segmentation workflow

## Overview

This Galaxy workflow provides a comprehensive pipeline for YOLO-based image segmentation and detection, specifically optimized for tail analysis. It is based on the [tail-analysis workflow](https://git.embl.org/grp-cba/tail-analysis/-/blob/main/analysis_workflow.md) and integrates standard bioimage processing steps to facilitate reproducible model training.

The process begins with image preprocessing, where input collections undergo histogram equalization and format conversion to ensure data consistency. Users then perform interactive annotation using the AnyLabeling tool. These annotations are automatically converted from JSON format into YOLO-compatible text files, streamlining the transition from manual labeling to machine learning.

In the final stage, the workflow executes YOLO training to generate models for object detection and segmentation. This automated approach is designed for bioimage researchers and follows [GTN](https://training.galaxyproject.org/) best practices, making it a robust solution for specialized morphological analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input Images | data_collection_input |  |
| 1 | YOLO Class File | data_input |  |


Ensure your input images are organized into a data collection to facilitate batch processing, while the YOLO class file should be uploaded as a single text dataset defining your target labels. Common image formats like PNG or TIFF are recommended, as the workflow includes conversion steps to prepare them for the AnyLabeling interactive tool. Refer to the `README.md` for comprehensive instructions on configuring the labeling interface and specific training hyperparameters. You can use `planemo workflow_job_init` to generate a `job.yml` for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Perform histogram equalization | toolshed.g2.bx.psu.edu/repos/imgteam/2d_histogram_equalization/ip_histogram_equalization/0.18.1+galaxy0 |  |
| 3 | Convert image format | toolshed.g2.bx.psu.edu/repos/bgruening/graphicsmagick_image_convert/graphicsmagick_image_convert/1.3.45+galaxy0 |  |
| 4 | AnyLabeling Interactive | interactive_tool_anylabeling |  |
| 5 | Convert AnyLabeling JSON to YOLO text | toolshed.g2.bx.psu.edu/repos/bgruening/json2yolosegment/json2yolosegment/8.3.0+galaxy2 |  |
| 6 | Perform YOLO training | toolshed.g2.bx.psu.edu/repos/bgruening/yolo_training/yolo_training/8.3.0+galaxy2 |  |


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
