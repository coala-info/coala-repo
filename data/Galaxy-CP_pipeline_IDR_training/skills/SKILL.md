---
name: cp_pipeline_idr_training
description: "This workflow downloads microscopy images from the Image Data Resource and employs CellProfiler to perform automated nucleoli segmentation and multi-parametric feature extraction. Use this skill when you need to characterize sub-nuclear morphology by quantifying object intensity, texture, and granularity across large biological imaging datasets."
homepage: https://workflowhub.eu/workflows/1505
---

# CP_pipeline_IDR_training

## Overview

This Galaxy workflow provides a comprehensive pipeline for nucleoli segmentation and feature extraction using [CellProfiler](https://cellprofiler.org/). It is designed to facilitate automated biological image analysis by integrating data acquisition directly from the [Image Data Resource (IDR)](https://idr.openmicroscopy.org/) with sophisticated morphological processing.

The pipeline begins by downloading image data and initializing CellProfiler modules. It employs a series of image processing steps, including feature enhancement and masking, to accurately identify primary objects. The workflow also includes visualization tools that convert identified objects back into images and overlay data to allow for manual verification of the segmentation results.

Once segmentation is complete, the workflow extracts a diverse set of measurements, including granularity, texture, intensity, and size/shape metrics. These features are calculated at both the object and image levels, providing a detailed quantitative profile of the sample. The final results are consolidated and exported as spreadsheets for downstream statistical analysis.

Developed as part of the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/), this workflow serves as a robust template for researchers looking to implement reproducible imaging pipelines. It demonstrates the integration of complex CellProfiler routines within the Galaxy ecosystem, making high-throughput image phenotyping accessible and scalable.

## Inputs and data preparation

_None listed._


