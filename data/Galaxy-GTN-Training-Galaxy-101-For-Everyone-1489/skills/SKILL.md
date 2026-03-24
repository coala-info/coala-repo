---
name: gtn-training-galaxy-101-for-everyone
description: "This workflow processes the iris dataset through data manipulation tools like Datamash and Grouping to generate statistical summaries and ggplot2 scatterplots. Use this skill when you need to perform basic data cleaning, aggregate tabular data by categories, and visualize relationships between variables in a dataset."
homepage: https://workflowhub.eu/workflows/1489
---

# GTN Training: Galaxy 101 For Everyone

## Overview

This workflow provides a foundational introduction to data analysis within the Galaxy platform, following the [GTN Training: Galaxy 101 For Everyone](https://training.galaxyproject.org/training-material/topics/introduction/tutorials/galaxy-intro-101-everyone/tutorial.html) curriculum. It is designed to guide users through the essential steps of data uploading, format conversion, and basic manipulation using the classic Iris dataset.

The pipeline begins by converting the input CSV data into a tabular format. It then employs various text processing and transformation tools, such as [Datamash](https://www.gnu.org/software/datamash/), to perform statistical operations and aggregate data. These steps include removing headers, cutting specific columns, and grouping data to extract meaningful summaries and unique values.

To conclude the analysis, the workflow generates visual representations of the data using [ggplot2](https://ggplot2.tidyverse.org/). It produces multiple scatterplots to illustrate relationships between variables, alongside the processed statistical outputs. This comprehensive approach demonstrates how to move from raw data to interpreted results and visualizations in a reproducible manner.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | iris | data_input |  |


Ensure the `iris` input is uploaded as a CSV file, as the initial step specifically converts this format into a standard Galaxy tabular dataset for downstream processing. Since this introductory workflow focuses on individual datasets rather than collections, you can upload the file directly to your active history. Refer to the `README.md` for comprehensive details on data acquisition and specific tool parameters. For automated testing or execution, you can use `planemo workflow_job_init` to generate a template `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Convert CSV to tabular | csv_to_tabular |  |
| 2 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 3 | Remove beginning | Remove beginning1 |  |
| 4 | Cut | Cut1 |  |
| 5 | Group | Grouping1 |  |
| 6 | Group | Grouping1 |  |
| 7 | Scatterplot w ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/2.2.1+galaxy1 |  |
| 8 | Scatterplot w ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/2.2.1+galaxy1 |  |
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
