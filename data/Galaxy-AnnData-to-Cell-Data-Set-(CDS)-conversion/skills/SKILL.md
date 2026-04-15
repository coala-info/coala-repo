---
name: anndata-to-cell-data-set-cds-conversion
description: This Galaxy workflow converts single-cell transcriptomics data from the AnnData format into a Monocle3 Cell Data Set (CDS) using AnnData inspection and Monocle3 creation tools. Use this skill when you need to perform trajectory inference or pseudotime analysis in Monocle3 using data previously processed in Scanpy or other AnnData-compatible pipelines.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# anndata-to-cell-data-set-cds-conversion

## Overview

This workflow facilitates the conversion of single-cell data from the [AnnData](https://anndata.readthedocs.io/) format to the Cell Data Set (CDS) format required by [Monocle3](https://cole-trapnell-lab.github.io/monocle3/). It is designed for users working within the [Galaxy](https://usegalaxy.org/) ecosystem who need to transition between these common bioinformatics data structures for downstream trajectory or manifold analysis.

The process begins by extracting the primary components of the input AnnData object—specifically the observations (`obs`), variables (`var`), and the expression matrix (`X`)—using the AnnData Inspect tool. Following a transposition step to ensure the data matrix is correctly oriented for the target format, the [Monocle3 create](https://toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_create/) tool assembles these components into a unified CDS file.

Note that this workflow performs a direct conversion and does not include steps for renaming metadata columns, such as those containing gene symbols. This resource is tagged for [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) use and is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | AnnData | data_input | Input file in AnnData format |


Ensure your input is a valid AnnData file in `.h5ad` format, containing the necessary observation and variable metadata required for the Monocle3 object creation. While the workflow is designed for individual datasets, you can utilize dataset collections to process multiple AnnData files in parallel. Refer to the `README.md` for comprehensive details on preparing your data, especially regarding the specific column requirements for gene symbols. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.7.5+galaxy1 |  |
| 2 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.7.5+galaxy1 |  |
| 3 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.7.5+galaxy1 |  |
| 4 | Transpose | toolshed.g2.bx.psu.edu/repos/iuc/datamash_transpose/datamash_transpose/1.8+galaxy1 |  |
| 5 | Monocle3 create | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_create/monocle3_create/0.1.4+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | Inspect AnnData: obs | obs |
| 2 | Inspect AnnData: var | var |
| 3 | Inspect AnnData: X | X |
| 5 | CDS Monocle file | output_rds |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run anndata-to-cell-data-set--cds--conversion.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run anndata-to-cell-data-set--cds--conversion.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run anndata-to-cell-data-set--cds--conversion.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init anndata-to-cell-data-set--cds--conversion.ga -o job.yml`
- Lint: `planemo workflow_lint anndata-to-cell-data-set--cds--conversion.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `anndata-to-cell-data-set--cds--conversion.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)