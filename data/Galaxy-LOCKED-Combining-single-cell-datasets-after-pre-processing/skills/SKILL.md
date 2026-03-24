---
name: locked-combining-single-cell-datasets-after-pre-processing
description: "This single-cell RNA-seq workflow integrates seven pre-processed sample datasets into a unified AnnData object using AnnData manipulation and inspection tools. Use this skill when you need to merge multiple individual scRNA-seq samples into a single batched dataset for downstream comparative analysis and cell-type identification across different experimental conditions."
homepage: https://workflowhub.eu/workflows/1543
---

# LOCKED | Combining single cell datasets after pre-processing

## Overview

This workflow is designed to merge multiple single-cell RNA-seq datasets into a single unified object for downstream analysis. It is specifically associated with the [GTN training tutorial](https://training.galaxyproject.org/training-material/topics/single-cell/tutorials/scrna-case_alevin-combine-datasets/tutorial.html) on combining datasets after initial pre-processing steps like quantification and filtering.

The pipeline processes up to seven individual sample inputs in AnnData format. It utilizes `anndata_manipulate` and `anndata_inspect` tools to concatenate the datasets while managing metadata. Integrated text processing tools, including `Replace Text`, `Cut`, and `Paste`, are used to clean and align cell-level metadata—such as sex and genotype information—ensuring consistency across the merged collection.

The final output is a consolidated "Batched Object" containing the integrated expression matrix and harmonized metadata. This unified format is essential for performing comparative analyses, batch correction, and cluster identification across different experimental conditions or biological replicates.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Sample 1 | data_input | The training uses 7 different AnnData objects. This is 1 of them. The order does matter. |
| 1 | Sample 2 | data_input | The training uses 7 different AnnData objects. This is 1 of them. The order does matter. |
| 2 | Sample 3 | data_input | The training uses 7 different AnnData objects. This is 1 of them. The order does matter. |
| 3 | Sample 4 | data_input | The training uses 7 different AnnData objects. This is 1 of them. The order does matter. |
| 4 | Sample 5 | data_input | The training uses 7 different AnnData objects. This is 1 of them. The order does matter. |
| 5 | Sample 6 | data_input | The training uses 7 different AnnData objects. This is 1 of them. The order does matter. |
| 6 | Sample 7 | data_input | The training uses 7 different AnnData objects. This is 1 of them. The order does matter. |


Ensure all input samples are provided in `h5ad` format to maintain compatibility with the AnnData manipulation tools used in this workflow. While the workflow is structured for seven individual datasets, organizing your data into a dataset collection can streamline history management and batch processing. Refer to the `README.md` for comprehensive details on preparing the necessary metadata and specific column requirements for the text processing steps. For those automating the process, `planemo workflow_job_init` can be used to generate a `job.yml` file for defining these inputs.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 7 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.9+galaxy1 |  |
| 8 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.9+galaxy1 |  |
| 9 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.9+galaxy1 |  |
| 10 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.9+galaxy1 |  |
| 11 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/9.5+galaxy0 |  |
| 12 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/9.5+galaxy0 |  |
| 13 | Cut | Cut1 |  |
| 14 | Cut | Cut1 |  |
| 15 | Paste | Paste1 |  |
| 16 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.9+galaxy1 |  |
| 17 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.9+galaxy1 |  |
| 18 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.9+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 7 | Combined_Object | anndata |
| 8 | var | var |
| 9 | general | general |
| 10 | obs | obs |
| 11 | outfile | outfile |
| 12 | outfile-genotype | outfile |
| 13 | Sex_Metadata | out_file1 |
| 14 | Genotype_metadata | out_file1 |
| 15 | Cell_Metadata | out_file1 |
| 16 | anndata | anndata |
| 17 | Batched_Object | anndata |
| 18 | obs-final | obs |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run combining-single-cell-datasets-after-pre-processing.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run combining-single-cell-datasets-after-pre-processing.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run combining-single-cell-datasets-after-pre-processing.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init combining-single-cell-datasets-after-pre-processing.ga -o job.yml`
- Lint: `planemo workflow_lint combining-single-cell-datasets-after-pre-processing.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `combining-single-cell-datasets-after-pre-processing.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
