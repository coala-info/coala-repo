---
name: ecoregionalization-workflow
description: "This ecoregionalization workflow processes species occurrence records and environmental data using Jupyter notebooks, Boosted Regression Trees, and clustering tools like ClaraClust to generate spatial ecological maps. Use this skill when you need to delineate biogeographic regions or analyze the spatial distribution of taxa in relation to environmental variables for conservation planning and biodiversity assessment."
homepage: https://workflowhub.eu/workflows/1680
---

# Ecoregionalization workflow

## Overview

This Galaxy workflow provides a comprehensive pipeline for ecoregionalization, designed to process biological occurrence data alongside environmental variables. It begins by ingesting raw occurrence records and environmental datasets, utilizing a series of text processing tools—including advanced cuts, regex-based find-and-replace, and tabular filtering—to clean and format the data for downstream ecological analysis.

The core of the workflow integrates interactive data manipulation via a Jupyter notebook (JupyTool) with specialized ecological modeling tools. It employs the GeoNearestNeighbor tool to associate biological observations with environmental parameters, followed by Boosted Regression Trees (BRT) for predictive modeling and distribution analysis. These steps generate detailed validation metrics, distribution plots, and predictive collections.

In the final stages, the workflow performs taxonomic refinement using TaxaSeeker and executes clustering analyses through ClusterEstimate and ClaraClust. These tools calculate silhouette indices and define spatial clusters, which are ultimately visualized as an ecological map (EcoMap). This end-to-end process is particularly useful for [GTN](https://training.galaxyproject.org/) tutorials and biodiversity research, and is released under the [MIT](https://opensource.org/licenses/MIT) license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | occurrence.txt | data_input |  |
| 1 | pivot_wider_jupytool_notebook.ipynb | data_input |  |
| 2 | ceamarc_env.tsv | data_input |  |


Ensure your input files are correctly formatted as tabular (TSV/TXT) for the occurrence and environmental data, while the Jupyter notebook must be uploaded as an .ipynb file to facilitate the interactive data pivoting step. While initial inputs are individual datasets, note that the BRT tool prediction step generates several output collections, so ensure your history is organized to handle grouped results for predictions and plots. For comprehensive details on column requirements and specific regex patterns used in the preprocessing steps, refer to the README.md file. You can automate the setup of these inputs by using planemo workflow_job_init to generate a job.yml file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/9.3+galaxy1 |  |
| 4 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 |  |
| 5 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 |  |
| 6 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 |  |
| 7 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 |  |
| 8 | Filter Tabular | toolshed.g2.bx.psu.edu/repos/iuc/filter_tabular/filter_tabular/3.3.0 |  |
| 9 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 |  |
| 10 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 |  |
| 11 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 |  |
| 12 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 |  |
| 13 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 |  |
| 14 | Merge Columns | toolshed.g2.bx.psu.edu/repos/devteam/merge_cols/mergeCols1/1.0.2 |  |
| 15 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/9.3+galaxy1 |  |
| 16 | Interactive JupyTool and notebook | interactive_tool_jupyter_notebook |  |
| 17 | GeoNearestNeighbor | toolshed.g2.bx.psu.edu/repos/ecology/ecoregion_geonearestneighbor/ecoregion_GeoNearestNeighbor/0.1.0+galaxy0 |  |
| 18 | BRT tool prediction | toolshed.g2.bx.psu.edu/repos/ecology/ecoregion_brt_analysis/ecoregion_brt_analysis/0.1.0+galaxy0 |  |
| 19 | TaxaSeeker | toolshed.g2.bx.psu.edu/repos/ecology/ecoregion_taxa_seeker/ecoregion_taxa_seeker/0.1.0+galaxy0 |  |
| 20 | ClusterEstimate | toolshed.g2.bx.psu.edu/repos/ecology/ecoregion_cluster_estimate/ecoregion_cluster_estimate/0.1.0+galaxy0 |  |
| 21 | ClaraClust | toolshed.g2.bx.psu.edu/repos/ecology/ecoregion_clara_cluster/ecoregion_clara_cluster/0.1.0+galaxy0 | Please ensure that the parameter 'Number of Clusters Wanted' reflects your actual desired number. To determine this parameter, refer to your SIH index plot from the ClusterEstimate step. |
| 22 | EcoMap | toolshed.g2.bx.psu.edu/repos/ecology/ecoregion_eco_map/ecoregion_eco_map/0.1.0+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 16 | occ_out | output_dataset |
| 17 | occ_env_out | occ_env_out |
| 17 | info_out | info_out |
| 18 | coll_pred | outputpred |
| 18 | coll_val | outputval |
| 18 | coll_distri | outputspdistri |
| 18 | coll_plots | outputplots |
| 19 | summary | output1 |
| 19 | taxa | output2 |
| 19 | taxa_clean | output3 |
| 20 | SIH_index | output1 |
| 20 | data_to_clus | output2 |
| 20 | databio_table | output3 |
| 21 | SIH_plot | output1 |
| 21 | cluster_points | output2 |
| 21 | cluster_info | output3 |
| 22 | eco_map | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run ecoregionalization-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run ecoregionalization-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run ecoregionalization-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init ecoregionalization-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint ecoregionalization-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `ecoregionalization-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
