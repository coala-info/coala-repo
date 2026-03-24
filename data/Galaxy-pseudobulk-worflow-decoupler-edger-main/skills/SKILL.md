---
name: differential-gene-expression-for-single-cell-data-using-pseu
description: "This workflow processes annotated AnnData files from single-cell RNA-seq experiments to generate pseudobulk count matrices using decoupler and performs differential gene expression analysis with edgeR and Volcano plot visualization. Use this skill when you need to identify differentially expressed genes between cell populations or experimental conditions while accounting for biological replicates and sample-level variability in single-cell datasets."
homepage: https://workflowhub.eu/workflows/1207
---

# Differential gene expression for single-cell data using pseudo-bulk counts with edgeR

## Overview

This Galaxy workflow performs differential gene expression (DGE) analysis on single-cell RNA-seq data by aggregating cell-level counts into pseudo-bulk samples. It utilizes the [decoupler](https://toolshed.g2.bx.psu.edu/repos/ebi-gxa/decoupler_pseudobulk/decoupler_pseudobulk/1.4.0+galaxy8) tool to transform annotated AnnData (`.h5ad`) files into a count matrix based on user-defined sample keys and grouping columns.

Following aggregation, the workflow executes a series of data sanitation and reformatting steps using text processing tools to ensure compatibility with downstream statistical models. These steps include cleaning factor labels, removing problematic characters, and handling leading digits to prevent errors during the linear modeling phase.

Differential expression is calculated using [edgeR](https://toolshed.g2.bx.psu.edu/repos/iuc/edger/edger/3.36.0+galaxy5), which applies a linear model to the pseudo-bulk counts based on a provided formula and contrast file. The workflow concludes by generating comprehensive outputs, including DGE tables, an HTML summary report, and visualized results via a [Volcano Plot](https://toolshed.g2.bx.psu.edu/repos/iuc/volcanoplot/volcanoplot/0.0.6).

This pipeline is based on the [Persist-SEQ](https://persist-seq.org/) pseudo-bulk scRNA-seq pipeline and is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/). For detailed information on input parameters and file preparation, please refer to the [README.md](README.md) in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Source AnnData file | data_input | Ensure your AnnData object contains all necessary layers before using the decoupler tool. The raw counts should be included in AnnData. If they are missing, create a new layer (e.g., 'raw_counts') and copy the raw counts into it. |
| 1 | Pseudo-bulk: Fields to merge | parameter_input | Merge Obs fields before pseudo-bulk analysis to create new categories for grouping, such as 'sample,phase' or 'sample,louvain'. Ensure the fields exist in the Obs of the AnnData object. Multiple groups can be merged with a colon (':'), e.g., 'sample,phase ,phase' creates 'sample_phase' and 'louvain_phase'. |
| 2 | Group by column | parameter_input | Typically, the column in obs that you want to use for comparisons later (the main contrast field) should be specified here. This column will also be used for plotting the pseudo-bulk samples, showing the number of counts and cells. |
| 3 | Sample key column | parameter_input | The field used to create the pseudo-bulk replicates is typically a combination of multiple Obs fields merged together. |
| 4 | Name Your Raw Counts Layer | parameter_input | Name of the layer containing your raw (non-normalized) counts. |
| 5 | Factor fields | parameter_input | The fields from Obs to be provided to EdgeR as factors. The first field should represent the main contrast for comparisons, while the subsequent fields will be used as covariates. |
| 6 | Formula | parameter_input | Example 1: ~ 0 + Factor_1 (Use this formula when you only want to account for one factor, Factor_1).  Example 2 (With covariate adjustment): ~ 0 + Factor_1 + Factor_2 (Use this formula if you need to adjust for additional factors, such as Factor_2, which serves as a covariate).  Note: Ensure that all factors (e.g., Factor_1, Factor_2) included in the formula are defined in your factor file. |
| 7 | Gene symbol column | parameter_input | Specify the name of the column containing your gene symbols. For example: gene_symbol, gene_name, x, etc. |


Ensure your primary input is a single AnnData (`h5ad`) file containing annotated scRNA-seq data with a defined raw counts layer. You must provide specific column headers for grouping, sample identification, and experimental factors to allow the decoupler tool to correctly aggregate cells into pseudobulk samples. While the workflow handles data sanitation for edgeR compatibility, verify that your formula and factor fields match the metadata exactly as described in the README.md for successful linear modeling. For automated execution and testing, you can initialize the configuration using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the README.md for comprehensive details on parameter formatting and contrast file requirements.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 8 | Decoupler pseudo-bulk | toolshed.g2.bx.psu.edu/repos/ebi-gxa/decoupler_pseudobulk/decoupler_pseudobulk/1.4.0+galaxy8 |  |
| 9 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/9.3+galaxy1 |  |
| 10 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/9.3+galaxy1 |  |
| 11 | Remove columns | toolshed.g2.bx.psu.edu/repos/iuc/column_remove_by_header/column_remove_by_header/1.0 | A column that may affect EdgeR and DESeq2. |
| 12 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/9.3+galaxy1 |  |
| 13 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.3+galaxy1 |  |
| 14 | edgeR | toolshed.g2.bx.psu.edu/repos/iuc/edger/edger/3.36.0+galaxy5 |  |
| 15 | Extract element identifiers | toolshed.g2.bx.psu.edu/repos/iuc/collection_element_identifiers/collection_element_identifiers/0.0.2 |  |
| 16 | Remove columns | toolshed.g2.bx.psu.edu/repos/iuc/column_remove_by_header/column_remove_by_header/1.0 |  |
| 17 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/9.3+galaxy1 |  |
| 18 | Split file | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_to_collection/split_file_to_collection/0.5.2 |  |
| 19 | Parse parameter value | param_value_from_file |  |
| 20 | Volcano Plot | toolshed.g2.bx.psu.edu/repos/iuc/volcanoplot/volcanoplot/0.0.6 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 8 | Pseudobulk count matrix | count_matrix |
| 8 | Pseudobulk Plot | plot_output |
| 8 | Filtered by expression | filter_by_expr_plot |
| 14 | Tables: DEG | outTables |
| 14 | Report Results: HTML File | outReport |
| 16 | Tables for volcano plot | output_tabular |
| 20 | Volcano Plot on input dataset(s): PDF | plot |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run pseudo-bulk_edgeR.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run pseudo-bulk_edgeR.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run pseudo-bulk_edgeR.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init pseudo-bulk_edgeR.ga -o job.yml`
- Lint: `planemo workflow_lint pseudo-bulk_edgeR.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `pseudo-bulk_edgeR.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
