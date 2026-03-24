---
name: climate-101
description: "This climate science workflow processes city-specific temperature CSV files using Copernicus Essential Climate Variables tools, Datamash, and visualization utilities like climate stripes and psy_maps. Use this skill when you need to analyze historical temperature trends and generate visual representations like warming stripes or geographic map plots to communicate climate change impacts for specific urban areas."
homepage: https://workflowhub.eu/workflows/42
---

# Climate 101

## Overview

This workflow provides an introductory framework for retrieving and visualizing essential climate variables. It primarily utilizes data from the [Copernicus Climate Data Store](https://cds.climate.copernicus.eu/) alongside city-specific temperature records to analyze historical climate trends.

The pipeline performs extensive data manipulation using [Datamash](https://toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0) and [text reformatting](https://toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/1.1.1) tools. These steps aggregate daily temperature observations and filter specific datasets, such as Paris daily means, to prepare them for high-quality graphical representation.

Users can generate several types of climate visualizations, including [climate stripes](https://toolshed.g2.bx.psu.edu/repos/climate/climate_stripes/climate_stripes/1.0.1) for illustrating warming trends, geographic [map plots](https://toolshed.g2.bx.psu.edu/repos/climate/psy_maps/psy_maps/1.2.1), and scatterplots created with [ggplot2](https://toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/2.2.1+galaxy1). The workflow is also designed to facilitate data exploration using the Panoply netCDF viewer.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | ts_cities.csv | data_input |  |
| 1 | tg_ens_mean_0.1deg_reg_v20.0e_Paris_daily.csv | data_input |  |


Ensure your input files are in CSV format and correctly labeled to match the expected city and temperature data structures. While this workflow primarily uses individual datasets, verify that all tabular data is properly formatted for the Datamash and ggplot2 tools to avoid processing errors. For automated testing and job configuration, you can use `planemo workflow_job_init` to generate a `job.yml` file. Refer to the README.md for comprehensive details on data sources and specific parameter settings.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Copernicus Essential Climate Variables | toolshed.g2.bx.psu.edu/repos/climate/cds_essential_variability/cds_essential_variability/0.1.4 |  |
| 3 | climate stripes | toolshed.g2.bx.psu.edu/repos/climate/climate_stripes/climate_stripes/1.0.1 |  |
| 4 | Select | Grep1 |  |
| 5 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 6 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 7 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 8 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/1.1.1 |  |
| 9 | map plot | toolshed.g2.bx.psu.edu/repos/climate/psy_maps/psy_maps/1.2.1 |  |
| 10 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 11 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 12 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 13 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 14 | Scatterplot w ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/2.2.1+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run climate_101_workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run climate_101_workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run climate_101_workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init climate_101_workflow.ga -o job.yml`
- Lint: `planemo workflow_lint climate_101_workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `climate_101_workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
