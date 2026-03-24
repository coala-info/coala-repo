---
name: standard-processing-of-single-cell-atac-seq-data-with-snapat
description: "This workflow processes single-cell ATAC-seq fragment or BAM files using SnapATAC2 and Scanpy to perform quality control filtering, dimensionality reduction, and leiden clustering. Use this skill when you need to identify cell-specific chromatin accessibility patterns, visualize clusters via UMAP, and annotate cell types based on gene activity matrices in epigenetic studies."
homepage: https://workflowhub.eu/workflows/1077
---

# Standard processing of single cell ATAC-seq data with SnapATAC2

## Overview

This Galaxy workflow provides a comprehensive pipeline for the standard processing of 10X single-cell ATAC-seq (scATAC-seq) data using the [SnapATAC2](https://kzhang.org/SnapATAC2/) framework. It is designed to take either a fragment file or a BAM file as the primary input, alongside essential genomic references such as chromosome sizes and gene annotations. The workflow automates the transition from raw chromatin accessibility data to interpreted biological insights, including cell type identification and marker gene visualization.

The pipeline begins with rigorous preprocessing and quality control, including fragment size analysis and the calculation of Transcription Start Site Enrichment (TSSE) scores. It performs cell filtering based on user-defined parameters for counts and TSSE, followed by tile matrix generation and feature selection. Advanced doublet detection is integrated via the Scrublet algorithm to ensure data integrity before downstream analysis.

For structural analysis, the workflow utilizes spectral embedding for dimension reduction, followed by K-Nearest Neighbors (KNN) graph construction and Leiden clustering. These clusters are visualized using UMAP embeddings. To facilitate biological interpretation, the workflow generates a gene activity matrix, performs normalization (including MAGIC imputation), and maps marker genes to clusters. The final stages allow for the integration of custom cell-type annotations, resulting in a fully annotated AnnData object and high-quality visualizations of the epigenetic landscape.

This workflow is tagged for **scATAC-seq** and **epigenetics** research and is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Fragment_file | data_input |  |
| 1 | chromosome_sizes.tabular | data_input |  |
| 2 | gene_annotation | data_input |  |
| 3 | Bam-file | data_input |  |
| 4 | min_counts | parameter_input |  |
| 5 | min_tsse | parameter_input |  |
| 6 | max_counts | parameter_input |  |
| 7 | max_tsse | parameter_input |  |
| 8 | Keys for annotations of obs/cells or vars/genes | parameter_input | Comma-separated list of obs/cells and vars/genes.  For example: leiden, CD3D, CD8A, CD4, MS4A1, NKG7, CD14, FCER1A |
| 9 | Replace_file | data_input | Tabular file, containing leiden clusters and the corresponding cell type annotations. |


Ensure your primary input is a tab-separated fragment file or a BAM file for conversion, alongside a tabular chromosome sizes file and a GTF/GFF3 gene annotation. For large-scale analyses, organize your inputs as individual datasets or collections to streamline the SnapATAC2 preprocessing and clustering steps. You can use a `Replace_file` to map cluster IDs to specific cell types during the final annotation stages. Refer to the `README.md` for comprehensive details on parameter tuning for TSSE and count filters. For automated execution, you can initialize the environment using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 10 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 |  |
| 11 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 | Not all regular expressions work. Simple expressions such as "(................):" are successful. This example expression captures 16bp long cell barcodes if they are located at the beginning of the read names field and followed by a colon. |
| 12 | SnapATAC2 Plotting | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_plotting/snapatac2_plotting/2.6.4+galaxy1 |  |
| 13 | SnapATAC2 Plotting | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_plotting/snapatac2_plotting/2.6.4+galaxy1 |  |
| 14 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 |  |
| 15 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 | After pp.make_fragment_file the new fragment file is sorted by barcode. |
| 16 | SnapATAC2 Plotting | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_plotting/snapatac2_plotting/2.6.4+galaxy1 |  |
| 17 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 | Filters should be selected after inspecting the quality control plots (especially TSSe) |
| 18 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 |  |
| 19 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 | The ideal number of selected features should be tested for each dataset. |
| 20 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 |  |
| 21 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 |  |
| 22 | SnapATAC2 Clustering | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_clustering/snapatac2_clustering/2.6.4+galaxy1 |  |
| 23 | SnapATAC2 Clustering | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_clustering/snapatac2_clustering/2.6.4+galaxy1 |  |
| 24 | SnapATAC2 Clustering | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_clustering/snapatac2_clustering/2.6.4+galaxy1 |  |
| 25 | SnapATAC2 Clustering | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_clustering/snapatac2_clustering/2.6.4+galaxy1 |  |
| 26 | SnapATAC2 Plotting | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_plotting/snapatac2_plotting/2.6.4+galaxy1 |  |
| 27 | SnapATAC2 Preprocessing | toolshed.g2.bx.psu.edu/repos/iuc/snapatac2_preprocessing/snapatac2_preprocessing/2.6.4+galaxy1 |  |
| 28 | Filter | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_filter/scanpy_filter/1.9.6+galaxy3 |  |
| 29 | Normalize | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_normalize/scanpy_normalize/1.9.6+galaxy3 |  |
| 30 | Inspect and manipulate | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_inspect/scanpy_inspect/1.9.6+galaxy4 |  |
| 31 | Normalize | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_normalize/scanpy_normalize/1.9.6+galaxy3 |  |
| 32 | AnnData Operations | toolshed.g2.bx.psu.edu/repos/ebi-gxa/anndata_ops/anndata_ops/1.9.3+galaxy0 | This step only copies 'obsm' annotations. Other annotations can also be copied with this tool. |
| 33 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.9.6+galaxy3 |  |
| 34 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.3+galaxy0 |  |
| 35 | Cut | Cut1 |  |
| 36 | Replace column | toolshed.g2.bx.psu.edu/repos/bgruening/replace_column_by_key_value_file/replace_column_with_key_value_file/0.2 |  |
| 37 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.3+galaxy0 | Add cell type annotations to the AnnData object |
| 38 | Plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.9.6+galaxy3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 12 | plot frag_size | out_png |
| 13 | plot log frag_size | out_png |
| 14 | anndata tsse | anndata_out |
| 15 | anndata | anndata_out |
| 16 | plot tsse | out_png |
| 17 | anndata filter cells | anndata_out |
| 18 | anndata tile matrix | anndata_out |
| 19 | anndata select features | anndata_out |
| 20 | anndata scrublet | anndata_out |
| 21 | anndata filter doublets | anndata_out |
| 22 | anndata spectral | anndata_out |
| 23 | anndata umap | anndata_out |
| 24 | anndata knn | anndata_out |
| 25 | anndata_leiden_clustering | anndata_out |
| 26 | umap_leiden-clusters | out_png |
| 27 | anndata gene matrix | anndata_out |
| 28 | anndata filter genes | anndata_out |
| 29 | anndata normalize | anndata_out |
| 30 | anndata log1p | anndata_out |
| 31 | anndata_magic | anndata_out |
| 32 | anndata_gene-matrix_leiden | output_h5ad |
| 33 | umap_marker-genes | out_png |
| 35 | leiden annotation | out_file1 |
| 36 | cell type annotation | outfile_replace |
| 37 | anndata_cell_type | anndata |
| 38 | umap_cell-type | out_png |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Standard_processing_of_single_cell_ATAC-seq_data_with_SnapATAC2.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Standard_processing_of_single_cell_ATAC-seq_data_with_SnapATAC2.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Standard_processing_of_single_cell_ATAC-seq_data_with_SnapATAC2.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Standard_processing_of_single_cell_ATAC-seq_data_with_SnapATAC2.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Standard_processing_of_single_cell_ATAC-seq_data_with_SnapATAC2.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Standard_processing_of_single_cell_ATAC-seq_data_with_SnapATAC2.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
