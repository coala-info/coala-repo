---
name: raceid-workflow
description: "This Galaxy workflow processes a tabular expression matrix to perform single-cell RNA-seq analysis using RaceID for clustering and StemID for lineage trajectory inference. Use this skill when you need to identify rare cell types, characterize cellular heterogeneity, and reconstruct developmental multipotency or differentiation pathways from transcriptomic data."
homepage: https://workflowhub.eu/workflows/1547
---

# RaceID Workflow

## Overview

This Galaxy workflow provides a comprehensive pipeline for downstream single-cell RNA sequencing (scRNA-seq) analysis using the [RaceID](https://toolshed.g2.bx.psu.edu/view/iuc/raceid_filtnormconf/) algorithm. It is designed to process a tabular expression matrix through initial filtering and normalization, followed by robust k-means clustering to identify cell types and rare subpopulations.

The pipeline extends beyond basic clustering by incorporating [StemID](https://toolshed.g2.bx.psu.edu/view/iuc/raceid_trajectory/) for lineage computation and trajectory inference. This allows researchers to analyze developmental pathways and branch points between identified clusters. The workflow includes multiple inspection steps to visualize cluster characteristics and perform differential gene expression analysis across specific lineage branches.

Tagged for **Transcriptomics** and **Single-cell** analysis, this workflow is aligned with [GTN](https://training.galaxyproject.org/) standards. It generates a variety of outputs, including RData objects for further exploration, detailed PDF visualizations of clusters and trajectories, and tabular gene lists. The workflow is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Tabular Matrix | data_input |  |


Ensure your input is a high-quality count matrix in tabular format, typically with gene symbols as row names and cell identifiers as column headers. For large-scale studies, consider organizing multiple samples into a dataset collection to streamline the initial filtering and normalization steps. Refer to the `README.md` for comprehensive parameter guidance and specific threshold recommendations for single-cell quality control. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated testing and reproducible execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Initial processing using RaceID | toolshed.g2.bx.psu.edu/repos/iuc/raceid_filtnormconf/raceid_filtnormconf/0.2.3+galaxy0 |  |
| 2 | Clustering using RaceID | toolshed.g2.bx.psu.edu/repos/iuc/raceid_clustering/raceid_clustering/0.2.3+galaxy0 |  |
| 3 | Lineage computation using StemID | toolshed.g2.bx.psu.edu/repos/iuc/raceid_trajectory/raceid_trajectory/0.2.3+galaxy0 |  |
| 4 | Cluster Inspection using RaceID | toolshed.g2.bx.psu.edu/repos/iuc/raceid_inspectclusters/raceid_inspectclusters/0.2.3+galaxy0 |  |
| 5 | Cluster Inspection using RaceID | toolshed.g2.bx.psu.edu/repos/iuc/raceid_inspectclusters/raceid_inspectclusters/0.2.3+galaxy0 |  |
| 6 | Cluster Inspection using RaceID | toolshed.g2.bx.psu.edu/repos/iuc/raceid_inspectclusters/raceid_inspectclusters/0.2.3+galaxy0 |  |
| 7 | Lineage Branch Analysis using StemID | toolshed.g2.bx.psu.edu/repos/iuc/raceid_inspecttrajectory/raceid_inspecttrajectory/0.2.3+galaxy0 |  |
| 8 | Lineage Branch Analysis using StemID | toolshed.g2.bx.psu.edu/repos/iuc/raceid_inspecttrajectory/raceid_inspecttrajectory/0.2.3+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | outpdf | outpdf |
| 1 | outrdat | outrdat |
| 1 | outlog | outlog |
| 1 | outtable | outtable |
| 2 | outpdf | outpdf |
| 2 | outrdat | outrdat |
| 2 | outassignments | outassignments |
| 2 | outgenelist | outgenelist |
| 2 | outlog | outlog |
| 3 | outpdf | outpdf |
| 3 | outrdat | outrdat |
| 4 | outlog | outlog |
| 4 | outpdf | outpdf |
| 5 | outlog | outlog |
| 5 | outpdf | outpdf |
| 6 | outlog | outlog |
| 6 | outpdf | outpdf |
| 7 | outdiffgenes | outdiffgenes |
| 7 | outlog | outlog |
| 7 | outpdf | outpdf |
| 8 | outlog | outlog |
| 8 | outpdf | outpdf |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run raceid-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run raceid-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run raceid-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init raceid-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint raceid-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `raceid-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
