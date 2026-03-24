---
name: de-novo-digitisation
description: "This workflow automates de novo digitisation by processing specimen metadata and image URIs through specimen data object creation and Teklia-based document layout analysis for segmentation. Use this skill when you need to convert physical specimen images and their associated catalog information into standardized digital specimen records with automated layout detection."
homepage: https://workflowhub.eu/workflows/245
---

# De novo digitisation

## Overview

This Galaxy workflow facilitates the "de novo" digitisation of biological specimens by transforming raw metadata and image URIs into structured digital records. It accepts a wide range of inputs, including catalog numbers, taxonomic classifications, and person identifiers, alongside institutional and licensing information to ensure provenance and data integrity.

The process begins by generating a specimen data object (SDO) and downloading the specimen image from the specified URI. It utilizes [JQ](https://jqlang.github.io/jq/) for efficient JSON data manipulation, ensuring that the metadata is correctly formatted for downstream processing and integration into digital collections.

A key component of the workflow is the **Segmentation** step, performed by the [SDR Teklia worker-dla](https://teklia.com/). This tool executes Document Layout Analysis (DLA) to identify and isolate relevant regions within the specimen image. The final outputs include the processed specimen data, the downloaded image, and standardized openDS records, providing a comprehensive digital representation of the physical object.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Catalog number | parameter_input |  |
| 1 | Image license | parameter_input |  |
| 2 | Image URI | parameter_input |  |
| 3 | Object type | parameter_input |  |
| 4 | Rights holder | parameter_input |  |
| 5 | Institution URL | parameter_input |  |
| 6 | Higher classification | parameter_input |  |
| 7 | Person name | parameter_input |  |
| 8 | Person identifier | parameter_input |  |


Ensure all metadata parameters and the Image URI are provided as valid text strings or URLs, as these drive the automated download and object creation steps. For high-throughput processing, consider using dataset collections to manage multiple specimen records simultaneously rather than manual individual entries. Consult the README.md for specific formatting requirements regarding the taxonomic classification and institutional metadata fields. You can streamline the configuration of these numerous parameters by using `planemo workflow_job_init` to create a `job.yml` file for the execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 9 | Create specimen data object | sdr_create_sdo |  |
| 10 | Download image | download_image |  |
| 11 | JQ | toolshed.g2.bx.psu.edu/repos/iuc/jq/jq/1.0 |  |
| 12 | SDR Teklia worker-dla | sdr_teklia_worker_dla |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 9 | output | output |
| 10 | output | output |
| 10 | openDS | openDS |
| 10 | opends_out | opends_out |
| 11 | output | output |
| 12 | output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-De_novo_digitisation.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-De_novo_digitisation.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-De_novo_digitisation.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-De_novo_digitisation.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-De_novo_digitisation.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-De_novo_digitisation.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
