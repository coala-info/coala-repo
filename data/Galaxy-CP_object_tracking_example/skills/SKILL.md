---
name: cp_object_tracking_example
description: This Galaxy workflow processes image datasets using CellProfiler modules to identify, measure, and track biological objects. Use this skill when you need to monitor the movement and morphological changes of individual cells or organelles across a time-lapse image sequence.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# cp_object_tracking_example

## Overview

This workflow provides an example [CellProfiler](https://cellprofiler.org/) pipeline integrated into Galaxy, specifically designed for automated object tracking in biological imaging. It follows methodologies often highlighted in [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) tutorials to demonstrate how to segment, measure, and monitor biological structures across a series of images.

The process begins by preprocessing input datasets, which includes unzipping files and converting images to grayscale. It then utilizes the `IdentifyPrimaryObjects` module to perform initial segmentation. Once objects are defined, the workflow extracts quantitative data using the `MeasureObjectSizeShape` and `MeasureObjectIntensity` modules to characterize the physical and spectral properties of the identified features.

The core of the pipeline is the `TrackObjects` module, which links identified objects across frames to analyze movement or changes over time. To facilitate validation and downstream analysis, the workflow generates visual overlays and tiled images, ultimately exporting the quantitative results into structured spreadsheets and providing a complete CellProfiler pipeline file for reproducibility.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 1 | Input dataset | data_input |  |


Ensure your input images are in standard formats like TIFF or PNG, and consider using a dataset collection if processing time-lapse sequences to maintain frame order for the tracking module. Since this workflow involves unzipping and specific CellProfiler module configurations, verify that your input dataset is correctly formatted as a compressed archive or individual file as required by the initial steps. Refer to the README.md for comprehensive details on parameter settings and expected image metadata. You can use `planemo workflow_job_init` to generate a `job.yml` for automated execution and testing.

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