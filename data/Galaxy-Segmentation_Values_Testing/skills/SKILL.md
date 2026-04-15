---
name: segmentation_values_testing
description: This imaging workflow evaluates nuclei segmentation performance by processing input images with varying Gaussian sigma values using 2D filtering, histogram equalization, and automated thresholding tools. Use this skill when you need to determine the optimal pre-processing parameters for accurate biological object detection by comparing automated segmentation results against a reference ground truth.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# segmentation_values_testing

## Overview

This Galaxy workflow is designed to evaluate the impact of Gaussian filtering on nuclei segmentation accuracy. By testing a range of sigma values during the pre-processing stage, users can determine which parameters yield the most precise results for their specific imaging datasets. The workflow requires three primary inputs: the raw image to be segmented, a list of sigma values, and a ground truth image for performance benchmarking.

The pipeline begins by parsing the sigma values and applying a [2-D simple filter](https://toolshed.g2.bx.psu.edu/repos/imgteam/2d_simple_filter/ip_filter_standard/1.12.0+galaxy1) to the input image. To prepare the data for segmentation, it performs [histogram equalization](https://toolshed.g2.bx.psu.edu/repos/imgteam/2d_histogram_equalization/ip_histogram_equalization/0.18.1+galaxy0) followed by [automated thresholding](https://toolshed.g2.bx.psu.edu/repos/imgteam/2d_auto_threshold/ip_threshold/0.18.1+galaxy3) to generate binary masks of the detected objects.

In the final stage, the workflow uses [segmetrics](https://toolshed.g2.bx.psu.edu/repos/imgteam/segmetrics/ip_segmetrics/1.4.0-2) to calculate object detection and segmentation performance measures by comparing the generated masks against the ground truth. The results are then consolidated into a single output collection for easy comparison. This workflow is particularly relevant for [GTN](https://training.galaxyproject.org/) imaging tutorials and is provided under the MIT license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Image to segment | data_input | Upload an image or provide a dataset to initiate the image segmentation process. |
| 1 | Sigma Values | data_input | Input a series of sigma values as tabular file |
| 2 | Ground Truth Image | data_input | Input the ground truth image |


Ensure your input images and ground truth masks are in standard formats like OME-TIFF or PNG, while the sigma values should be provided as a tabular file to facilitate the splitting process. Utilizing dataset collections for your input images is recommended to efficiently handle batch processing across different parameter sets. Please refer to the `README.md` for comprehensive details on data formatting and ground truth requirements. You may also use `planemo workflow_job_init` to create a `job.yml` for streamlined execution and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Split by group | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_on_column/tp_split_on_column/0.6 |  |
| 4 | Parse parameter value | param_value_from_file |  |
| 5 | Filter 2-D image | toolshed.g2.bx.psu.edu/repos/imgteam/2d_simple_filter/ip_filter_standard/1.12.0+galaxy1 |  |
| 6 | Perform histogram equalization | toolshed.g2.bx.psu.edu/repos/imgteam/2d_histogram_equalization/ip_histogram_equalization/0.18.1+galaxy0 |  |
| 7 | Threshold image | toolshed.g2.bx.psu.edu/repos/imgteam/2d_auto_threshold/ip_threshold/0.18.1+galaxy3 |  |
| 8 | Compute image segmentation and object detection performance measures | toolshed.g2.bx.psu.edu/repos/imgteam/segmetrics/ip_segmetrics/1.4.0-2 |  |
| 9 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 9 | output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run segmentation-values-testing.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run segmentation-values-testing.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run segmentation-values-testing.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init segmentation-values-testing.ga -o job.yml`
- Lint: `planemo workflow_lint segmentation-values-testing.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `segmentation-values-testing.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)