---
name: combining-datasets-after-pre-processing
description: This single-cell transcriptomics workflow integrates multiple pre-processed datasets into a unified structure using AnnData manipulation, inspection, and text processing tools. Use this skill when you need to merge several individual sample libraries into a single annotated object while consolidating metadata like genotype and sex for comparative downstream analysis.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# combining-datasets-after-pre-processing

## Overview

This Galaxy workflow is designed for single-cell RNA-seq analysis, specifically focusing on the integration of multiple pre-processed datasets into a unified structure. It accepts seven distinct inputs (N701–N707), representing different samples or experimental runs, and processes them using the [AnnData](https://anndata.readthedocs.io/) format to maintain data integrity across the merging process.

The pipeline performs extensive metadata manipulation to ensure that sample-specific information is correctly preserved. Using a combination of text processing tools—including `Replace Text`, `Cut`, and `Paste`—the workflow extracts and formats metadata such as sex and genotype. These attributes are then synchronized with the cell-level data using `Manipulate AnnData` and `AnnData Operations` to create a comprehensive, annotated dataset.

The final outputs include a combined object, a batched object for comparative analysis, and a fully annotated AnnData file ready for downstream visualization or clustering. This workflow is a [Galaxy Training Network](https://training.galaxyproject.org/) (GTN) resource, categorized under single-cell training and licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | N701 | data_input | Dataset to be combined |
| 1 | N702 | data_input | Dataset to be combined |
| 2 | N703 | data_input | Dataset to be combined |
| 3 | N704 | data_input | Dataset to be combined |
| 4 | N705 | data_input | Dataset to be combined |
| 5 | N706 | data_input | Dataset to be combined |
| 6 | N707 | data_input | Dataset to be combined |


Ensure all seven input files (N701–N707) are uploaded in h5ad format to ensure compatibility with the AnnData manipulation and inspection tools. While the workflow is configured for individual datasets, organizing your samples into a dataset collection can streamline data handling before the merging process. Consult the README.md for comprehensive details on the specific metadata requirements and sample-specific configurations needed for successful execution. For automated batch processing, you can use planemo workflow_job_init to generate a job.yml file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 7 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.3+galaxy0 |  |
| 8 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.3+galaxy0 |  |
| 9 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.3+galaxy0 |  |
| 10 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.3+galaxy0 |  |
| 11 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/9.3+galaxy0 |  |
| 12 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/9.3+galaxy0 |  |
| 13 | Cut | Cut1 |  |
| 14 | Cut | Cut1 |  |
| 15 | Paste | Paste1 |  |
| 16 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.3+galaxy0 |  |
| 17 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.3+galaxy0 |  |
| 18 | AnnData Operations | toolshed.g2.bx.psu.edu/repos/ebi-gxa/anndata_ops/anndata_ops/1.9.3+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 7 | Combined Object | anndata |
| 13 | Sex metadata | out_file1 |
| 14 | Genotype metadata | out_file1 |
| 15 | Cell metadata | out_file1 |
| 16 | AnnData with Cell Metadata | anndata |
| 17 | Batched Object | anndata |
| 18 | Annotated AnnData | output_h5ad |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run combining-datasets-after-pre-processing-archive.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run combining-datasets-after-pre-processing-archive.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run combining-datasets-after-pre-processing-archive.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init combining-datasets-after-pre-processing-archive.ga -o job.yml`
- Lint: `planemo workflow_lint combining-datasets-after-pre-processing-archive.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `combining-datasets-after-pre-processing-archive.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)