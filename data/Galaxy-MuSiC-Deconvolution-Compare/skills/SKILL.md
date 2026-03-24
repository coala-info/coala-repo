---
name: music-deconvolution-compare
description: "This transcriptomics workflow utilizes the MuSiC Compare tool to analyze single-cell and bulk ExpressionSet objects by performing three distinct deconvolution comparisons between healthy and diseased samples. Use this skill when you need to evaluate how the selection of healthy or diseased single-cell references impacts the accuracy of cell type proportion estimates in bulk transcriptomic data."
homepage: https://workflowhub.eu/workflows/1498
---

# MuSiC-Deconvolution: Compare

## Overview

This Galaxy workflow performs a comparative analysis of cell type deconvolution using the [MuSiC](https://toolshed.g2.bx.psu.edu/repos/bgruening/music_compare/music_compare/0.1.1+galaxy4) tool. It is designed to evaluate how different reference sets impact the estimation of cell compositions in bulk transcriptomics data, specifically focusing on healthy and diseased (T2D) states.

The process executes three distinct comparison scenarios: inferring cell compositions from a combined reference of healthy and diseased cells, using state-specific references (diseased for diseased, healthy for healthy), and applying a strictly healthy reference to both datasets. The workflow requires five ExpressionSet (ESet) objects as inputs, covering single-cell and bulk data for both conditions.

The outputs include comprehensive statistical tables and heatmaps (PDF format) for each comparison. These visualizations and data tables allow researchers to assess the accuracy and sensitivity of deconvolution results across different biological contexts, making it a valuable resource for [single-cell](https://training.galaxyproject.org/training-material/topics/single-cell/) and [transcriptomics](https://training.galaxyproject.org/training-material/topics/transcriptomics/) training and research.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | ESet Object - Single cell:T2D | data_input |  |
| 1 | ESet Object - Single cell:normal | data_input |  |
| 2 | ESet Object - Bulk:normal | data_input |  |
| 3 | ESet Object - Bulk:T2D | data_input |  |
| 4 | ESet Object - Single cell Total | data_input |  |


Ensure all inputs are provided as ExpressionSet (ESet) objects in RData format, containing both expression matrices and phenotypic metadata. While these inputs are processed as individual datasets, verify that cell type labels and sample identifiers are consistent across the single-cell and bulk data to ensure accurate deconvolution. Refer to the accompanying README.md for specific details on the experimental design and the three distinct comparison scenarios executed by the workflow. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and parameter management.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | MuSiC Compare | toolshed.g2.bx.psu.edu/repos/bgruening/music_compare/music_compare/0.1.1+galaxy4 | Here the T2D bulk sample is inferred from the sc T2D sample, while the normal bulk sample is inferred from the sc normal sample |
| 6 | MuSiC Compare | toolshed.g2.bx.psu.edu/repos/bgruening/music_compare/music_compare/0.1.1+galaxy4 | Here the T2D bulk sample and the normal sample are separately compared separately against the healthy sc reference only (excluding unhealthy sc reference) |
| 7 | MuSiC Compare | toolshed.g2.bx.psu.edu/repos/bgruening/music_compare/music_compare/0.1.1+galaxy4 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | stats | stats |
| 5 | dtables | dtables |
| 5 | out_heatsumm_pdf | out_heatsumm_pdf |
| 5 | out_heatmulti_pdf | out_heatmulti_pdf |
| 6 | out_heatsumm_pdf | out_heatsumm_pdf |
| 6 | out_heatmulti_pdf | out_heatmulti_pdf |
| 6 | stats | stats |
| 6 | dtables | dtables |
| 7 | dtables | dtables |
| 7 | out_heatmulti_pdf | out_heatmulti_pdf |
| 7 | stats | stats |
| 7 | out_heatsumm_pdf | out_heatsumm_pdf |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run compare.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run compare.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run compare.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init compare.ga -o job.yml`
- Lint: `planemo workflow_lint compare.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `compare.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
