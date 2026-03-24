---
name: yolo-tail-analysis-training-workflow
description: "This bioimage analysis workflow processes image collections and class files using histogram equalization, AnyLabeling for interactive annotation, and YOLO for training segmentation and detection models. Use this skill when you need to train a custom deep learning model to automatically detect and segment tail structures in biological image datasets."
homepage: https://workflowhub.eu/workflows/1811
---

# YOLO - Tail analysis training workflow

## Overview

This Galaxy workflow provides a complete pipeline for YOLO-based tail analysis, specifically designed for image segmentation and detection in bioimage datasets. It is based on the [analysis workflow](https://git.embl.org/grp-cba/tail-analysis/-/blob/main/analysis_workflow.md) developed by the EMBL-CBA group. The process allows researchers to move from raw image collections to a fully trained YOLO model within a single environment.

The pipeline begins with image preprocessing, utilizing histogram equalization to enhance feature contrast and GraphicsMagick for format standardization. Users then perform manual annotation through the **AnyLabeling Interactive** tool. These interactive annotations are automatically converted from JSON format into the specific YOLO text format required for machine learning tasks.

In the final stage, the workflow executes YOLO training using the processed images and class labels. This results in a trained model optimized for tail segmentation. The workflow is licensed under GPL-3.0-or-later and is tagged for use in yolo and bioimage analysis projects.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input dataset collection | data_collection_input |  |
| 1 | Class File | data_input |  |


Ensure your raw images are organized in a dataset collection (typically PNG or TIFF) to facilitate batch processing through the histogram equalization and conversion steps. The class file must be a plain text file listing your target labels, which is essential for both the AnyLabeling interactive tool and the final YOLO training step. For comprehensive instructions on configuring the AnyLabeling interface and specific parameter tuning, refer to the included README.md. You can streamline the setup of your execution environment by using `planemo workflow_job_init` to generate a `job.yml` file.

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
planemo run Galaxy-Workflow-YOLO_-_Tail_analysis_training_workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-YOLO_-_Tail_analysis_training_workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-YOLO_-_Tail_analysis_training_workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-YOLO_-_Tail_analysis_training_workflow.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-YOLO_-_Tail_analysis_training_workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-YOLO_-_Tail_analysis_training_workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
