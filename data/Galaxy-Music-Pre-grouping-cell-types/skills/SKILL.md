---
name: music-pre-grouping-cell-types
description: "This transcriptomics workflow utilizes MuSiC tools to process single-cell and bulk RNA-seq datasets alongside specific marker genes for hierarchical cell type estimation. Use this skill when you need to accurately estimate cell type proportions in bulk samples by grouping closely related cell populations to overcome high collinearity in gene expression profiles."
homepage: https://workflowhub.eu/workflows/1553
---

# Music: Pre-grouping cell types

## Overview

This workflow implements the "Estimation of cell type proportions with pre-grouping of cell types" section from the [Bulk RNA Deconvolution with MuSiC](https://training.galaxyproject.org/training-material/topics/transcriptomics/tutorials/bulk-music/tutorial.html) tutorial. It is designed for transcriptomics research, specifically for estimating the cellular composition of bulk RNA-seq samples using single-cell RNA-seq (scRNA) reference data.

The process begins by converting scRNA and bulk RNA assay and phenotype data into Expression Set Objects. By incorporating specific marker files for epithelial and immune cells, the workflow utilizes a pre-grouping strategy. This approach enhances deconvolution accuracy by grouping closely related cell types before calculating their individual proportions within the bulk samples.

The workflow utilizes the [MuSiC Deconvolution](https://toolshed.g2.bx.psu.edu/repos/bgruening/music_deconvolution/) tool to perform the analysis, generating both tabular data and visual PDF reports. These outputs provide a detailed breakdown of cell type estimations, facilitating a deeper understanding of the biological heterogeneity present in the bulk transcriptomic data.

This resource is tagged for use in **Transcriptomics** and **Single-cell** analysis and is licensed under the [MIT License](https://opensource.org/licenses/MIT).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | scRNA Assay Tabular | data_input |  |
| 1 | scRNA Phenotype Tabular | data_input |  |
| 2 | Bulk RNA Assay Tabular | data_input |  |
| 3 | Bulk RNA Phenotype Tabular | data_input |  |
| 4 | epith.markers | data_input |  |
| 5 | immune.markers | data_input |  |


Ensure all input files are uploaded in tabular format, paying close attention to the matrix structure of the scRNA and bulk RNA expression assays. While these inputs are processed as individual datasets, verify that the marker lists are formatted as single-column files to ensure successful Expression Set construction. Refer to the `README.md` for specific column naming requirements and comprehensive data preparation instructions. For automated execution, you can generate a `job.yml` file using `planemo workflow_job_init`.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 6 | Construct Expression Set Object | toolshed.g2.bx.psu.edu/repos/bgruening/music_construct_eset/music_construct_eset/0.1.1+galaxy4 |  |
| 7 | Construct Expression Set Object | toolshed.g2.bx.psu.edu/repos/bgruening/music_construct_eset/music_construct_eset/0.1.1+galaxy4 |  |
| 8 | MuSiC Deconvolution | toolshed.g2.bx.psu.edu/repos/bgruening/music_deconvolution/music_deconvolution/0.1.1+galaxy4 |  |
| 9 | MuSiC Deconvolution | toolshed.g2.bx.psu.edu/repos/bgruening/music_deconvolution/music_deconvolution/0.1.1+galaxy4 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 8 | out_pdf | out_pdf |
| 9 | out_tab | out_tab |
| 9 | out_pdf | out_pdf |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run music-pre-grouping-cell-types.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run music-pre-grouping-cell-types.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run music-pre-grouping-cell-types.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init music-pre-grouping-cell-types.ga -o job.yml`
- Lint: `planemo workflow_lint music-pre-grouping-cell-types.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `music-pre-grouping-cell-types.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
