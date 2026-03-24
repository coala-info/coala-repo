---
name: dla-collections-test
description: "This workflow processes input datasets for document layout analysis using the SDR Teklia worker-dla tool, file splitting, and specimen data object creation. Use this skill when you need to automate the identification and extraction of structural elements from digitized specimen collections or historical documents."
homepage: https://workflowhub.eu/workflows/374
---

# DLA-Collections-test

## Overview

This Galaxy workflow is designed to process multi-specimen inputs through a Document Layout Analysis (DLA) pipeline using Teklia workers. It begins by cleaning an input dataset and splitting it into a collection, which is then transformed into specimen data objects from CSV metadata.

The core processing involves filtering out failed datasets before applying [JQ](https://toolshed.g2.bx.psu.edu/repos/iuc/jq/jq/1.0) for data manipulation and executing the [SDR Teklia worker-dla](https://github.com/search?q=sdr_teklia_worker_dla&type=repositories) step. The final results are aggregated using a bundle collection tool to produce a unified SDR output.

Validated as of 2022-06-29, this workflow is tagged for `default-sdr` and `multi-specimen-input` use cases. For detailed setup instructions and environment requirements, please refer to the `README.md` located in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input dataset | data_input |  |


Ensure your primary input is a CSV or tabular file containing specimen data, as the workflow utilizes `split_file_to_collection` and `sdr_create_sdo_from_csv` to process records. This workflow is optimized for high-throughput processing by converting a single dataset into a collection, allowing the SDR Teklia worker-dla to handle multiple specimens in parallel. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated testing and parameter configuration. Refer to the `README.md` for comprehensive details on specific column requirements and specimen data object structures.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Remove beginning | Remove beginning1 |  |
| 2 | Split file | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_to_collection/split_file_to_collection/0.5.0 |  |
| 3 | Create specimen data object from csv | sdr_create_sdo_from_csv |  |
| 4 | Filter failed datasets | __FILTER_FAILED_DATASETS__ |  |
| 5 | JQ | toolshed.g2.bx.psu.edu/repos/iuc/jq/jq/1.0 |  |
| 6 | SDR Teklia worker-dla | sdr_teklia_worker_dla |  |
| 7 | Bundle Collection | toolshed.g2.bx.psu.edu/repos/nml/bundle_collections/bundle_collection/1.3.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | out_file1 | out_file1 |
| 3 | output | output |
| 4 | input dataset(s) (filtered failed datasets) | output |
| 5 | output | output |
| 6 | output | output |
| 7 | SDR_output | html_file |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-DLA-Collections-test.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-DLA-Collections-test.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-DLA-Collections-test.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-DLA-Collections-test.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-DLA-Collections-test.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-DLA-Collections-test.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
