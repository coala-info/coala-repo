---
name: gtn-training-galaxy-101-for-everyone
description: "This workflow processes the Iris dataset using Datamash for summary statistics, grouping tools for data aggregation, and ggplot2 for generating scatterplots. Use this skill when you need to perform exploratory data analysis, calculate descriptive statistics across categories, and visualize numerical relationships within a tabular dataset."
homepage: https://workflowhub.eu/workflows/1536
---

# GTN Training: Galaxy 101 For Everyone

## Overview

This workflow provides a foundational introduction to data analysis using the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) "Galaxy 101" curriculum. It processes the classic Iris dataset, beginning with a format conversion from CSV to tabular to ensure compatibility with standard analytical tools.

The pipeline performs several data manipulation steps, including cleaning the dataset by removing headers and cutting specific columns. It leverages **Datamash** and **Grouping** tools to aggregate data and calculate summary statistics, while the **Unique** tool is used to identify distinct entries within the processed files.

For the final analysis, the workflow generates multiple visualizations using **ggplot2** to create scatterplots. These visual outputs, combined with the statistical summaries, demonstrate how to transform raw data into meaningful insights through a structured, multi-step automated process.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | iris | data_input |  |


Ensure your input file is in CSV format, as the workflow begins by converting it to a tabular format for downstream processing. This introductory workflow typically handles individual datasets rather than collections, making it ideal for learning basic data manipulation and visualization. Refer to the `README.md` file for comprehensive instructions on data acquisition and specific column requirements. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Convert CSV to tabular | csv_to_tabular |  |
| 2 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 3 | Remove beginning | Remove beginning1 |  |
| 4 | Cut | Cut1 |  |
| 5 | Group | Grouping1 |  |
| 6 | Group | Grouping1 |  |
| 7 | Scatterplot with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/3.3.5+galaxy0 |  |
| 8 | Scatterplot with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/3.3.5+galaxy0 |  |
| 9 | Unique | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sorted_uniq/1.1.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | datamash_output | out_file |
| 5 | group1 | out_file1 |
| 6 | group2 | out_file1 |
| 7 | output2 | output2 |
| 8 | output2 | output2 |
| 9 | unique_output | outfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run main-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run main-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run main-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init main-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint main-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `main-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
