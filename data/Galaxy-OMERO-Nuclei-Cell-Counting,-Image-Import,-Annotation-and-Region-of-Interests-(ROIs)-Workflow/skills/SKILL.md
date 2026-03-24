---
name: 2024_nuclei_counting_w_omero_upload
description: "This bioimage analysis workflow processes image collections using histogram equalization, automated thresholding, and particle analysis to count nuclei and extract morphological features. Use this skill when you need to quantify cellular populations in microscopy datasets and automatically archive the images, segmentation regions, and metadata in an OMERO server for standardized research data management."
homepage: https://workflowhub.eu/workflows/1259
---

# 2024_Nuclei_counting_w_OMERO_upload

## Overview

This workflow provides an automated pipeline for bioimage analysis and Research Data Management (RDM) by integrating Galaxy with [OMERO](https://www.openmicroscopy.org/omero/). It is designed to handle image collections, requiring a target dataset ID and OMERO server credentials as inputs to facilitate the seamless transfer, processing, and annotation of microscopy data.

The core analysis involves several pre-processing steps, including format conversion via [Bio-Formats](https://www.glencoesoftware.com/bio-formats.html), histogram equalization, and standard 2D filtering. Following these enhancements, the workflow performs nuclei counting and feature extraction through automated thresholding, binary-to-label map conversion, and particle analysis.

A key feature of this pipeline is its deep integration with OMERO. Beyond initial image import, the workflow reformats analysis results to automatically upload metadata and Regions of Interest (ROIs) back to the OMERO server. This ensures that all derived features and segmentations are directly linked to the original images, supporting [NFDI4Bioimage](https://nfdi4bioimage.de/) standards for reproducible and FAIR image informatics. This workflow is shared under the [MIT License](https://opensource.org/licenses/MIT).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Image to Upload in OMERO | data_collection_input | Select the image file to upload into OMERO |
| 1 | Target Dataset | parameter_input | Select a target dataset to upload the image to. If the dataset name does not exist in OMERO, a new dataset will be created automatically. |
| 2 | OMERO server address | parameter_input | Please enter a valid OMERO server address to upload your images to. |


Ensure your input images are organized into a data collection to facilitate batch processing and automated metadata mapping during the OMERO upload. Use standard bio-image formats compatible with Bio-Formats, as the workflow includes a conversion step to ensure compatibility before histogram equalization and thresholding. You must provide the specific OMERO server address and target Dataset ID as parameters to route the processed images and ROIs correctly. For complex configurations or credential handling, refer to the `README.md` for comprehensive setup details. You can also use `planemo workflow_job_init` to generate a `job.yml` file for defining these inputs programmatically.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Convert image format | toolshed.g2.bx.psu.edu/repos/imgteam/bfconvert/ip_convertimage/6.7.0+galaxy3 |  |
| 4 | Extract element identifiers | toolshed.g2.bx.psu.edu/repos/iuc/collection_element_identifiers/collection_element_identifiers/0.0.2 |  |
| 5 | Perform histogram equalization | toolshed.g2.bx.psu.edu/repos/imgteam/2d_histogram_equalization/ip_histogram_equalization/0.18.1+galaxy0 |  |
| 6 | OMERO Image Import | toolshed.g2.bx.psu.edu/repos/ufz/omero_import/omero_import/5.18.0+galaxy3 |  |
| 7 | Convert | Convert characters1 |  |
| 8 | Filter 2-D image | toolshed.g2.bx.psu.edu/repos/imgteam/2d_simple_filter/ip_filter_standard/1.12.0+galaxy1 |  |
| 9 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/9.3+galaxy1 |  |
| 10 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/9.3+galaxy1 |  |
| 11 | Threshold image | toolshed.g2.bx.psu.edu/repos/imgteam/2d_auto_threshold/ip_threshold/0.18.1+galaxy3 |  |
| 12 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.3+galaxy1 |  |
| 13 | Split file | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_to_collection/split_file_to_collection/0.5.2 |  |
| 14 | Convert binary image to label map | toolshed.g2.bx.psu.edu/repos/imgteam/binary2labelimage/ip_binary_to_labelimage/0.5+galaxy0 |  |
| 15 | Analyze particles | toolshed.g2.bx.psu.edu/repos/imgteam/imagej2_analyze_particles_binary/imagej2_analyze_particles_binary/20240614+galaxy0 |  |
| 16 | Parse parameter value | param_value_from_file |  |
| 17 | Parse parameter value | param_value_from_file |  |
| 18 | Extract image features | toolshed.g2.bx.psu.edu/repos/imgteam/2d_feature_extraction/ip_2d_feature_extraction/0.18.1+galaxy0 |  |
| 19 | OMERO IDs | toolshed.g2.bx.psu.edu/repos/ufz/omero_filter/omero_filter/5.18.0+galaxy0 |  |
| 20 | Parse parameter value | param_value_from_file |  |
| 21 | OMERO Metadata Import | toolshed.g2.bx.psu.edu/repos/ufz/omero_metadata_import/omero_metadata_import/5.18.0+galaxy3 |  |
| 22 | OMERO ROI Import | toolshed.g2.bx.psu.edu/repos/ufz/omero_roi_import/omero_roi_import/5.18.0+galaxy4 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 6 | image_upload_log | log |
| 21 | metadata_import_log | log |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-2024_Nuclei_counting_w_OMERO_upload.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-2024_Nuclei_counting_w_OMERO_upload.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-2024_Nuclei_counting_w_OMERO_upload.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-2024_Nuclei_counting_w_OMERO_upload.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-2024_Nuclei_counting_w_OMERO_upload.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-2024_Nuclei_counting_w_OMERO_upload.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
