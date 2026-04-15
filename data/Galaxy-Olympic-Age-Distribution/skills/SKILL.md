---
name: olympic-age-distribution
description: This Galaxy workflow processes a collection of Olympic athlete datasets to analyze age distributions using column manipulation, summary statistics, and ggplot2 histograms. Use this skill when you need to characterize the demographic profile of sports participants and visualize age frequency patterns across multiple data groups.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# olympic-age-distribution

## Overview

This workflow provides an introductory analysis of Olympic athlete demographics, specifically focusing on age distribution. It is designed as a foundational pipeline, often utilized in [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) tutorials to demonstrate data manipulation and visualization within the Galaxy ecosystem.

The process begins by taking an input dataset collection and performing several data transformation steps. It uses the Compute tool to add new data columns and cleans the dataset by removing unnecessary headers. These steps prepare the raw data for statistical analysis and ensure the attributes are correctly formatted for downstream tools.

The workflow generates two primary types of output: numerical summaries and visual representations. It calculates comprehensive summary statistics to describe the age range and mean of the athletes. Simultaneously, it utilizes [ggplot2](https://ggplot2.tidyverse.org/) to create histograms, which are then consolidated into a single visual report using an image montage tool.

Licensed under the MIT license, this workflow serves as an excellent starting point for users learning to manage data collections and multi-step analytical pipelines in Galaxy. For detailed setup instructions and data requirements, please refer to the [README.md](README.md) in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input Dataset Collection | data_collection_input |  |


Ensure your input is a dataset collection containing tabular files (TSV or CSV) with age data, as the workflow is designed to process multiple files in batch mode. Verify that your tabular data includes clear headers to ensure the column removal and summary statistics tools function correctly. Refer to the `README.md` for specific column requirements and comprehensive data preparation instructions. You can use `planemo workflow_job_init` to generate a `job.yml` for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.1 |  |
| 2 | Summary Statistics | Summary_Statistics1 |  |
| 3 | Remove columns | toolshed.g2.bx.psu.edu/repos/iuc/column_remove_by_header/column_remove_by_header/1.0 |  |
| 4 | Histogram with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_histogram/ggplot2_histogram/3.5.1+galaxy1 |  |
| 5 | Image Montage | toolshed.g2.bx.psu.edu/repos/bgruening/imagemagick_image_montage/imagemagick_image_montage/7.1.2-2+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | summary_statistics | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run olympic-age-distribution.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run olympic-age-distribution.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run olympic-age-distribution.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init olympic-age-distribution.ga -o job.yml`
- Lint: `planemo workflow_lint olympic-age-distribution.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `olympic-age-distribution.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)