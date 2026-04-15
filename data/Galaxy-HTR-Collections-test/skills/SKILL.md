---
name: htr-collections-test
description: This workflow processes input datasets through a pipeline that utilizes Teklia workers for document layout analysis and handwritten text recognition to generate structured specimen data objects. Use this skill when you need to digitize historical specimen collections by automatically identifying layouts and transcribing handwritten text from large batches of archival documents.
homepage: https://www.synthesys.info/
metadata:
  docker_image: "N/A"
---

# htr-collections-test

## Overview

This workflow is designed to automate Handwritten Text Recognition (HTR) and Document Layout Analysis (DLA) for multi-specimen collections. It begins by cleaning an input CSV dataset and splitting it into a collection to facilitate batch processing. The pipeline then converts these entries into Specimen Data Objects (SDO), ensuring the data is structured for downstream analysis.

The core processing is handled by specialized [Teklia](https://teklia.com/) workers. The workflow first performs Document Layout Analysis (DLA) to identify page structures, followed by HTR to transcribe handwritten content. Throughout these steps, the system utilizes [JQ](https://stedolan.github.io/jq/) for JSON transformation and includes automated filtering to remove any failed datasets from the collection.

The final stage aggregates the processed data into a bundled collection, providing a unified SDR output. Validated in June 2022, this workflow is optimized for "multi-specimen-input" scenarios where high-throughput processing of archival or biological specimen records is required. For detailed setup instructions, please refer to the README.md in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input dataset | data_input |  |


Ensure your primary input is a properly formatted CSV file, as it is used to generate specimen data objects and drive the collection-based processing. This workflow leverages Galaxy collections to handle multi-specimen inputs efficiently, so verify that your data is structured to support the split-to-collection step. For comprehensive details on required CSV columns and SDR parameters, consult the README.md file. You can also use `planemo workflow_job_init` to create a `job.yml` for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Remove beginning | Remove beginning1 |  |
| 2 | Split file | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_to_collection/split_file_to_collection/0.5.0 |  |
| 3 | Create specimen data object from csv | sdr_create_sdo_from_csv |  |
| 4 | Filter failed datasets | __FILTER_FAILED_DATASETS__ |  |
| 5 | JQ | toolshed.g2.bx.psu.edu/repos/iuc/jq/jq/1.0 |  |
| 6 | SDR Teklia worker-dla | sdr_teklia_worker_dla |  |
| 7 | SDR Teklia worker-htr | sdr_teklia_worker_htr |  |
| 8 | Bundle Collection | toolshed.g2.bx.psu.edu/repos/nml/bundle_collections/bundle_collection/1.3.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | out_file1 | out_file1 |
| 3 | output | output |
| 4 | input dataset(s) (filtered failed datasets) | output |
| 5 | output | output |
| 6 | output | output |
| 7 | output | output |
| 8 | SDR_output | html_file |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-HTR-Collections-test.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-HTR-Collections-test.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-HTR-Collections-test.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-HTR-Collections-test.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-HTR-Collections-test.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-HTR-Collections-test.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)