---
name: gbif-data-quality-check-and-filtering-workflow-feb-2020
description: This ecology workflow retrieves species occurrence data from GBIF and performs quality control through filtering, statistical summaries, and spatial data conversion using OGR2ogr. Use this skill when you need to prepare high-quality biodiversity datasets by removing erroneous or incomplete occurrence records for use in ecological research or species distribution modeling.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# gbif-data-quality-check-and-filtering-workflow-feb-2020

## Overview

This Galaxy workflow is designed for ecologists to automate the retrieval and rigorous cleaning of species occurrence data from the Global Biodiversity Information Facility (GBIF). It begins by using the [spocc_occ](https://toolshed.g2.bx.psu.edu/repos/ecology/spocc_occ/spocc_occ/0.9.0) tool to fetch raw biodiversity records, providing a standardized starting point for ecological analysis.

The core of the workflow focuses on data quality control through a multi-stage filtering process. By combining summary statistics and iterative filtering steps, the pipeline identifies and removes inconsistent or low-quality records. This ensures that the resulting dataset is refined and reliable for use in species distribution modeling or other ecological research.

In the final stages, the workflow utilizes [OGR2ogr](https://toolshed.g2.bx.psu.edu/repos/ecology/gdal_ogr2ogr/gdal_ogr2ogr/3.0.0) to handle spatial data transformations. These steps ensure that the filtered occurrence data is correctly formatted and projected for integration with geographic information systems (GIS) and other spatial analysis tools.

## Inputs and data preparation

_None listed._


Ensure your input species lists are in tabular format, such as CSV or TSV, to facilitate seamless filtering and coordinate cleaning across the various tool steps. If you are analyzing multiple taxa simultaneously, organizing your inputs into a dataset collection will significantly simplify the execution of downstream summary statistics and OGR2ogr conversions. Refer to the README.md for comprehensive details on specific column headers and the quality threshold parameters required for this workflow. You can use `planemo workflow_job_init` to generate a `job.yml` file for efficient batch processing and parameter configuration.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Get species occurrences data | toolshed.g2.bx.psu.edu/repos/ecology/spocc_occ/spocc_occ/0.9.0 |  |
| 1 | Filter | Filter1 |  |
| 2 | Count | Count1 |  |
| 3 | Summary Statistics | Summary_Statistics1 |  |
| 4 | Summary Statistics | Summary_Statistics1 |  |
| 5 | Filter | Filter1 |  |
| 6 | Filter | Filter1 |  |
| 7 | Count | Count1 |  |
| 8 | Filter | Filter1 |  |
| 9 | OGR2ogr | toolshed.g2.bx.psu.edu/repos/ecology/gdal_ogr2ogr/gdal_ogr2ogr/3.0.0 |  |
| 10 | OGR2ogr | toolshed.g2.bx.psu.edu/repos/ecology/gdal_ogr2ogr/gdal_ogr2ogr/3.0.0 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-gbif-data-quality-check-and-filtering-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-gbif-data-quality-check-and-filtering-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-gbif-data-quality-check-and-filtering-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-gbif-data-quality-check-and-filtering-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-gbif-data-quality-check-and-filtering-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-gbif-data-quality-check-and-filtering-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)