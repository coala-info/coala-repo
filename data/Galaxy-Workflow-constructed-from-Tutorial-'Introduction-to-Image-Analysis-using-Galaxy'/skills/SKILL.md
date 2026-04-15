---
name: workflow-constructed-from-tutorial-introduction-to-image-ana
description: This imaging workflow processes an input image through filtering, histogram equalization, and automated thresholding to generate label maps and object counts. Use this skill when you need to segment biological or physical structures from microscopy data to quantify the number of distinct objects present in a sample.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# workflow-constructed-from-tutorial-introduction-to-image-ana

## Overview

This workflow is based on the [Introduction to Image Analysis using Galaxy](https://training.galaxyproject.org/training-material/topics/imaging/tutorials/introduction-to-imaging/tutorial.html) tutorial from the Galaxy Training Network (GTN). It provides a foundational pipeline for processing 2D images, moving from initial metadata extraction to the quantification of biological or physical features.

The pipeline begins by retrieving image information and applying a 2D filter to reduce noise. It then performs histogram equalization to enhance contrast, followed by automated thresholding to segment the image into a binary format. This process allows for the clear separation of objects from the background.

In the final stages, the workflow converts the binary image into a label map to identify individual objects. The results are visualized by overlaying the processed data onto the original image and quantified by counting the detected objects. This MIT-licensed workflow is a primary resource for users learning basic imaging techniques within the Galaxy ecosystem.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | input_image | data_input | The image to be segmented |


Ensure your `input_image` is in a standard format like PNG, TIFF, or OME-TIFF to ensure the "Show image info" tool correctly parses the metadata. While the workflow accepts individual datasets, utilizing data collections is recommended if you intend to process batches of microscopy images simultaneously through the thresholding and labeling steps. Consult the `README.md` for comprehensive details on input specifications and expected image characteristics. You may also use `planemo workflow_job_init` to create a `job.yml` for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Show image info | toolshed.g2.bx.psu.edu/repos/imgteam/image_info/ip_imageinfo/5.7.1+galaxy1 |  |
| 2 | Filter 2-D image | toolshed.g2.bx.psu.edu/repos/imgteam/2d_simple_filter/ip_filter_standard/1.12.0+galaxy1 |  |
| 3 | Perform histogram equalization | toolshed.g2.bx.psu.edu/repos/imgteam/2d_histogram_equalization/ip_histogram_equalization/0.18.1+galaxy0 |  |
| 4 | Threshold image | toolshed.g2.bx.psu.edu/repos/imgteam/2d_auto_threshold/ip_threshold/0.18.1+galaxy3 |  |
| 5 | Convert binary image to label map | toolshed.g2.bx.psu.edu/repos/imgteam/binary2labelimage/ip_binary_to_labelimage/0.5+galaxy0 |  |
| 6 | Overlay images | toolshed.g2.bx.psu.edu/repos/imgteam/overlay_images/ip_overlay_images/0.0.4+galaxy4 |  |
| 7 | Count objects in label map | toolshed.g2.bx.psu.edu/repos/imgteam/count_objects/ip_count_objects/0.0.5-2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 6 | out_png | out_png |
| 7 | output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-gtn-tutorial--introduction-to-imaging.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-gtn-tutorial--introduction-to-imaging.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-gtn-tutorial--introduction-to-imaging.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-gtn-tutorial--introduction-to-imaging.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-gtn-tutorial--introduction-to-imaging.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-gtn-tutorial--introduction-to-imaging.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)