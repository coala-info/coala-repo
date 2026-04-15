---
name: 2024_omero_basic_upload
description: This workflow automates the transfer of bioimaging data, associated metadata files, and regions of interest into an OMERO repository using the OMERO Import, Metadata, and ROI tools. Use this skill when you need to archive microscopy images alongside their experimental metadata and spatial annotations in a centralized database to ensure FAIR data management and collaborative analysis.
homepage: https://zenodo.org/records/14205500
metadata:
  docker_image: "N/A"
---

# 2024_omero_basic_upload

## Overview

This workflow provides a standardized pipeline for importing image data and associated descriptive information into an [OMERO](https://www.openmicroscopy.org/omero/) server. It is designed to streamline Research Data Management (RDM) by automating the upload of raw images alongside their corresponding metadata and Region of Interest (ROI) files, ensuring that data remains structured and searchable from the point of ingestion.

The process begins with the [OMERO Image Import](https://toolshed.g2.bx.psu.edu/repos/ufz/omero_import/omero_import/5.18.0+galaxy3) tool, which transfers the primary image to a specified target dataset. Simultaneously, the workflow handles metadata and ROI files through a series of text-processing steps—including character conversion, text replacement, and file splitting—to parse parameter values and format the data for the server's requirements.

Once the image is successfully staged, the workflow utilizes specialized tools to attach annotations and spatial coordinates. The [OMERO Metadata Import](https://toolshed.g2.bx.psu.edu/repos/ufz/omero_metadata_import/omero_metadata_import/5.18.0+galaxy3) and [OMERO ROI Import](https://toolshed.g2.bx.psu.edu/repos/ufz/omero_roi_import/omero_roi_import/5.18.0+galaxy4) steps ensure that all experimental context and regions of interest are correctly linked to the image. Detailed logs are generated for each stage to provide full traceability of the upload process.

Developed under the MIT license and aligned with [NFDI4Bioimage](https://nfdi4bioimage.de/en/) standards, this workflow is a foundational tool for bioimage analysis and FAIR data practices. For detailed setup instructions and configuration options, please refer to the README.md in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Image to Upload in OMERO | data_input | Select the image file to upload into OMERO |
| 1 | Target Dataset | parameter_input | Select a target dataset to upload the image to. If the dataset name does not exist in OMERO, a new dataset will be created automatically. |
| 2 | OMERO server address | parameter_input | Please enter a valid OMERO server address to upload your images to. |
| 3 | Select Metadata Type | parameter_input | Select if you want metadata as a table (please type "Table") or Key-Value Pairs (please type "Key-Value Pairs") |
| 4 | Metadata File | data_input | Select the metadata file to upload into OMERO. Please refer to the tool "OMERO Metadata Import" to check how the file should be formatted |
| 5 | ROIs File | data_input | Select the ROIs file to upload into OMERO. Please refer to the tool "OMERO ROIs Import" to check how the file should be formatted |


Ensure your input images are in Bio-Formats compatible formats like OME-TIFF, while metadata and ROI files should be provided as structured CSV or TSV files. If processing multiple images, use a data collection for the image input to trigger batch processing, ensuring the target dataset ID matches your existing OMERO project structure. Refer to the included README.md for specific formatting requirements regarding metadata columns and ROI coordinate systems. You can automate the configuration of these parameters by generating a template job file with `planemo workflow_job_init`.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 6 | OMERO Image Import | toolshed.g2.bx.psu.edu/repos/ufz/omero_import/omero_import/5.18.0+galaxy3 |  |
| 7 | Convert | Convert characters1 |  |
| 8 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/9.3+galaxy1 |  |
| 9 | Split file | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_to_collection/split_file_to_collection/0.5.2 |  |
| 10 | Parse parameter value | param_value_from_file |  |
| 11 | OMERO Metadata Import | toolshed.g2.bx.psu.edu/repos/ufz/omero_metadata_import/omero_metadata_import/5.18.0+galaxy3 |  |
| 12 | OMERO ROI Import | toolshed.g2.bx.psu.edu/repos/ufz/omero_roi_import/omero_roi_import/5.18.0+galaxy4 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 6 | image_upload_log | log |
| 11 | metadata_import_log | log |
| 12 | log | log |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-2024_OMERO_Basic_Upload.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-2024_OMERO_Basic_Upload.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-2024_OMERO_Basic_Upload.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-2024_OMERO_Basic_Upload.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-2024_OMERO_Basic_Upload.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-2024_OMERO_Basic_Upload.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)