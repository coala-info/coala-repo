---
name: compute-and-analyze-biodiversity-metrics-with-pampa-toolsuit
description: "This ecology workflow processes Catch Per Unit Effort datasets using the PAMPA toolsuite and text processing tools to calculate biodiversity metrics and perform statistical modeling. Use this skill when you need to analyze community and population trends in ecosystems by computing presence-absence tables, community metrics, and Generalized Linear Models from abundance data."
homepage: https://workflowhub.eu/workflows/1696
---

# Compute and analyze biodiversity metrics with PAMPA toolsuite

## Overview

This workflow provides a comprehensive pipeline for ecological data analysis using the PAMPA toolsuite within Galaxy. It is designed to process raw catch data—specifically Catch Per Unit Effort (CPUE) per length per area—sourced from [Zenodo](https://zenodo.org/record/4264936). The initial stages focus on data preparation, utilizing regex-based cleaning, concatenation, and column merging to standardize disparate datasets for downstream analysis.

The core of the workflow employs specialized PAMPA tools to calculate presence-absence tables and derive essential community metrics. These steps allow researchers to quantify biodiversity patterns and species distributions across different sampling areas. By automating the transition from raw tabular data to ecological indices, the workflow ensures consistency in how community structures are evaluated.

In the final stages, the pipeline performs statistical modeling through Generalized Linear Models (GLM) at both the community and population levels. The results are then processed through data transposition and visualization tools to generate plots that illustrate biodiversity trends and model outputs. This end-to-end approach supports ecological monitoring and research as part of the [Galaxy Training Network](https://training.galaxyproject.org/) (GTN) ecology curriculum.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | https://zenodo.org/record/4264936/files/CPUE%20per%20length%20per%20area_A.csv?download=1 | data_input |  |
| 1 | https://zenodo.org/record/4264936/files/CPUE%20per%20length%20per%20area_B.csv?download=1 | data_input |  |
| 2 | https://zenodo.org/record/4264936/files/CPUE%20per%20length%20per%20area_C.csv?download=1 | data_input |  |


Ensure your input files are in CSV format, as the PAMPA toolsuite and subsequent text processing steps rely on structured tabular data for calculating biodiversity metrics. While this workflow uses individual datasets for CPUE (Catch Per Unit Effort) data, you can organize multiple study areas into a dataset collection to streamline the concatenation and regex filtering steps. Refer to the README.md for specific column requirements and regex patterns needed to clean your ecological metadata. For automated testing or command-line execution, you can initialize the environment using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.1 |  |
| 4 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.1 |  |
| 5 | Concatenate datasets | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cat/0.1.0 |  |
| 6 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.1 |  |
| 7 | Merge Columns | toolshed.g2.bx.psu.edu/repos/devteam/merge_cols/mergeCols1/1.0.2 |  |
| 8 | Merge Columns | toolshed.g2.bx.psu.edu/repos/devteam/merge_cols/mergeCols1/1.0.2 |  |
| 9 | Count | Count1 |  |
| 10 | Filter | Filter1 |  |
| 11 | Merge Columns | toolshed.g2.bx.psu.edu/repos/devteam/merge_cols/mergeCols1/1.0.2 |  |
| 12 | Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regex1/1.0.0 |  |
| 13 | Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regex1/1.0.0 |  |
| 14 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.1 |  |
| 15 | Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regex1/1.0.0 |  |
| 16 | Calculate presence absence table | toolshed.g2.bx.psu.edu/repos/ecology/pampa_presabs/pampa_presabs/0.0.2 |  |
| 17 | Calculate presence absence table | toolshed.g2.bx.psu.edu/repos/ecology/pampa_presabs/pampa_presabs/0.0.2 |  |
| 18 | Merge Columns | toolshed.g2.bx.psu.edu/repos/devteam/merge_cols/mergeCols1/1.0.2 |  |
| 19 | Calculate presence absence table | toolshed.g2.bx.psu.edu/repos/ecology/pampa_presabs/pampa_presabs/0.0.2 |  |
| 20 | Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regex1/1.0.0 |  |
| 21 | Calculate community metrics | toolshed.g2.bx.psu.edu/repos/ecology/pampa_communitymetrics/pampa_communitymetrics/0.0.2 |  |
| 22 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.0 |  |
| 23 | Merge Columns | toolshed.g2.bx.psu.edu/repos/devteam/merge_cols/mergeCols1/1.0.2 |  |
| 24 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.1 |  |
| 25 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/1.1.0 |  |
| 26 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/1.1.1 |  |
| 27 | Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regex1/1.0.0 |  |
| 28 | Compute GLM on community data | toolshed.g2.bx.psu.edu/repos/ecology/pampa_glmcomm/pampa_glmcomm/0.0.2 |  |
| 29 | Compute GLM on population data | toolshed.g2.bx.psu.edu/repos/ecology/pampa_glmsp/pampa_glmsp/0.0.2 |  |
| 30 | Compute GLM on population data | toolshed.g2.bx.psu.edu/repos/ecology/pampa_glmsp/pampa_glmsp/0.0.2 |  |
| 31 | Compute GLM on population data | toolshed.g2.bx.psu.edu/repos/ecology/pampa_glmsp/pampa_glmsp/0.0.2 |  |
| 32 | Transpose | toolshed.g2.bx.psu.edu/repos/iuc/datamash_transpose/datamash_transpose/1.1.0 |  |
| 33 | Create a plot from GLM data | toolshed.g2.bx.psu.edu/repos/ecology/pampa_plotglm/pampa_plotglm/0.0.2 |  |
| 34 | Transpose | toolshed.g2.bx.psu.edu/repos/iuc/datamash_transpose/datamash_transpose/1.1.0 |  |
| 35 | Create a plot from GLM data | toolshed.g2.bx.psu.edu/repos/ecology/pampa_plotglm/pampa_plotglm/0.0.2 |  |
| 36 | Transpose | toolshed.g2.bx.psu.edu/repos/iuc/datamash_transpose/datamash_transpose/1.1.0 |  |
| 37 | Create a plot from GLM data | toolshed.g2.bx.psu.edu/repos/ecology/pampa_plotglm/pampa_plotglm/0.0.2 |  |
| 38 | Transpose | toolshed.g2.bx.psu.edu/repos/iuc/datamash_transpose/datamash_transpose/1.1.0 |  |
| 39 | Create a plot from GLM data | toolshed.g2.bx.psu.edu/repos/ecology/pampa_plotglm/pampa_plotglm/0.0.2 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-compute-and-analyze-biodiversity-metrics-with-pampa-toolsuite.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-compute-and-analyze-biodiversity-metrics-with-pampa-toolsuite.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-compute-and-analyze-biodiversity-metrics-with-pampa-toolsuite.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-compute-and-analyze-biodiversity-metrics-with-pampa-toolsuite.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-compute-and-analyze-biodiversity-metrics-with-pampa-toolsuite.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-compute-and-analyze-biodiversity-metrics-with-pampa-toolsuite.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
