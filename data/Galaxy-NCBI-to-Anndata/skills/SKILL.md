---
name: ncbi-to-anndata
description: This single-cell RNA-seq workflow converts multiple NCBI GEO digital gene expression text files into a unified AnnData object using AnnData import, manipulation, and Scanpy filtering tools. Use this skill when you need to aggregate raw public transcriptomics data from NCBI into a standardized h5ad format for downstream single-cell analysis and visualization.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# ncbi-to-anndata

## Overview

This Galaxy workflow automates the conversion of raw single-cell digital gene expression (DGE) data from NCBI's Gene Expression Omnibus (GEO) into the standardized AnnData format. It is designed for [single-cell](https://galaxyproject.org/use/single-cell/) data management, taking multiple GSM-coded text files as input and processing them through a series of import and manipulation steps.

The pipeline utilizes [AnnData Import](https://toolshed.g2.bx.psu.edu/repos/iuc/anndata_import) to initialize data objects, followed by extensive text processing using tools like [Replace Text](https://toolshed.g2.bx.psu.edu/repos/bgruening/text_processing) and [Scanpy FilterCells](https://toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_filter_cells). These steps allow for cleaning metadata, filtering out low-quality cells, and concatenating multiple samples into a unified dataset.

The final outputs include a consolidated `.h5ad` file and its associated observation metadata (`obs`), making the data ready for downstream analysis in the [Scanpy](https://scanpy.readthedocs.io/) ecosystem. This workflow is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) and is a valuable resource for researchers integrating public NCBI datasets into their single-cell pipelines.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | GSM5353219_PA_PB1B_Pool_2_S24_L001_dge.txt | data_input |  |
| 1 | GSM5353223_PA_PB2B_Pool_2_S26_L001_dge.txt | data_input |  |
| 2 | GSM5353218_PA_PB1B_Pool_1_2_S74_L003_dge.txt | data_input |  |
| 3 | GSM5353216_PA_PB1A_Pool_1_3_S50_L002_dge.txt | data_input |  |
| 4 | GSM5353221_PA_PB2A_Pool_1_3_S25_L001_dge.txt | data_input |  |
| 5 | GSM5353215_PA_AUG_PB_1B_S2_dge.txt | data_input |  |
| 6 | GSM5353222_PA_PB2B_Pool_1_3_S52_L002_dge.txt | data_input |  |
| 7 | GSM5353220_PA_PB1B_Pool_3_S51_L002_dge.txt | data_input |  |
| 8 | GSM5353217_PA_PB1A_Pool_2_S107_L004_dge.txt | data_input |  |
| 9 | GSM5353214_PA_AUG_PB_1A_S1_dge.txt | data_input |  |


Ensure the input Digital Gene Expression (DGE) files are uploaded as tabular text datasets, as these serve as the primary count matrices for conversion. While the workflow is configured for individual datasets, users may find it more efficient to group these into a dataset collection for streamlined management within the Galaxy history. Refer to the README.md for comprehensive details on the specific text manipulation steps and filtering thresholds applied during the AnnData object construction. For automated execution and reproducibility, you can use `planemo workflow_job_init` to generate a `job.yml` file containing the necessary input parameters.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 10 | Import Anndata | toolshed.g2.bx.psu.edu/repos/iuc/anndata_import/anndata_import/0.10.9+galaxy0 |  |
| 11 | Import Anndata | toolshed.g2.bx.psu.edu/repos/iuc/anndata_import/anndata_import/0.10.9+galaxy0 |  |
| 12 | Import Anndata | toolshed.g2.bx.psu.edu/repos/iuc/anndata_import/anndata_import/0.10.9+galaxy0 |  |
| 13 | Import Anndata | toolshed.g2.bx.psu.edu/repos/iuc/anndata_import/anndata_import/0.10.9+galaxy0 |  |
| 14 | Import Anndata | toolshed.g2.bx.psu.edu/repos/iuc/anndata_import/anndata_import/0.10.9+galaxy0 |  |
| 15 | Import Anndata | toolshed.g2.bx.psu.edu/repos/iuc/anndata_import/anndata_import/0.10.9+galaxy0 |  |
| 16 | Import Anndata | toolshed.g2.bx.psu.edu/repos/iuc/anndata_import/anndata_import/0.10.9+galaxy0 |  |
| 17 | Import Anndata | toolshed.g2.bx.psu.edu/repos/iuc/anndata_import/anndata_import/0.10.9+galaxy0 |  |
| 18 | Import Anndata | toolshed.g2.bx.psu.edu/repos/iuc/anndata_import/anndata_import/0.10.9+galaxy0 |  |
| 19 | Import Anndata | toolshed.g2.bx.psu.edu/repos/iuc/anndata_import/anndata_import/0.10.9+galaxy0 |  |
| 20 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.9+galaxy0 |  |
| 21 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.9+galaxy0 |  |
| 22 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.9+galaxy0 |  |
| 23 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.9+galaxy0 |  |
| 24 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.9+galaxy0 |  |
| 25 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.9+galaxy0 |  |
| 26 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.9+galaxy0 |  |
| 27 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.9+galaxy0 |  |
| 28 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.9+galaxy0 |  |
| 29 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.9+galaxy0 |  |
| 30 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.9+galaxy0 |  |
| 31 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.9+galaxy0 |  |
| 32 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/9.3+galaxy1 |  |
| 33 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/9.3+galaxy1 |  |
| 34 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/9.3+galaxy1 |  |
| 35 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/9.3+galaxy1 |  |
| 36 | Cut | Cut1 |  |
| 37 | Cut | Cut1 |  |
| 38 | Cut | Cut1 |  |
| 39 | Cut | Cut1 |  |
| 40 | Paste | Paste1 |  |
| 41 | Paste | Paste1 |  |
| 42 | Paste | Paste1 |  |
| 43 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.9+galaxy0 |  |
| 44 | Scanpy FilterCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_filter_cells/scanpy_filter_cells/1.9.3+galaxy0 |  |
| 45 | AnnData Operations | toolshed.g2.bx.psu.edu/repos/ebi-gxa/anndata_ops/anndata_ops/1.9.3+galaxy0 |  |
| 46 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.9+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 45 | output_h5ad | output_h5ad |
| 46 | obs | obs |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run ncbi-to-anndata.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run ncbi-to-anndata.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run ncbi-to-anndata.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init ncbi-to-anndata.ga -o job.yml`
- Lint: `planemo workflow_lint ncbi-to-anndata.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `ncbi-to-anndata.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)