---
name: voronoi-segmentation
description: This Galaxy workflow performs Voronoi segmentation on planar RGB TIFF images and seed maps using tools for tessellation, thresholding, and feature extraction. Use this skill when you need to partition an image into distinct regions based on proximity to specific seed points to analyze individual object morphology and spatial distribution in biological or material samples.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# voronoi-segmentation

## Overview

This Galaxy workflow performs Voronoi segmentation to partition an image into regions based on provided seed points. It is designed for image analysis tasks where objects are ideally lighter than their background. The process requires two primary inputs in `.tiff` format: the raw image (stored in [planar RGB format](http://avitevet.com/uncategorized/when-to-use-it-interleaved-vs-planar-image-data-storage/)) and a corresponding seeds image containing white markers on a black background.

The pipeline begins by converting and preprocessing the input data, including smoothing the image via 2D filtering and converting binary seeds into a label map. It then computes the Voronoi tessellation and generates a mask through automated thresholding. These components are combined using image mathematics to produce the final segmentation, which isolates regions of interest based on the proximity to the input seeds.

In the final stages, the workflow extracts quantitative image features and counts the identified objects. It also provides visual outputs, such as a colorized label map and an overlay of the segmentation onto the original image, to facilitate qualitative validation. This generic workflow is tagged for [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) use and is licensed under the MIT license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Image | data_input | Image to be segmented. |
| 1 | Seeds | data_input | Seeds for the Voronoi segmentation. |


Ensure your input images and seeds are provided in `.tiff` format, specifically using planar RGB storage rather than interleaved to avoid processing errors. For optimal results, the primary image should feature light objects on a dark background, while the seeds must be white on a black background. You can upload these as individual datasets or organize them into collections for batch processing. Refer to the `README.md` for comprehensive parameter details and specific preprocessing requirements. For automated testing or execution, consider using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Convert image format | toolshed.g2.bx.psu.edu/repos/imgteam/bfconvert/ip_convertimage/6.7.0+galaxy3 |  |
| 3 | Convert binary image to label map | toolshed.g2.bx.psu.edu/repos/imgteam/binary2labelimage/ip_binary_to_labelimage/0.5+galaxy0 |  |
| 4 | Convert single-channel to multi-channel image | toolshed.g2.bx.psu.edu/repos/imgteam/repeat_channels/repeat_channels/1.26.4+galaxy0 |  |
| 5 | Filter 2-D image | toolshed.g2.bx.psu.edu/repos/imgteam/2d_simple_filter/ip_filter_standard/1.12.0+galaxy1 |  |
| 6 | Compute Voronoi tessellation | toolshed.g2.bx.psu.edu/repos/imgteam/voronoi_tesselation/voronoi_tessellation/0.22.0+galaxy3 |  |
| 7 | Threshold image | toolshed.g2.bx.psu.edu/repos/imgteam/2d_auto_threshold/ip_threshold/0.18.1+galaxy3 |  |
| 8 | Count objects in label map | toolshed.g2.bx.psu.edu/repos/imgteam/count_objects/ip_count_objects/0.0.5-2 |  |
| 9 | Extract image features | toolshed.g2.bx.psu.edu/repos/imgteam/2d_feature_extraction/ip_2d_feature_extraction/0.18.1+galaxy0 |  |
| 10 | Process images using arithmetic expressions | toolshed.g2.bx.psu.edu/repos/imgteam/image_math/image_math/1.26.4+galaxy2 |  |
| 11 | Colorize label map | toolshed.g2.bx.psu.edu/repos/imgteam/colorize_labels/colorize_labels/3.2.1+galaxy3 |  |
| 12 | Overlay images | toolshed.g2.bx.psu.edu/repos/imgteam/overlay_images/ip_overlay_images/0.0.4+galaxy4 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | Single channel image | output |
| 3 | label map | output |
| 4 | multi-channel image | output |
| 5 | Smoothed image | output |
| 6 | tesselation | result |
| 7 | mask | output |
| 8 | object count | output |
| 9 | image features | output |
| 10 | segmentation | result |
| 11 | colorized label map | output |
| 12 | segmented image | out_tiff |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run voronoi-segmentation.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run voronoi-segmentation.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run voronoi-segmentation.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init voronoi-segmentation.ga -o job.yml`
- Lint: `planemo workflow_lint voronoi-segmentation.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `voronoi-segmentation.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)