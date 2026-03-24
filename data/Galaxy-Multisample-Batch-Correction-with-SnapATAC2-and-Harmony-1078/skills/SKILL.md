---
name: multisample-batch-correction-with-snapatac2-and-harmony
description: "This workflow processes a collection of single-cell ATAC-seq fragment files using SnapATAC2 and Harmony to perform preprocessing, dimension reduction, batch correction, and Leiden clustering. Use this skill when you need to integrate multiple single-cell chromatin accessibility datasets and remove technical variation between samples to identify consistent cell clusters across different experimental batches."
homepage: https://workflowhub.eu/workflows/1078
---

# Multisample Batch Correction with SnapATAC2 and Harmony

## Overview

This Galaxy workflow provides a comprehensive pipeline for the analysis of multisample single-cell ATAC-seq data, leveraging the [SnapATAC2](https://kzhang.org/SnapATAC2/) framework and [Harmony](https://github.com/immunogenomics/harmony) for robust batch effect correction. It is designed to process a dataset collection of fragments alongside essential genomic references, including chromosome sizes and GTF annotations.

The pipeline begins with rigorous preprocessing and quality control, including the generation of TSS enrichment (TSSE) plots and initial filtering of cells. Following individual sample processing, the workflow concatenates the datasets and performs dimensionality reduction. It specifically addresses technical variation across samples by applying Harmony batch correction, while also providing comparative outputs for other integration methods like MNN and Scanorama.

In the final stages, the workflow executes Leiden clustering on the integrated data to identify distinct cell populations. The primary outputs include an AnnData object containing the Harmony-corrected embeddings and Leiden cluster assignments, as well as various diagnostic plots to visualize the success of the integration and the resulting cluster structure.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input MultiSample Collection | data_collection_input |  |
| 1 | chrom_sizes | data_input |  |
| 2 | gencode.v46.annotation.gtf.gz | data_input |  |


Ensure your input fragments are provided as a dataset collection of TSV files, while the reference genome requires a specific chrom_sizes text file and a Gencode GTF for gene annotation. Using a collection is essential for the workflow to correctly iterate through multiple samples before concatenation and batch correction. For automated execution and testing, you can initialize a job configuration using `planemo workflow_job_init` to generate a `job.yml` file. Detailed parameter descriptions and specific filtering thresholds are available in the accompanying README.md. Refer to the tool documentation for further guidance on SnapATAC2 and Harmony integration.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 |  |
| 4 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 |  |
| 5 | SnapATAC2 Plotting | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_plotting/snapatac2_plotting/2.6.4+galaxy1 |  |
| 6 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 |  |
| 7 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 |  |
| 8 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 |  |
| 9 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 |  |
| 10 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 |  |
| 11 | Extract element identifiers | toolshed.g2.bx.psu.edu/repos/iuc/collection_element_identifiers/collection_element_identifiers/0.0.2 |  |
| 12 | Extract dataset | __EXTRACT_DATASET__ |  |
| 13 | Select first | Show beginning1 |  |
| 14 | Filter collection | __FILTER_FROM_FILE__ |  |
| 15 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.3+galaxy0 |  |
| 16 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 |  |
| 17 | SnapATAC2 Clustering | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_clustering/snapatac2_clustering/2.6.4+galaxy1 |  |
| 18 | SnapATAC2 Clustering | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_clustering/snapatac2_clustering/2.6.4+galaxy1 |  |
| 19 | SnapATAC2 Plotting | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_plotting/snapatac2_plotting/2.6.4+galaxy1 |  |
| 20 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 |  |
| 21 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 |  |
| 22 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 |  |
| 23 | SnapATAC2 Clustering | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_clustering/snapatac2_clustering/2.6.4+galaxy1 | Recalculates UMAP-embeddings and adds it under the key 'X_umap_harmony' |
| 24 | SnapATAC2 Clustering | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_clustering/snapatac2_clustering/2.6.4+galaxy1 | Recalculates UMAP-embeddings and adds it under the key 'X_umap_harmony' |
| 25 | SnapATAC2 Clustering | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_clustering/snapatac2_clustering/2.6.4+galaxy1 | Recalculates UMAP-embeddings and adds it under the key 'X_umap_harmony' |
| 26 | SnapATAC2 Plotting | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_plotting/snapatac2_plotting/2.6.4+galaxy1 |  |
| 27 | SnapATAC2 Clustering | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_clustering/snapatac2_clustering/2.6.4+galaxy1 | Recalculates UMAP-embeddings and adds it under the key 'X_umap_harmony' |
| 28 | SnapATAC2 Plotting | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_plotting/snapatac2_plotting/2.6.4+galaxy1 |  |
| 29 | SnapATAC2 Plotting | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_plotting/snapatac2_plotting/2.6.4+galaxy1 |  |
| 30 | SnapATAC2 Clustering | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_clustering/snapatac2_clustering/2.6.4+galaxy1 | Recalculates UMAP-embeddings and adds it under the key 'X_umap_harmony' |
| 31 | SnapATAC2 Plotting | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_plotting/snapatac2_plotting/2.6.4+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | tsse-plots | out_png |
| 14 | collection_without_first_entry | output_filtered |
| 19 | out_png | out_png |
| 26 | x_spectral_harmony | out_png |
| 28 | x_spectral_mnn-correct | out_png |
| 29 | x_spectral_scanorma | out_png |
| 30 | anndata_harmony_leiden | anndata_out |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run version2-Galaxy-Workflow-Multisample_Batch_Correction_with_SnapATAC2_and_Harmony.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run version2-Galaxy-Workflow-Multisample_Batch_Correction_with_SnapATAC2_and_Harmony.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run version2-Galaxy-Workflow-Multisample_Batch_Correction_with_SnapATAC2_and_Harmony.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init version2-Galaxy-Workflow-Multisample_Batch_Correction_with_SnapATAC2_and_Harmony.ga -o job.yml`
- Lint: `planemo workflow_lint version2-Galaxy-Workflow-Multisample_Batch_Correction_with_SnapATAC2_and_Harmony.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `version2-Galaxy-Workflow-Multisample_Batch_Correction_with_SnapATAC2_and_Harmony.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
