---
name: ebi-scxa-to-anndata-scanpy-or-seurat-object
description: This Galaxy workflow retrieves single-cell RNA-seq data from the EBI Single Cell Expression Atlas using an accession number and converts it into standardized AnnData or Seurat objects using Scanpy and Seurat tools. Use this skill when you need to import publicly available single-cell datasets for downstream filtering, visualization, or comparative transcriptomic analysis in Python or R environments.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# ebi-scxa-to-anndata-scanpy-or-seurat-object

## Overview

This workflow automates the retrieval and preparation of single-cell RNA-seq data from the [EBI Single Cell Expression Atlas (SCXA)](https://www.ebi.ac.uk/gxa/sc/home). By providing a specific experiment accession number, users can fetch expression matrices and metadata directly into Galaxy for standardized processing.

The pipeline utilizes text processing tools such as [Regex Find And Replace](https://toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3) and [Grep](https://toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/9.3+galaxy1) to clean metadata and identify mitochondrial genes. It then converts the retrieved data into interoperable formats using [Scanpy Read10x](https://toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_read_10x/scanpy_read_10x/1.9.3+galaxy0) and [Seurat Read10x](https://toolshed.g2.bx.psu.edu/repos/ebi-gxa/seurat_read10x/seurat_read10x/4.0.4+galaxy0), supporting both Python and R-based analysis environments.

The final outputs include validated AnnData and Seurat objects, as well as a specialized AnnData file with mitochondrial counts calculated via [AnnData Operations](https://toolshed.g2.bx.psu.edu/repos/ebi-gxa/anndata_ops/anndata_ops/1.9.3+galaxy0). This workflow is a key component of [GTN](https://training.galaxyproject.org/) training materials, specifically designed to create the necessary input files for the "Filter, Plot, Explore" single-cell tutorial.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | SC-Atlas experiment accession | parameter_input | EBI Single Cell Atlas accession for the experiment that you want to retrieve. |


Ensure you provide a valid EBI Single Cell Expression Atlas accession ID (e.g., E-MTAB-6945) as the primary parameter to initiate the automated retrieval of MTX and metadata files. The workflow processes these inputs as data collections, seamlessly converting raw matrix files into standardized AnnData or Seurat objects ready for downstream analysis. Consult the README.md for comprehensive details on the regex patterns used for mitochondrial gene identification and metadata cleaning. For high-throughput execution, use planemo workflow_job_init to create a job.yml file configured for your specific experiment accessions.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | EBI SCXA Data Retrieval | toolshed.g2.bx.psu.edu/repos/ebi-gxa/retrieve_scxa/retrieve_scxa/v0.0.2+galaxy2 |  |
| 2 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 | Changes the batch label from "1" to "N01" etc |
| 3 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/9.3+galaxy1 | Shows how mitochondrial genes are annotated. |
| 4 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/9.3+galaxy1 |  |
| 5 | Scanpy Read10x | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_read_10x/scanpy_read_10x/1.9.3+galaxy0 |  |
| 6 | Seurat Read10x | toolshed.g2.bx.psu.edu/repos/ebi-gxa/seurat_read10x/seurat_read10x/4.0.4+galaxy0 |  |
| 7 | AnnData Operations | toolshed.g2.bx.psu.edu/repos/ebi-gxa/anndata_ops/anndata_ops/1.9.3+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | Mito genes check | output |
| 5 | AnnData object | output_h5ad |
| 6 | Seurat object | rds_seurat_file |
| 7 | Mito-counted AnnData for downstream analysis | output_h5ad |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run ebi-scxa-to-anndata--scanpy--or-seurat-object.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run ebi-scxa-to-anndata--scanpy--or-seurat-object.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run ebi-scxa-to-anndata--scanpy--or-seurat-object.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init ebi-scxa-to-anndata--scanpy--or-seurat-object.ga -o job.yml`
- Lint: `planemo workflow_lint ebi-scxa-to-anndata--scanpy--or-seurat-object.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `ebi-scxa-to-anndata--scanpy--or-seurat-object.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)