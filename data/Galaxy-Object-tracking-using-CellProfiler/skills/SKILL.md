---
name: cp_object_tracking_example
description: This workflow processes image datasets using CellProfiler modules to identify, measure, and track biological objects across time-lapse sequences. Use this skill when you need to quantify temporal changes in cell morphology, intensity, or movement and generate tracked visual overlays from microscopy data.
homepage: https://www.ibisba.eu
metadata:
  docker_image: "N/A"
---

# cp_object_tracking_example

## Overview

This Galaxy workflow provides an automated pipeline for [CellProfiler](https://cellprofiler.org/) imaging analysis, specifically designed for object tracking. It begins by processing input datasets through common starting modules and a color-to-gray conversion to prepare images for segmentation. The workflow includes an unzipping step to handle compressed image sets, ensuring all frames are available for temporal analysis.

The core of the analysis involves identifying primary objects and extracting detailed morphological and intensity measurements. By utilizing the `TrackObjects` module, the workflow links identified objects across consecutive frames to monitor movement or changes over time. Results are visualized through overlaid outlines and tiled image sets, while quantitative data is formatted for downstream analysis using the `ExportToSpreadsheet` tool.

This example is tagged for **imaging** and **CellProfiler** applications, offering a comprehensive template for researchers needing to quantify dynamic cellular behavior. The final outputs include the processed image files, structured spreadsheets of measurements, and detailed execution logs.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 1 | Input dataset | data_input |  |


Ensure your input is a single compressed archive (e.g., .zip) containing the image sequence, as the pipeline includes an unzipping step to prepare files for processing. While this example uses a single dataset, you can adapt the workflow for high-throughput analysis by utilizing dataset collections to handle multiple image sets simultaneously. Refer to the README.md for specific details on configuring the CellProfiler modules and metadata requirements. You can automate the execution and testing of this workflow using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Starting Modules | toolshed.g2.bx.psu.edu/repos/bgruening/cp_common/cp_common/3.1.9+galaxy1 |  |
| 2 | ColorToGray | toolshed.g2.bx.psu.edu/repos/bgruening/cp_color_to_gray/cp_color_to_gray/3.1.9+galaxy0 |  |
| 3 | Unzip | toolshed.g2.bx.psu.edu/repos/imgteam/unzip/unzip/0.2 |  |
| 4 | IdentifyPrimaryObjects | toolshed.g2.bx.psu.edu/repos/bgruening/cp_identify_primary_objects/cp_identify_primary_objects/3.1.9+galaxy1 |  |
| 5 | MeasureObjectSizeShape | toolshed.g2.bx.psu.edu/repos/bgruening/cp_measure_object_size_shape/cp_measure_object_size_shape/3.1.9+galaxy0 |  |
| 6 | MeasureObjectIntensity | toolshed.g2.bx.psu.edu/repos/bgruening/cp_measure_object_intensity/cp_measure_object_intensity/3.1.9+galaxy0 |  |
| 7 | TrackObjects | toolshed.g2.bx.psu.edu/repos/bgruening/cp_track_objects/cp_track_objects/3.1.9+galaxy0 |  |
| 8 | OverlayOutlines | toolshed.g2.bx.psu.edu/repos/bgruening/cp_overlay_outlines/cp_overlay_outlines/3.1.9+galaxy0 |  |
| 9 | Tile | toolshed.g2.bx.psu.edu/repos/bgruening/cp_tile/cp_tile/3.1.9+galaxy0 |  |
| 10 | SaveImages | toolshed.g2.bx.psu.edu/repos/bgruening/cp_save_images/cp_save_images/3.1.9+galaxy1 |  |
| 11 | ExportToSpreadsheet | toolshed.g2.bx.psu.edu/repos/bgruening/cp_export_to_spreadsheet/cp_export_to_spreadsheet/3.1.9+galaxy1 |  |
| 12 | CellProfiler | toolshed.g2.bx.psu.edu/repos/bgruening/cp_cellprofiler/cp_cellprofiler/3.1.9+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | output_pipeline | output_pipeline |
| 2 | output_pipeline | output_pipeline |
| 3 | unzipped | unzipped |
| 4 | output_pipeline | output_pipeline |
| 5 | output_pipeline | output_pipeline |
| 6 | output_pipeline | output_pipeline |
| 7 | output_pipeline | output_pipeline |
| 8 | output_pipeline | output_pipeline |
| 9 | output_pipeline | output_pipeline |
| 10 | output_pipeline | output_pipeline |
| 11 | output_pipeline | output_pipeline |
| 12 | logs | logs |
| 12 | CellProfiler pipeline output files | pipeline_output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run tracking_workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run tracking_workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run tracking_workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init tracking_workflow.ga -o job.yml`
- Lint: `planemo workflow_lint tracking_workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `tracking_workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)