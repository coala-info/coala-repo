---
name: gtn-training-workflow-reports
description: "This Galaxy workflow processes the Iris dataset using Datamash for statistical aggregation and ggplot2 for generating comparative sepal and petal scatterplots. Use this skill when you need to perform exploratory data analysis on morphological measurements to identify species-specific patterns through automated data cleaning and visualization."
homepage: https://workflowhub.eu/workflows/1402
---

# GTN Training: Workflow Reports

## Overview

This workflow is a companion to the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) tutorial on Workflow Reports. It demonstrates how to transform raw data into a structured analytical report using the classic Iris dataset. The pipeline is designed to showcase Galaxy's reporting capabilities by automating data cleaning, statistical summarization, and visualization.

The process begins by converting the input Iris CSV file into a tabular format, followed by data manipulation steps using [Datamash](https://toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0) and various text processing tools. These steps perform data aggregation, filtering, and grouping to calculate descriptive statistics and identify unique species within the dataset.

For the final outputs, the workflow utilizes [ggplot2](https://toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/3.3.5+galaxy0) to generate scatterplots of sepal and petal dimensions. The resulting workflow report integrates these PNG visualizations with statistical summaries, providing a comprehensive overview of the analysis that can be automatically generated upon workflow completion.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Iris Dataset | data_input |  |


Ensure the Iris Dataset is uploaded in CSV format, as the initial workflow step is specifically configured to convert this file type into a tabular format for processing. While this workflow utilizes a single dataset input, you can adapt it for high-throughput analysis by employing dataset collections to manage multiple species files simultaneously. For a comprehensive breakdown of data specifications and the column headers required for the ggplot2 visualizations, please consult the `README.md`. You can also streamline your execution and testing by using `planemo workflow_job_init` to generate a `job.yml` file.

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
| 7 | Sepal Plot (PNG) | output1 |
| 8 | Petal Plot (PNG) | output1 |
| 8 | output2 | output2 |
| 9 | Iris Species | outfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run workflow-reports-final-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run workflow-reports-final-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run workflow-reports-final-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init workflow-reports-final-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint workflow-reports-final-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `workflow-reports-final-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
