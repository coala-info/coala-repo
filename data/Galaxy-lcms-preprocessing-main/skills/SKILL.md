---
name: mass-spectrometry-lc-ms-preprocessing-with-xcms
description: "This metabolomics workflow processes LC-MS dataset collections and sample metadata using the XCMS and CAMERA R packages to perform peak picking, retention time correction, and feature annotation. Use this skill when you need to extract and align metabolic features from raw mass spectrometry data while annotating isotopes and adducts to prepare a validated data matrix for comparative metabolomics."
homepage: https://workflowhub.eu/workflows/677
---

# Mass spectrometry: LC-MS preprocessing with XCMS

## Overview

This workflow provides a comprehensive pipeline for the preprocessing of Liquid Chromatography-Mass Spectrometry (LC-MS) metabolomics data. It utilizes the [XCMS](https://bioconductor.org/packages/release/bioc/html/xcms.html) R package to perform essential data processing tasks, including peak picking, retention time alignment, and peak grouping. The pipeline is designed to transform raw mass spectrometry data into a structured data matrix suitable for downstream statistical analysis.

The process begins by reading raw MS data (in formats such as mzML, mzXML, or netCDF) and sample metadata. Key steps include peak detection via `findChromPeaks`, shared ion determination with `groupChromPeaks`, and retention time correction using `adjustRtime`. To ensure data integrity, the workflow includes `fillChromPeaks` to integrate areas of missing peaks and utilizes the [CAMERA](https://bioconductor.org/packages/release/bioc/html/CAMERA.html) R package to annotate isotopes, adducts, and fragments.

Users are provided with various diagnostic outputs, such as Base Peak Intensity (BPI) and Total Ion Chromatogram (TIC) plots, to monitor data quality at different stages. The final outputs include a processed data matrix and variable metadata, facilitating a seamless transition to metabolite identification and statistical interpretation. For detailed guidance on parameter settings and execution, refer to the [Galaxy Training Network tutorial](https://training.galaxyproject.org/training-material/topics/metabolomics/tutorials/lcms-preprocessing/tutorial.html).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | SampleMetadata | data_input |  |
| 1 | Mass-spectrometry Dataset Collection | data_collection_input |  |


For this workflow, ensure your mass spectrometry raw data files are in open formats such as mzML or mzXML and organized into a Galaxy Dataset Collection to enable parallel processing. You must also provide a tabular SampleMetadata file containing sample classes and injection orders, which can be generated using the `xcms get a sampleMetadata file` tool to avoid naming mismatches. Refer to the README.md for specific column requirements and detailed instructions on preparing your metadata template. For automated job configuration, you can use `planemo workflow_job_init` to generate a `job.yml` file. One paragraph only.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | MSnbase readMSData | toolshed.g2.bx.psu.edu/repos/lecorguille/msnbase_readmsdata/msnbase_readmsdata/2.16.1+galaxy3 |  |
| 3 | xcms plot chromatogram | toolshed.g2.bx.psu.edu/repos/lecorguille/xcms_plot_chromatogram/xcms_plot_chromatogram/3.12.0+galaxy3 |  |
| 4 | xcms findChromPeaks (xcmsSet) | toolshed.g2.bx.psu.edu/repos/lecorguille/xcms_xcmsset/abims_xcms_xcmsSet/3.12.0+galaxy3 |  |
| 5 | xcms findChromPeaks Merger | toolshed.g2.bx.psu.edu/repos/lecorguille/xcms_merge/xcms_merge/3.12.0+galaxy3 |  |
| 6 | xcms groupChromPeaks (group) | toolshed.g2.bx.psu.edu/repos/lecorguille/xcms_group/abims_xcms_group/3.12.0+galaxy3 |  |
| 7 | xcms adjustRtime (retcor) | toolshed.g2.bx.psu.edu/repos/lecorguille/xcms_retcor/abims_xcms_retcor/3.12.0+galaxy3 |  |
| 8 | Check Format | toolshed.g2.bx.psu.edu/repos/ethevenot/checkformat/checkFormat/3.0.0 |  |
| 9 | xcms plot chromatogram | toolshed.g2.bx.psu.edu/repos/lecorguille/xcms_plot_chromatogram/xcms_plot_chromatogram/3.12.0+galaxy3 |  |
| 10 | xcms groupChromPeaks (group) | toolshed.g2.bx.psu.edu/repos/lecorguille/xcms_group/abims_xcms_group/3.12.0+galaxy3 |  |
| 11 | Intensity Check | toolshed.g2.bx.psu.edu/repos/melpetera/intensity_checks/intens_check/1.3.0 |  |
| 12 | xcms fillChromPeaks (fillPeaks) | toolshed.g2.bx.psu.edu/repos/lecorguille/xcms_fillpeaks/abims_xcms_fillPeaks/3.12.0+galaxy3 |  |
| 13 | CAMERA.annotate | toolshed.g2.bx.psu.edu/repos/lecorguille/camera_annotate/abims_CAMERA_annotateDiffreport/2.2.7+camera1.48.0-galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | bpisPdf | bpisPdf |
| 3 | ticsPdf | ticsPdf |
| 6 | plotChromPeakDensity | plotChromPeakDensity |
| 7 | rawVSadjustedPdf | rawVSadjustedPdf |
| 9 | ticsPdf | ticsPdf |
| 9 | bpisPdf | bpisPdf |
| 10 | plotChromPeakDensity | plotChromPeakDensity |
| 11 | graphs_out | graphs_out |
| 12 | dataMatrix | dataMatrix |
| 13 | rdata_quick_true | rdata_quick_true |
| 13 | CAMERA.annotate variableMetadata | variableMetadata |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Mass_spectrometry__LC-MS_preprocessing_with_XCMS.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Mass_spectrometry__LC-MS_preprocessing_with_XCMS.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Mass_spectrometry__LC-MS_preprocessing_with_XCMS.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Mass_spectrometry__LC-MS_preprocessing_with_XCMS.ga -o job.yml`
- Lint: `planemo workflow_lint Mass_spectrometry__LC-MS_preprocessing_with_XCMS.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Mass_spectrometry__LC-MS_preprocessing_with_XCMS.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
