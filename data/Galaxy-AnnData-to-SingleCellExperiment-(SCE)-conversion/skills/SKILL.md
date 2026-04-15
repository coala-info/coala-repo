---
name: anndata-to-singlecellexperiment-sce-conversion
description: This Galaxy workflow converts single-cell transcriptomics data from AnnData format to a SingleCellExperiment object using AnnData Inspect and DropletUtils. Use this skill when you need to migrate single-cell datasets from Python-based Scanpy environments to R-based Bioconductor pipelines for specialized downstream statistical analysis.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# anndata-to-singlecellexperiment-sce-conversion

## Overview

This workflow facilitates the conversion of single-cell data from the AnnData format (commonly used in Python/Scanpy) to the SingleCellExperiment (SCE) format (standard in R/Bioconductor). It is designed for users working within the [Galaxy](https://usegalaxy.org/) ecosystem who need to bridge these two major single-cell analysis frameworks for downstream analysis.

The process begins by extracting the observation metadata (`obs`) and the expression matrix (`X`) from the input AnnData object using the [AnnData Inspect](https://toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/) tool. The data is then transformed via [Datamash Transpose](https://toolshed.g2.bx.psu.edu/repos/iuc/datamash_transpose/) to ensure the matrix orientation is compatible with R-based tools.

The workflow concludes by utilizing [DropletUtils](https://toolshed.g2.bx.psu.edu/repos/iuc/dropletutils/) to reformat the extracted components into a structure that can be read as a final SCE object. This automated pipeline, tagged under [GTN](https://training.galaxyproject.org/), ensures that cell identifiers and expression values are preserved correctly during the transition between environments.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | AnnData | data_input | Input file in AnnData format |
| 1 | Cell ID column | parameter_input | Values must match those provided in the expression matrix. |


Ensure your primary input is a valid AnnData file in `.h5ad` format and that you have identified the exact column name containing unique cell identifiers within the observation metadata. While the workflow is configured for individual datasets, you may utilize dataset collections to efficiently process multiple samples in parallel. Please consult the `README.md` for exhaustive documentation on metadata handling and specific tool configurations. You can also use `planemo workflow_job_init` to create a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.3+galaxy0 |  |
| 3 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.3+galaxy0 |  |
| 4 | Transpose | toolshed.g2.bx.psu.edu/repos/iuc/datamash_transpose/datamash_transpose/1.8+galaxy1 |  |
| 5 | DropletUtils | toolshed.g2.bx.psu.edu/repos/iuc/dropletutils/dropletutils/1.10.0+galaxy2 |  |
| 6 | DropletUtils Read10x | toolshed.g2.bx.psu.edu/repos/ebi-gxa/dropletutils_read_10x/dropletutils_read_10x/1.0.4+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | Inspect AnnData: obs | obs |
| 3 | Inspect AnnData: X | X |
| 6 | Converted SCE object | output_rds |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run anndata-to-singlecellexperiment--sce--conversion.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run anndata-to-singlecellexperiment--sce--conversion.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run anndata-to-singlecellexperiment--sce--conversion.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init anndata-to-singlecellexperiment--sce--conversion.ga -o job.yml`
- Lint: `planemo workflow_lint anndata-to-singlecellexperiment--sce--conversion.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `anndata-to-singlecellexperiment--sce--conversion.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)