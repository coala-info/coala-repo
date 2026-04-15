---
name: workflow-6-gucfg2galaxy-alpha-diversity-16s-microbial-analys
description: This metagenomics workflow processes a Mothur shared file to perform alpha diversity analysis using Mothur's rarefaction and summary tools. Use this skill when you need to evaluate microbial community richness and diversity within individual samples or assess if your sequencing depth is sufficient through rarefaction curves.
homepage: https://www.qcif.edu.au/
metadata:
  docker_image: "N/A"
---

# workflow-6-gucfg2galaxy-alpha-diversity-16s-microbial-analys

## Overview

This workflow is designed for metagenomics research, specifically focusing on alpha diversity analysis within 16S microbial studies. It utilizes the [Mothur](https://mothur.org/) toolset to process shared files (OTU tables) to evaluate the microbial richness and diversity within individual samples.

The pipeline begins by executing `Rarefaction.single` to generate rarefaction curves, which help determine if the sampling depth is sufficient to represent the microbial community. Simultaneously, it runs `Summary.single` to calculate various alpha diversity indices, providing detailed summary files and subsampled data for comparative analysis.

In the final stage, the workflow employs a plotting tool to generate an XY plot in PNG format. The final outputs include comprehensive summary statistics and visual representations of the rarefaction curves, enabling researchers to assess the complexity and diversity of the microbial communities in their datasets.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Shared file | data_input |  |


Ensure your primary input is a valid Mothur `.shared` file, as this specific format is required to calculate rarefaction curves and alpha diversity indices correctly. While the workflow is designed for a single dataset input, you can utilize Galaxy collections to process multiple shared files in parallel. Please refer to the `README.md` for comprehensive details on data formatting and parameter settings. For automated execution, you can generate a template for your inputs using `planemo workflow_job_init` to create a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Rarefaction.single | toolshed.g2.bx.psu.edu/repos/iuc/mothur_rarefaction_single/mothur_rarefaction_single/1.39.5.0 |  |
| 2 | Summary.single | toolshed.g2.bx.psu.edu/repos/iuc/mothur_summary_single/mothur_summary_single/1.39.5.2 |  |
| 3 | Plotting tool | toolshed.g2.bx.psu.edu/repos/devteam/xy_plot/XY_Plot_1/1.0.2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | rarefactioncurves | rarefactioncurves |
| 2 | summaryfiles | summaryfiles |
| 2 | summary | summary |
| 2 | subsample_summary | subsample_summary |
| 3 | out_file_png | out_file_png |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Workflow_6_[gucfg2galaxy]__Alpha_Diversity_[16S_Microbial_Analysis_With_Mothur].ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Workflow_6_[gucfg2galaxy]__Alpha_Diversity_[16S_Microbial_Analysis_With_Mothur].ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Workflow_6_[gucfg2galaxy]__Alpha_Diversity_[16S_Microbial_Analysis_With_Mothur].ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Workflow_6_[gucfg2galaxy]__Alpha_Diversity_[16S_Microbial_Analysis_With_Mothur].ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Workflow_6_[gucfg2galaxy]__Alpha_Diversity_[16S_Microbial_Analysis_With_Mothur].ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Workflow_6_[gucfg2galaxy]__Alpha_Diversity_[16S_Microbial_Analysis_With_Mothur].ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)