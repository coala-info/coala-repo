---
name: music-deconvolution
description: "This transcriptomics workflow utilizes the MuSiC tool suite to perform bulk RNA-seq deconvolution by integrating single-cell and bulk RNA assay and phenotype data. Use this skill when you need to estimate the relative proportions of different cell types within heterogeneous bulk RNA-seq samples using a multi-subject single-cell reference."
homepage: https://workflowhub.eu/workflows/1557
---

# MuSiC: Deconvolution

## Overview

This workflow implements the first half of the [Bulk RNA Deconvolution with MuSiC](https://training.galaxyproject.org/training-material/topics/transcriptomics/tutorials/bulk-music/tutorial.html) tutorial from the Galaxy Training Network (GTN). It is designed to estimate cell type proportions in bulk RNA-seq samples by leveraging multi-subject single-cell RNA-seq data as a reference.

The pipeline processes four primary inputs: assay and phenotype tabular files for both single-cell and bulk datasets, along with a specified list of cell types. It utilizes the `music_construct_eset` tool to transform these inputs into Expression Set objects, which are then validated through multiple inspection steps to ensure data integrity before analysis.

The core of the workflow is the MuSiC Deconvolution tool, which applies the MuSiC algorithm to calculate cell type compositions. The final outputs include tabular summaries of the expression sets and a PDF report visualizing the deconvolution results. This MIT-licensed workflow is a key resource for transcriptomics researchers performing integrated single-cell and bulk RNA analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | scRNA Assay Tabular | data_input |  |
| 1 | scRNA Phenotype Tabular | data_input |  |
| 2 | Bulk RNA Assay Tabular | data_input |  |
| 3 | Bulk RNA Phenotype Tabular | data_input |  |
| 4 | Cell Types List | parameter_input |  |


Ensure all input files are provided in tabular format, with assay files containing count matrices and phenotype files containing corresponding metadata. It is critical that the sample identifiers match exactly between the assay and phenotype datasets to allow for successful Expression Set construction. For comprehensive details on column headers and data structure, please consult the README.md. You may also use `planemo workflow_job_init` to create a `job.yml` for streamlined job configuration.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | Construct Expression Set Object | toolshed.g2.bx.psu.edu/repos/bgruening/music_construct_eset/music_construct_eset/0.1.1+galaxy4 |  |
| 6 | Construct Expression Set Object | toolshed.g2.bx.psu.edu/repos/bgruening/music_construct_eset/music_construct_eset/0.1.1+galaxy4 |  |
| 7 | Inspect Expression Set Object | toolshed.g2.bx.psu.edu/repos/bgruening/music_inspect_eset/music_inspect_eset/0.1.1+galaxy4 |  |
| 8 | Inspect Expression Set Object | toolshed.g2.bx.psu.edu/repos/bgruening/music_inspect_eset/music_inspect_eset/0.1.1+galaxy4 |  |
| 9 | Inspect Expression Set Object | toolshed.g2.bx.psu.edu/repos/bgruening/music_inspect_eset/music_inspect_eset/0.1.1+galaxy4 |  |
| 10 | MuSiC Deconvolution | toolshed.g2.bx.psu.edu/repos/bgruening/music_deconvolution/music_deconvolution/0.1.1+galaxy4 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 7 | out_tab | out_tab |
| 9 | out_tab | out_tab |
| 10 | out_pdf | out_pdf |


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
