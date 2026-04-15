---
name: music-stage-2-inferring-cellular-proportions
description: This Galaxy workflow utilizes the MuSiC deconvolution tool and Expression Set construction to infer cell type proportions from pseudobulk datasets using a single-cell RNA-seq reference. Use this skill when you need to quantify the cellular composition of heterogeneous tissue samples by leveraging multi-subject single-cell transcriptomic data to account for cross-subject consistency.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# music-stage-2-inferring-cellular-proportions

## Overview

This Galaxy workflow performs the second stage of the MuSiC (Multi-subject Single-cell deconvolution) pipeline, focusing on inferring cellular proportions from pseudobulk datasets. It utilizes a reference scRNA-seq Expression Set (ESet) to estimate cell type compositions across multiple samples, leveraging the [MuSiC Deconvolution](https://toolshed.g2.bx.psu.edu/repos/bgruening/music_deconvolution/music_deconvolution/0.1.1+galaxy4) tool to account for subject-to-subject variation.

The process begins by constructing an Expression Set object from the provided scRNA-seq reference, cell type labels, and sample identifiers. The workflow then executes deconvolution on two distinct pseudobulk collections (A and B). It compares the performance of the MuSiC algorithm against Non-Negative Least Squares (NNLS) methods, generating proportion matrices and diagnostic plots to evaluate the accuracy of the cellular estimates.

Data processing steps include text reformatting, transposing, and advanced cutting/joining operations to align the inferred proportions with actual ground-truth data. The final outputs provide comprehensive results for both MuSiC and NNLS methods across both pseudobulk sets, facilitating a detailed performance evaluation of the deconvolution strategy. This workflow is licensed under the [MIT](https://opensource.org/licenses/MIT) license and is tagged for use with [GTN](https://training.galaxyproject.org/) materials.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Pseudobulk - A | data_collection_input | Genes are rows, with one column of values from the pseudobulk Header with 'name' of sample required |
| 1 | Pseudobulk - B | data_collection_input | Genes are rows, with one column of values from the pseudobulk Header with 'name' of sample required |
| 2 | ESet Reference scRNA-seq | data_collection_input |  |
| 3 | Cell Types Label from scRNA dataset | parameter_input | Example: cellType |
| 4 | Samples Identifer from scRNA dataset | parameter_input | Example: sampleID, Individual |
| 5 | Cell types to use from scRNA dataset | parameter_input | Comma list of cell types to use from scRNA dataset.  Example: acinar,alpha,beta,delta,ductal,gamma |
| 6 | Actuals - B | data_collection_input | Tabular format Row &amp; Column Headers Rows of cell types Column header "A_actual" or similar |
| 7 | Actuals - A | data_collection_input | Tabular format Row &amp; Column Headers Rows of cell types Column header "A_actual" or similar |


Ensure your pseudobulk and reference scRNA-seq data are formatted as tabular files or ExpressionSet objects (RDS) within data collections to facilitate batch processing. Verify that the cell type labels and sample identifiers exactly match the column headers in your reference metadata to avoid errors during the ExpressionSet construction step. For automated testing and reproducible execution, you can initialize your environment using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the `README.md` for comprehensive details on parameter specifications and data pre-processing requirements. This workflow specifically requires paired actual proportion collections if you intend to perform downstream evaluation against the inferred results.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 8 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/9.3+galaxy1 |  |
| 9 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.3+galaxy1 | Extracts the names of the samples/runs and outputs them as columnar values |
| 10 | Construct Expression Set Object | toolshed.g2.bx.psu.edu/repos/bgruening/music_construct_eset/music_construct_eset/0.1.1+galaxy4 |  |
| 11 | MuSiC Deconvolution | toolshed.g2.bx.psu.edu/repos/bgruening/music_deconvolution/music_deconvolution/0.1.1+galaxy4 |  |
| 12 | Transpose | toolshed.g2.bx.psu.edu/repos/iuc/datamash_transpose/datamash_transpose/1.8+galaxy1 |  |
| 13 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/9.3+galaxy2 |  |
| 14 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/9.3+galaxy2 |  |
| 15 | Multi-Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_multijoin_tool/1.1.1 |  |
| 16 | Multi-Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_multijoin_tool/1.1.1 |  |
| 17 | Cut | Cut1 |  |
| 18 | Cut | Cut1 |  |
| 19 | Cut | Cut1 |  |
| 20 | Cut | Cut1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 10 | out_rds | out_rds |
| 11 | out_pdf | out_pdf |
| 11 | MuSiC Deconvolution on input dataset(s): Proportion Matrices | props |
| 17 | B - Music Results | out_file1 |
| 18 | B - NNLS Results | out_file1 |
| 19 | A - Music Results | out_file1 |
| 20 | A - NNLS Results | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run deconv-eval-stage-2-deconv.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run deconv-eval-stage-2-deconv.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run deconv-eval-stage-2-deconv.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init deconv-eval-stage-2-deconv.ga -o job.yml`
- Lint: `planemo workflow_lint deconv-eval-stage-2-deconv.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `deconv-eval-stage-2-deconv.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)