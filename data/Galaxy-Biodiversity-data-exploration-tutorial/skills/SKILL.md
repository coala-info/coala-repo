---
name: biodiversity-data-exploration-tutorial
description: This ecology workflow processes tabular fish survey data using tools for spatial anonymization, variable exploration, and statistical analysis of presence-absence, abundance, and beta diversity. Use this skill when you need to evaluate species distribution patterns, verify statistical assumptions for ecological modeling, or identify sites with unique contributions to regional biodiversity.
homepage: https://www.pndb.fr/
metadata:
  docker_image: "N/A"
---

# biodiversity-data-exploration-tutorial

## Overview

This workflow provides a comprehensive pipeline for the exploration and statistical analysis of biodiversity data, specifically tailored for ecological survey datasets. Starting with tabular input such as the [Reel life survey fish](https://usegalaxy.eu/) data, the process begins with spatial coordinates anonymization to ensure data privacy before proceeding to exploratory analysis.

The pipeline conducts a thorough investigation of environmental and biological variables, identifying correlations and testing fundamental statistical assumptions. It includes dedicated steps for verifying homoscedasticity and normality through Levene and Kolmogorov-Smirnov tests, ensuring that the data is suitable for subsequent parametric or non-parametric modeling.

In the final stages, the workflow calculates key ecological metrics, including species presence-absence and abundance distributions. It culminates in advanced diversity analysis by computing Local Contributions to Beta Diversity (LCBD) and Species Contributions to Beta Diversity (SCBD). These outputs, provided as both statistical tables and visual plots, allow researchers to identify unique ecological sites and the specific species driving regional biodiversity patterns. For detailed implementation notes, refer to the [README.md](README.md) in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Reel_life_survey_fish_modif.tabular | data_input |  |


Ensure the primary input is a `.tabular` file containing both spatial coordinates and numerical ecological variables to satisfy the requirements of the anonymization and statistical tools. While this tutorial uses a single dataset, you can efficiently scale the analysis for multiple survey sites by organizing your data into a dataset collection. Refer to the `README.md` for specific details on the mandatory column structures and data formatting needed for successful tool execution. You can also use `planemo workflow_job_init` to create a `job.yml` file for streamlining your workflow runs.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Spatial coordinates anonymization | toolshed.g2.bx.psu.edu/repos/ecology/tool_anonymization/tool_anonymization/0.0.0 |  |
| 2 | Variables exploration | toolshed.g2.bx.psu.edu/repos/ecology/ecology_link_between_var/ecology_link_between_var/0.0.0 |  |
| 3 | Statistics on presence-absence | toolshed.g2.bx.psu.edu/repos/ecology/ecology_stat_presence_abs/ecology_stat_presence_abs/0.0.0 |  |
| 4 | Homoscedasticity and normality | toolshed.g2.bx.psu.edu/repos/ecology/ecology_homogeneity_normality/ecology_homogeneity_normality/0.0.0 |  |
| 5 | Presence-absence and abundance | toolshed.g2.bx.psu.edu/repos/ecology/ecology_presence_abs_abund/ecology_presence_abs_abund/0.0.0 |  |
| 6 | Local Contributions to Beta Diversity (LCBD) | toolshed.g2.bx.psu.edu/repos/ecology/ecology_beta_diversity/ecology_beta_diversity/0.0.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | output | output |
| 2 | plots | plots |
| 2 | output_coli | output_coli |
| 3 | output_md | output_md |
| 3 | output_0 | output_0 |
| 4 | output_levene | output_levene |
| 4 | output_ks | output_ks |
| 4 | plots | plots |
| 5 | plots | plots |
| 5 | output_abund | output_abund |
| 6 | output_beta | output_beta |
| 6 | output_scbd | output_scbd |
| 6 | output_lcbd | output_lcbd |
| 6 | plots | plots |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Biodiversity_data_exploration_tutorial.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Biodiversity_data_exploration_tutorial.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Biodiversity_data_exploration_tutorial.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Biodiversity_data_exploration_tutorial.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Biodiversity_data_exploration_tutorial.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Biodiversity_data_exploration_tutorial.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)