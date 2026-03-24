---
name: multiplex-tissue-microarray-analysis
description: "This workflow processes registered OME-TIFF multiplex tissue images using Mesmer, MCQUANT, Scimap, and Squidpy to perform nuclear segmentation, feature quantification, cell phenotyping, and spatial arrangement analysis. Use this skill when you need to characterize cellular phenotypes and their spatial interactions within complex tissue microenvironments from cyclic immunofluorescence or other high-plex imaging datasets."
homepage: https://workflowhub.eu/workflows/1745
---

# Multiplex Tissue Microarray Analysis

## Overview

This Galaxy workflow provides an end-to-end pipeline for the analysis of registered multiplexed tissue microarray (TMA) images. It automates the transition from raw OME-TIFF images to interactive spatial exploration by performing background subtraction, nuclear segmentation via [Mesmer](https://deepcell.readthedocs.io/en/master/), and feature quantification using [MCQUANT](https://mcmicro.org/). The resulting data is converted into the AnnData format to facilitate seamless integration with single-cell and spatial omics ecosystems.

The downstream analysis focuses on cellular phenotyping and spatial architecture. Using [Scimap](https://scimap-doc.readthedocs.io/en/latest/), the workflow performs hierarchical, GMM-based cell phenotyping and quantifies multi-sample cell type composition. Spatial arrangements and neighborhood interactions are further analyzed using [Squidpy](https://squidpy.readthedocs.io/en/stable/), allowing researchers to characterize the organization of cell types within the tissue microenvironment.

The workflow concludes by generating interactive [Vitessce](https://vitessce.io/) dashboards and spatial scatterplot montages. These outputs link original multiplexed images with single-cell analysis components, enabling integrated data exploration. For detailed configuration of markers and phenotyping gates, refer to the [Galaxy Training Network tutorial](https://training.galaxyproject.org/training-material/topics/imaging/tutorials/multiplex-tissue-imaging-TMA/tutorial.html).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Registered Images | data_collection_input | Collection of registered OME-TIFF images |
| 1 | Markers File | data_input | File specifying marker names and autofluorescence channels to subtract |
| 2 | Manual Gates | data_input | CSV with log1p intensity manual gates per marker. Markers not specified will be GMM auto thresholded |
| 3 | Phenotype workflow | data_input | Scimap phenotype workflow |


To prepare your data for this workflow, ensure your multiplexed images are in OME-TIFF format and organized within a Galaxy data collection. You must provide three CSV files: a markers file for background subtraction, a manual gates file for thresholding, and a phenotype workflow file to map hierarchical cell types. Verify that your image resolution and nuclear segmentation channels match the workflow defaults (0.65 µm/pixel and channel 0, respectively) or adjust the tool parameters accordingly. Refer to the README.md for specific CSV formatting examples and links to detailed phenotyping tutorials. For automated execution, you can initialize a job configuration using `planemo workflow_job_init`.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Extract element identifiers | toolshed.g2.bx.psu.edu/repos/iuc/collection_element_identifiers/collection_element_identifiers/0.0.2 |  |
| 5 | Background subtraction | toolshed.g2.bx.psu.edu/repos/goeckslab/backsub/backsub/0.4.1+galaxy0 |  |
| 6 | Select first | Show beginning1 |  |
| 7 | Perform segmentation of multiplexed tissue data | toolshed.g2.bx.psu.edu/repos/goeckslab/mesmer/mesmer/0.12.3+galaxy3 |  |
| 8 | MCQUANT | toolshed.g2.bx.psu.edu/repos/perssond/quantification/quantification/1.6.0+galaxy0 |  |
| 9 | Convert McMicro Output to Anndata | toolshed.g2.bx.psu.edu/repos/goeckslab/scimap_mcmicro_to_anndata/scimap_mcmicro_to_anndata/2.1.0+galaxy3 |  |
| 10 | Single Cell Phenotyping | toolshed.g2.bx.psu.edu/repos/goeckslab/scimap_phenotyping/scimap_phenotyping/2.1.0+galaxy3 |  |
| 11 | AnnData Operations | toolshed.g2.bx.psu.edu/repos/ebi-gxa/anndata_ops/anndata_ops/1.9.3+galaxy1 |  |
| 12 | Extract dataset | __EXTRACT_DATASET__ |  |
| 13 | Filter collection | __FILTER_FROM_FILE__ |  |
| 14 | Create spatial scatterplot | toolshed.g2.bx.psu.edu/repos/goeckslab/squidpy_scatter/squidpy_scatter/1.5.0+galaxy2 |  |
| 15 | Vitessce | toolshed.g2.bx.psu.edu/repos/goeckslab/vitessce_spatial/vitessce_spatial/3.5.1+galaxy3 |  |
| 16 | Analyze and visualize spatial multi-omics data | toolshed.g2.bx.psu.edu/repos/goeckslab/squidpy_spatial/squidpy_spatial/1.5.0+galaxy2 |  |
| 17 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.9+galaxy2 |  |
| 18 | Image Montage | toolshed.g2.bx.psu.edu/repos/bgruening/graphicsmagick_image_montage/graphicsmagick_image_montage/1.3.46+galaxy0 |  |
| 19 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/9.5+galaxy3 |  |
| 20 | Analyze and visualize spatial multi-omics data | toolshed.g2.bx.psu.edu/repos/goeckslab/squidpy_spatial/squidpy_spatial/1.5.0+galaxy2 |  |
| 21 | Spatial plotting functions | toolshed.g2.bx.psu.edu/repos/goeckslab/scimap_plotting/scimap_plotting/2.1.0+galaxy3 |  |
| 22 | Image Montage | toolshed.g2.bx.psu.edu/repos/bgruening/graphicsmagick_image_montage/graphicsmagick_image_montage/1.3.46+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | Background subtracted images | image_output |
| 5 | Background subtracted markers | marker_output |
| 7 | Segmented Multiplexed Mask | mask |
| 8 | Primary Mask Quantification | cellmask |
| 10 | phenotyped adata | output |
| 14 | Squidpy Spatial Scatterplots | output_plot |
| 15 | Vitessce HTML | output |
| 17 | Merged anndata | anndata |
| 18 | Spatial Scatterplot Montage | output |
| 19 | Vitessce Dashboard | outfile |
| 20 | Interaction Matrix Plot | output_plot |
| 20 | Interaction Matrix Anndata | output |
| 21 | Multisample barplot | output |
| 22 | Spatial Interaction Montage | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run multiplex-tma.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run multiplex-tma.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run multiplex-tma.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init multiplex-tma.ga -o job.yml`
- Lint: `planemo workflow_lint multiplex-tma.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `multiplex-tma.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
