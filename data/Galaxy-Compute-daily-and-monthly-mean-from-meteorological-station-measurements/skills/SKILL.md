---
name: compute-daily-and-monthly-mean-from-meteorological-station-m
description: This Galaxy workflow processes standardized CSV temperature time series from meteorological stations using AWK, Datamash, and climate visualization tools to calculate daily and monthly means. Use this skill when you need to aggregate high-frequency weather observations into periodic averages and generate climate stripes or bar charts to analyze temporal temperature trends.
homepage: https://workflowhub.eu/workflows/123
metadata:
  docker_image: "N/A"
---

# compute-daily-and-monthly-mean-from-meteorological-station-m

## Overview

This Galaxy workflow processes meteorological station data to calculate temporal averages from raw temperature observations. It requires a standardized CSV input containing six specific columns: year, month, day, time, time zone, and air temperature in degrees Celsius.

The pipeline begins by converting the CSV input into a tabular format, followed by text reformatting using [AWK](https://www.gnu.org/software/gawk/manual/gawk.html). It then utilizes [Datamash](https://www.gnu.org/software/datamash/) to perform statistical operations, specifically computing the daily and monthly mean temperatures from the input timeseries.

The final stage generates several analytical products, including daily and monthly mean timeseries datasets. To aid in data interpretation, the workflow produces [climate stripes](https://en.wikipedia.org/wiki/Warming_stripes) for both daily and monthly intervals, as well as a bar chart visualization of the daily temperature fluctuations.

Developed for climate observation analysis and tagged under the [EOSC-Nordic](https://www.eosc-nordic.eu/) initiative, this workflow is licensed under GPL-3.0-or-later. It provides a streamlined path from raw station measurements to publication-ready visualizations.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Temperature timeseries (csv) | data_input | Data is usually sampled at a higher frequency (from second to a few minutes).  The dataset must contain 6 columns:  1. Year	 2.m	 3.d	 4.Time	 5.Time zone	(such as UTC)  6. Air temperature (degC) |


Ensure your input is a CSV file containing exactly six columns for year, month, day, time, time zone, and air temperature to avoid processing errors during the conversion to tabular format. While this workflow processes individual datasets, you can use Galaxy collections to run the analysis across multiple meteorological stations simultaneously. Refer to the `README.md` for specific column formatting examples and standardization requirements. You can use `planemo workflow_job_init` to generate a `job.yml` for automated testing or batch execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Convert CSV to tabular | csv_to_tabular |  |
| 2 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/1.1.2 |  |
| 3 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/1.1.2 |  |
| 4 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 5 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 6 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 7 | Filter | Filter1 |  |
| 8 | Filter | Filter1 |  |
| 9 | climate stripes | toolshed.g2.bx.psu.edu/repos/climate/climate_stripes/climate_stripes/1.0.1 |  |
| 10 | climate stripes | toolshed.g2.bx.psu.edu/repos/climate/climate_stripes/climate_stripes/1.0.1 |  |
| 11 | Column Join | toolshed.g2.bx.psu.edu/repos/iuc/collection_column_join/collection_column_join/0.0.3 |  |
| 12 | Bar chart | barchart_gnuplot |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | daily_mean_timeseries | out_file |
| 6 | monthly_mean_timeseries | out_file |
| 9 | stripes_daily_temperatures | ofilename |
| 10 | stripes_monthly_temperatures | ofilename |
| 12 | daily_barchart | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Compute_daily_and_monthly_mean_from_meteorological_station_measurements.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Compute_daily_and_monthly_mean_from_meteorological_station_measurements.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Compute_daily_and_monthly_mean_from_meteorological_station_measurements.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Compute_daily_and_monthly_mean_from_meteorological_station_measurements.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Compute_daily_and_monthly_mean_from_meteorological_station_measurements.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Compute_daily_and_monthly_mean_from_meteorological_station_measurements.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)