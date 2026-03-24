---
name: end-to-end-tissue-microarray-analysis
description: "This workflow processes raw cyclic immunofluorescence images and marker metadata using ASHLAR, Mesmer, and Scimap to perform illumination correction, registration, and cell phenotyping for tissue microarray analysis. Use this skill when you need to transform raw multiplexed tissue microarray images into quantified single-cell data and interactive visualizations to study spatial protein expression and cell phenotypes."
homepage: https://workflowhub.eu/workflows/1337
---

# End-to-End Tissue Microarray Analysis

## Overview

This workflow provides a comprehensive pipeline for analyzing multiplexed tissue microarray (TMA) images acquired via cyclic immunofluorescence. It begins with raw image preprocessing, utilizing [BaSiC](https://mcmicro.org/) for illumination correction and [ASHLAR](https://github.com/labsyspharm/ashlar) for stitching and registration. The resulting whole-slide OME-TIFF images are then processed by [UNetCoreograph](https://mcmicro.org/) to segment and crop individual TMA cores for downstream batch analysis.

Once cores are isolated, the pipeline performs nuclear segmentation using [Mesmer](https://deepcell.readthedocs.io/en/master/) to generate high-fidelity masks. These masks facilitate single-cell feature quantification via [MCQUANT](https://mcmicro.org/), which extracts marker intensities, spatial coordinates, and morphological data. The resulting quantification tables are converted into the [anndata](https://anndata.readthedocs.io/) format, ensuring compatibility with standard single-cell and spatial omics analysis ecosystems.

The final stages involve automated cell phenotyping using [Scimap](https://scimap-doc.readthedocs.io/en/latest/), which applies Gaussian Mixture Models (GMM) to assign cell types based on marker expression. To explore the results, the workflow generates an interactive [Vitessce](https://vitessce.io/) dashboard. This environment integrates pyramidal image viewing with linked single-cell visualizations, allowing researchers to validate phenotypes and spatial distributions directly.

For detailed configuration and input requirements, including the markers and phenotype CSV formats, please refer to the [Galaxy Training Network tutorial](https://training.galaxyproject.org/training-material/topics/imaging/tutorials/multiplex-tissue-imaging-TMA/tutorial.html). Note that while GMM-based phenotyping is automated, manual gating is recommended for markers that do not exhibit a strong bimodal distribution.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Raw cycle images | data_collection_input | Raw TIFF images (CZI, TIFF) in an round-ordered list |
| 1 | markers.csv | data_input | CSV file containing marker names |
| 2 | PhenotypeWorkflow | data_input | Scimap formatted phenotype workflow |


Ensure raw cycle images are provided as a data collection of TIFF or OME-TIFF files strictly ordered by cycle to ensure correct registration. The markers file must be a CSV with marker names in the third column, and the phenotype file should follow the hierarchical Scimap format for automated cell classification. Verify that the preset image resolution and reference channels match your specific hardware settings, as these parameters are optimized for Rarecyte scanners. Refer to the README.md for detailed examples of the required CSV structures and specific column requirements. You can use `planemo workflow_job_init` to generate a `job.yml` file for configuring these inputs for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | BaSiC Illumination | toolshed.g2.bx.psu.edu/repos/perssond/basic_illumination/basic_illumination/1.1.1+galaxy2 | Illumination correction |
| 4 | ASHLAR | toolshed.g2.bx.psu.edu/repos/perssond/ashlar/ashlar/1.18.0+galaxy1 | Stitching and registration |
| 5 | UNetCoreograph | toolshed.g2.bx.psu.edu/repos/perssond/coreograph/unet_coreograph/2.2.8+galaxy1 | TMA dearray |
| 6 | Perform segmentation of multiplexed tissue data | toolshed.g2.bx.psu.edu/repos/goeckslab/mesmer/mesmer/0.12.3+galaxy3 | Nuclear segmentation |
| 7 | Convert image format | toolshed.g2.bx.psu.edu/repos/imgteam/bfconvert/ip_convertimage/6.7.0+galaxy3 | Convert to OME-TIFF |
| 8 | MCQUANT | toolshed.g2.bx.psu.edu/repos/perssond/quantification/quantification/1.6.0+galaxy0 | Quantify cell features |
| 9 | Rename OME-TIFF channels | toolshed.g2.bx.psu.edu/repos/goeckslab/rename_tiff_channels/rename_tiff_channels/0.0.2+galaxy1 | Rename OME-TIFF channels |
| 10 | Convert McMicro Output to Anndata | toolshed.g2.bx.psu.edu/repos/goeckslab/scimap_mcmicro_to_anndata/scimap_mcmicro_to_anndata/2.1.0+galaxy2 | Convert to Anndata |
| 11 | Single Cell Phenotyping | toolshed.g2.bx.psu.edu/repos/goeckslab/scimap_phenotyping/scimap_phenotyping/2.1.0+galaxy2 | Scimap phenotyping |
| 12 | Vitessce | toolshed.g2.bx.psu.edu/repos/goeckslab/vitessce_spatial/vitessce_spatial/3.5.1+galaxy0 | Create a Vitessce dashboard |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | DFP images | output_dfp |
| 3 | FFP images | output_ffp |
| 4 | Registered image | output |
| 5 | Dearray images | tma_sections |
| 5 | Dearray masks | masks |
| 5 | TMA dearray map | TMA_MAP |
| 6 | Nuclear mask | mask |
| 7 | Converted image | output |
| 8 | Primary Mask Quantification | cellmask |
| 9 | Renamed image | renamed_image |
| 10 | Anndata feature table | outfile |
| 11 | Phenotyped feature table | output |
| 12 | Vitessce dashboard | output |
| 12 | Vitessce Dashboard Config | vitessce_config |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run tissue-micro-array-analysis.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run tissue-micro-array-analysis.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run tissue-micro-array-analysis.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init tissue-micro-array-analysis.ga -o job.yml`
- Lint: `planemo workflow_lint tissue-micro-array-analysis.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `tissue-micro-array-analysis.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
