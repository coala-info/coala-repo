---
name: preprocessing-and-clustering-of-single-cell-rna-seq-data-wit
description: This workflow processes single-cell RNA-seq count matrices, barcodes, and gene features using Scanpy and AnnData to perform quality control, normalization, dimensionality reduction, and Louvain clustering. Use this skill when you need to identify distinct cell populations, detect cluster-specific marker genes, and generate comprehensive visualizations like UMAPs and dot plots from raw single-cell expression data.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# preprocessing-and-clustering-of-single-cell-rna-seq-data-wit

## Overview

This Galaxy workflow provides a comprehensive pipeline for the preprocessing, quality control, and clustering of single-cell RNA-seq (scRNA-seq) data using [Scanpy](https://scanpy.readthedocs.io/) and the [AnnData](https://anndata.readthedocs.io/) format. It is modeled after the classic [3k PBMC clustering tutorial](https://scanpy.readthedocs.io/en/stable/tutorials/basics/clustering-2017.html) and is compatible with the [Galaxy Training Network material](https://training.galaxyproject.org/training-material/topics/single-cell/tutorials/scrna-scanpy-pbmc3k/tutorial.html).

The process begins by importing a count matrix, barcodes, and gene/feature files to create an AnnData object. It performs essential quality control by filtering cells based on gene expression counts and mitochondrial content. Following QC, the data is normalized and scaled, and highly variable genes are identified to focus the analysis on the most informative features.

Dimensionality reduction is handled via Principal Component Analysis (PCA), followed by the construction of a neighborhood graph to enable clustering through the Louvain algorithm. The workflow generates UMAP embeddings for visualization and identifies cluster-specific marker genes using the Wilcoxon rank-sum test. Users can optionally provide manual cell-type annotations to label the resulting clusters.

The workflow produces a variety of diagnostic and analytical outputs, including QC violin plots, PCA elbow plots, and UMAP visualizations. Final results include the annotated AnnData object and several gene expression plots—such as dot plots, heatmaps, and stacked violin plots—to characterize the identified cell populations.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Minimum number of cells expressed | parameter_input | use a small number. Generally 3-5. If not set, a default of 3 is used. |
| 1 | Barcodes | data_input | A cell barcodes file with a single barcode in each line. The barcodes should correspond to the cells in the matrix file |
| 2 | Genes | data_input | A genes/features tabular file with gene ids and gene symbols |
| 3 | Matrix | data_input | A single-cell count matrix file in Matrix Market Exchange format |
| 4 | Input is from Cell Ranger v2 or earlier versions | parameter_input | v2 genes.tsv file contains two columns with Gene ID and Gene Name. v3 features.tsv file contains three columns Feature ID, Feature Name, Feature Type |
| 5 | Mitochondrial genes start with pattern | parameter_input | For eg MT- or M- |
| 6 | Minimum number of genes expressed | parameter_input | Minimum number of genes expressed per cell. If not set, a default of 200 is used. |
| 7 | Maximum number of genes expressed | parameter_input | Maximum number of genes expressed per cell. If not set, a default of 2500 is used. |
| 8 | Number of neighbours for computing neighborhood graph | parameter_input | Size of the local neighborhood. If not set a default of 15 is used. |
| 9 | Number of PCs to use for computing neighborhood graph | parameter_input | This parameter can be estimated from an Elbow plot of PC loadings. |
| 10 | Louvain resolution | parameter_input | Louvain clustering resolution. Higher resolution means finding more and smaller clusters. If not set, a default value of 1.0 is used. |
| 11 | Manually annotate celltypes? | parameter_input | You must have run the workflow at least once, to know the number of clusters and the cell types inferred. |
| 12 | Annotate louvain clusters with these cell types | parameter_input | Provide a comma-separated list of cell types to annotate the louvain clusters. |


To run this workflow, ensure you have the three required Matrix Market files: the count matrix (.mtx), barcodes (.tsv), and genes/features (.tsv) uploaded as individual datasets. Note that the genes file format differs between Cell Ranger v2 (two columns) and v3 (three columns), so verify your input matches the expected structure. It is critical to adjust the mitochondrial gene pattern and filtering thresholds to suit your specific organism and data quality. Please consult the README.md for comprehensive details on column requirements and parameter configurations for the Louvain algorithm. You may also use `planemo workflow_job_init` to create a `job.yml` file for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 13 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 14 | Import Anndata | toolshed.g2.bx.psu.edu/repos/iuc/anndata_import/anndata_import/0.10.9+galaxy0 |  |
| 15 | Map parameter value | toolshed.g2.bx.psu.edu/repos/iuc/map_param_value/map_param_value/0.2.0 |  |
| 16 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 17 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 18 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 19 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 20 | Import Anndata | toolshed.g2.bx.psu.edu/repos/iuc/anndata_import/anndata_import/0.10.9+galaxy0 |  |
| 21 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 22 | Scanpy filter | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_filter/scanpy_filter/1.10.2+galaxy0 |  |
| 23 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.9+galaxy0 |  |
| 24 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.9+galaxy0 |  |
| 25 | Scanpy Inspect and manipulate | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_inspect/scanpy_inspect/1.10.2+galaxy1 |  |
| 26 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy0 |  |
| 27 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy0 |  |
| 28 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy0 |  |
| 29 | Scanpy filter | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_filter/scanpy_filter/1.10.2+galaxy0 |  |
| 30 | Scanpy filter | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_filter/scanpy_filter/1.10.2+galaxy0 |  |
| 31 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.9+galaxy0 |  |
| 32 | Scanpy normalize | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_normalize/scanpy_normalize/1.10.2+galaxy0 |  |
| 33 | Scanpy Inspect and manipulate | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_inspect/scanpy_inspect/1.10.2+galaxy1 |  |
| 34 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.9+galaxy0 |  |
| 35 | Scanpy filter | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_filter/scanpy_filter/1.10.2+galaxy0 |  |
| 36 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.9+galaxy0 |  |
| 37 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy0 |  |
| 38 | Scanpy remove confounders | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_remove_confounders/scanpy_remove_confounders/1.10.2+galaxy0 |  |
| 39 | Scanpy Inspect and manipulate | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_inspect/scanpy_inspect/1.10.2+galaxy1 |  |
| 40 | Scanpy cluster, embed | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_cluster_reduce_dimension/scanpy_cluster_reduce_dimension/1.10.2+galaxy0 |  |
| 41 | Scanpy Inspect and manipulate | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_inspect/scanpy_inspect/1.10.2+galaxy1 |  |
| 42 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy0 |  |
| 43 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy0 |  |
| 44 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy0 |  |
| 45 | Scanpy cluster, embed | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_cluster_reduce_dimension/scanpy_cluster_reduce_dimension/1.10.2+galaxy0 |  |
| 46 | Scanpy cluster, embed | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_cluster_reduce_dimension/scanpy_cluster_reduce_dimension/1.10.2+galaxy0 | Higher resolution means finding more and smaller clusters. |
| 47 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy0 |  |
| 48 | Scanpy Inspect and manipulate | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_inspect/scanpy_inspect/1.10.2+galaxy1 |  |
| 49 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.9+galaxy0 |  |
| 50 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.9+galaxy0 | Here I inspected the louviain clusters... |
| 51 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy0 |  |
| 52 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.9+galaxy0 |  |
| 53 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.9+galaxy0 |  |
| 54 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.3+galaxy1 |  |
| 55 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.3+galaxy1 |  |
| 56 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.3+galaxy1 |  |
| 57 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.8+galaxy0 |  |
| 58 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 59 | Parse parameter value | param_value_from_file |  |
| 60 | Parse parameter value | param_value_from_file |  |
| 61 | Parse parameter value | param_value_from_file |  |
| 62 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy0 |  |
| 63 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy0 |  |
| 64 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy0 |  |
| 65 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy0 |  |
| 66 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy0 |  |
| 67 | Scanpy plot | toolshed.g2.bx.psu.edu/repos/iuc/scanpy_plot/scanpy_plot/1.10.2+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 23 | Initial Anndata General Info | general |
| 26 | Scatter plot of n_genes vs pct_mito | out_png |
| 27 | Scatter plot of plot n_counts vs n_genes | out_png |
| 28 | Violin plot n_genes, n_counts, pct_mito | out_png |
| 34 | Anndata with raw attribute | anndata |
| 37 | Plot highly variable | out_png |
| 42 | Plot genes according to contributions to PCs | out_png |
| 43 | Plot PCA over view with genes | out_png |
| 44 | Elbow plot of PCs and variance | out_png |
| 47 | UMAP of louvain | out_png |
| 49 | Ranked genes with Wilcoxon test | uns_rank_genes_groups_names |
| 51 | Plot Rank gene groups | out_png |
| 52 | Anndata with Celltype Annotation | anndata |
| 53 | General information about the final Anndata object | general |
| 57 | Number of cells per cluster | out_file |
| 62 | UMAP with annotated cell types | out_png |
| 63 | Violin plot of top genes on clusters | out_png |
| 64 | Stacked violin of top genes on clusters | out_png |
| 65 | Dotplot of top genes on clusters | out_png |
| 66 | Heatmap of top 20 highly ranked genes | out_png |
| 67 | UMAP of louvain and top ranked genes | out_png |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Preprocessing-and-Clustering-of-single-cell-RNA-seq-data-with-Scanpy.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Preprocessing-and-Clustering-of-single-cell-RNA-seq-data-with-Scanpy.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Preprocessing-and-Clustering-of-single-cell-RNA-seq-data-with-Scanpy.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Preprocessing-and-Clustering-of-single-cell-RNA-seq-data-with-Scanpy.ga -o job.yml`
- Lint: `planemo workflow_lint Preprocessing-and-Clustering-of-single-cell-RNA-seq-data-with-Scanpy.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Preprocessing-and-Clustering-of-single-cell-RNA-seq-data-with-Scanpy.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)