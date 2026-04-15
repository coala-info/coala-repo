---
name: marine-omics-visualisation
description: This workflow retrieves marine occurrence data from the Ocean Biodiversity Information System and processes it using text manipulation and specialized indicator tools to generate ecological biodiversity metrics. Use this skill when you need to assess marine ecosystem health or analyze spatial patterns of biodiversity using standardized indicators derived from global ocean observation records.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# marine-omics-visualisation

## Overview

This Galaxy workflow provides a streamlined pipeline for transforming raw marine biological data into actionable biodiversity indicators. By leveraging the [Ocean Biodiversity Information System (OBIS)](https://obis.org/), the workflow enables researchers to retrieve occurrence records and process them for ecological visualization and assessment.

The process begins with the [OBIS occurrences](https://toolshed.g2.bx.psu.edu/repos/ecology/obis_data/obis_data/0.0.2) tool to fetch specific species data, followed by a data refinement step using [Advanced Cut](https://toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/9.3+galaxy0). This ensures that only the necessary taxonomic and spatial fields are passed to the final analysis stage.

In the final step, the [Ocean biodiversity indicators](https://toolshed.g2.bx.psu.edu/repos/ecology/obisindicators/obisindicators/0.0.2) tool calculates key metrics essential for monitoring marine ecosystem health. Developed within the [GTN](https://training.galaxyproject.org/) framework, this toolset is a valuable resource for the Marineomics and Earth-system communities and is shared under a [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) license.

## Inputs and data preparation

_None listed._


Ensure your input data is in tabular format, such as CSV or TSV, containing essential OBIS occurrence fields like scientificName and eventDate. While individual datasets are suitable for single runs, utilizing Galaxy collections is highly recommended for efficiently managing multiple sampling sites or time-series data. Refer to the README.md for comprehensive details on specific column requirements and parameter configurations necessary for the indicators tool. For automated execution and testing, you can use `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | OBIS occurences | toolshed.g2.bx.psu.edu/repos/ecology/obis_data/obis_data/0.0.2 |  |
| 1 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/9.3+galaxy0 |  |
| 2 | Ocean biodiversity indicators | toolshed.g2.bx.psu.edu/repos/ecology/obisindicators/obisindicators/0.0.2 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run obis-indicators.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run obis-indicators.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run obis-indicators.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init obis-indicators.ga -o job.yml`
- Lint: `planemo workflow_lint obis-indicators.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `obis-indicators.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)