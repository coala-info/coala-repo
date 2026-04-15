---
name: argo-glider-nitrate-qcv
description: This oceanography workflow processes Argo float or glider NetCDF collections and reference datasets to perform nitrate qualification, calibration, and validation using QCV harmonizers, Ocean Data View, and neural network-based biogeochemical calibration tools. Use this skill when you need to ensure the accuracy of nitrate sensor measurements from autonomous platforms by comparing them against climatology or neural network models to produce high-quality biogeochemical data for marine research.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# argo-glider-nitrate-qcv

## Overview

This Galaxy workflow is designed for the Qualification, Nitrate Calibration, and Validation (QCV) of data from individual Argo floats or gliders. By leveraging neural networks and climatology reference datasets, it provides a standardized pipeline for processing biogeochemical sensor data to ensure high-quality oceanographic observations.

The process begins with the harmonization of input netCDF collections and reference datasets. It integrates [Ocean Data View (ODV)](https://odv.awi.de/) through interactive tools and collection managers, allowing users to perform manual quality control and visualize data distributions. The core of the workflow utilizes a specialized BioGeoChemical calibration tool to apply corrections based on established neural network models and climatological benchmarks.

The workflow produces a comprehensive set of outputs, including calibrated and QCed netCDF files, PNG visualizations for data inspection, and detailed processing logs. Licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/), this tool is a key resource for the Ocean and Argo communities (GTN) to maintain data integrity in autonomous platform monitoring. For detailed setup instructions, please refer to the README.md in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input Argo or gliders netcdf collection | data_collection_input |  |
| 1 | input ref dataset | data_input |  |


Ensure your input Argo or glider data is organized as a netCDF collection, while the reference climatology should be provided as a single dataset. Verify that all netCDF files follow standard oceanographic naming conventions to ensure the QCV harmonizer and ODV tools process the metadata correctly. You may need to adjust calibration parameters within the BioGeoChemical tool step depending on the specific sensor drift observed in your float or glider. For a comprehensive guide on parameterization and data structure, refer to the README.md file included in the repository. You can also use `planemo workflow_job_init` to generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | QCV harmonizer | toolshed.g2.bx.psu.edu/repos/ecology/harmonize_insitu_to_netcdf/harmonize_insitu_to_netcdf/3.0+galaxy1 |  |
| 3 | QCV harmonizer | toolshed.g2.bx.psu.edu/repos/ecology/harmonize_insitu_to_netcdf/harmonize_insitu_to_netcdf/3.0+galaxy1 |  |
| 4 | ODV collection manager | toolshed.g2.bx.psu.edu/repos/ecology/tool_odv/tool_odv/1.3+galaxy2 |  |
| 5 | ODV | interactive_tool_odv |  |
| 6 | ODV history manager | toolshed.g2.bx.psu.edu/repos/ecology/tool_odv_history/tool_odv_history/1.2+galaxy2 |  |
| 7 | BioGeoChemical calibration | toolshed.g2.bx.psu.edu/repos/ecology/tool_biogeochemical_calibration/tool_biogeochemical_calibration/2.1+galaxy2 |  |
| 8 | ODV collection manager | toolshed.g2.bx.psu.edu/repos/ecology/tool_odv/tool_odv/1.3+galaxy2 |  |
| 9 | ODV | interactive_tool_odv |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | Harmonized netcdf | output_net |
| 3 | Harmonized netcd | output_net |
| 4 | Output odv collection | output |
| 4 | Collection of files | files |
| 5 | ODV history extracted (txt) | outputs_txt |
| 5 | outputs_all | outputs_all |
| 6 | csv_files | csv_files |
| 6 | nc_files_qced | nc_files |
| 7 | nc_files_calibrated | nc_files |
| 7 | tar_files | tar_files |
| 7 | png_files | png_files |
| 7 | log_files | log_files |
| 8 | files | files |
| 8 | output odv collection (txt) | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-argo-glider-nitrate-qcv.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-argo-glider-nitrate-qcv.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-argo-glider-nitrate-qcv.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-argo-glider-nitrate-qcv.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-argo-glider-nitrate-qcv.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-argo-glider-nitrate-qcv.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)