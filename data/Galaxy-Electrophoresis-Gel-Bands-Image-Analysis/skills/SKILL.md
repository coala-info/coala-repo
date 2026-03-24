---
name: electrophoresis-gel-bands-image-analysis
description: "This bioimaging workflow processes electrophoresis gel images using QuPath and feature extraction tools to quantify band intensities from regions of interest. Use this skill when you need to perform precise densitometry or comparative quantification of molecular bands to analyze protein expression or nucleic acid concentrations."
homepage: https://workflowhub.eu/workflows/1848
---

# Electrophoresis-Gel-Bands-Image-Analysis

## Overview

This workflow automates the quantification of electrophoresis gel bands by integrating interactive annotation with automated image processing. Starting with an input image such as `Electropheresis-Gel.jpg`, the process utilizes [QuPath](https://qupath.github.io/) as an interactive tool within Galaxy to define Regions of Interest (ROIs) for specific bands.

The pipeline processes these annotations by converting coordinate data into label maps and extracting detailed image features. It employs a suite of tools to convert image formats, split images along axes for localized analysis, and retrieve metadata, ensuring that band intensities are measured accurately across the entire gel.

The final output consists of tabular data ready for visualization and statistical analysis. This [MIT-licensed](https://opensource.org/licenses/MIT) workflow is designed for bioimaging researchers needing a reproducible method to quantify gel electrophoresis results, following standards often found in [GTN](https://training.galaxyproject.org/) training materials.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Electropheresis-Gel.jpg | data_input |  |


Ensure your input gel images are in standard formats like JPG or PNG, as the workflow includes conversion steps to prepare them for feature extraction. While single datasets are sufficient for individual runs, using dataset collections is highly recommended when processing multiple gels to streamline the batch analysis of band intensities. Since the workflow relies on QuPath for ROI generation, verify that your coordinate files are correctly formatted before proceeding to the label map conversion. Refer to the README.md for comprehensive instructions on configuring the interactive QuPath environment and specific tool parameters. You can also use `planemo workflow_job_init` to create a `job.yml` for automated execution and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Convert coordinates to label map | toolshed.g2.bx.psu.edu/repos/imgteam/points2labelimage/ip_points_to_label/0.4.1+galaxy1 |  |
| 2 | Convert image format | toolshed.g2.bx.psu.edu/repos/bgruening/graphicsmagick_image_convert/graphicsmagick_image_convert/1.3.45+galaxy0 |  |
| 3 | Extract image features | toolshed.g2.bx.psu.edu/repos/imgteam/2d_feature_extraction/ip_2d_feature_extraction/0.18.1+galaxy0 |  |
| 4 | Show image info | toolshed.g2.bx.psu.edu/repos/imgteam/image_info/ip_imageinfo/5.7.1+galaxy1 |  |
| 5 | Split image along axes | toolshed.g2.bx.psu.edu/repos/imgteam/split_image/ip_split_image/2.2.3+galaxy1 |  |
| 6 | QuPath | interactive_tool_qupath |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 6 | outputs | outputs |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-electrophoresis-gel-bands-image-analysis.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-electrophoresis-gel-bands-image-analysis.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-electrophoresis-gel-bands-image-analysis.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-electrophoresis-gel-bands-image-analysis.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-electrophoresis-gel-bands-image-analysis.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-electrophoresis-gel-bands-image-analysis.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
