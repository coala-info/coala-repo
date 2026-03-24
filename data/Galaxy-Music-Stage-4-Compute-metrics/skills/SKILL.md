---
name: music-stage-4-compute-metrics
description: "This Galaxy workflow calculates performance metrics for cell type deconvolution by processing cell proportion data using Table Compute and column manipulation tools. Use this skill when you need to evaluate the accuracy of deconvolution results by calculating statistical indicators like Squared Error and Pearson Correlation between predicted and expected cell type proportions."
homepage: https://workflowhub.eu/workflows/1567
---

# Music Stage 4 - Compute metrics

## Overview

This Galaxy workflow represents the fourth stage of a deconvolution evaluation pipeline, specifically designed to calculate performance metrics for cell type proportion estimates. It takes cell proportions as input and processes the data through a series of transformation and computation steps to assess the accuracy of deconvolution results.

The workflow utilizes several data manipulation tools, including [Table Compute](https://toolshed.g2.bx.psu.edu/repos/iuc/table_compute/table_compute/1.2.4+galaxy0) and [Column Maker](https://toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.0), to perform arithmetic operations and reformat tabular data. It also employs text processing via [AWK](https://toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.3+galaxy1) and transposition tools to prepare the datasets for statistical comparison.

The final outputs of the workflow are two critical evaluation metrics: the Squared Error and the Pearson Correlation. These metrics provide a quantitative measure of the similarity between the estimated cell proportions and the ground truth or reference data.

This workflow is part of the **deconv-eval** suite and is compatible with [GTN](https://training.galaxyproject.org/) training materials. It is released under the MIT license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Cell Proportions | data_input | Tabular dataset with row and column headers Rows = cell types Columns = ACTUAL followed by INFERRED Numbers = cell proportions |


Ensure the input Cell Proportions file is provided in a clean tabular format, such as TSV or CSV, to ensure compatibility with the Table Compute and AWK processing steps. While a single dataset is typically used for this stage, you may utilize dataset collections if you are calculating metrics across multiple deconvolution outputs simultaneously. Please consult the README.md for comprehensive details on the expected column structures and specific mathematical transformations applied. For automated execution, you can generate a template for your parameters using `planemo workflow_job_init` to create a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Table Compute | toolshed.g2.bx.psu.edu/repos/iuc/table_compute/table_compute/1.2.4+galaxy0 |  |
| 2 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.0 | This computes (actual-expected)^2 |
| 3 | Remove beginning | Remove beginning1 |  |
| 4 | Cut | Cut1 | Takes the (actual-inferred)^2 column alone |
| 5 | Paste | Paste1 |  |
| 6 | Table Compute | toolshed.g2.bx.psu.edu/repos/iuc/table_compute/table_compute/1.2.4+galaxy0 |  |
| 7 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.3+galaxy1 |  |
| 8 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.0 | Finally we take the square root of the number to get the RSME |
| 9 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.1 |  |
| 10 | Cut | Cut1 |  |
| 11 | Table Compute | toolshed.g2.bx.psu.edu/repos/iuc/table_compute/table_compute/1.2.4+galaxy0 |  |
| 12 | Transpose | toolshed.g2.bx.psu.edu/repos/iuc/datamash_transpose/datamash_transpose/1.8+galaxy1 |  |
| 13 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.1 |  |
| 14 | Cut | Cut1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | Squared Error | out_file1 |
| 14 | Pearson Correlation | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run deconv-eval-stage-4-metrics.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run deconv-eval-stage-4-metrics.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run deconv-eval-stage-4-metrics.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init deconv-eval-stage-4-metrics.ga -o job.yml`
- Lint: `planemo workflow_lint deconv-eval-stage-4-metrics.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `deconv-eval-stage-4-metrics.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
