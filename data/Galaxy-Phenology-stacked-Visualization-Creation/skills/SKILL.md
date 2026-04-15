---
name: phenology-stacked-visualization-creation
description: This ecology workflow processes flight curve datasets using filtering and pasting tools to generate a stacked phenology visualization based on regional Generalized Additive Models. Use this skill when you need to visualize and compare seasonal timing patterns of species across different geographic regions to identify phenological shifts.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# phenology-stacked-visualization-creation

## Overview

This Galaxy workflow is designed for ecological data analysis, specifically focusing on the creation of "stacked" visualizations for phenology studies. It processes flight curve datasets to help researchers visualize species activity patterns over time, utilizing regional Generalized Additive Models (GAM) to interpret biological trends.

The pipeline begins by taking a flight curve dataset as the primary input. It then executes a series of data manipulation steps, including two sequential filtering operations to isolate specific variables or timeframes, followed by a paste operation to restructure the data. This process prepares the dataset for comparative visualization, allowing for the stacking of phenological data across different regions or periods.

Categorized under [Ecology](https://training.galaxyproject.org/training-material/topics/ecology/) and developed within the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) framework, this workflow provides a standardized approach to handling regional GAM outputs. It simplifies the transition from raw flight data to structured formats suitable for ecological reporting and biodiversity monitoring.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Flight curve dataset | data_input |  |


Ensure the flight curve dataset is provided in a tabular format such as CSV or TSV, ensuring that columns are correctly formatted for the subsequent filtering and pasting operations. While the workflow is designed for individual datasets, utilizing dataset collections allows for efficient batch processing across multiple ecological sites or time series. Consult the `README.md` for comprehensive details on the specific data schema and metadata requirements needed to avoid errors during the Regional GAM analysis. For streamlined execution, consider using `planemo workflow_job_init` to create a `job.yml` file for your input parameters.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Filter | Filter1 |  |
| 2 | Filter | Filter1 |  |
| 3 | Paste | Paste1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-phenology--stacked--visualization-creation.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-phenology--stacked--visualization-creation.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-phenology--stacked--visualization-creation.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-phenology--stacked--visualization-creation.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-phenology--stacked--visualization-creation.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-phenology--stacked--visualization-creation.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)