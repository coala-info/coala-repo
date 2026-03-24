---
name: workflow-biodiversity-data-exploration-tuto
description: "This ecology workflow processes tabular fish survey data using tools for spatial anonymization, statistical normality testing, and abundance analysis to explore biodiversity patterns. Use this skill when you need to evaluate species presence-absence, calculate local contributions to beta diversity, and assess the statistical properties of ecological survey datasets."
homepage: https://workflowhub.eu/workflows/1693
---

# Workflow 'Biodiversity data exploration tuto'

## Overview

This workflow is designed for ecological data analysis, specifically focusing on biodiversity exploration and community composition. It processes tabular fish survey data, beginning with the [anonymization](https://toolshed.g2.bx.psu.edu/repos/ecology/tool_anonymization/tool_anonymization/0.0.0) of spatial coordinates to protect sensitive location information while maintaining data integrity for further analysis.

The pipeline performs essential statistical preprocessing by testing for [homoscedasticity and normality](https://toolshed.g2.bx.psu.edu/repos/ecology/ecology_homogeneity_normality/ecology_homogeneity_normality/0.0.0) using Levene and Kolmogorov-Smirnov tests. It also includes steps for [variable exploration](https://toolshed.g2.bx.psu.edu/repos/ecology/ecology_link_between_var/ecology_link_between_var/0.0.0) to identify correlations and links between different environmental or biological factors within the dataset.

Finally, the workflow calculates key ecological indicators, including [presence-absence and abundance](https://toolshed.g2.bx.psu.edu/repos/ecology/ecology_presence_abs_abund/ecology_presence_abs_abund/0.0.0) metrics. It concludes with advanced diversity analysis, specifically measuring [Local Contributions to Beta Diversity (LCBD)](https://toolshed.g2.bx.psu.edu/repos/ecology/ecology_beta_diversity/ecology_beta_diversity/0.0.0) and Species Contributions to Beta Diversity (SCBD), which help researchers identify unique sites and species that drive community variation.

This resource is tagged with **Ecology** and **GTN**, making it a valuable tool for researchers following Galaxy Training Network tutorials on biodiversity informatics.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Reel_life_survey_fish_modif.tabular | data_input |  |


Ensure your input data is formatted as a tabular file, specifically following the structure of the Reel Life Survey fish dataset required for the initial anonymization and statistical steps. Since this workflow is designed for individual datasets rather than collections, upload your file directly to the Galaxy history before execution. Consult the README.md for exhaustive documentation on column headers and the specific ecological parameters used in the downstream beta diversity and abundance tools. To streamline execution, you can use `planemo workflow_job_init` to create a `job.yml` file for your inputs.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Spatial coordinates anonymization | toolshed.g2.bx.psu.edu/repos/ecology/tool_anonymization/tool_anonymization/0.0.0 |  |
| 2 | Homoscedasticity and normality | toolshed.g2.bx.psu.edu/repos/ecology/ecology_homogeneity_normality/ecology_homogeneity_normality/0.0.0 |  |
| 3 | Variables exploration | toolshed.g2.bx.psu.edu/repos/ecology/ecology_link_between_var/ecology_link_between_var/0.0.0 |  |
| 4 | Presence-absence and abundance | toolshed.g2.bx.psu.edu/repos/ecology/ecology_presence_abs_abund/ecology_presence_abs_abund/0.0.0 |  |
| 5 | Statistics on presence-absence | toolshed.g2.bx.psu.edu/repos/ecology/ecology_stat_presence_abs/ecology_stat_presence_abs/0.0.0 |  |
| 6 | Local Contributions to Beta Diversity (LCBD) | toolshed.g2.bx.psu.edu/repos/ecology/ecology_beta_diversity/ecology_beta_diversity/0.0.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | output | output |
| 2 | output_levene | output_levene |
| 2 | output_ks | output_ks |
| 2 | plots | plots |
| 3 | output_coli | output_coli |
| 3 | plots | plots |
| 4 | output_abund | output_abund |
| 4 | plots | plots |
| 5 | output_0 | output_0 |
| 5 | output_md | output_md |
| 6 | plots | plots |
| 6 | output_lcbd | output_lcbd |
| 6 | output_scbd | output_scbd |
| 6 | output_beta | output_beta |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run main-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run main-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run main-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init main-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint main-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `main-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
