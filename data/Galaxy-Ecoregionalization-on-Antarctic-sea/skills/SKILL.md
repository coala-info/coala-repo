---
name: ecoregionalization-on-antarctic-sea
description: "This workflow processes environmental and taxa data from the Antarctic sea using Boosted Regression Trees, clustering algorithms, and mapping tools to perform ecoregionalization. Use this skill when you need to define distinct ecological zones or map the spatial distribution of marine communities based on species presence and environmental variables."
homepage: https://workflowhub.eu/workflows/658
---

# Ecoregionalization on Antarctic sea

## Overview

This Galaxy workflow performs ecoregionalization analysis on Antarctic marine data to identify distinct ecological zones based on environmental and biological variables. It processes environmental parameters from `ceamarc_env.csv` alongside biological occurrence data from `cnidaria_filtered.csv` to model species distributions and their relationships with the habitat.

The analysis begins with [BRT tool prediction](https://toolshed.g2.bx.psu.edu/repos/ecology/ecoregion_brt_analysis/ecoregion_brt_analysis/0.1.0+galaxy0) to perform Boosted Regression Tree modeling, followed by [TaxaSeeker](https://toolshed.g2.bx.psu.edu/repos/ecology/ecoregion_taxa_seeker/ecoregion_taxa_seeker/0.1.0+galaxy0) for taxonomic data refinement. To define the ecoregions, the workflow utilizes [ClusterEstimate](https://toolshed.g2.bx.psu.edu/repos/ecology/ecoregion_cluster_estimate/ecoregion_cluster_estimate/0.1.0+galaxy0) to determine the optimal number of groupings and [ClaraClust](https://toolshed.g2.bx.psu.edu/repos/ecology/ecoregion_clara_cluster/ecoregion_clara_cluster/0.1.0+galaxy0) to execute the clustering algorithm.

The final stage uses [EcoMap](https://toolshed.g2.bx.psu.edu/repos/ecology/ecoregion_eco_map/ecoregion_eco_map/0.1.0+galaxy0) to generate spatial visualizations of the resulting ecoregions. This allows researchers to map biogeographic patterns across the Antarctic sea floor, providing a comprehensive view of regional biodiversity and environmental structure.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | ceamarc_env.csv | data_input |  |
| 1 | cnidaria_filtered.csv | data_input |  |


Ensure your environmental and biological occurrence data are formatted as CSV files, specifically matching the structure of the provided ceamarc_env.csv and cnidaria_filtered.csv templates. While these inputs are handled as individual datasets, ensure that column headers for coordinates and environmental variables are consistent across both files to allow the BRT and clustering tools to align data correctly. For a comprehensive breakdown of required column names and specific parameter settings for the clustering algorithms, refer to the included README.md. You can automate the setup of these input parameters by generating a job.yml file using the planemo workflow_job_init command.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | BRT tool prediction | toolshed.g2.bx.psu.edu/repos/ecology/ecoregion_brt_analysis/ecoregion_brt_analysis/0.1.0+galaxy0 |  |
| 3 | TaxaSeeker | toolshed.g2.bx.psu.edu/repos/ecology/ecoregion_taxa_seeker/ecoregion_taxa_seeker/0.1.0+galaxy0 |  |
| 4 | ClusterEstimate | toolshed.g2.bx.psu.edu/repos/ecology/ecoregion_cluster_estimate/ecoregion_cluster_estimate/0.1.0+galaxy0 |  |
| 5 | ClaraClust | toolshed.g2.bx.psu.edu/repos/ecology/ecoregion_clara_cluster/ecoregion_clara_cluster/0.1.0+galaxy0 |  |
| 6 | EcoMap | toolshed.g2.bx.psu.edu/repos/ecology/ecoregion_eco_map/ecoregion_eco_map/0.1.0+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Ecoregionalization_on_Antarctic_sea.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Ecoregionalization_on_Antarctic_sea.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Ecoregionalization_on_Antarctic_sea.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Ecoregionalization_on_Antarctic_sea.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Ecoregionalization_on_Antarctic_sea.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Ecoregionalization_on_Antarctic_sea.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
