---
name: multisample-batch-correction-with-snapatac2-and-harmony
description: "This workflow processes multi-sample single-cell ATAC-seq fragment collections through a pipeline of preprocessing, filtering, and dimension reduction using SnapATAC2 and Harmony. Use this skill when you need to integrate epigenomic data from multiple biological replicates or batches to remove technical noise and identify shared cell clusters through Leiden clustering."
homepage: https://workflowhub.eu/workflows/1561
---

# Multisample Batch Correction with SnapATAC2 and Harmony

## Overview

This Galaxy workflow provides a comprehensive pipeline for the analysis of multisample single-cell ATAC-seq (scATAC-seq) data, specifically focusing on batch effect correction and clustering. Utilizing the [SnapATAC2](https://toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing) framework, the process begins by taking a collection of fragment files along with reference genome annotations and chromosome sizes to perform initial preprocessing, quality control filtering, and data concatenation.

The core of the workflow addresses technical variations between samples through multiple integration methods. It performs dimension reduction and applies batch correction algorithms, with a primary focus on [Harmony](https://toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_clustering), while also providing outputs for MNN and Scanorama for comparison. These corrected embeddings are then used for Leiden clustering and visualization.

Final outputs include TSSE plots for quality assessment, batch-corrected spectral embeddings, and an AnnData object containing the integrated clusters. This workflow is tagged for epigenetics and single-cell analysis and is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input MultiSample Collection | data_collection_input |  |
| 1 | chrom_sizes | data_input |  |
| 2 | gencode.v46.annotation.gtf.gz | data_input |  |


Ensure your input fragments are organized into a dataset collection to enable batch processing, while providing the chromosome sizes and gene annotations in tabular and GTF formats respectively. For optimal results, verify that fragment files are properly indexed and that the GTF version matches your reference genome. Detailed parameter configurations and metadata requirements are documented in the README.md file. You can streamline the setup of these inputs by using `planemo workflow_job_init` to generate a template `job.yml` file.

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
