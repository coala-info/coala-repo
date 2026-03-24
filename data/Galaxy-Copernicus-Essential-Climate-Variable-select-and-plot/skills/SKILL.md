---
name: workflow-with-copernicus-essential-climate-variable-select-a
description: "This climate science workflow retrieves Copernicus Essential Climate Variables, processes the NetCDF data using xarray tools, and generates scatterplots with ggplot2. Use this skill when you need to analyze long-term climate trends or visualize specific atmospheric and oceanic variables from the Copernicus Climate Data Store."
homepage: https://workflowhub.eu/workflows/46
---

# Workflow with Copernicus Essential Climate Variable - select and plot

## Overview

This Galaxy workflow is designed to automate the retrieval, processing, and visualization of climate data from the Copernicus Climate Data Store (CDS). It begins by using the [Copernicus Essential Climate Variables](https://toolshed.g2.bx.psu.edu/repos/climate/cds_essential_variability/cds_essential_variability/0.1.4) tool to fetch specific environmental datasets, such as temperature, sea level, or atmospheric composition records.

Once the data is retrieved in NetCDF format, the workflow employs [xarray](https://toolshed.g2.bx.psu.edu/repos/ecology/xarray_select/xarray_select/0.15.1) utilities to inspect metadata and subset the variables of interest. The extracted data then undergoes a series of transformations, including column-based computations and text reformatting using [AWK](https://toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/1.1.1) and [Datamash](https://toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0), to structure the information for statistical analysis.

The final stage of the pipeline generates a visual representation of the processed climate data. By utilizing [ggplot2](https://toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/2.2.1+galaxy2), the workflow produces a scatterplot that allows users to identify trends or anomalies within the selected Essential Climate Variables (ECVs). Detailed configuration and usage instructions can be found in the [README.md](README.md) file in the Files section.

## Inputs and data preparation

_None listed._


Ensure you have your Copernicus Climate Data Store (CDS) API credentials configured, as the workflow primarily retrieves and processes NetCDF (.nc) files. While individual datasets are supported, organizing multi-variable outputs into collections simplifies the downstream xarray selection and metadata extraction steps. Refer to the `README.md` for specific instructions on configuring the CDS tool parameters and handling coordinate variables. You can automate the testing of these inputs by generating a `job.yml` file using `planemo workflow_job_init`.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Copernicus Essential Climate Variables | toolshed.g2.bx.psu.edu/repos/climate/cds_essential_variability/cds_essential_variability/0.1.4 | Select variable of your choice as well as period of time, etc. and retrieve dataset. |
| 1 | NetCDF xarray Metadata Info | toolshed.g2.bx.psu.edu/repos/ecology/xarray_metadata_info/xarray_metadata_info/0.15.1 | Get metadata from retrieved dataset |
| 2 | NetCDF xarray Selection | toolshed.g2.bx.psu.edu/repos/ecology/xarray_select/xarray_select/0.15.1 | Select a single location to extract timeseries |
| 3 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/1.3.0 |  |
| 4 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/1.1.1 |  |
| 5 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 6 | Scatterplot with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/2.2.1+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Copernicus_Essential_Climate_Variable_-_select_and_plot.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Copernicus_Essential_Climate_Variable_-_select_and_plot.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Copernicus_Essential_Climate_Variable_-_select_and_plot.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Copernicus_Essential_Climate_Variable_-_select_and_plot.ga -o job.yml`
- Lint: `planemo workflow_lint Copernicus_Essential_Climate_Variable_-_select_and_plot.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Copernicus_Essential_Climate_Variable_-_select_and_plot.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
