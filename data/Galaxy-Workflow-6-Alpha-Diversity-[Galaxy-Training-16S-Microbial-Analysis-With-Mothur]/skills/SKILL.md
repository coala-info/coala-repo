---
name: workflow-6-alpha-diversity-galaxy-training-16s-microbial-ana
description: This 16S microbial analysis workflow processes a shared OTU file using Mothur tools to calculate alpha diversity indices and generate rarefaction curves. Use this skill when you need to evaluate the richness and diversity of microbial communities within individual samples or determine if sequencing depth is sufficient to capture the full taxonomic variety.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# workflow-6-alpha-diversity-galaxy-training-16s-microbial-ana

## Overview

This workflow is a component of the [Galaxy Training Network](https://training.galaxyproject.org/) suite for 16S microbial analysis using the mothur toolset. It is designed to assess alpha diversity, which measures the species richness and evenness within individual samples to characterize microbial community complexity.

The pipeline processes a shared file (OTU table) using the `mothur_rarefaction_single` and `mothur_summary_single` tools. These steps calculate essential alpha diversity indices—such as Chao1, Shannon, and Simpson metrics—while determining if the sequencing depth was sufficient to represent the full diversity of the environment.

The final stage of the workflow utilizes a plotting tool to generate a PNG visualization of the rarefaction curves. This provides both quantitative summary tables and qualitative graphical representations, allowing researchers to evaluate sample coverage and compare diversity across different experimental groups.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Shared file | data_input |  |


Ensure your primary input is a valid mothur `.shared` file containing OTU abundance data across your samples. While this workflow is designed for a single dataset, you can utilize dataset collections to manage multiple shared files simultaneously if needed. Refer to the `README.md` for comprehensive details on data formatting and specific parameter configurations required for the rarefaction and summary tools. For automated testing or execution, consider using `planemo workflow_job_init` to create a `job.yml` file.

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
planemo run workflow6-alpha-diversity.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run workflow6-alpha-diversity.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run workflow6-alpha-diversity.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init workflow6-alpha-diversity.ga -o job.yml`
- Lint: `planemo workflow_lint workflow6-alpha-diversity.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `workflow6-alpha-diversity.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)