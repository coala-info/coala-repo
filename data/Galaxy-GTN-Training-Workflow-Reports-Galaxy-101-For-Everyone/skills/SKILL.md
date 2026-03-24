---
name: gtn-training-workflow-reports-galaxy-101-for-everyone
description: "This workflow processes the Iris dataset using Datamash and text manipulation tools to perform data aggregation and generates statistical visualizations with ggplot2. Use this skill when you need to perform basic exploratory data analysis, calculate group-wise summary statistics, and create scatterplots to identify patterns in biological or tabular datasets."
homepage: https://workflowhub.eu/workflows/1405
---

# GTN Training: Workflow Reports - Galaxy 101 For Everyone

## Overview

This workflow is an introductory pipeline designed for the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) "Galaxy 101" tutorial. It serves as a foundational guide for new users to navigate the Galaxy interface, using the classic Iris dataset to demonstrate essential data manipulation and analysis techniques.

The process begins with data preparation, converting raw CSV input into a tabular format and cleaning the dataset by removing headers and cutting specific columns. It then utilizes [Datamash](https://www.gnu.org/software/datamash/) and native grouping tools to perform data aggregation and calculate summary statistics, such as means or counts, across different categories.

For the final stages, the workflow generates visual insights using [ggplot2](https://ggplot2.tidyverse.org/) to create scatterplots. The final outputs include these visualizations along with processed tables of unique records and statistical summaries, providing a complete end-to-end example of a biological data analysis project. For detailed setup instructions, please refer to the README.md in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Iris Dataset | data_input |  |


Ensure the Iris Dataset is uploaded in CSV format, as the workflow begins by converting it to a tabular format for downstream processing. Since this workflow processes a single dataset rather than a collection, verify that the input is correctly identified as a standalone file in your history. For comprehensive instructions on parameter settings and data acquisition, refer to the accompanying README.md file. You can automate the setup of these inputs by using `planemo workflow_job_init` to generate a `job.yml` file.

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
| 7 | output1 | output1 |
| 8 | output1 | output1 |
| 9 | unique_output | outfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-101-everyone.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-101-everyone.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-101-everyone.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-101-everyone.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-101-everyone.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-101-everyone.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
