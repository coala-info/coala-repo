---
name: 2024_omero_basic_upload
description: This bioimaging workflow uploads images, associated metadata, and regions of interest to an OMERO server using the OMERO suite of import tools. Use this skill when you need to centralize microscopy data and ensure that experimental metadata and spatial annotations are systematically linked to their corresponding images for long-term research data management.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# 2024_omero_basic_upload

## Overview

This workflow facilitates the automated transfer of imaging data and associated information into an OMERO server. It is designed to handle the primary image upload while simultaneously managing the integration of regions of interest (ROIs) and tabular metadata, ensuring a comprehensive data management process for bioimaging projects.

The process begins with the `OMERO Image Import` tool to establish the image on the target server. Subsequently, the workflow utilizes several text-processing steps—including character conversion, text replacement, and file splitting—to parse and prepare metadata parameters. These processed inputs are then used by the `OMERO Metadata Import` and `OMERO ROI Import` tools to attach descriptive data and spatial annotations to the uploaded images.

Developed in alignment with [GTN training materials](https://training.galaxyproject.org/training-material/topics/imaging/tutorials/omero-suite/tutorial.html), this workflow supports Research Data Management (RDM) best practices. It provides detailed logs for each stage of the import process, allowing users to verify the success of image, metadata, and ROI transfers. This tool is particularly useful for researchers needing to standardize their data ingestion into the OMERO suite under the CC-BY-4.0 license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Image to Upload in OMERO | data_input | Select the image file to upload into OMERO |
| 1 | Target Dataset | parameter_input | Select a target dataset to upload the image to. If the dataset name does not exist in OMERO, a new dataset will be created automatically. |
| 2 | OMERO server address | parameter_input | Please enter a valid OMERO server address to upload your images to. |
| 3 | Select Metadata Type | parameter_input | Select if you want metadata as a table (please type "Table") or Key-Value Pairs (please type "Key-Value Pairs") |
| 4 | Metadata File | data_input | Select the metadata file to upload into OMERO. Please refer to the tool "OMERO Metadata Import" to check how the file should be formatted |
| 5 | ROIs File | data_input | Select the ROIs file to upload into OMERO. Please refer to the tool "OMERO ROIs Import" to check how the file should be formatted |


Ensure your input images are in Bio-Formats compatible formats like OME-TIFF, while metadata and ROI files should be provided as tabular CSV or TSV files to match the expected tool parameters. If you are processing multiple images simultaneously, organizing them into a dataset collection will streamline the batch upload process to the OMERO server. Refer to the README.md for specific formatting requirements regarding the metadata and ROI structures to ensure successful integration. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated testing and parameter configuration.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 6 | OMERO Image Import | toolshed.g2.bx.psu.edu/repos/ufz/omero_import/omero_import/5.18.0+galaxy6 |  |
| 7 | Convert | Convert characters1 |  |
| 8 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/9.3+galaxy1 |  |
| 9 | Split file | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_to_collection/split_file_to_collection/0.5.2 |  |
| 10 | Parse parameter value | param_value_from_file |  |
| 11 | OMERO Metadata Import | toolshed.g2.bx.psu.edu/repos/ufz/omero_metadata_import/omero_metadata_import/5.18.0+galaxy7 |  |
| 12 | OMERO ROI Import | toolshed.g2.bx.psu.edu/repos/ufz/omero_roi_import/omero_roi_import/5.18.0+galaxy5 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 6 | image_upload_log | log |
| 11 | metadata_import_log | log |
| 12 | log | log |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run 2024-omero-basic-upload.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run 2024-omero-basic-upload.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run 2024-omero-basic-upload.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init 2024-omero-basic-upload.ga -o job.yml`
- Lint: `planemo workflow_lint 2024-omero-basic-upload.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `2024-omero-basic-upload.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)