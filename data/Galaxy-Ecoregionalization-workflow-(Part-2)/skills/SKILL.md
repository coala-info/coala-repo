---
name: ecoregionalization-workflow-part-2
description: This ecological workflow processes environmental and biological tabular data using ClaraClust and EcoMap to perform ecoregionalization and generate spatial maps. Use this skill when you need to identify distinct ecological regions and visualize their spatial distribution based on clustered environmental and biological variables.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# ecoregionalization-workflow-part-2

## Overview

This workflow represents the second stage of the ecoregionalization process, designed to partition geographical areas into distinct ecological units based on environmental and biological datasets. It processes tabular data—specifically environmental parameters and biological tables—to identify patterns and group similar spatial points into clusters.

The core analysis is performed using the [ClaraClust](https://toolshed.g2.bx.psu.edu/repos/ecology/ecoregion_clara_cluster/ecoregion_clara_cluster/0.1.0+galaxy0) tool, which applies the Clustering Large Applications (CLARA) algorithm to the input datasets. This step generates detailed cluster information and a Silhouette (SIH) plot, allowing users to assess the quality and consistency of the identified ecoregions.

Following the clustering analysis, the [EcoMap](https://toolshed.g2.bx.psu.edu/repos/ecology/ecoregion_eco_map/ecoregion_eco_map/0.1.0+galaxy0) tool transforms the statistical groupings into a spatial visualization. The final output is a comprehensive ecoregion map that facilitates the interpretation of regional ecological boundaries. This workflow is shared under a [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | ceamarc_env.tabular | data_input | Environmental file |
| 1 | Data_to_cluster.tabular | data_input | Prediction matrix |
| 2 | Data.bio_table.tabular | data_input | Prediction table |


Ensure all input files are uploaded in `.tabular` format, verifying that column headers match the expected environmental and biological schemas required by the ClaraClust tool. While these inputs are typically processed as individual datasets, using dataset collections can streamline the workflow if you are comparing multiple clustering scenarios. Consult the `README.md` for comprehensive details on data structure and specific parameter settings for the mapping stage. You may also use `planemo workflow_job_init` to create a `job.yml` for automated input management.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | ClaraClust | toolshed.g2.bx.psu.edu/repos/ecology/ecoregion_clara_cluster/ecoregion_clara_cluster/0.1.0+galaxy0 | Please ensure that the parameter 'Number of Clusters Wanted' reflects your actual desired number. To determine this parameter, refer to your SIH index plot from the ClusterEstimate step. |
| 4 | EcoMap | toolshed.g2.bx.psu.edu/repos/ecology/ecoregion_eco_map/ecoregion_eco_map/0.1.0+galaxy0 | Tool for mapping ecoregions |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | SIH_plot | output1 |
| 3 | cluster_points | output2 |
| 3 | cluster_info | output3 |
| 4 | eco_map | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Ecoregionalization_workflow_Part_2.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Ecoregionalization_workflow_Part_2.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Ecoregionalization_workflow_Part_2.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Ecoregionalization_workflow_Part_2.ga -o job.yml`
- Lint: `planemo workflow_lint Ecoregionalization_workflow_Part_2.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Ecoregionalization_workflow_Part_2.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)