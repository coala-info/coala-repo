---
name: gbif-data-quality-check-and-filtering-workflow-feb-2020
description: This ecology workflow retrieves species occurrence data from GBIF using the spocc tool and performs quality filtering, statistical summarization, and geospatial format conversion using OGR2ogr. Use this skill when you need to clean raw biodiversity records by removing low-quality observations and preparing standardized spatial datasets for species distribution modeling or conservation planning.
homepage: https://www.pndb.fr/
metadata:
  docker_image: "N/A"
---

# gbif-data-quality-check-and-filtering-workflow-feb-2020

## Overview

This Galaxy workflow automates the retrieval, quality assessment, and refinement of species occurrence data from the Global Biodiversity Information Facility (GBIF). It begins by using the [spocc_occ](https://toolshed.g2.bx.psu.edu/repos/ecology/spocc_occ/spocc_occ/0.9.0) tool to fetch occurrence records, providing a standardized starting point for biodiversity analysis.

The core of the workflow focuses on data cleaning and validation through a series of iterative filtering and statistical steps. It employs multiple filter modules to remove records that do not meet specific quality criteria, while simultaneously generating summary statistics and counts to help researchers monitor the dataset's integrity and the impact of each filtering stage.

In the final phase, the workflow utilizes [gdal_ogr2ogr](https://toolshed.g2.bx.psu.edu/repos/ecology/gdal_ogr2ogr/gdal_ogr2ogr/3.0.0) to process and convert the spatial data. This ensures that the resulting high-quality occurrence records are properly formatted for downstream geospatial analysis, mapping, or ecological modeling.

## Inputs and data preparation

_None listed._


Ensure your input species list is in a clean tabular format or provided as a single string for the initial occurrence retrieval tool. If processing multiple species simultaneously, organize your inputs into a dataset collection to streamline the filtering and summary statistics steps across the entire batch. Verify that coordinate columns are correctly formatted as numeric values before conversion to spatial formats like GeoJSON via OGR2ogr. Consult the `README.md` for comprehensive details on specific filtering criteria and parameter configurations required for high-quality data cleaning. You can use `planemo workflow_job_init` to generate a `job.yml` for automated testing and execution.

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
planemo run Galaxy-Workflow-GBIF_data_Quality_check_and_filtering_workflow_Feb-2020.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-GBIF_data_Quality_check_and_filtering_workflow_Feb-2020.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-GBIF_data_Quality_check_and_filtering_workflow_Feb-2020.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-GBIF_data_Quality_check_and_filtering_workflow_Feb-2020.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-GBIF_data_Quality_check_and_filtering_workflow_Feb-2020.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-GBIF_data_Quality_check_and_filtering_workflow_Feb-2020.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)