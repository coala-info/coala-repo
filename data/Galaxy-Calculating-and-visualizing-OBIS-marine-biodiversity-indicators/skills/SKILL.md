---
name: obis-indicators
description: "This Galaxy workflow processes marine occurrence data from a CSV file using text processing tools and the OBIS indicators tool to calculate biodiversity metrics. Use this skill when you need to analyze marine species occurrence records to derive standardized biodiversity indicators for ecological monitoring or conservation assessments."
homepage: https://workflowhub.eu/workflows/758
---

# Obis indicators

## Overview

This Galaxy workflow calculates and visualizes marine biodiversity indicators using data from the Ocean Biodiversity Information System (OBIS). It is designed to process species observation data, starting with an initial `Occurrence.csv` input to generate standardized ecological metrics.

The pipeline begins with data preprocessing, utilizing a conversion step to transform the CSV input into a tabular format. It then employs the [Advanced Cut](https://toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/1.1.0) tool to filter and refine the dataset, ensuring the necessary columns are isolated for analysis.

The core of the workflow is the [Ocean biodiversity indicators](https://toolshed.g2.bx.psu.edu/repos/ecology/obisindicators/obisindicators/0.0.2) tool. This step calculates essential biodiversity indices—such as species richness, Shannon diversity, and Simpson index—to provide insights into marine ecosystem health. The workflow is licensed under [CC-BY-SA-4.0](https://creativecommons.org/licenses/by-sa/4.0/).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Occurrence.csv | data_input |  |


Ensure your input file is a standard CSV containing OBIS-formatted occurrence data, as the workflow begins by converting this format into a tabular structure for processing. While this workflow handles individual datasets, you can adapt it for large-scale analysis by using dataset collections to process multiple occurrence files simultaneously. For automated testing and execution, consider using `planemo workflow_job_init` to generate a `job.yml` file. Detailed column requirements and parameter configurations are documented in the accompanying README.md file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Convert CSV to tabular | csv_to_tabular |  |
| 2 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/1.1.0 |  |
| 3 | Ocean biodiversity indicators | toolshed.g2.bx.psu.edu/repos/ecology/obisindicators/obisindicators/0.0.2 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Obis marine indicators.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Obis marine indicators.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Obis marine indicators.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Obis marine indicators.ga -o job.yml`
- Lint: `planemo workflow_lint Obis marine indicators.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Obis marine indicators.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
