---
name: gtn_exemplar_002_tma_workflow_feb2025
description: "This workflow processes raw multiplexed cycle images and marker metadata through a pipeline involving BaSiC illumination correction, ASHLAR registration, UNetCoreograph dearraying, and Mesmer segmentation. Use this skill when you need to perform comprehensive single-cell phenotyping and spatial quantification on tissue microarray samples to characterize cellular composition and distribution across large tissue cohorts."
homepage: https://workflowhub.eu/workflows/1514
---

# GTN_Exemplar_002_TMA_workflow_Feb2025

## Overview

This workflow provides an end-to-end solution for Tissue Microarray (TMA) analysis using the Galaxy-ME ecosystem. It automates the processing of raw multiplexed cycle images, beginning with illumination correction via [BaSiC](https://toolshed.g2.bx.psu.edu/repos/perssond/basic_illumination/basic_illumination/1.1.1+galaxy2) and image registration using [ASHLAR](https://toolshed.g2.bx.psu.edu/repos/perssond/ashlar/ashlar/1.18.0+galaxy1). The pipeline then utilizes [UNetCoreograph](https://toolshed.g2.bx.psu.edu/repos/perssond/coreograph/unet_coreograph/2.2.8+galaxy1) to dearray the TMA into individual tissue cores for downstream analysis.

Following dearraying, the workflow performs nuclear segmentation with [Mesmer](https://toolshed.g2.bx.psu.edu/repos/goeckslab/mesmer/mesmer/0.12.3+galaxy3) and single-cell intensity quantification through [MCQUANT](https://toolshed.g2.bx.psu.edu/repos/perssond/quantification/quantification/1.6.0+galaxy0). The resulting data is converted into the Anndata format to facilitate single-cell phenotyping, allowing for the identification of specific cell populations based on marker expression.

The final outputs include phenotyped feature tables and a [Vitessce](https://toolshed.g2.bx.psu.edu/repos/goeckslab/vitessce_spatial/vitessce_spatial/3.5.1+galaxy0) dashboard for interactive spatial visualization of the multiplexed data. This workflow is licensed under the MIT license and is tagged for Imaging and GTN (Galaxy Training Network) applications.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | markers.csv | data_input | CSV file containing marker names |
| 1 | PhenotypeWorkflow | data_input | Scimap formatted phenotype workflow |
| 2 | Raw cycle images | data_collection_input | Raw TIFF images (CZI, TIFF) in an round-ordered list |


Ensure your input images are organized into a data collection to facilitate batch processing through the illumination correction and registration steps. Use CSV files for markers and phenotype definitions, ensuring column headers match the expected tool specifications for MCQUANT and Scimap. For large-scale tissue microarray analysis, verify that your OME-TIFF files contain the necessary metadata for accurate dearraying and segmentation. Refer to the README.md for comprehensive parameter configurations and data preparation specifics. You can also use `planemo workflow_job_init` to generate a `job.yml` for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | BaSiC Illumination | toolshed.g2.bx.psu.edu/repos/perssond/basic_illumination/basic_illumination/1.1.1+galaxy2 | Illumination correction |
| 4 | ASHLAR | toolshed.g2.bx.psu.edu/repos/perssond/ashlar/ashlar/1.18.0+galaxy1 | Stitching and registration |
| 5 | UNetCoreograph | toolshed.g2.bx.psu.edu/repos/perssond/coreograph/unet_coreograph/2.2.8+galaxy1 | TMA dearray |
| 6 | Perform segmentation of multiplexed tissue data | toolshed.g2.bx.psu.edu/repos/goeckslab/mesmer/mesmer/0.12.3+galaxy3 | Nuclear segmentation |
| 7 | Convert image | toolshed.g2.bx.psu.edu/repos/imgteam/bfconvert/ip_convertimage/6.7.0+galaxy0 | Convert to OME-TIFF |
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
| 5 | TMA dearray map | TMA_MAP |
| 5 | Dearray masks | masks |
| 6 | Nuclear mask | mask |
| 7 | Converted image | output |
| 8 | Primary Mask Quantification | cellmask |
| 9 | Renamed image | renamed_image |
| 10 | Anndata feature table | outfile |
| 11 | Phenotyped feature table | output |
| 12 | Vitessce dashboard | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run gtn-exemplar-002-tma-workflow-feb2025.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run gtn-exemplar-002-tma-workflow-feb2025.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run gtn-exemplar-002-tma-workflow-feb2025.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init gtn-exemplar-002-tma-workflow-feb2025.ga -o job.yml`
- Lint: `planemo workflow_lint gtn-exemplar-002-tma-workflow-feb2025.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `gtn-exemplar-002-tma-workflow-feb2025.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
