---
name: investigation-of-lockdown-effect-on-air-quality-between-janu
description: "This climate workflow utilizes NetCDF xarray selection and Datamash tools to extract air quality data across multiple time periods between 2019 and 2021 for a specific geographic location. Use this skill when you need to analyze the impact of COVID-19 lockdowns on atmospheric composition by comparing mean, minimum, and maximum pollutant levels across consecutive years."
homepage: https://workflowhub.eu/workflows/251
---

# Investigation of lockdown effect on air quality between January 2019 to May 2021: RELIANCE DS1-GC0-SC3'

## Overview

This Galaxy workflow investigates the impact of COVID-19 lockdowns on air quality by analyzing atmospheric data spanning from January 2019 to May 2021. It is designed to extract and compare five specific time periods—January to June for 2019, 2020, and 2021, and July to December for 2019 and 2020—over a single user-selected geographic location.

The technical pipeline leverages [NetCDF xarray](https://toolshed.g2.bx.psu.edu/repos/ecology/xarray_select) tools to handle multidimensional climate data, performing precise temporal selections and metadata extraction. Data is then processed through a series of text transformation steps using `awk` and [Datamash](https://toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops) to calculate essential air quality statistics, including mean, minimum, and maximum values for the targeted intervals.

The final outputs provide a comparative analysis of air quality metrics across consecutive years and specifically during lockdown periods. This workflow is categorized under **climate** and **reliance** tags and is licensed under [GPL-3.0-or-later](https://spdx.org/licenses/GPL-3.0-or-later.html), offering a reproducible method for environmental researchers to quantify changes in atmospheric composition.

## Inputs and data preparation

_None listed._


This workflow requires NetCDF files as the primary input, which are processed using xarray tools to extract specific time periods and locations. Ensure that your input datasets are correctly formatted as NetCDF to allow for metadata extraction and coordinate-based selection. While individual datasets are used for each time period, organizing your inputs into collections can streamline the execution of the numerous statistical steps. For comprehensive guidance on parameter settings and data structure, refer to the README.md file. You can also use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | NetCDF xarray Metadata Info | toolshed.g2.bx.psu.edu/repos/ecology/xarray_metadata_info/xarray_metadata_info/0.18.2+galaxy0 | Input data corresponding to 1st January 2019 to 30th June 2019. |
| 1 | NetCDF xarray Metadata Info | toolshed.g2.bx.psu.edu/repos/ecology/xarray_metadata_info/xarray_metadata_info/0.18.2+galaxy0 |  |
| 2 | NetCDF xarray Metadata Info | toolshed.g2.bx.psu.edu/repos/ecology/xarray_metadata_info/xarray_metadata_info/0.18.2+galaxy0 |  |
| 3 | NetCDF xarray Metadata Info | toolshed.g2.bx.psu.edu/repos/ecology/xarray_metadata_info/xarray_metadata_info/0.18.2+galaxy0 |  |
| 4 | NetCDF xarray Metadata Info | toolshed.g2.bx.psu.edu/repos/ecology/xarray_metadata_info/xarray_metadata_info/0.18.2+galaxy0 |  |
| 5 | NetCDF xarray Selection | toolshed.g2.bx.psu.edu/repos/ecology/xarray_select/xarray_select/0.18.2+galaxy0 |  |
| 6 | NetCDF xarray Selection | toolshed.g2.bx.psu.edu/repos/ecology/xarray_select/xarray_select/0.18.2+galaxy0 |  |
| 7 | NetCDF xarray Selection | toolshed.g2.bx.psu.edu/repos/ecology/xarray_select/xarray_select/0.18.2+galaxy0 |  |
| 8 | NetCDF xarray Selection | toolshed.g2.bx.psu.edu/repos/ecology/xarray_select/xarray_select/0.18.2+galaxy0 |  |
| 9 | NetCDF xarray Selection | toolshed.g2.bx.psu.edu/repos/ecology/xarray_select/xarray_select/0.18.2+galaxy0 |  |
| 10 | Remove beginning | Remove beginning1 |  |
| 11 | Remove beginning | Remove beginning1 |  |
| 12 | Remove beginning | Remove beginning1 |  |
| 13 | Remove beginning | Remove beginning1 |  |
| 14 | Remove beginning | Remove beginning1 |  |
| 15 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/1.1.2 |  |
| 16 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/1.1.2 |  |
| 17 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/1.1.2 |  |
| 18 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/1.1.2 |  |
| 19 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/1.1.2 |  |
| 20 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 21 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 22 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 23 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 24 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 25 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 26 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 27 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 28 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 29 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 30 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 31 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 32 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 33 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 34 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 35 | Concatenate datasets | cat1 |  |
| 36 | Concatenate datasets | cat1 |  |
| 37 | Concatenate datasets | cat1 |  |
| 38 | Concatenate datasets | cat1 |  |
| 39 | Concatenate datasets | cat1 |  |
| 40 | Concatenate datasets | cat1 |  |
| 41 | Concatenate datasets | cat1 |  |
| 42 | Concatenate datasets | cat1 |  |
| 43 | Concatenate datasets | cat1 |  |
| 44 | Paste | Paste1 |  |
| 45 | Paste | Paste1 |  |
| 46 | Paste | Paste1 |  |
| 47 | Paste | Paste1 |  |
| 48 | Paste | Paste1 |  |
| 49 | Paste | Paste1 |  |
| 50 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/1.1.2 |  |
| 51 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/1.1.2 |  |
| 52 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/1.1.2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 41 | Maximum consecutive years 2019, 2020, 2021 | out_file1 |
| 42 | Minimum  consecutive years 2019, 2020, 2021 | out_file1 |
| 43 | Mean  consecutive years 2019, 2020, 2021 | out_file1 |
| 47 | Maximum 2019-2020-2021 | out_file1 |
| 48 | Minimum 2019-2020-2021 | out_file1 |
| 49 | Mean 2019-2020-2021 | out_file1 |
| 50 | Maximum 2019-2020-2021 over lockdown | outfile |
| 51 | Minimum 2019-2020-2021 over lockdown | outfile |
| 52 | Mean 2019-2020-2021 over lockdown | outfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Investigation_of_lockdown_effect_on_air_quality_between_January_2019_to_May_2021.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Investigation_of_lockdown_effect_on_air_quality_between_January_2019_to_May_2021.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Investigation_of_lockdown_effect_on_air_quality_between_January_2019_to_May_2021.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Investigation_of_lockdown_effect_on_air_quality_between_January_2019_to_May_2021.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Investigation_of_lockdown_effect_on_air_quality_between_January_2019_to_May_2021.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Investigation_of_lockdown_effect_on_air_quality_between_January_2019_to_May_2021.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