To run this workflow, ensure your input images are provided as a dataset collection of TIFF or PNG files to allow the CellProfiler modules to process the batch efficiently. If you are using the IDR Download tool, you must provide a list of valid IDR identifiers to fetch the raw imaging data before the segmentation steps begin. For a comprehensive guide on configuring specific tool parameters and metadata, please refer to the README.md file. You can also use `planemo workflow_job_init` to generate a `job.yml` file for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Starting Modules | toolshed.g2.bx.psu.edu/repos/bgruening/cp_common/cp_common/3.1.9 | Detail the metadata associated to the images that will be processed |
| 1 | IDR Download | toolshed.g2.bx.psu.edu/repos/iuc/idr_download_by_ids/idr_download_by_ids/0.41 |  |
| 2 | IdentifyPrimaryObjects | toolshed.g2.bx.psu.edu/repos/bgruening/cp_identify_primary_objects/cp_identify_primary_objects/3.1.9 | Incomplete nuclei that are touching the borders of the image are ignored and therefore, not segmented. It doesn't include the nuclei outside the diameter range either. |
| 3 | ConvertObjectsToImage | toolshed.g2.bx.psu.edu/repos/bgruening/cp_convert_objects_to_image/cp_convert_objects_to_image/3.1.9 |  |
| 4 | DisplayDataOnImage | toolshed.g2.bx.psu.edu/repos/bgruening/cp_display_data_on_image/cp_display_data_on_image/3.1.9 |  |
| 5 | SaveImages | toolshed.g2.bx.psu.edu/repos/bgruening/cp_save_images/cp_save_images/3.1.9 |  |
| 6 | EnhanceOrSuppressFeatures | toolshed.g2.bx.psu.edu/repos/bgruening/cp_enhance_or_suppress_features/cp_enhance_or_suppress_features/3.1.9 |  |
| 7 | MaskImage | toolshed.g2.bx.psu.edu/repos/bgruening/cp_mask_image/cp_mask_image/3.1.9 | The dark holes enhanced in the previous step are segmented only if they are inside a nuclei |
| 8 | IdentifyPrimaryObjects | toolshed.g2.bx.psu.edu/repos/bgruening/cp_identify_primary_objects/cp_identify_primary_objects/3.1.9 | The segmentation only affects those inside the nuclei |
| 9 | ConvertObjectsToImage | toolshed.g2.bx.psu.edu/repos/bgruening/cp_convert_objects_to_image/cp_convert_objects_to_image/3.1.9 |  |
| 10 | GrayToColor | toolshed.g2.bx.psu.edu/repos/bgruening/cp_gray_to_color/cp_gray_to_color/3.1.9 |  |
| 11 | SaveImages | toolshed.g2.bx.psu.edu/repos/bgruening/cp_save_images/cp_save_images/3.1.9 |  |
| 12 | IdentifyPrimaryObjects | toolshed.g2.bx.psu.edu/repos/bgruening/cp_identify_primary_objects/cp_identify_primary_objects/3.1.9 | Incomplete nuclei that are touching the borders of the image are segmented, also the nuclei outside the diameter range. |
| 13 | ConvertObjectsToImage | toolshed.g2.bx.psu.edu/repos/bgruening/cp_convert_objects_to_image/cp_convert_objects_to_image/3.1.9 |  |
| 14 | ImageMath | toolshed.g2.bx.psu.edu/repos/bgruening/cp_image_math/cp_image_math/0.1.0 |  |
| 15 | MeasureGranularity | toolshed.g2.bx.psu.edu/repos/bgruening/cp_measure_granularity/cp_measure_granularity/3.1.9 | This step measures the granularity of the original image |
| 16 | MeasureTexture | toolshed.g2.bx.psu.edu/repos/bgruening/cp_measure_texture/cp_measure_texture/3.1.9 | This step measures the texture of the original image and nuclei in it |
| 17 | MeasureObjectIntensity | toolshed.g2.bx.psu.edu/repos/bgruening/cp_measure_object_intensity/cp_measure_object_intensity/3.1.9 | This step measures the intensity of the original image and the nuclei |
| 18 | MeasureObjectSizeShape | toolshed.g2.bx.psu.edu/repos/bgruening/cp_measure_object_size_shape/cp_measure_object_size_shape/3.1.9 |  |
| 19 | RelateObjects | toolshed.g2.bx.psu.edu/repos/bgruening/cp_relate_objects/cp_relate_objects/3.1.9 |  |
| 20 | MeasureImageQuality | toolshed.g2.bx.psu.edu/repos/bgruening/cp_measure_image_quality/cp_measure_image_quality/3.1.9 |  |
| 21 | MeasureImageAreaOccupied | toolshed.g2.bx.psu.edu/repos/bgruening/cp_measure_image_area_occupied/cp_measure_image_area_occupied/3.1.9 |  |
| 22 | MeasureImageIntensity | toolshed.g2.bx.psu.edu/repos/bgruening/cp_measure_image_intensity/cp_measure_image_intensity/3.1.9 |  |
| 23 | ExportToSpreadsheet | toolshed.g2.bx.psu.edu/repos/bgruening/cp_export_to_spreadsheet/cp_export_to_spreadsheet/3.1.9 |  |
| 24 | CellProfiler | toolshed.g2.bx.psu.edu/repos/bgruening/cp_cellprofiler/cp_cellprofiler/3.1.9 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | output_pipeline | output_pipeline |
| 1 | out_log | out_log |
| 1 | output_tar | output_tar |
| 2 | output_pipeline | output_pipeline |
| 3 | output_pipeline | output_pipeline |
| 4 | output_pipeline | output_pipeline |
| 5 | output_pipeline | output_pipeline |
| 6 | output_pipeline | output_pipeline |
| 7 | output_pipeline | output_pipeline |
| 8 | output_pipeline | output_pipeline |
| 9 | output_pipeline | output_pipeline |
| 10 | output_pipeline | output_pipeline |
| 11 | output_pipeline | output_pipeline |
| 12 | output_pipeline | output_pipeline |
| 13 | output_pipeline | output_pipeline |
| 14 | output_pipeline | output_pipeline |
| 15 | output_pipeline | output_pipeline |
| 16 | output_pipeline | output_pipeline |
| 17 | output_pipeline | output_pipeline |
| 18 | output_pipeline | output_pipeline |
| 19 | output_pipeline | output_pipeline |
| 20 | output_pipeline | output_pipeline |
| 21 | output_pipeline | output_pipeline |
| 22 | output_pipeline | output_pipeline |
| 23 | output_pipeline | output_pipeline |
| 24 | pipeline_output | pipeline_output |


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
