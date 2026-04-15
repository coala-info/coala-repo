---
name: pseudobulk-with-decoupler-and-edger-tutorial-workflow
description: This Galaxy workflow processes single-cell AnnData files to perform pseudobulk differential expression analysis using Decoupler for sample aggregation and edgeR for statistical testing. Use this skill when you need to identify differentially expressed genes between experimental conditions or cell populations while accounting for biological replicates and the hierarchical structure of single-cell sequencing data.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# pseudobulk-with-decoupler-and-edger-tutorial-workflow

## Overview

This workflow performs pseudobulk differential expression analysis on single-cell RNA-seq data, following the methodology established in the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) tutorials. It begins by processing an AnnData (`.h5ad`) input, utilizing [Scanpy](https://scanpy.readthedocs.io/) to inspect and filter the single-cell dataset to ensure high-quality observations before aggregation.

The core of the analysis uses the [decoupler-py](https://github.com/saezlab/decoupler-py) framework to aggregate single-cell counts into pseudobulk profiles. This step transforms sparse single-cell data into robust count matrices based on specific sample and cell-type metadata, generating diagnostic plots to evaluate expression filtering and the quality of the resulting pseudobulk samples.

Following aggregation, the workflow employs various text-processing tools to format metadata and contrast files for statistical testing. It then performs differential expression analysis using [edgeR](https://bioconductor.org/packages/release/bioc/html/edgeR.html), a bioconductor package optimized for count data. The final outputs include detailed tables of differentially expressed genes (DEGs) and a volcano plot for visual identification of significant biological changes.

This resource is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) and is tagged for single-cell and pseudobulk analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | ncm_pdcs_subset.h5ad | data_input |  |


Ensure your primary input is a single-cell AnnData object in `.h5ad` format containing the necessary raw counts and cell-type annotations. While this workflow processes a single dataset, ensure your metadata columns are correctly formatted for decoupler to aggregate cells into pseudobulk profiles effectively. For automated testing or command-line execution, you can initialize a job configuration using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the `README.md` for comprehensive details on specific parameter settings and metadata requirements. Always verify that your gene identifiers are consistent across the count matrix and metadata to avoid errors during the edgeR differential expression analysis.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.9+galaxy1 | Retrieve general information of the AnnData object |
| 2 | Scanpy filter | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_filter/scanpy_filter/1.10.2+galaxy3 | Filter pDC and/or Non_Classical_Monocyte clusters for DEG analysis. |
| 3 | Decoupler pseudo-bulk | toolshed.g2.bx.psu.edu/repos/ebi-gxa/decoupler_pseudobulk/decoupler_pseudobulk/1.4.0+galaxy8 | Generate pseudobulk counts, samples metadata, genes metadata files plus two plots to inspect the pseudobulk results. |
| 4 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/9.3+galaxy1 | replace [ --+*^]+ with _ for easier file handling |
| 5 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/9.3+galaxy1 |  |
| 6 | Remove columns | toolshed.g2.bx.psu.edu/repos/iuc/column_remove_by_header/column_remove_by_header/1.0 |  |
| 7 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/9.3+galaxy1 |  |
| 8 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.3+galaxy1 |  |
| 9 | edgeR | toolshed.g2.bx.psu.edu/repos/iuc/edger/edger/3.36.0+galaxy5 |  |
| 10 | Extract dataset | __EXTRACT_DATASET__ |  |
| 11 | Remove columns | toolshed.g2.bx.psu.edu/repos/iuc/column_remove_by_header/column_remove_by_header/1.0 |  |
| 12 | Volcano Plot | toolshed.g2.bx.psu.edu/repos/iuc/volcanoplot/volcanoplot/0.0.6 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | General AnnData Information | general |
| 2 | anndata_out | anndata_out |
| 3 | genes_metadata | genes_metadata |
| 3 | samples_metadata | samples_metadata |
| 3 | count_matrix | count_matrix |
| 3 | plot_output | plot_output |
| 3 | filter_by_expr_plot | filter_by_expr_plot |
| 7 | Samples Metadata | outfile |
| 8 | Contrast File | outfile |
| 9 | outTables | outTables |
| 10 | output | output |
| 11 | DEG Table | output_tabular |
| 12 | Volcano Plot DEG | plot |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run pseudo-bulk-edger.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run pseudo-bulk-edger.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run pseudo-bulk-edger.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init pseudo-bulk-edger.ga -o job.yml`
- Lint: `planemo workflow_lint pseudo-bulk-edger.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `pseudo-bulk-edger.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)