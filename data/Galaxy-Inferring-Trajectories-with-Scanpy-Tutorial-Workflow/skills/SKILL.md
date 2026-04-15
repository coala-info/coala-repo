---
name: inferring-trajectories-with-scanpy-tutorial-workflow
description: This Galaxy workflow processes AnnData objects to perform single-cell trajectory inference using Scanpy tools including PAGA, Diffusion Maps, and Diffusion Pseudotime. Use this skill when you need to model cellular differentiation pathways, identify branching lineages, or calculate pseudotime values to understand the progression of biological processes in single-cell datasets.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# inferring-trajectories-with-scanpy-tutorial-workflow

## Overview

This Galaxy workflow is designed for single-cell RNA sequencing analysis, specifically focusing on trajectory inference using the Scanpy ecosystem. It takes an AnnData object as input and performs a series of preprocessing and dimensionality reduction steps to uncover the underlying biological transitions and developmental relationships between cell states.

The pipeline utilizes several advanced algorithms to represent cellular connectivity, including Diffusion Maps and Force-Directed Graph (FDG) layouts. A central component of the workflow is the application of Partition-based Graph Abstraction (PAGA), which provides a robust, high-level topology of the data. This allows researchers to identify branching lineages and visualize the connectivity between different cell clusters.

To quantify cellular progression, the workflow calculates Diffusion Pseudotime (DPT), mapping cells along a continuous developmental timeline. The results are visualized through multiple embedding plots, enabling the comparison of different layout techniques and the mapping of metadata onto the inferred trajectories. This workflow is aligned with [GTN](https://training.galaxyproject.org/) training materials for single-cell analysis and is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input Anndata | data_input |  |


Ensure your input is a valid AnnData file in `h5ad` format, containing the necessary pre-processed expression data and metadata required for trajectory inference. While this workflow typically processes a single dataset, you can utilize dataset collections if you intend to run parallel analyses across multiple samples. Refer to the `README.md` for comprehensive details on parameter settings and specific data requirements. You can also use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.7.5+galaxy1 |  |
| 2 | Scanpy RunFDG | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_run_fdg/scanpy_run_fdg/1.8.1+galaxy9 |  |
| 3 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |
| 4 | Scanpy DiffusionMap | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_run_diffmap/scanpy_run_diffmap/1.8.1+galaxy9 |  |
| 5 | Scanpy ComputeGraph | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_compute_graph/scanpy_compute_graph/1.8.1+galaxy9 |  |
| 6 | Scanpy RunFDG | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_run_fdg/scanpy_run_fdg/1.8.1+galaxy9 |  |
| 7 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |
| 8 | Scanpy PAGA | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_run_paga/scanpy_run_paga/1.8.1+galaxy9 |  |
| 9 | Scanpy PlotTrajectory | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_trajectory/scanpy_plot_trajectory/1.8.1+galaxy9 |  |
| 10 | Scanpy RunFDG | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_run_fdg/scanpy_run_fdg/1.8.1+galaxy9 |  |
| 11 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |
| 12 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |
| 13 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |
| 14 | Scanpy DPT | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_run_dpt/scanpy_run_dpt/1.8.1+galaxy9 |  |
| 15 | Scanpy PlotEmbed | toolshed.g2.bx.psu.edu/repos/ebi-gxa/scanpy_plot_embed/scanpy_plot_embed/1.8.1+galaxy9 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run inferring-trajectories-with-scanpy-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run inferring-trajectories-with-scanpy-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run inferring-trajectories-with-scanpy-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init inferring-trajectories-with-scanpy-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint inferring-trajectories-with-scanpy-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `inferring-trajectories-with-scanpy-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)