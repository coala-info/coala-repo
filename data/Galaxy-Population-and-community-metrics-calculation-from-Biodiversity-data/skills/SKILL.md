---
name: population-and-community-metrics-calculation-from-biodiversi
description: This biodiversity workflow processes observation and unit data to generate community metrics and presence-absence tables using Generalized Linear Models for population and community analysis. Use this skill when you need to quantify ecological community structures or statistically model species distribution patterns and population dynamics from field observation datasets.
homepage: https://www.pndb.fr/
metadata:
  docker_image: "N/A"
---

# population-and-community-metrics-calculation-from-biodiversi

## Overview

This Galaxy workflow is designed to analyze biodiversity data by calculating key ecological indicators and performing statistical modeling. It processes raw observation data and unit observations to derive structured insights into species distribution and community structure.

The pipeline begins by generating a presence-absence table and calculating specific community metrics using the [pampa_communitymetrics](https://toolshed.g2.bx.psu.edu/repos/ecology/pampa_communitymetrics/pampa_communitymetrics/0.0.1) and [pampa_presabs](https://toolshed.g2.bx.psu.edu/repos/ecology/pampa_presabs/pampa_presabs/0.0.1) tools. These steps transform primary biodiversity records into a format suitable for comparative ecological analysis.

In the final stages, the workflow applies Generalized Linear Models (GLM) to both community and population-level data. By utilizing specialized tools for [community GLM](https://toolshed.g2.bx.psu.edu/repos/ecology/pampa_glmcomm/pampa_glmcomm/0.0.1) and [population GLM](https://toolshed.g2.bx.psu.edu/repos/ecology/pampa_glmsp/pampa_glmsp/0.0.1), researchers can evaluate statistical trends and relationships within their datasets.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Observations | data_input | Species count. A tabular file with observation data. Must at least contain three columns 'observation.unit' which associate year and location (alternatively, you can have this column splited in 2 columns named 'year' and 'location'), 'species.code' with species ID and 'number' for abundance. |
| 1 | Unitobs | data_input | Sampling sites geographical and temporal informations |


Ensure your observation and unit observation files are formatted as tabular CSV or TSV files with matching identifiers to ensure the presence-absence and GLM tools function correctly. While the workflow accepts individual datasets, using data collections is recommended if you are managing multiple biodiversity surveys or time-series data. Please consult the README.md for comprehensive details on required column headers and data preprocessing. For streamlined execution and testing, you can generate a `job.yml` file using `planemo workflow_job_init`.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Calculate community metrics | toolshed.g2.bx.psu.edu/repos/ecology/pampa_communitymetrics/pampa_communitymetrics/0.0.1 |  |
| 3 | Calculate presence absence table | toolshed.g2.bx.psu.edu/repos/ecology/pampa_presabs/pampa_presabs/0.0.1 |  |
| 4 | Compute GLM on community data | toolshed.g2.bx.psu.edu/repos/ecology/pampa_glmcomm/pampa_glmcomm/0.0.1 |  |
| 5 | Compute GLM on population data | toolshed.g2.bx.psu.edu/repos/ecology/pampa_glmsp/pampa_glmsp/0.0.1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Population_and_community_metrics_calculation_from_Biodiversity_data.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Population_and_community_metrics_calculation_from_Biodiversity_data.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Population_and_community_metrics_calculation_from_Biodiversity_data.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Population_and_community_metrics_calculation_from_Biodiversity_data.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Population_and_community_metrics_calculation_from_Biodiversity_data.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Population_and_community_metrics_calculation_from_Biodiversity_data.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)