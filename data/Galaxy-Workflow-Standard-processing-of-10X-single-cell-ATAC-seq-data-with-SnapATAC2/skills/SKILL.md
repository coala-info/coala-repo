---
name: workflow-standard-processing-of-10x-single-cell-atac-seq-dat
description: This Galaxy workflow performs standard processing of 10X single-cell ATAC-seq data from fragment or BAM files using SnapATAC2 and Scanpy for filtering, dimensionality reduction, and embedding. Use this skill when you need to analyze single-cell chromatin accessibility to identify cell clusters, visualize marker gene activity, and annotate cell types within complex biological samples.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# workflow-standard-processing-of-10x-single-cell-atac-seq-dat

## Overview

This Galaxy workflow implements a comprehensive pipeline for the standard processing of 10X single-cell ATAC-seq data using the [SnapATAC2](https://kzhang.org/SnapATAC2/) framework. It is designed to follow the [GTN tutorial](https://training.galaxyproject.org/training-material/topics/single-cell/tutorials/snapatac2/tutorial.html) for epigenetics analysis, taking either a fragment file or a BAM file as the primary input. The workflow automates the transition from raw chromatin accessibility data to annotated cell clusters.

The pipeline begins with rigorous preprocessing, including fragment size distribution analysis, Transcription Start Site Enrichment (TSSE) scoring, and doublet detection via Scrublet. After filtering low-quality cells and doublets, the workflow performs feature selection and creates a tile matrix. Dimensionality reduction is executed using spectral embedding, followed by K-Nearest Neighbor (KNN) graph construction and UMAP visualization to reveal the underlying cellular landscape.

In the final stages, the workflow performs Leiden clustering and generates a gene activity matrix to facilitate cell type identification. It incorporates Scanpy tools for normalization, log-transformation, and MAGIC imputation to enhance the signal of marker genes. The end results include high-resolution UMAP plots of clusters and marker gene expression, as well as final AnnData objects containing comprehensive cell-type annotations.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Fragment_file | data_input |  |
| 1 | chromosome_sizes.tabular | data_input |  |
| 2 | gene_annotation | data_input |  |
| 3 | Bam-file | data_input |  |
| 4 | Keys for annotations of obs/cells or vars/genes | parameter_input | Comma-separated list of obs/cells and vars/genes |
| 5 | Replace_file | data_input |  |


To run this workflow, ensure your primary input is a fragment file (typically a compressed BED-like format) or a BAM file if you intend to generate fragments within the pipeline. You must also provide a tabular chromosome sizes file and a gene annotation file (GTF/GFF) to facilitate accurate genomic mapping and feature selection. While individual datasets are standard, using collections can streamline the processing of multiple samples simultaneously. For comprehensive guidance on parameter settings and reference data requirements, please refer to the README.md. You can also use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 6 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 |  |
| 7 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 |  |
| 8 | SnapATAC2 Plotting | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_plotting/snapatac2_plotting/2.6.4+galaxy1 |  |
| 9 | SnapATAC2 Plotting | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_plotting/snapatac2_plotting/2.6.4+galaxy1 |  |
| 10 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 |  |
| 11 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 |  |
| 12 | SnapATAC2 Plotting | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_plotting/snapatac2_plotting/2.6.4+galaxy1 |  |
| 13 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 |  |
| 14 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 |  |
| 15 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 |  |
| 16 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 |  |
| 17 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 |  |
| 18 | SnapATAC2 Clustering | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_clustering/snapatac2_clustering/2.6.4+galaxy1 |  |
| 19 | SnapATAC2 Clustering | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_clustering/snapatac2_clustering/2.6.4+galaxy1 |  |
| 20 | SnapATAC2 Clustering | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_clustering/snapatac2_clustering/2.6.4+galaxy1 |  |
| 21 | SnapATAC2 Clustering | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_clustering/snapatac2_clustering/2.6.4+galaxy1 |  |
| 22 | SnapATAC2 Plotting | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_plotting/snapatac2_plotting/2.6.4+galaxy1 |  |
| 23 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 |  |
| 24 | Filter | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_filter/scanpy_filter/1.9.6+galaxy3 |  |
| 25 | Normalize | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_normalize/scanpy_normalize/1.9.6+galaxy3 |  |
| 26 | Inspect and manipulate | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_inspect/scanpy_inspect/1.9.6+galaxy3 |  |
| 27 | Normalize | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_normalize/scanpy_normalize/1.9.6+galaxy3 |  |
| 28 | AnnData Operations | toolshed.g2.bx.psu.edu/repos/ebi-gxa/anndata_ops/anndata_ops/1.9.3+galaxy0 |  |
| 29 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.9.6+galaxy3 |  |
| 30 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.3+galaxy0 |  |
| 31 | Cut | Cut1 |  |
| 32 | Replace column | toolshed.g2.bx.psu.edu/repos/bgruening/replace_column_by_key_value_file/replace_column_with_key_value_file/0.2 |  |
| 33 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.3+galaxy0 |  |
| 34 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.9.6+galaxy3 |  |
| 35 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.3+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 8 | plot frag_size | out_png |
| 9 | plot log frag_size | out_png |
| 10 | anndata tsse | anndata_out |
| 11 | anndata | anndata_out |
| 12 | plot tsse | out_png |
| 13 | anndata filter cells | anndata_out |
| 14 | anndata tile matrix | anndata_out |
| 15 | anndata select features | anndata_out |
| 16 | anndata scrublet | anndata_out |
| 17 | anndata filter doublets | anndata_out |
| 18 | anndata spectral | anndata_out |
| 19 | anndata umap | anndata_out |
| 20 | anndata knn | anndata_out |
| 21 | anndata_leiden_clustering | anndata_out |
| 22 | umap_leiden-clusters | out_png |
| 23 | anndata gene matrix | anndata_out |
| 24 | anndata filter genes | anndata_out |
| 25 | anndata normalize | anndata_out |
| 26 | anndata log1p | anndata_out |
| 27 | anndata_magic | anndata_out |
| 28 | anndata_gene-matrix_leiden | output_h5ad |
| 29 | umap_marker-genes | out_png |
| 31 | leiden annotation | out_file1 |
| 32 | cell type annotation | outfile_replace |
| 33 | anndata_cell_type | anndata |
| 34 | umap_cell-type | out_png |
| 35 | general | general |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run standard-processing-of-10x-single-cell-atac-seq-data-with-snapatac2.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run standard-processing-of-10x-single-cell-atac-seq-data-with-snapatac2.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run standard-processing-of-10x-single-cell-atac-seq-data-with-snapatac2.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init standard-processing-of-10x-single-cell-atac-seq-data-with-snapatac2.ga -o job.yml`
- Lint: `planemo workflow_lint standard-processing-of-10x-single-cell-atac-seq-data-with-snapatac2.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `standard-processing-of-10x-single-cell-atac-seq-data-with-snapatac2.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)