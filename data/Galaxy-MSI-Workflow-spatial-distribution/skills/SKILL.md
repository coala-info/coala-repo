---
name: msi-workflow-spatial-distribution
description: This mass spectrometry imaging workflow processes imzML datasets and m/z features using Cardinal tools to perform quality control, filtering, and spatial visualization. Use this skill when you need to visualize the localization of specific metabolites across tissue sections and assess the quality of imaging mass spectrometry data.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# msi-workflow-spatial-distribution

## Overview

This Galaxy workflow is designed for Mass Spectrometry Imaging (MSI) analysis, specifically focusing on examining the spatial distribution of analytes within a sample. Utilizing the [Cardinal](https://cardinalmsi.org/) suite of tools, the pipeline processes metabolomics data to visualize where specific molecules are located. It requires three primary inputs: a composite imzML dataset, an annotation file, and a list of m/z features of interest.

The analytical process begins with comprehensive quality control and initial spectral plotting to assess the raw data. The workflow then performs data filtering to refine the signal and remove noise, followed by a second round of spectral visualization to verify the preprocessing results. These steps ensure that the subsequent spatial mapping is based on high-quality, cleaned data.

The final stages of the workflow involve exporting the processed data into intensity matrices and generating detailed m/z images. These images provide a visual representation of analyte distribution across the tissue or sample surface. This workflow is a valuable resource for [GTN-based](https://training.galaxyproject.org/) training and research applications where spatial context is critical for understanding metabolic profiles.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Uploaded Composite Dataset (imzml) | data_input |  |
| 1 | Annotation | data_input |  |
| 2 | m/z features | data_input |  |


Ensure the primary input is uploaded as a composite `imzML` dataset, which must include both the metadata and binary data files to maintain spatial integrity within the Cardinal-based tools. While this workflow processes individual datasets, organizing multiple samples into a dataset collection is recommended for scaling the analysis across larger imaging cohorts. Consult the `README.md` for precise formatting requirements regarding the annotation and m/z feature tabular files. For automated testing or batch execution, `planemo workflow_job_init` can be used to generate a template `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | MSI Qualitycontrol | toolshed.g2.bx.psu.edu/repos/galaxyp/cardinal_quality_report/cardinal_quality_report/2.6.0.1 |  |
| 4 | MSI plot spectra | toolshed.g2.bx.psu.edu/repos/galaxyp/cardinal_spectra_plots/cardinal_spectra_plots/2.6.0.0 |  |
| 5 | MSI filtering | toolshed.g2.bx.psu.edu/repos/galaxyp/cardinal_filtering/cardinal_filtering/2.6.0.0 |  |
| 6 | MSI plot spectra | toolshed.g2.bx.psu.edu/repos/galaxyp/cardinal_spectra_plots/cardinal_spectra_plots/2.6.0.0 |  |
| 7 | MSI data exporter | toolshed.g2.bx.psu.edu/repos/galaxyp/cardinal_data_exporter/cardinal_data_exporter/2.6.0.0 |  |
| 8 | MSI mz images | toolshed.g2.bx.psu.edu/repos/galaxyp/cardinal_mz_images/cardinal_mz_images/2.6.0.0 |  |
| 9 | Filter | Filter1 |  |
| 10 | MSI mz images | toolshed.g2.bx.psu.edu/repos/galaxyp/cardinal_mz_images/cardinal_mz_images/2.6.0.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | QC_report | QC_report |
| 4 | plots | plots |
| 5 | QC_overview | QC_overview |
| 5 | outfile_imzml | outfile_imzml |
| 6 | plots | plots |
| 7 | intensity_matrix | intensity_matrix |
| 7 | feature_output | feature_output |
| 8 | plots | plots |
| 9 | out_file1 | out_file1 |
| 10 | plots | plots |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run wf-msi-distribution.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run wf-msi-distribution.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run wf-msi-distribution.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init wf-msi-distribution.ga -o job.yml`
- Lint: `planemo workflow_lint wf-msi-distribution.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `wf-msi-distribution.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)