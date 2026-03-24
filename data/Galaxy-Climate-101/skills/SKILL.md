---
name: climate-101
description: "This climate science workflow processes city-specific temperature data and ensemble means using Copernicus Essential Climate Variables, climate stripes, and psy_maps to generate visual representations of climate change. Use this skill when you need to analyze historical temperature variations, create climate stripes for specific locations, or visualize essential climate variables through maps and scatterplots."
homepage: https://workflowhub.eu/workflows/1441
---

# Climate 101

## Overview

This workflow provides an introductory approach to climate data analysis and visualization within the Galaxy ecosystem, following [GTN](https://training.galaxyproject.org/) standards. It processes climate datasets, such as city-specific temperature records and ensemble means, to explore long-term environmental trends. The pipeline integrates data from the [Copernicus Climate Data Store](https://cds.climate.copernicus.eu/) to retrieve and analyze essential climate variables.

The analytical core of the workflow involves extensive data manipulation using [Datamash](https://www.gnu.org/software/datamash/) and AWK-based text reformatting. These steps clean and aggregate daily temperature observations, allowing for the calculation of statistical means and the filtering of specific geographic coordinates. This structured approach transforms raw CSV and climate data into formats suitable for high-quality geospatial and statistical rendering.

For the final outputs, the workflow generates several impactful visualizations, including [climate stripes](https://showyourstripes.info/), spatial map plots via psy_maps, and scatterplots using ggplot2. These tools help identify warming trends and spatial climate patterns. Additionally, the workflow is designed to support further data inspection using the Panoply netCDF viewer to visualize complex multidimensional climate arrays.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | ts_cities.csv | data_input |  |
| 1 | tg_ens_mean_0.1deg_reg_v20.0e_Paris_daily.csv | data_input |  |


Ensure your input files are in CSV format for the city coordinates and daily temperature means, while the Copernicus tool will retrieve netCDF data for spatial visualization. Since this workflow processes individual datasets rather than collections, verify that each file is correctly assigned to its respective input port before execution. For automated testing or batch execution, you can use `planemo workflow_job_init` to generate a `job.yml` file. Refer to the README.md for comprehensive details on parameter settings and data sources.

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
planemo run climate-101-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run climate-101-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run climate-101-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init climate-101-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint climate-101-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `climate-101-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
