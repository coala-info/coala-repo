---
name: arc2omero
description: This bioimaging workflow automates the transfer of Annotated Research Context (ARC) data from ZIP files to an OMERO instance using tools like unzip, xlsx2tsv, and OMERO import utilities. Use this skill when you need to preserve complex ARC structures and automate the metadata annotation of imaging assays during the migration of research data to a centralized OMERO repository.
homepage: https://git.nfdi4plants.org/natural-variation-and-evolution/microscopy_collection/map-by-seq_clsm-stacks/-/tree/main?ref_type=heads
metadata:
  docker_image: "N/A"
---

# arc2omero

## Overview

The ARC2OMERO workflow facilitates the seamless transfer of imaging data from an Annotated Research Context (ARC) to a target OMERO instance. By processing ARC data stored in .ZIP format, the workflow preserves the original research structure while automating the migration of images and their associated metadata. This tool is designed to streamline Research Data Management (RDM) workflows, particularly for the [NFDI4Bioimage](https://nfdi4bioimage.de/) community.

The process operates by extracting file paths from the `./assays/experiment/dataset/` directory to generate corresponding OMERO datasets. It leverages the `isa.assay.xlsx` file to automatically annotate these datasets with relevant key-value pairs, ensuring that experimental context is maintained during the transition. Users can configure specific parameters such as the image file extension (e.g., TIFF, PNG, JPEG) and the folder depth to accurately locate images within the ARC hierarchy.

Technical execution involves a series of Galaxy tools, including `unzip`, `xlsx2tsv` for metadata parsing, and specialized OMERO import modules for data synchronization. The workflow requires a target OMERO server URL and an input ARC file, which can be sourced from repositories such as the [DataPLANT ARC repo](https://git.nfdi4plants.org/natural-variation-and-evolution/microscopy_collection/map-by-seq_clsm-stacks/-/tree/main?ref_type=heads). This resource is shared under a [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | OMERO server URL | parameter_input |  |
| 1 | Image File Extension | parameter_input | Image format of the image to import into OMERO |
| 2 | Input ARC .zip file | data_input | Input here the .zip file from the ARC repository. |
| 3 | Deepth of the folder under "dataset" where the image are stored | parameter_input |  |


Ensure the input ARC is provided as a single .ZIP file containing the standard ISA structure, specifically including the `isa.assay.xlsx` file for metadata extraction. When configuring the workflow, specify the exact image file extension (e.g., .tiff or .png) and the correct folder depth relative to the `dataset` directory to ensure the internal file crawler locates your images. Since this workflow handles direct transfers to an OMERO instance, verify your target server URL and credentials before execution. For comprehensive details on directory mapping and metadata key-value pairs, refer to the README.md. You can use `planemo workflow_job_init` to generate a `job.yml` for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Unzip | toolshed.g2.bx.psu.edu/repos/imgteam/unzip/unzip/6.0+galaxy2 |  |
| 5 | Excel to Tabular | toolshed.g2.bx.psu.edu/repos/ufz/xlsx2tsv/xlsx2tsv/0.1.0+galaxy0 | Extract the metadata from the assay |
| 6 | Select | Grep1 |  |
| 7 | Filter Tabular | toolshed.g2.bx.psu.edu/repos/iuc/filter_tabular/filter_tabular/3.3.1 |  |
| 8 | Cut | Cut1 |  |
| 9 | Transpose | toolshed.g2.bx.psu.edu/repos/iuc/datamash_transpose/datamash_transpose/1.9+galaxy0 |  |
| 10 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy3 |  |
| 11 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 |  |
| 12 | Parse parameter value | param_value_from_file |  |
| 13 | Parse parameter value | param_value_from_file |  |
| 14 | Unzip | toolshed.g2.bx.psu.edu/repos/imgteam/unzip/unzip/6.0+galaxy2 |  |
| 15 | OMERO Image Import | toolshed.g2.bx.psu.edu/repos/ufz/omero_import/omero_import/5.18.0+galaxy6 |  |
| 16 | JQ | toolshed.g2.bx.psu.edu/repos/iuc/jq/jq/1.0 |  |
| 17 | Parse parameter value | param_value_from_file |  |
| 18 | OMERO Metadata Import | toolshed.g2.bx.psu.edu/repos/ufz/omero_metadata_import/omero_metadata_import/5.18.0+galaxy7 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 18 | log | log |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-ARC2OMERO.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-ARC2OMERO.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-ARC2OMERO.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-ARC2OMERO.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-ARC2OMERO.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-ARC2OMERO.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)