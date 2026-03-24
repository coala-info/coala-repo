---
name: mass-spectrometry-gcms-with-metams
description: "This untargeted metabolomics workflow processes GC-MS dataset collections and sample metadata using XCMS for peak picking and the metaMS R package for pseudo-spectra definition and feature extraction. Use this skill when you need to perform automated peak detection, alignment, and multivariate statistical analysis to identify metabolic differences between experimental groups in gas chromatography-mass spectrometry studies."
homepage: https://workflowhub.eu/workflows/680
---

# Mass spectrometry: GCMS with metaMS

## Overview

This workflow provides an automated pipeline for untargeted metabolomics analysis using Gas Chromatography-Mass Spectrometry (GC-MS) data. It leverages the [XCMS](https://bioconductor.org/packages/release/bioc/html/xcms.html) R package for peak picking and the [metaMS](https://bioconductor.org/packages/release/bioc/html/metaMS.html) R package for the definition of pseudo-spectra and metabolite identification. The process is designed to handle raw mass spectrometry data in open formats such as mzXML, mzML, or netCDF, alongside a user-provided sample metadata file.

The pipeline begins by reading raw data via `MSnbase` and performing peak picking with `xcms findChromPeaks`. After merging peak data and generating diagnostic chromatogram plots (BPIs and TICs), the workflow utilizes `metaMS.runGC` to perform alignment, grouping, and annotation. This stage is critical for transforming raw spectral features into a structured peak table and data matrix suitable for biological interpretation.

In the final stages, the workflow performs data validation and statistical analysis. It includes a format check to ensure compatibility before executing multivariate analysis, which generates updated sample and variable metadata. This workflow is based on established [Galaxy Training Network](https://training.galaxyproject.org/training-material/topics/metabolomics/tutorials/gcms/tutorial.html) protocols and is released under the MIT license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Mass-spectrometry Dataset Collection | data_collection_input |  |
| 1 | sampleMetadata | data_input |  |


Ensure your mass spectrometry raw data files (mzXML, mzML, or netCDF) are organized into a Galaxy Dataset Collection to facilitate batch processing through the XCMS and metaMS modules. The required sampleMetadata file must be a tab-separated tabular format containing sample classes and experimental conditions, which can be generated using the `xcms get a sampleMetadata file` tool to avoid naming mismatches. For automated job configuration, you can use `planemo workflow_job_init` to generate a `job.yml` file. Refer to the README.md for comprehensive details on metadata column requirements and data preparation.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | MSnbase readMSData | toolshed.g2.bx.psu.edu/repos/lecorguille/msnbase_readmsdata/msnbase_readmsdata/2.16.1+galaxy3 |  |
| 3 | xcms findChromPeaks (xcmsSet) | toolshed.g2.bx.psu.edu/repos/lecorguille/xcms_xcmsset/abims_xcms_xcmsSet/3.12.0+galaxy3 |  |
| 4 | xcms plot chromatogram | toolshed.g2.bx.psu.edu/repos/lecorguille/xcms_plot_chromatogram/xcms_plot_chromatogram/3.12.0+galaxy3 |  |
| 5 | xcms findChromPeaks Merger | toolshed.g2.bx.psu.edu/repos/lecorguille/xcms_merge/xcms_merge/3.12.0+galaxy3 |  |
| 6 | metaMS.runGC | toolshed.g2.bx.psu.edu/repos/yguitton/metams_rungc/metams_runGC/3.0.0+metaMS1.24.0-galaxy0 |  |
| 7 | Check Format | toolshed.g2.bx.psu.edu/repos/ethevenot/checkformat/checkFormat/3.0.0 |  |
| 8 | Multivariate | toolshed.g2.bx.psu.edu/repos/ethevenot/multivariate/Multivariate/2.3.10 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | bpisPdf | bpisPdf |
| 4 | ticsPdf | ticsPdf |
| 6 | metaMS.runGC dataMatrix | dataMatrix |
| 6 | peaktable | peaktable |
| 8 | Multivariate variableMetadata | variableMetadata_out |
| 8 | Multivariate sampleMetadata | sampleMetadata_out |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Mass-spectrometry__GCMS-with-metaMS.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Mass-spectrometry__GCMS-with-metaMS.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Mass-spectrometry__GCMS-with-metaMS.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Mass-spectrometry__GCMS-with-metaMS.ga -o job.yml`
- Lint: `planemo workflow_lint Mass-spectrometry__GCMS-with-metaMS.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Mass-spectrometry__GCMS-with-metaMS.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
