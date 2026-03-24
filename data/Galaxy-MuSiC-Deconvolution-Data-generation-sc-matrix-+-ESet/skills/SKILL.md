---
name: music-deconvolution-data-generation-sc-matrix-eset
description: "This single-cell transcriptomics workflow retrieves data from the EBI Single Cell Expression Atlas and processes it using Scanpy and MuSiC tools to generate a standardized ExpressionSet object. Use this skill when you need to prepare single-cell RNA-seq reference datasets for MuSiC deconvolution by converting raw counts and metadata into a compatible format for downstream tissue composition analysis."
homepage: https://workflowhub.eu/workflows/1548
---

# MuSiC-Deconvolution: Data generation | sc | matrix + ESet

## Overview

This Galaxy workflow automates the generation of an ExpressionSet (ESet) object from single-cell RNA-seq data, specifically designed for use in [MuSiC deconvolution](https://github.com/xuranw/MuSiC) pipelines. It begins by retrieving single-cell datasets from the [EBI SCXA](https://www.ebi.ac.uk/gxa/sc/home) and processing them through Scanpy to handle 10x Genomics formats.

The pipeline performs essential data transformation and annotation tasks, including transposing matrices and mapping Ensembl IDs to Gene Symbols via `annotateMyIDs`. A specialized subworkflow handles the conversion and summation of duplicate gene entries to ensure data integrity.

The final stages utilize MuSiC-specific tools to construct and manipulate the ESet object. This results in a standardized RData object containing the expression matrix and associated metadata, ready for downstream cell-type proportion estimation. This workflow is tagged for [single-cell transcriptomics](https://training.galaxyproject.org/training-material/topics/single-cell/) and follows [GTN](https://training.galaxyproject.org/) training standards.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 1 | Single cell metadata | data_input | This should be output from the MuSiC Deconvolution \| Data generation \| sc \| metadata workflow |


Ensure the single-cell metadata is provided as a TSV file with columns that align with the matrix, gene, and barcode files retrieved from EBI SCXA to successfully construct the ExpressionSet (ESet) object. While the workflow processes individual datasets, you may find it efficient to organize your raw count components into a dataset collection for batch processing during the initial Scanpy and Transpose steps. Refer to the `README.md` for specific details on required metadata formatting and Ensembl-to-GeneSymbol mapping requirements. You can use `planemo workflow_job_init` to generate a `job.yml` file for streamlined job configuration and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | EBI SCXA Data Retrieval | toolshed.g2.bx.psu.edu/repos/ebi-gxa/retrieve_scxa/retrieve_scxa/v0.0.2+galaxy2 |  |
| 2 | Scanpy Read10x | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_read_10x/scanpy_read_10x/1.8.1+galaxy0 |  |
| 3 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.7.5+galaxy1 |  |
| 4 | Transpose | toolshed.g2.bx.psu.edu/repos/iuc/datamash_transpose/datamash_transpose/1.1.0+galaxy2 |  |
| 5 | annotateMyIDs | toolshed.g2.bx.psu.edu/repos/iuc/annotatemyids/annotatemyids/3.14.0+galaxy1 |  |
| 6 | 1st step removed - Convert from Ensembl to GeneSymbol, summing duplicate genes | (subworkflow) |  |
| 7 | Construct Expression Set Object | toolshed.g2.bx.psu.edu/repos/bgruening/music_construct_eset/music_construct_eset/0.1.1+galaxy4 |  |
| 8 | Manipulate Expression Set Object | toolshed.g2.bx.psu.edu/repos/bgruening/music_manipulate_eset/music_manipulate_eset/0.1.1+galaxy4 |  |
| 9 | Manipulate Expression Set Object | toolshed.g2.bx.psu.edu/repos/bgruening/music_manipulate_eset/music_manipulate_eset/0.1.1+galaxy4 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | barcode_tsv | barcode_tsv |
| 0 | design_tsv | design_tsv |
| 0 | genes_tsv | genes_tsv |
| 0 | matrix_mtx | matrix_mtx |
| 2 | Scanpy Read10x on input dataset(s): anndata | output_h5 |
| 3 | X | X |
| 4 | out_file | out_file |
| 5 | annotateMyIDs on input dataset(s): Annotated IDs | out_tab |
| 7 | Construct Expression Set Object on input dataset(s): RData ESet Object | out_rds |
| 7 | Construct Expression Set Object on input dataset(s): General Info | out_txt |
| 8 | Manipulate Expression Set Object on input dataset(s): ExpressionSet Object | out_eset |
| 9 | out_eset | out_eset |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run sc-matrix.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run sc-matrix.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run sc-matrix.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init sc-matrix.ga -o job.yml`
- Lint: `planemo workflow_lint sc-matrix.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `sc-matrix.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
