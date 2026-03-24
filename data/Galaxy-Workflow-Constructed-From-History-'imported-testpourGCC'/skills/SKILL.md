---
name: workflow-constructed-from-history-imported-testpourgcc
description: "This metabolomics workflow processes LC-MS data from mzML files using XCMS for peak picking and alignment, CAMERA for feature annotation, and statistical tools for batch correction and univariate analysis. Use this skill when you need to identify and quantify metabolic features in complex biological samples to discover biomarkers or characterize metabolic profiles using the Human Metabolome Database."
homepage: https://workflowhub.eu/workflows/1584
---

# Workflow Constructed From History 'imported: testpourGCC'

## Overview

This Galaxy workflow provides a comprehensive pipeline for LC-MS (Liquid Chromatography-Mass Spectrometry) metabolomics data analysis. It is designed to process raw mass spectrometry data in `.mzML` format, moving from initial data ingestion to metabolite identification. The workflow follows standard [GTN](https://training.galaxyproject.org/) practices for reproducible metabolomics research.

The core of the pipeline utilizes the [xcms](https://toolshed.g2.bx.psu.edu/repos/lecorguille/xcms_xcmsset) suite to perform peak picking, retention time alignment, and feature grouping. Following feature extraction, [CAMERA](https://toolshed.g2.bx.psu.edu/repos/lecorguille/camera_annotate) is used for the annotation of isotopes and adducts, which helps in characterizing the detected metabolic features.

Data quality and statistical integrity are addressed through integrated steps for batch correction, quality metric assessment, and generic filtering. These steps ensure that the resulting feature table is normalized and filtered for high-quality signals before undergoing univariate statistical analysis to identify significant metabolic changes.

In the final stages, the workflow facilitates biological interpretation by performing an [HMDB MS search](https://toolshed.g2.bx.psu.edu/repos/fgiacomoni/hmdb_ms_search) to annotate features against the Human Metabolome Database. This enables researchers to transition from raw spectral data to identified metabolites and statistically significant findings.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | HU_neg_048.mzML | data_input |  |
| 1 | Input Dataset Collection | data_collection_input |  |


Ensure your input files are in `.mzML` format to maintain compatibility with the `MSnbase` and `xcms` tool suite. While individual files can be used, organizing your samples into a data collection is recommended for efficient batch processing through the LC-MS pipeline. Detailed parameter settings and metadata requirements are documented in the `README.md` file. You can automate the setup of these inputs by using `planemo workflow_job_init` to generate a `job.yml` template.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | MSnbase readMSData | toolshed.g2.bx.psu.edu/repos/lecorguille/msnbase_readmsdata/msnbase_readmsdata/2.8.2.1 |  |
| 3 | xcms findChromPeaks (xcmsSet) | toolshed.g2.bx.psu.edu/repos/lecorguille/xcms_xcmsset/abims_xcms_xcmsSet/3.4.4.1 |  |
| 4 | xcms plot chromatogram | toolshed.g2.bx.psu.edu/repos/lecorguille/xcms_plot_chromatogram/xcms_plot_chromatogram/3.4.4.0 |  |
| 5 | xcms findChromPeaks Merger | toolshed.g2.bx.psu.edu/repos/lecorguille/xcms_merge/xcms_merge/3.4.4.0 |  |
| 6 | xcms groupChromPeaks (group) | toolshed.g2.bx.psu.edu/repos/lecorguille/xcms_group/abims_xcms_group/3.4.4.0 |  |
| 7 | xcms adjustRtime (retcor) | toolshed.g2.bx.psu.edu/repos/lecorguille/xcms_retcor/abims_xcms_retcor/3.4.4.1 |  |
| 8 | xcms plot chromatogram | toolshed.g2.bx.psu.edu/repos/lecorguille/xcms_plot_chromatogram/xcms_plot_chromatogram/3.4.4.0 |  |
| 9 | xcms groupChromPeaks (group) | toolshed.g2.bx.psu.edu/repos/lecorguille/xcms_group/abims_xcms_group/3.4.4.0 |  |
| 10 | xcms fillChromPeaks (fillPeaks) | toolshed.g2.bx.psu.edu/repos/lecorguille/xcms_fillpeaks/abims_xcms_fillPeaks/3.4.4.0 |  |
| 11 | CAMERA.annotate | toolshed.g2.bx.psu.edu/repos/lecorguille/camera_annotate/abims_CAMERA_annotateDiffreport/2.2.4 |  |
| 12 | Batch_correction | toolshed.g2.bx.psu.edu/repos/melpetera/batchcorrection/Batch_correction/2.1.2 |  |
| 13 | Quality Metrics | toolshed.g2.bx.psu.edu/repos/ethevenot/qualitymetrics/quality_metrics/2.2.8 |  |
| 14 | Quality Metrics | toolshed.g2.bx.psu.edu/repos/ethevenot/qualitymetrics/quality_metrics/2.2.8 |  |
| 15 | Generic_Filter | toolshed.g2.bx.psu.edu/repos/melpetera/generic_filter/generic_filter/2017.04 |  |
| 16 | Univariate | toolshed.g2.bx.psu.edu/repos/ethevenot/univariate/Univariate/2.2.4 |  |
| 17 | Generic_Filter | toolshed.g2.bx.psu.edu/repos/melpetera/generic_filter/generic_filter/2017.04 |  |
| 18 | HMDB MS search | toolshed.g2.bx.psu.edu/repos/fgiacomoni/hmdb_ms_search/wsdl_hmdb/2018-10-01 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

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
