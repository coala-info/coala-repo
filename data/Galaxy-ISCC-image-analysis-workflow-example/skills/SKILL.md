---
name: iscc-image-analysis-workflow-example
description: "This bioimaging workflow processes original images and segmented data using channel splitting, Otsu thresholding, and ISCC-CODE generation to verify the integrity of image analysis steps. Use this skill when you need to ensure the reproducibility and consistency of image processing results by validating that segmented outputs correspond correctly to the source data through digital fingerprinting."
homepage: https://workflowhub.eu/workflows/2089
---

# ISCC - image analysis workflow example

## Overview

This workflow demonstrates how International Standard Content Codes (ISCC) can be utilized within a bioimaging context to verify image analysis steps and ensure data integrity. Designed as an example for the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/), it showcases how digital content identifiers act as similarity-preserving fingerprints to track transformations in imaging data.

The pipeline processes an original image and a pre-segmented dataset through several key stages. It utilizes tools to split images along specific axes and applies automated thresholding (Otsu) to generate segmented outputs. During this process, the workflow generates and verifies ISCC codes to validate the consistency of the analysis, ensuring that the processed results align with the expected content characteristics of the source data.

The final outputs include the Otsu-segmented image and the verified ISCC code. This approach is particularly valuable for [Bioimaging](https://galaxyproject.org/use/imaging/) workflows where provenance and reproducibility are critical, providing a standardized method to confirm that analysis steps have been executed correctly. The workflow is licensed under Apache-2.0.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | original_image | data_input | Select an original image that will be processed |
| 1 | Channel selection | parameter_input | Select the channel to segment |
| 2 | segmented image | data_input | Select an image segmentation result |


Ensure input images are provided in standard bioimaging formats such as OME-TIFF or PNG, and confirm that the channel selection parameter aligns with your specific image dimensions. While the workflow is configured for individual datasets, you may utilize dataset collections to efficiently process large batches of images for automated verification. Please refer to the README.md for comprehensive details regarding parameter configurations and expected ISCC code results. You can also use `planemo workflow_job_init` to generate a `job.yml` file for streamlined execution and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Split image along axes | toolshed.g2.bx.psu.edu/repos/imgteam/split_image/ip_split_image/2.3.5+galaxy0 | As the example image contains multiple channels |
| 4 | Generate ISCC-CODE | toolshed.g2.bx.psu.edu/repos/imgteam/iscc_sum/iscc_sum/0.1.0+galaxy1 |  |
| 5 | Extract dataset | __EXTRACT_DATASET__ |  |
| 6 | Parse parameter value | param_value_from_file |  |
| 7 | Threshold image | toolshed.g2.bx.psu.edu/repos/imgteam/2d_auto_threshold/ip_threshold/0.25.0+galaxy0 |  |
| 8 | Verify ISCC-CODE | toolshed.g2.bx.psu.edu/repos/imgteam/iscc_sum_verify/iscc_sum_verify/0.1.0+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 7 | otsu_segmented | output |
| 8 | ISCC-code | output_file |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run iscc---image-analysis-workflow-example.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run iscc---image-analysis-workflow-example.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run iscc---image-analysis-workflow-example.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init iscc---image-analysis-workflow-example.ga -o job.yml`
- Lint: `planemo workflow_lint iscc---image-analysis-workflow-example.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `iscc---image-analysis-workflow-example.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
