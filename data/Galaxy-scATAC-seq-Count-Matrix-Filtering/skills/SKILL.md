---
name: scatac-seq-count-matrix-filtering
description: "This Galaxy workflow processes scATAC-seq AnnData objects using epiScanpy and Scanpy to visualize and filter chromatin accessibility data. Use this skill when you need to remove low-quality cells and noisy genomic features from single-cell chromatin accessibility datasets to ensure high-quality downstream analysis."
homepage: https://workflowhub.eu/workflows/1502
---

# scATAC-seq Count Matrix Filtering

## Overview

This Galaxy workflow is designed to visualize and filter single-cell ATAC-seq (scATAC-seq) data stored in AnnData format. By leveraging a series of [EpiScanpy](https://toolshed.g2.bx.psu.edu/repos/iuc/episcanpy_preprocess) preprocessing steps, the pipeline streamlines the transition from raw count matrices to high-quality datasets ready for downstream analysis.

The process involves multiple iterative filtering stages to remove low-quality cells and features based on specific accessibility metrics. It utilizes [Scanpy](https://toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot) plotting tools to generate diagnostic visualizations, allowing users to inspect the data distribution before and after quality control.

The final outputs include a cleaned and filtered AnnData object, a detailed summary of the AnnData structure, and visual plots confirming the filtering results. This workflow is particularly useful for researchers following [GTN](https://training.galaxyproject.org/) tutorials for single-cell chromatin accessibility analysis under the CC-BY-4.0 license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | scATAC-seq Anndata | data_input | scATAC Anndata with cells x peaks |


Ensure your input scATAC-seq data is in the `h5ad` (AnnData) format, as this workflow is optimized for processing high-dimensional sparse matrices. While single datasets are standard, you can use dataset collections to process multiple samples in parallel through the preprocessing steps. Refer to the `README.md` for specific parameter thresholds and detailed quality control guidance. For automated testing or command-line execution, you can initialize a job configuration using `planemo workflow_job_init`. Always verify that your input file contains the necessary peak-by-cell counts before starting the filtering pipeline.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | scATAC-seq Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/episcanpy_preprocess/episcanpy_preprocess/0.3.2+galaxy1 |  |
| 2 | scATAC-seq Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/episcanpy_preprocess/episcanpy_preprocess/0.3.2+galaxy1 |  |
| 3 | scATAC-seq Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/episcanpy_preprocess/episcanpy_preprocess/0.3.2+galaxy1 |  |
| 4 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy2 |  |
| 5 | scATAC-seq Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/episcanpy_preprocess/episcanpy_preprocess/0.3.2+galaxy1 |  |
| 6 | scATAC-seq Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/episcanpy_preprocess/episcanpy_preprocess/0.3.2+galaxy1 |  |
| 7 | scATAC-seq Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/episcanpy_preprocess/episcanpy_preprocess/0.3.2+galaxy1 |  |
| 8 | scATAC-seq Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/episcanpy_preprocess/episcanpy_preprocess/0.3.2+galaxy1 |  |
| 9 | scATAC-seq Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/episcanpy_preprocess/episcanpy_preprocess/0.3.2+galaxy1 |  |
| 10 | scATAC-seq Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/episcanpy_preprocess/episcanpy_preprocess/0.3.2+galaxy1 |  |
| 11 | scATAC-seq Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/episcanpy_preprocess/episcanpy_preprocess/0.3.2+galaxy1 |  |
| 12 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.9+galaxy1 |  |
| 13 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 11 | Filtered Anndata | anndata_out |
| 12 | Anndata info | general |
| 13 | out_png | out_png |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run scatac-seq-count-matrix-filtering.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run scatac-seq-count-matrix-filtering.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run scatac-seq-count-matrix-filtering.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init scatac-seq-count-matrix-filtering.ga -o job.yml`
- Lint: `planemo workflow_lint scatac-seq-count-matrix-filtering.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `scatac-seq-count-matrix-filtering.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
