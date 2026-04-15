---
name: msi-finding-diff-analytes
description: This mass spectrometry imaging workflow processes treated and control metabolomics datasets using Cardinal and MALDIquant tools to perform preprocessing, peak detection, and spatial segmentation. Use this skill when you need to identify spatially resolved differential analytes or glycans between experimental groups and visualize their distribution across tissue samples.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# msi-finding-diff-analytes

## Overview

This Galaxy workflow is designed for the comparative analysis of Mass Spectrometry Imaging (MSI) data, specifically aimed at identifying differential analytes between treated and control groups. It leverages the [Cardinal](https://cardinalmsi.org/) and [MALDIquant](https://strimmerlab.github.io/software/maldiquant/) R packages to perform a comprehensive metabolomics pipeline, from raw data integration to statistical classification.

The process begins by combining multiple datasets and performing essential preprocessing steps, including normalization, baseline correction, and peak detection. Quality control reports are generated to ensure data integrity before moving into downstream analysis. The workflow then utilizes spatial segmentation and classification algorithms to isolate features that distinguish different biological conditions or tissue regions.

In the final stages, the workflow filters and joins the resulting feature lists with identification metadata (such as Glycan IDs). It produces summary statistics and high-resolution m/z images to visualize the spatial distribution of the identified differential analytes. This automated pipeline is particularly useful for [GTN-based metabolomics](https://training.galaxyproject.org/) tutorials and large-scale spatial omics studies.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | treated | data_input |  |
| 1 | control | data_input |  |
| 2 | Glycan_IDs | data_input |  |
| 3 | all_files | data_input |  |


Ensure your input files are in imzML or RData format, specifically organizing treated and control samples as individual datasets or collections to facilitate the MSI combine step. Verify that the Glycan_IDs file is a compatible tabular format for the fuzzy join operation later in the pipeline. For automated testing or local execution, you can generate a configuration template using `planemo workflow_job_init` to create a `job.yml` file. Refer to the README.md for comprehensive details on parameter settings and specific data preparation requirements.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | MSI combine | toolshed.g2.bx.psu.edu/repos/galaxyp/cardinal_combine/cardinal_combine/1.12.1.3 |  |
| 5 | MSI preprocessing | toolshed.g2.bx.psu.edu/repos/galaxyp/cardinal_preprocessing/cardinal_preprocessing/1.12.1.3 |  |
| 6 | MSI Qualitycontrol | toolshed.g2.bx.psu.edu/repos/galaxyp/cardinal_quality_report/cardinal_quality_report/1.12.1.3 |  |
| 7 | MALDIquant preprocessing | toolshed.g2.bx.psu.edu/repos/galaxyp/maldi_quant_preprocessing/maldi_quant_preprocessing/1.18.0.3 |  |
| 8 | MALDIquant peak detection | toolshed.g2.bx.psu.edu/repos/galaxyp/maldi_quant_peak_detection/maldi_quant_peak_detection/1.18.0.4 |  |
| 9 | MSI preprocessing | toolshed.g2.bx.psu.edu/repos/galaxyp/cardinal_preprocessing/cardinal_preprocessing/1.12.1.3 |  |
| 10 | MSI classification | toolshed.g2.bx.psu.edu/repos/galaxyp/cardinal_classification/cardinal_classification/1.12.1.3 |  |
| 11 | MSI segmentation | toolshed.g2.bx.psu.edu/repos/galaxyp/cardinal_segmentations/cardinal_segmentations/1.12.1.3 |  |
| 12 | Filter | Filter1 |  |
| 13 | Join two files | toolshed.g2.bx.psu.edu/repos/bgruening/join_files_on_column_fuzzy/join_files_on_column_fuzzy/1.0.1 |  |
| 14 | Summary Statistics | Summary_Statistics1 |  |
| 15 | MSI mz images | toolshed.g2.bx.psu.edu/repos/galaxyp/cardinal_mz_images/cardinal_mz_images/1.12.1.2 |  |
| 16 | Select | Grep1 |  |
| 17 | MSI mz images | toolshed.g2.bx.psu.edu/repos/galaxyp/cardinal_mz_images/cardinal_mz_images/1.12.1.2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | outfile_imzml | outfile_imzml |
| 5 | outfile_rdata | outfile_rdata |
| 5 | outfile_imzml | outfile_imzml |
| 5 | QC_overview | QC_overview |
| 6 | QC_report | QC_report |
| 7 | outfile_imzml | outfile_imzml |
| 7 | plots | plots |
| 10 | mzfeatures | mzfeatures |
| 10 | classification_images | classification_images |
| 11 | segmentationimages | segmentationimages |
| 13 | merged_file | merged_file |
| 14 | out_file1 | out_file1 |
| 15 | svg_output | svg_output |
| 15 | plots | plots |
| 16 | out_file1 | out_file1 |
| 17 | plots | plots |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run msi-finding-diff-analytes.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run msi-finding-diff-analytes.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run msi-finding-diff-analytes.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init msi-finding-diff-analytes.ga -o job.yml`
- Lint: `planemo workflow_lint msi-finding-diff-analytes.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `msi-finding-diff-analytes.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)