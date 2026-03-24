---
name: anndata-object-to-monocle-input-files
description: "This transcriptomics workflow processes AnnData objects to extract and filter gene annotations, cell annotations, and expression matrices using AnnData inspection and text processing tools. Use this skill when you need to prepare single-cell RNA sequencing datasets for trajectory analysis in Monocle by cleaning expression matrices and standardizing metadata."
homepage: https://workflowhub.eu/workflows/1520
---

# AnnData object to Monocle input files

## Overview

This Galaxy workflow automates the conversion of single-cell datasets from the AnnData format into the specific input files required for [Monocle](https://cole-trapnell-lab.github.io/monocle3/) trajectory analysis. It processes two versions of an AnnData object—one containing processed annotations and another containing the raw expression matrix—to ensure that the resulting files are clean, filtered, and correctly formatted.

The pipeline performs several data manipulation steps, including extracting cell (`obs`) and gene (`var`) annotations, filtering out specific cell types (such as macrophages), and ensuring gene tables include the required `gene_short_name` column. It utilizes tools like `anndata_inspect`, `regex_find_replace`, and `datamash_transpose` to align the expression matrix with the filtered cell and gene lists.

The final outputs consist of a filtered expression matrix and corresponding annotation files, ready for seamless import into Monocle. This workflow is particularly useful for [transcriptomics](https://training.galaxyproject.org/training-material/topics/transcriptomics/) and [scRNA-seq](https://training.galaxyproject.org/training-material/topics/single-cell/) researchers following [GTN](https://training.galaxyproject.org/) protocols for trajectory analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | AnnData to extract genes & cells annotations | data_input |  |
| 1 | AnnData before processing to extract clean expression matrix | data_input |  |


Ensure your input AnnData files are in H5AD format, providing both a processed version for metadata extraction and a raw version to ensure the expression matrix remains unnormalized for Monocle. Verify that cell and gene identifiers match across both datasets to prevent errors during the join and filtering steps. For large-scale runs, you can automate the setup using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the README.md for specific column naming requirements and detailed filtering parameters.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.7.5+galaxy1 |  |
| 3 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.7.5+galaxy1 |  |
| 4 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.7.5+galaxy1 | Unprocessed means here before normalisation or dimensionality reduction. For this step, must have cell IDs as rownames. |
| 5 | Filter | Filter1 | Double-check the cell_type column number |
| 6 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.2 | Check the number of the column with genes names (using column) and its header (Find Regex) |
| 7 | Cut | Cut1 |  |
| 8 | Cut | Cut1 |  |
| 9 | Join two Datasets | join1 |  |
| 10 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/1.1.0 |  |
| 11 | Transpose | toolshed.g2.bx.psu.edu/repos/iuc/datamash_transpose/datamash_transpose/1.1.0+galaxy2 |  |
| 12 | Join two Datasets | join1 |  |
| 13 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/1.1.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | Extracted cell annotations (obs) | obs |
| 3 | Extracted gene annotations (var) | var |
| 4 | Unprocessed expression matrix | X |
| 5 | Cells without macrophages | out_file1 |
| 6 | Genes table with gene_short_name colname | out_file1 |
| 7 | Filtered cells IDs  | out_file1 |
| 8 | Genes IDs | out_file1 |
| 9 | Pre-filtered matrix (by cells) | out_file1 |
| 10 | Filtered matrix (by cells)  | output |
| 11 | filtered matrix (by cells) transposed | out_file |
| 12 | Pre-filtered matrix (by cells & genes) | out_file1 |
| 13 | Filtered matrix (by cells & genes) | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-anndata-object-to-monocle-input-files.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-anndata-object-to-monocle-input-files.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-anndata-object-to-monocle-input-files.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-anndata-object-to-monocle-input-files.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-anndata-object-to-monocle-input-files.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-anndata-object-to-monocle-input-files.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
