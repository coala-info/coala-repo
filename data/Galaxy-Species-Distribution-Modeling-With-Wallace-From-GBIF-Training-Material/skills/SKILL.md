---
name: species-distribution-modeling-with-wallace-from-gbif-trainin
description: "This ecology workflow retrieves species occurrence data from GBIF and performs species distribution modeling using the Wallace interactive tool and integrated text processing utilities. Use this skill when you need to predict geographic distributions of species or assess habitat suitability based on environmental variables and historical occurrence records."
homepage: https://workflowhub.eu/workflows/1687
---

# Species Distribution Modeling With Wallace From GBIF - Training Material

## Overview

This workflow provides a streamlined pipeline for ecological research, specifically focused on Species Distribution Modeling (SDM). It begins by retrieving species occurrence data from the Global Biodiversity Information Facility (GBIF) using the `spocc_occ` tool. This initial step automates the collection of spatial data points necessary for mapping the geographic range of a target species.

The core of the analysis is powered by [Wallace](https://wallaceecomod.github.io/), an interactive tool designed for reproducible modeling of species niches and distributions. To ensure the data is properly formatted for the modeling environment, the workflow includes several text-processing steps, such as filtering, cutting specific columns, and converting tabular data into CSV format. These steps refine the raw biodiversity data into a clean dataset ready for spatial analysis.

Developed in alignment with [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) materials, this workflow is categorized under Ecology and serves as a practical resource for researchers and students. It facilitates the transition from raw occurrence records to comprehensive distribution models, ultimately producing a final output that summarizes the modeling results and environmental interactions.

## Inputs and data preparation

_None listed._


Ensure your species occurrence data is formatted as tabular or CSV files to facilitate seamless integration with the Wallace interactive tool and subsequent text processing steps. When managing multiple species or environmental layers, organizing your inputs into dataset collections will significantly streamline the workflow execution. For comprehensive details on specific parameter configurations and data requirements, please refer to the README.md file. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated testing and job configuration.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Get species occurrences data | toolshed.g2.bx.psu.edu/repos/ecology/spocc_occ/spocc_occ/0.9.0 |  |
| 1 | Wallace | interactive_tool_wallace |  |
| 2 | Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/1.1.0 |  |
| 3 | Filter | Filter1 |  |
| 4 | Convert tabular to CSV | tabular_to_csv |  |
| 5 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | outfile | outfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-species-distribution-modeling-with-wallace-from-gbif---training-material.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-species-distribution-modeling-with-wallace-from-gbif---training-material.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-species-distribution-modeling-with-wallace-from-gbif---training-material.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-species-distribution-modeling-with-wallace-from-gbif---training-material.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-species-distribution-modeling-with-wallace-from-gbif---training-material.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-species-distribution-modeling-with-wallace-from-gbif---training-material.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
