---
name: segmentation-and-counting-of-cell-nuclei-in-fluorescence-mic
description: This Galaxy workflow processes fluorescence microscopy images to segment and count cell nuclei using 2-D filtering, histogram equalization, and Otsu thresholding. Use this skill when you need to automate the identification of individual nuclei and obtain precise object counts or label maps from single-channel biological imaging data.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# segmentation-and-counting-of-cell-nuclei-in-fluorescence-mic

## Overview

This workflow automates the detection and quantification of cell nuclei in fluorescence microscopy images. It is based on the [Galaxy Training Network tutorial](https://training.galaxyproject.org/training-material/topics/imaging/tutorials/imaging-introduction/tutorial.html) for introductory bioimage analysis and is provided under an MIT license.

The pipeline begins by preprocessing a single-channel input image using 2D filtering and histogram equalization to enhance contrast and reduce noise. Segmentation is then performed using the Otsu thresholding method (Otsu, 1979), which automatically calculates an optimal threshold to separate nuclei from the background.

The resulting binary mask is converted into a label map where each individual nucleus is assigned a unique identifier. The workflow generates three primary outputs: a label image for downstream analysis, a tabular count of the detected objects, and an overlay image that allows for visual verification of the segmentation results against the original data.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | input_image | data_input | The fluorescence microscopy images to be segmented. Must be the single image channel, which contains the cell nuclei. |


Ensure your input images are in standard formats like TIFF, PNG, or OME-TIFF, specifically providing the single channel containing the cell nuclei for accurate segmentation. While the workflow accepts individual datasets, you can process multiple images efficiently by using a dataset collection. For comprehensive configuration details and parameter settings, refer to the `README.md` file. You can also automate the execution setup by using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Filter 2-D image | toolshed.g2.bx.psu.edu/repos/imgteam/2d_simple_filter/ip_filter_standard/1.12.0+galaxy1 |  |
| 2 | Perform histogram equalization | toolshed.g2.bx.psu.edu/repos/imgteam/2d_histogram_equalization/ip_histogram_equalization/0.18.1+galaxy0 |  |
| 3 | Threshold image | toolshed.g2.bx.psu.edu/repos/imgteam/2d_auto_threshold/ip_threshold/0.18.1+galaxy3 |  |
| 4 | Convert image format | toolshed.g2.bx.psu.edu/repos/imgteam/bfconvert/ip_convertimage/6.7.0+galaxy3 |  |
| 5 | Convert binary image to label map | toolshed.g2.bx.psu.edu/repos/imgteam/binary2labelimage/ip_binary_to_labelimage/0.5+galaxy0 |  |
| 6 | Overlay images | toolshed.g2.bx.psu.edu/repos/imgteam/overlay_images/ip_overlay_images/0.0.4+galaxy4 |  |
| 7 | Count objects in label map | toolshed.g2.bx.psu.edu/repos/imgteam/count_objects/ip_count_objects/0.0.5-2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | label_image | output |
| 6 | overlay_image | out_png |
| 7 | objects_count | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run segmentation-and-counting.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run segmentation-and-counting.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run segmentation-and-counting.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init segmentation-and-counting.ga -o job.yml`
- Lint: `planemo workflow_lint segmentation-and-counting.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `segmentation-and-counting.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)