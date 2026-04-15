---
name: obis-biodiversity-indicator-on-asian-pacific
description: This Galaxy workflow processes South Pacific occurrence CSV data using text manipulation tools and the OBIS indicators package to calculate marine biodiversity metrics. Use this skill when you need to evaluate ecological health or species richness in the Asia-Pacific region by generating standardized ocean biodiversity indicators from occurrence records.
homepage: https://www.pndb.fr/
metadata:
  docker_image: "N/A"
---

# obis-biodiversity-indicator-on-asian-pacific

## Overview

This Galaxy workflow is designed to calculate marine biodiversity metrics for the South Pacific region using occurrence data. It begins by processing a raw CSV input, `Occurrence_southpacific.csv`, and transforming it into a structured format suitable for ecological analysis.

The data preparation phase involves converting the CSV to a tabular format, followed by precise column selection using the [Advanced Cut](https://toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/1.1.0) tool. A filtering step is then applied to refine the dataset, ensuring that only relevant occurrence records are passed to the final analysis stage.

The core of the workflow utilizes the [Ocean biodiversity indicators](https://toolshed.g2.bx.psu.edu/repos/ecology/obisindicators/obisindicators/0.0.2) tool. This tool processes the cleaned data to generate standardized indicators, providing insights into the biodiversity health and distribution within the Asian Pacific marine environment.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Occurrence_southpacific.csv | data_input |  |


Ensure the input `Occurrence_southpacific.csv` is uploaded as a standard CSV file, as the workflow includes an initial step to convert it into the tabular format required by the filtering and indicator tools. While the workflow is designed for individual datasets, you may utilize dataset collections to process multiple geographic regions in parallel. Refer to the `README.md` for comprehensive details on the specific column headers and taxonomic requirements necessary for the OBIS indicators tool to function correctly. You can also use `planemo workflow_job_init` to create a `job.yml` file for streamlined, reproducible execution and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Convert CSV to tabular | csv_to_tabular |  |
| 2 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/1.1.0 |  |
| 3 | Filter | Filter1 |  |
| 4 | Ocean biodiversity indicators | toolshed.g2.bx.psu.edu/repos/ecology/obisindicators/obisindicators/0.0.2 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Obis_biodiversity_indicator_on_Asian_pacific.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Obis_biodiversity_indicator_on_Asian_pacific.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Obis_biodiversity_indicator_on_Asian_pacific.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Obis_biodiversity_indicator_on_Asian_pacific.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Obis_biodiversity_indicator_on_Asian_pacific.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Obis_biodiversity_indicator_on_Asian_pacific.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)