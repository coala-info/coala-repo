---
name: oceans-variables-20
description: "This workflow processes Mediterranean eutrophication profiles and GEBCO bathymetry using ODV and DIVAnd to subset data and visualize phosphate concentrations. Use this skill when you need to perform spatial interpolation of oceanographic chemical tracers to study nutrient distribution or eutrophication patterns in the Mediterranean Sea."
homepage: https://workflowhub.eu/workflows/1445
---

# Ocean's variables 2.0

## Overview

This workflow is designed for Earth-system and oceanographic research, specifically focusing on subsetting and analyzing Mediterranean Sea data. It enables researchers to extract and visualize the Phosphate variable from eutrophication profile datasets, facilitating the study of nutrient distribution and water quality.

The process utilizes [ODV (Ocean Data View)](https://odv.awi.de/) for interactive data exploration and visualization. It integrates [DIVAnd (Data-Interpolating Variational Analysis)](https://github.com/gher-ulg/DIVAnd.jl) through both automated tools and interactive Jupyter Notebooks to perform spatial interpolation and analysis on the oceanographic profiles.

Users provide eutrophication profile snapshots and GEBCO bathymetry data as primary inputs. The workflow generates a processed NetCDF file (`Water_body_Phosphate_Mediterranean.nc`) along with both interactive and static visualizations of the ocean variables. It supports different operational modes, ranging from fully interactive to semi-automatic execution.

Developed as part of the [GTN (Galaxy Training Network)](https://training.galaxyproject.org/), this workflow is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/). It serves as a robust tool for oceanographers to handle complex spatial data and perform high-quality interpolations within the Galaxy ecosystem.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Worflow fully interactive | parameter_input | Choose whether you want to have only interactive tools (for more experimented user) or if you want a workflow hat combines interactive and non-interactive tools (easier) |
| 1 | Eutrophication_Med_profiles_2022_unrestricted_SNAPSHOT_2023-10-24T16-39-44.zip | data_input | The data here are Mediterranean Sea - Eutrophication and Acidity aggregated datasets EMODnet Chemistry. |
| 2 | Workflow semi automatic | parameter_input | Choose whether you want to have only interactive tools (for more experimented user) or if you want a workflow hat combines interactive and non-interactive tools (easier) |
| 3 | gebco_30sec_8.nc | data_input | A bathymetry file in netcdf. |


Ensure your input data is provided in `.zip` format for the Eutrophication profiles and `.nc` (NetCDF) for the GEBCO bathymetry to maintain compatibility with the ODV and DIVAnd tools. While this workflow processes individual datasets, you may find it efficient to use data collections if handling multiple regional snapshots simultaneously. Refer to the `README.md` for comprehensive details on configuring the interactive parameters required for subsetting Mediterranean variables. You can also use `planemo workflow_job_init` to create a `job.yml` for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | ODV | interactive_tool_odv | Interactively subset you data. |
| 5 | Interactive DIVAnd Notebooks | interactive_tool_divand | Create a climatology interactively with notebooks |
| 6 | DIVAnd | toolshed.g2.bx.psu.edu/repos/ecology/divand_full_analysis/divand_full_analysis/0.1.0+galaxy0 | Create a climatology (not interactively) |
| 7 | ODV | interactive_tool_odv | Final step to visualize in different way a ocean variable like the phosphate. |
| 8 | ODV | interactive_tool_odv | Final step to visualize in different way a ocean variable like the phosphate. |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 6 | Water_body_Phosphate_Mediterranean.nc | output_netcdf |
| 7 | Ocean variables visualisation interactive | outputs_all |
| 8 | Ocean variables visualisation | outputs_all |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run main-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run main-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run main-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init main-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint main-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `main-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
