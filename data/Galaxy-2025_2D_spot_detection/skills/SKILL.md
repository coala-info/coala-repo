---
name: 2025_2d_spot_detection
description: This bioimaging workflow retrieves images from the Image Data Resource by ID to perform 2D spot detection on specific channels and z-stacks using histogram equalization and automated blob detection tools. Use this skill when you need to identify and visualize punctate signals or smFISH spots within specific focal planes of large-scale public biological datasets.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# 2025_2d_spot_detection

## Overview

This workflow is designed for automated 2D spot and blob detection within bioimaging datasets, specifically targeting applications such as [smFISH](https://en.wikipedia.org/wiki/Fluorescence_in_situ_hybridization). It streamlines the process of fetching image data directly from the [Image Data Resource (IDR)](https://idr.openmicroscopy.org/) using specific IDs, allowing users to isolate and analyze individual channels and z-stacks.

The pipeline begins by downloading and unzipping the requested imagery, followed by a pre-processing step of histogram equalization to normalize image intensity. This enhancement ensures more robust feature identification during the subsequent 2D spot detection phase.

Once spots are detected, the workflow converts the resulting point coordinates into a label map. The final output is a visual overlay of the detected spots onto the original image, provided as a PNG file for easy verification. This tool is particularly useful for researchers following [GTN](https://training.galaxyproject.org/) protocols for high-throughput bioimaging segmentation and is released under the [MIT license](https://opensource.org/licenses/MIT).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | IDR IDs | parameter_input | A list of images IDs from IDR |
| 1 | Channel to analyze | parameter_input | Name of the image channel to analyze |
| 2 | z-stack | parameter_input | Select a z-stack to analyze |


Ensure you have the specific IDR image IDs ready as text parameters, alongside the target channel and z-stack indices required for the spot detection process. While individual IDs can be processed, using a dataset collection is recommended for scaling the analysis across multiple image sets efficiently. For comprehensive instructions on formatting these parameters and understanding the pre-processing steps, refer to the README.md file. You can also use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Download IDR/OMERO | toolshed.g2.bx.psu.edu/repos/iuc/idr_download_by_ids/idr_download_by_ids/0.45 |  |
| 4 | Unzip | toolshed.g2.bx.psu.edu/repos/imgteam/unzip/unzip/6.0+galaxy0 |  |
| 5 | Perform histogram equalization | toolshed.g2.bx.psu.edu/repos/imgteam/2d_histogram_equalization/ip_histogram_equalization/0.18.1+galaxy0 | List of images from IDR to analyzed |
| 6 | Perform 2-D spot detection | toolshed.g2.bx.psu.edu/repos/imgteam/spot_detection_2d/ip_spot_detection_2d/0.1+galaxy0 |  |
| 7 | Convert point coordinates to label map | toolshed.g2.bx.psu.edu/repos/imgteam/points2labelimage/ip_points_to_label/0.4+galaxy0 |  |
| 8 | Overlay images | toolshed.g2.bx.psu.edu/repos/imgteam/overlay_images/ip_overlay_images/0.0.4+galaxy4 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 8 | out_png | out_png |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run 2025-2d-spot-detection.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run 2025-2d-spot-detection.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run 2025-2d-spot-detection.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init 2025-2d-spot-detection.ga -o job.yml`
- Lint: `planemo workflow_lint 2025-2d-spot-detection.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `2025-2d-spot-detection.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)