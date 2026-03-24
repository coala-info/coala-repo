---
name: voronoi-segmentation-for-astronomy-on-legacy-survey-data
description: "This astronomy workflow retrieves DESI Legacy Survey images using coordinate and band inputs to perform Voronoi segmentation and feature extraction through astropy and image processing tools. Use this skill when you need to partition astronomical images into discrete regions to identify celestial objects, calculate their spatial features, and analyze the morphology of survey data."
homepage: https://workflowhub.eu/workflows/1730
---

# Voronoi segmentation for Astronomy on Legacy Survey data

## Overview

This workflow performs Voronoi segmentation on astronomical imagery retrieved from the DESI Legacy Survey. Users provide specific celestial coordinates (RA and Dec), a search radius, pixel size, and the desired spectral band (g, r, z, or i). The pipeline is an adaptation of a [published Galaxy workflow](https://usegalaxy.eu/published/workflow?id=23030421cd9fcfb2) designed for advanced image analysis and object detection in deep-sky surveys.

The process begins by fetching FITS data and converting it into standard image formats. It applies several preprocessing steps, including histogram equalization for contrast enhancement and 2D filtering for smoothing. The workflow then utilizes automated thresholding to create binary masks, which are subsequently converted into label maps to identify and isolate distinct astronomical structures.

The core of the analysis involves computing a Voronoi tessellation to partition the image space based on the identified objects. The workflow performs image arithmetic to refine the segmentation and extracts quantitative data, such as object counts and 2D image features. Finally, it generates visual outputs by colorizing label maps and overlaying them onto the original imagery for qualitative inspection.

This tool is licensed under the MIT License and is categorized under segmentation, astronomy, and image analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | RA | parameter_input |  |
| 1 | Dec | parameter_input |  |
| 2 | Radius (arcmin) | parameter_input |  |
| 3 | pixel size (arcsec) | parameter_input |  |
| 4 | Band | parameter_input |  |


To run this workflow, ensure you provide the astronomical coordinates (RA/Dec) and radius as float values to correctly query the DESI Legacy Survey. The process primarily handles FITS files and converts them into standard image formats like PNG or TIFF for segmentation, so verify that your pixel size and band selection (g, r, z, or i) align with your specific research area. While the workflow operates on individual coordinate sets, you can use Galaxy dataset collections to batch process multiple sky regions simultaneously. For a comprehensive guide on parameter ranges and tool configurations, refer to the README.md file. You can also use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | DESI Legacy Survey | toolshed.g2.bx.psu.edu/repos/astroteam/desi_legacy_survey_astro_tool/desi_legacy_survey_astro_tool/0.0.1+galaxy0 |  |
| 6 | astropy fits2bitmap | toolshed.g2.bx.psu.edu/repos/astroteam/astropy_fits2bitmap/astropy_fits2bitmap/0.2.0+galaxy1 |  |
| 7 | Split image along axes | toolshed.g2.bx.psu.edu/repos/imgteam/split_image/ip_split_image/2.2.3+galaxy1 |  |
| 8 | Extract dataset | __EXTRACT_DATASET__ |  |
| 9 | Filter 2-D image | toolshed.g2.bx.psu.edu/repos/imgteam/2d_simple_filter/ip_filter_standard/1.12.0+galaxy1 |  |
| 10 | Convert image format | toolshed.g2.bx.psu.edu/repos/imgteam/bfconvert/ip_convertimage/6.7.0+galaxy3 |  |
| 11 | Perform histogram equalization | toolshed.g2.bx.psu.edu/repos/imgteam/2d_histogram_equalization/ip_histogram_equalization/0.18.1+galaxy0 |  |
| 12 | Convert single-channel to multi-channel image | toolshed.g2.bx.psu.edu/repos/imgteam/repeat_channels/repeat_channels/1.26.4+galaxy0 |  |
| 13 | Filter 2-D image | toolshed.g2.bx.psu.edu/repos/imgteam/2d_simple_filter/ip_filter_standard/1.12.0+galaxy1 |  |
| 14 | Threshold image | toolshed.g2.bx.psu.edu/repos/imgteam/2d_auto_threshold/ip_threshold/0.25.0+galaxy0 |  |
| 15 | Threshold image | toolshed.g2.bx.psu.edu/repos/imgteam/2d_auto_threshold/ip_threshold/0.18.1+galaxy3 |  |
| 16 | Convert binary image to label map | toolshed.g2.bx.psu.edu/repos/imgteam/binary2labelimage/ip_binary_to_labelimage/0.5+galaxy0 |  |
| 17 | Compute Voronoi tessellation | toolshed.g2.bx.psu.edu/repos/imgteam/voronoi_tesselation/voronoi_tessellation/0.22.0+galaxy3 |  |
| 18 | Process images using arithmetic expressions | toolshed.g2.bx.psu.edu/repos/imgteam/image_math/image_math/1.26.4+galaxy2 |  |
| 19 | Count objects in label map | toolshed.g2.bx.psu.edu/repos/imgteam/count_objects/ip_count_objects/0.0.5-2 |  |
| 20 | Extract image features | toolshed.g2.bx.psu.edu/repos/imgteam/2d_feature_extraction/ip_2d_feature_extraction/0.18.1+galaxy0 |  |
| 21 | Colorize label map | toolshed.g2.bx.psu.edu/repos/imgteam/colorize_labels/colorize_labels/3.2.1+galaxy3 |  |
| 22 | Overlay images | toolshed.g2.bx.psu.edu/repos/imgteam/overlay_images/ip_overlay_images/0.0.4+galaxy4 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 10 | Single channel image | output |
| 12 | multi-channel image | output |
| 13 | Smoothed image | output |
| 15 | mask | output |
| 16 | label map | output |
| 17 | tesselation | result |
| 18 | segmentation | result |
| 19 | object count | output |
| 20 | image features | output |
| 21 | colorized label map | output |
| 22 | segmented image | out_tiff |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Voronoi_segmentation_for_Astronomy_on_Legacy_Survey_data.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Voronoi_segmentation_for_Astronomy_on_Legacy_Survey_data.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Voronoi_segmentation_for_Astronomy_on_Legacy_Survey_data.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Voronoi_segmentation_for_Astronomy_on_Legacy_Survey_data.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Voronoi_segmentation_for_Astronomy_on_Legacy_Survey_data.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Voronoi_segmentation_for_Astronomy_on_Legacy_Survey_data.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
