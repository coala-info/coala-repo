---
name: music-stage-3-preprocess-visualisations
description: This Galaxy workflow processes cell proportion data collections from MuSiC deconvolution using tools like collection collapsing, column joining, and transposition to generate structured results and error tables. Use this skill when you need to format and aggregate deconvolution performance metrics to visualize the accuracy of predicted cell type compositions across multiple samples.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# music-stage-3-preprocess-visualisations

## Overview

This Galaxy workflow represents the third stage of the Music pipeline, specifically designed for preprocessing visualization data within the [deconv-eval](https://github.com/galaxyproject/training-material) framework. It automates the transformation of cell proportion data collections into structured formats suitable for performance evaluation and graphical representation.

The process begins by cleaning and aggregating input collections using tools such as `Collapse Collection` and `Column join`. It applies computational adjustments and structural modifications—including transposing data and removing headers—to generate two primary outputs: a comprehensive Results Table and a specialized Error Table.

Developed under the [MIT license](https://opensource.org/licenses/MIT), this workflow is integrated with [GTN](https://training.galaxyproject.org/) resources, ensuring it meets standard [Galaxy](https://galaxyproject.org/) community practices for reproducible bioinformatics analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Cell Proportions | data_collection_input |  |


Ensure the "Cell Proportions" input is provided as a list collection of tabular files (TSV or CSV) to allow the workflow to correctly collapse and join data across multiple samples. Verify that all datasets within the collection maintain consistent column headers to prevent alignment errors during the column join and transposition steps. Refer to the README.md for comprehensive details on the expected data structure and specific metric definitions. You can use `planemo workflow_job_init` to generate a `job.yml` file for streamlined execution and testing of this preprocessing stage.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Remove beginning | Remove beginning1 |  |
| 2 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 3 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.1 |  |
| 4 | Cut | Cut1 |  |
| 5 | Column join | toolshed.g2.bx.psu.edu/repos/iuc/collection_column_join/collection_column_join/0.0.3 |  |
| 6 | Remove beginning | Remove beginning1 |  |
| 7 | Transpose | toolshed.g2.bx.psu.edu/repos/iuc/datamash_transpose/datamash_transpose/1.8+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | Results Table | output |
| 7 | Error Table | out_file |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run deconv-eval-stage-3-process.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run deconv-eval-stage-3-process.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run deconv-eval-stage-3-process.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init deconv-eval-stage-3-process.ga -o job.yml`
- Lint: `planemo workflow_lint deconv-eval-stage-3-process.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `deconv-eval-stage-3-process.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)