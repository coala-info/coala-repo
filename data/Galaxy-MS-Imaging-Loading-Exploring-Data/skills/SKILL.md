---
name: ms-imaging-loading-exploring-data
description: This proteomics workflow processes mass spectrometry imaging data and internal calibrants using Cardinal-based quality control and data export tools to explore spatial molecular distributions. Use this skill when you need to perform initial quality assessment and data exploration of mass spectrometry imaging datasets to identify spatial patterns of proteins or metabolites.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# ms-imaging-loading-exploring-data

## Overview

This workflow provides a standardized pipeline for the initial loading and exploration of Mass Spectrometry Imaging (MSI) data. Developed in alignment with [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) tutorials for proteomics, it is designed to handle complex spatial chemical data, such as the included mouse kidney dataset, alongside internal calibrants for data validation.

The core of the workflow utilizes the [Cardinal](https://cardinalmsi.org/) suite of tools to perform essential data management tasks. It features the **MSI Qualitycontrol** tool to generate detailed reports on spectral quality and spatial intensity, and the **MSI data exporter** to convert processed information into shareable formats. These steps allow researchers to assess the integrity of their MSI experiments before moving to advanced statistical modeling.

To ensure data consistency, the pipeline incorporates text processing utilities for sorting and filtering tabular metadata. By combining specialized imaging tools with general data manipulation steps, the workflow streamlines the transition from raw mass spectrometry files to interpreted spatial distributions.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | mouse_kidney_cut.i | data_input |  |
| 1 | internal calibrants.tab | data_input |  |


Ensure your mass spectrometry imaging data is uploaded in imzML format, typically requiring both the .imzML and .ibd files to be handled as a composite dataset or within a single history item. While individual datasets are sufficient for this workflow, using data collections is recommended if you plan to scale the analysis to multiple tissue sections. The internal calibrants must be provided as a tabular file containing the specific m/z values targeted for your quality control steps. Please refer to the README.md for comprehensive details on data preparation and specific tool parameters. You may also use `planemo workflow_job_init` to create a `job.yml` for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | MSI data exporter | toolshed.g2.bx.psu.edu/repos/galaxyp/cardinal_data_exporter/cardinal_data_exporter/1.12.1.1 |  |
| 3 | MSI Qualitycontrol | toolshed.g2.bx.psu.edu/repos/galaxyp/cardinal_quality_report/cardinal_quality_report/1.12.1.2 |  |
| 4 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/1.1.1 |  |
| 5 | Select | Grep1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run ms-imaging-loading-exploring-data.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run ms-imaging-loading-exploring-data.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run ms-imaging-loading-exploring-data.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init ms-imaging-loading-exploring-data.ga -o job.yml`
- Lint: `planemo workflow_lint ms-imaging-loading-exploring-data.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `ms-imaging-loading-exploring-data.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)