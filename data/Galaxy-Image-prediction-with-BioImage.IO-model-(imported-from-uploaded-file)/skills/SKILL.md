---
name: image-prediction-with-bioimageio-model-imported-from-uploade
description: "This workflow processes biological images by applying a BioImage.IO model through inference, thresholding, and label map conversion tools to generate segmented overlays. Use this skill when you need to perform automated object detection or segmentation on microscopy data using pre-trained deep learning models."
homepage: https://workflowhub.eu/workflows/1526
---

# Image prediction with BioImage.IO model (imported from uploaded file)

## Overview

This workflow facilitates image inference using pre-trained deep learning models from the [BioImage.IO](https://bioimage.io/) ecosystem. It is designed to take a user-uploaded BioImage.IO model package and a target image as primary inputs, allowing researchers to apply standardized AI models to their biological data within the Galaxy environment.

The process begins by running the model via the `bioimage_inference` tool. The resulting raw predictions are then refined through a series of post-processing steps, including splitting the image along specific axes and applying arithmetic expressions to normalize or adjust the output values.

To generate interpretable results, the workflow performs automated 2D thresholding to create binary masks, which are subsequently converted into label maps. The final output is a PNG visualization that overlays these predictions onto the original input image, providing a clear spatial context for the model's findings.

This workflow is particularly useful for [Imaging](https://galaxyproject.org/use/imaging/) analysis and is associated with [GTN](https://training.galaxyproject.org/) training materials. It is shared under a [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | BioImage.IO Model | data_input | This PyTorch [.pt] file is located in our Galaxy repository under the ML model/bioimaging-models directory. |
| 1 | Image for Prediction | data_input | Input image required for inference with the ML model. Ensure that the image is of the same biological type the model was trained on or is designed to process. The tool only accepts image files in TIFF or PNG format. |


Ensure the BioImage.IO model is uploaded as a `.zip` archive and the input image is in a compatible format such as TIFF or PNG. This workflow is designed to process individual datasets rather than collections, so ensure your inputs are selected accordingly in the history. Refer to the `README.md` for comprehensive details on model metadata requirements and specific preprocessing steps. You can use `planemo workflow_job_init` to create a `job.yml` file for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Process image using a BioImage.IO model | toolshed.g2.bx.psu.edu/repos/bgruening/bioimage_inference/bioimage_inference/2.4.1+galaxy3 |  |
| 3 | Split image along axes | toolshed.g2.bx.psu.edu/repos/imgteam/split_image/ip_split_image/2.2.3+galaxy1 |  |
| 4 | Extract dataset | __EXTRACT_DATASET__ |  |
| 5 | Extract dataset | __EXTRACT_DATASET__ |  |
| 6 | Process images using arithmetic expressions | toolshed.g2.bx.psu.edu/repos/imgteam/image_math/image_math/1.26.4+galaxy2 |  |
| 7 | Threshold image | toolshed.g2.bx.psu.edu/repos/imgteam/2d_auto_threshold/ip_threshold/0.18.1+galaxy3 |  |
| 8 | Convert binary image to label map | toolshed.g2.bx.psu.edu/repos/imgteam/binary2labelimage/ip_binary_to_labelimage/0.5+galaxy0 |  |
| 9 | Overlay images | toolshed.g2.bx.psu.edu/repos/imgteam/overlay_images/ip_overlay_images/0.0.4+galaxy4 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 9 | out_png | out_png |


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
