---
name: ecoregionalization-workflow-part-1
description: "This workflow processes species occurrence records and environmental datasets using text processing tools, Boosted Regression Trees, and clustering algorithms to prepare data for ecoregionalization. Use this skill when you need to integrate biodiversity observations with environmental variables to identify spatial patterns and estimate ecological clusters for biogeographic mapping."
homepage: https://workflowhub.eu/workflows/1208
---

# Ecoregionalization workflow (Part 1)

## Overview

This Galaxy workflow represents the first phase of an ecoregionalization analysis, designed to process biological occurrence data and environmental variables. The pipeline begins by unzipping raw data and performing extensive text cleaning using regex-based find-and-replace tools and advanced column cutting. It integrates a JupyterLab notebook for custom data pivoting and manipulation, ensuring the datasets are correctly formatted for ecological modeling.

The core of the workflow utilizes specialized ecological tools to link occurrences with environmental parameters. It employs the **GeoNearestNeighbor** tool to associate spatial data, followed by **TaxaSeeker** for taxonomic refinement and **BRT tool prediction** for Boosted Regression Tree analysis. These steps generate critical outputs, including distribution predictions, validation metrics, and visualization plots.

In the final stages, the workflow performs cluster estimation to identify potential ecological zones. Key outputs include the SIH index, cleaned taxonomic tables, and processed biological data ready for further regionalization steps. This workflow is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | 0030809-240506114902167.zip | data_input | Gbif downloaded zip file |
| 1 | ceamarc_env.tab | data_input | Environment file |
| 2 | pivot_wider_jupytool_notebook.ipynb | data_input | Jupyter Notebook file |


Ensure your input files are correctly formatted as ZIP archives for occurrence data, tabular (.tab) files for environmental variables, and Jupyter Notebook (.ipynb) files for custom processing steps. Use individual datasets for these primary inputs, as the workflow is designed to unzip and filter specific columns before merging them for spatial analysis. For comprehensive parameter settings and data schema requirements, refer to the README.md file. You can streamline the execution process by using `planemo workflow_job_init` to generate a `job.yml` file for automated testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Unzip | toolshed.g2.bx.psu.edu/repos/imgteam/unzip/unzip/6.0+galaxy0 | Unzipped file |
| 4 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/9.3+galaxy2 | Advanced Cut |
| 5 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 | Column Regex Find And Replace |
| 6 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 | Column Regex Find And Replace |
| 7 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 | Column Regex Find And Replace |
| 8 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 | Column Regex Find And Replace |
| 9 | Filter Tabular | toolshed.g2.bx.psu.edu/repos/iuc/filter_tabular/filter_tabular/3.3.1 | Filter |
| 10 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 | Column Regex Find And Replace |
| 11 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 | Column Regex Find And Replace |
| 12 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 | Column Regex Find And Replace |
| 13 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 | Column Regex Find And Replace |
| 14 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 | Column Regex Find And Replace |
| 15 | Merge Columns | toolshed.g2.bx.psu.edu/repos/devteam/merge_cols/mergeCols1/1.0.2 | Merge file |
| 16 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/9.3+galaxy2 | Advanced Cut |
| 17 | Interactive JupyterLab Notebook | interactive_tool_jupyter_notebook | Interactive tool jupyter notebook |
| 18 | GeoNearestNeighbor | toolshed.g2.bx.psu.edu/repos/ecology/ecoregion_geonearestneighbor/ecoregion_GeoNearestNeighbor/0.1.0+galaxy0 | GeoNearestNeighbor to merge environemental file and occurrence file |
| 19 | BRT tool prediction | toolshed.g2.bx.psu.edu/repos/ecology/ecoregion_brt_analysis/ecoregion_brt_analysis/0.1.0+galaxy0 | BRT predictions |
| 20 | TaxaSeeker | toolshed.g2.bx.psu.edu/repos/ecology/ecoregion_taxa_seeker/ecoregion_taxa_seeker/0.1.0+galaxy0 | Retrive taxa |
| 21 | ClusterEstimate | toolshed.g2.bx.psu.edu/repos/ecology/ecoregion_cluster_estimate/ecoregion_cluster_estimate/0.1.0+galaxy0 | Estimate the number of cluster |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 17 | occ_out | output_dataset |
| 18 | occ_env_out | occ_env_out |
| 18 | info_out | info_out |
| 19 | coll_pred | outputpred |
| 19 | coll_val | outputval |
| 19 | coll_distri | outputspdistri |
| 19 | coll_plots | outputplots |
| 20 | summary | output1 |
| 20 | taxa | output2 |
| 20 | taxa_clean | output3 |
| 21 | SIH_index | output1 |
| 21 | data_to_clus | output2 |
| 21 | databio_table | output3 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Ecoregionalization_workflow_Part_1.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Ecoregionalization_workflow_Part_1.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Ecoregionalization_workflow_Part_1.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Ecoregionalization_workflow_Part_1.ga -o job.yml`
- Lint: `planemo workflow_lint Ecoregionalization_workflow_Part_1.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Ecoregionalization_workflow_Part_1.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
