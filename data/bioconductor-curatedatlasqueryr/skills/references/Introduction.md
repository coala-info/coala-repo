# CuratedAtlasQueryR

[![Lifecycle:maturing](data:image/svg+xml;charset=utf-8;base64...)](https://www.tidyverse.org/lifecycle/#maturing)

`CuratedAtlasQuery` is a query interface that allow the programmatic exploration and retrieval of the harmonised, curated and reannotated CELLxGENE single-cell human cell atlas. Data can be retrieved at cell, sample, or dataset levels based on filtering criteria.

Harmonised data is stored in the ARDC Nectar Research Cloud, and most `CuratedAtlasQuery` functions interact with Nectar via web requests, so a network connection is required for most functionality.

![](data:image/png;base64...)

![](data:image/jpeg;base64...)![](data:image/png;base64...)![](data:image/jpeg;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

# Query interface

## Installation

```
devtools::install_github("stemangiola/CuratedAtlasQueryR")
```

## Load the package

```
library(CuratedAtlasQueryR)
```

## Load and explore the metadata

### Load the metadata

```
# Note: in real applications you should use the default value of remote_url
metadata <- get_metadata(remote_url = METADATA_URL)
metadata
#> # Source:   SQL [?? x 56]
#> # Database: DuckDB 1.4.1 [biocbuild@Linux 6.8.0-79-generic:R 4.5.1/:memory:]
#>    cell_               sample_   cell_type cell_type_harmonised confidence_class
#>    <chr>               <chr>     <chr>     <chr>                           <dbl>
#>  1 TTATGCTAGGGTGTTG_12 039c558c… mature N… immune_unclassified                 5
#>  2 GCTTGAACATGGTCTA_12 039c558c… mature N… cd8 tem                             3
#>  3 GTCATTTGTGCACCAC_12 039c558c… mature N… immune_unclassified                 5
#>  4 AAGGAGCGTATTCTCT_12 039c558c… mature N… immune_unclassified                 5
#>  5 ATTGGACTCCGTACAA_12 039c558c… mature N… immune_unclassified                 5
#>  6 CTCGTCAAGTACGTTC_12 039c558c… mature N… immune_unclassified                 5
#>  7 CGTCTACTCTCTAAGG_11 07e64957… mature N… immune_unclassified                 5
#>  8 ACGATCAAGGTGGTTG_15 17640030… mature N… immune_unclassified                 5
#>  9 TCATACTTCCGCACGA_15 17640030… mature N… immune_unclassified                 5
#> 10 GAGACCCTCCCTTCCC_15 17640030… mature N… immune_unclassified                 5
#> # ℹ more rows
#> # ℹ 51 more variables: cell_annotation_azimuth_l2 <chr>,
#> #   cell_annotation_blueprint_singler <chr>,
#> #   cell_annotation_monaco_singler <chr>, sample_id_db <chr>,
#> #   `_sample_name` <chr>, assay <chr>, assay_ontology_term_id <chr>,
#> #   file_id_db <chr>, cell_type_ontology_term_id <chr>,
#> #   development_stage <chr>, development_stage_ontology_term_id <chr>, …
```

The `metadata` variable can then be re-used for all subsequent queries.

### Explore the tissue

```
metadata |>
    dplyr::distinct(tissue, file_id)
#> # Source:   SQL [?? x 2]
#> # Database: DuckDB 1.4.1 [biocbuild@Linux 6.8.0-79-generic:R 4.5.1/:memory:]
#>    tissue          file_id
#>    <chr>           <chr>
#>  1 blood           60ba353d-236a-4b91-a0a2-a74669c2b55e
#>  2 blood           4c6bf6de-f200-446c-add6-80cf605c0315
#>  3 lung parenchyma 874eca21-bac1-48e1-96d9-53a24f7ebf20
#>  4 kidney          c790ef7a-1523-4627-8603-d6a02f8f4877
#>  5 renal pelvis    f7e94dbb-8638-4616-aaf9-16e2212c369f
#>  6 blood           5500774a-6ebe-4ddf-adce-90302b7cd007
#>  7 axilla          56ed3d2a-a8cf-4c60-a184-f4e3e4af5176
#>  8 blood           a0396bf6-cd6d-42d9-b1b5-c66b19d312ae
#>  9 renal pelvis    63523aa3-0d04-4fc6-ac59-5cadd3e73a14
#> 10 caecum          59dfc135-19c1-4380-a9e8-958908273756
#> # ℹ more rows
```

## Download single-cell RNA sequencing counts

### Query raw counts

```
single_cell_counts =
    metadata |>
    dplyr::filter(
        ethnicity == "African" &
        stringr::str_like(assay, "%10x%") &
        tissue == "lung parenchyma" &
        stringr::str_like(cell_type, "%CD4%")
    ) |>
    get_single_cell_experiment()
#> ℹ Realising metadata.
#> ℹ Synchronising files
#> ℹ Downloading 0 files, totalling 0 GB
#> ℹ Reading files.
#> ℹ Compiling Single Cell Experiment.

single_cell_counts
#> class: SingleCellExperiment
#> dim: 36229 1571
#> metadata(0):
#> assays(1): counts
#> rownames(36229): A1BG A1BG-AS1 ... ZZEF1 ZZZ3
#> rowData names(0):
#> colnames(1571): ACACCAAAGCCACCTG_SC18_1 TCAGCTCCAGACAAGC_SC18_1 ...
#>   CAGCATAAGCTAACAA_F02607_1 AAGGAGCGTATAATGG_F02607_1
#> colData names(56): sample_ cell_type ... updated_at_y original_cell_id
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
```

### Query counts scaled per million

This is helpful if just few genes are of interest, as they can be compared across samples.

```
single_cell_counts =
    metadata |>
    dplyr::filter(
        ethnicity == "African" &
        stringr::str_like(assay, "%10x%") &
        tissue == "lung parenchyma" &
        stringr::str_like(cell_type, "%CD4%")
    ) |>
    get_single_cell_experiment(assays = "cpm")
#> ℹ Realising metadata.
#> ℹ Synchronising files
#> ℹ Downloading 0 files, totalling 0 GB
#> ℹ Reading files.
#> ℹ Compiling Single Cell Experiment.

single_cell_counts
#> class: SingleCellExperiment
#> dim: 36229 1571
#> metadata(0):
#> assays(1): cpm
#> rownames(36229): A1BG A1BG-AS1 ... ZZEF1 ZZZ3
#> rowData names(0):
#> colnames(1571): ACACCAAAGCCACCTG_SC18_1 TCAGCTCCAGACAAGC_SC18_1 ...
#>   CAGCATAAGCTAACAA_F02607_1 AAGGAGCGTATAATGG_F02607_1
#> colData names(56): sample_ cell_type ... updated_at_y original_cell_id
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
```

### Extract only a subset of genes

```
single_cell_counts =
    metadata |>
    dplyr::filter(
        ethnicity == "African" &
        stringr::str_like(assay, "%10x%") &
        tissue == "lung parenchyma" &
        stringr::str_like(cell_type, "%CD4%")
    ) |>
    get_single_cell_experiment(assays = "cpm", features = "PUM1")
#> ℹ Realising metadata.
#> ℹ Synchronising files
#> ℹ Downloading 0 files, totalling 0 GB
#> ℹ Reading files.
#> ℹ Compiling Single Cell Experiment.

single_cell_counts
#> class: SingleCellExperiment
#> dim: 1 1571
#> metadata(0):
#> assays(1): cpm
#> rownames(1): PUM1
#> rowData names(0):
#> colnames(1571): ACACCAAAGCCACCTG_SC18_1 TCAGCTCCAGACAAGC_SC18_1 ...
#>   CAGCATAAGCTAACAA_F02607_1 AAGGAGCGTATAATGG_F02607_1
#> colData names(56): sample_ cell_type ... updated_at_y original_cell_id
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
```

### Extract the counts as a Seurat object

This convert the H5 SingleCellExperiment to Seurat so it might take long time and occupy a lot of memory depending on how many cells you are requesting.

```
single_cell_counts_seurat =
    metadata |>
    dplyr::filter(
        ethnicity == "African" &
        stringr::str_like(assay, "%10x%") &
        tissue == "lung parenchyma" &
        stringr::str_like(cell_type, "%CD4%")
    ) |>
    get_seurat()
#> ℹ Realising metadata.
#> ℹ Synchronising files
#> ℹ Downloading 0 files, totalling 0 GB
#> ℹ Reading files.
#> ℹ Compiling Single Cell Experiment.
#> Warning: `FilterObjects()` was deprecated in SeuratObject 5.0.0.
#> ℹ Please use `.FilterObjects()` instead.
#> ℹ The deprecated feature was likely used in the SeuratObject package.
#>   Please report the issue at
#>   <https://github.com/satijalab/seurat-object/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.

single_cell_counts_seurat
#> An object of class Seurat
#> 36229 features across 1571 samples within 1 assay
#> Active assay: originalexp (36229 features, 0 variable features)
#>  2 layers present: counts, data
```

## Save your `SingleCellExperiment`

The returned `SingleCellExperiment` can be saved with two modalities, as `.rds` or as `HDF5`.

### Saving as RDS (fast saving, slow reading)

Saving as `.rds` has the advantage of being fast, andd the `.rds` file occupies very little disk space as it only stores the links to the files in your cache.

However it has the disadvantage that for big `SingleCellExperiment` objects, which merge a lot of HDF5 from your `get_single_cell_experiment`, the display and manipulation is going to be slow. In addition, an `.rds` saved in this way is not portable: you will not be able to share it with other users.

```
single_cell_counts |> saveRDS("single_cell_counts.rds")
```

### Saving as HDF5 (slow saving, fast reading)

Saving as `.hdf5` executes any computation on the `SingleCellExperiment` and writes it to disk as a monolithic `HDF5`. Once this is done, operations on the `SingleCellExperiment` will be comparatively very fast. The resulting `.hdf5` file will also be totally portable and sharable.

However this `.hdf5` has the disadvantage of being larger than the corresponding `.rds` as it includes a copy of the count information, and the saving process is going to be slow for large objects.

```
single_cell_counts |> HDF5Array::saveHDF5SummarizedExperiment("single_cell_counts", replace = TRUE)
```

## Visualise gene transcription

We can gather all CD14 monocytes cells and plot the distribution of HLA-A across all tissues

```
suppressPackageStartupMessages({
    library(ggplot2)
})

# Plots with styling
counts <- metadata |>
  # Filter and subset
  dplyr::filter(cell_type_harmonised == "cd14 mono") |>
  dplyr::filter(file_id_db != "c5a05f23f9784a3be3bfa651198a48eb") |>

  # Get counts per million for HCA-A gene
  get_single_cell_experiment(assays = "cpm", features = "HLA-A") |>
  suppressMessages() |>

  # Add feature to table
  tidySingleCellExperiment::join_features("HLA-A", shape = "wide") |>

  # Rank x axis
  tibble::as_tibble()

# Plot by disease
counts |>
  dplyr::with_groups(disease, ~ .x |> dplyr::mutate(median_count = median(`HLA.A`, rm.na=TRUE))) |>

  # Plot
  ggplot(aes(forcats::fct_reorder(disease, median_count,.desc = TRUE), `HLA.A`,color = file_id)) +
  geom_jitter(shape=".") +

  # Style
  guides(color="none") +
  scale_y_log10() +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 60, vjust = 1, hjust = 1)) +
  xlab("Disease") +
  ggtitle("HLA-A in CD14 monocytes by disease")
#> Warning in scale_y_log10(): log-10 transformation introduced infinite values.
```

![](data:image/png;base64...)

![](data:image/png;base64...)

```
# Plot by tissue
counts |>
  dplyr::with_groups(tissue_harmonised, ~ .x |> dplyr::mutate(median_count = median(`HLA.A`, rm.na=TRUE))) |>

  # Plot
  ggplot(aes(forcats::fct_reorder(tissue_harmonised, median_count,.desc = TRUE), `HLA.A`,color = file_id)) +
  geom_jitter(shape=".") +

  # Style
  guides(color="none") +
  scale_y_log10() +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 60, vjust = 1, hjust = 1)) +
  xlab("Tissue") +
  ggtitle("HLA-A in CD14 monocytes by tissue") +
  theme(legend.position = "none")
#> Warning in scale_y_log10(): log-10 transformation introduced infinite values.
```

![](data:image/png;base64...) ![](data:image/png;base64...)

```
metadata |>

  # Filter and subset
  dplyr::filter(cell_type_harmonised=="nk") |>

  # Get counts per million for HCA-A gene
  get_single_cell_experiment(assays = "cpm", features = "HLA-A") |>
  suppressMessages() |>

  # Plot
  tidySingleCellExperiment::join_features("HLA-A", shape = "wide") |>
  ggplot(aes(tissue_harmonised, `HLA.A`, color = file_id)) +
  theme_bw() +
  theme(
      axis.text.x = element_text(angle = 60, vjust = 1, hjust = 1),
      legend.position = "none"
  ) +
  geom_jitter(shape=".") +
  xlab("Tissue") +
  ggtitle("HLA-A in nk cells by tissue")
```

![](data:image/png;base64...)

## Obtain Unharmonised Metadata

Various metadata fields are *not* common between datasets, so it does not make sense for these to live in the main metadata table. However, we can obtain it using the `get_unharmonised_metadata()` function. This function returns a data frame with one row per dataset, including the `unharmonised` column which contains unharmnised metadata as a nested data frame.

```
harmonised <- metadata |> dplyr::filter(tissue == "kidney blood vessel")
unharmonised <- get_unharmonised_metadata(harmonised)
unharmonised
#> # A tibble: 4 × 2
#>   file_id                              unharmonised
#>   <chr>                                <list>
#> 1 63523aa3-0d04-4fc6-ac59-5cadd3e73a14 <tbl_dck_[,17]>
#> 2 8fee7b82-178b-4c04-bf23-04689415690d <tbl_dck_[,12]>
#> 3 dc9d8cdd-29ee-4c44-830c-6559cb3d0af6 <tbl_dck_[,14]>
#> 4 f7e94dbb-8638-4616-aaf9-16e2212c369f <tbl_dck_[,14]>
```

Notice that the columns differ between each dataset’s data frame:

```
dplyr::pull(unharmonised) |> head(2)
#> [[1]]
#> # Source:   SQL [?? x 17]
#> # Database: DuckDB 1.4.1 [biocbuild@Linux 6.8.0-79-generic:R 4.5.1/:memory:]
#>    cell_        file_id donor_age donor_uuid library_uuid mapped_reference_ann…¹
#>    <chr>        <chr>   <chr>     <chr>      <chr>        <chr>
#>  1 4602STDY701… 63523a… 27 months a8536b6a-… 5ddaeac7-0f… GENCODE 24
#>  2 4602STDY701… 63523a… 27 months a8536b6a-… 5ddaeac7-0f… GENCODE 24
#>  3 4602STDY701… 63523a… 27 months a8536b6a-… 5ddaeac7-0f… GENCODE 24
#>  4 4602STDY701… 63523a… 27 months a8536b6a-… 5ddaeac7-0f… GENCODE 24
#>  5 4602STDY701… 63523a… 27 months a8536b6a-… 5ddaeac7-0f… GENCODE 24
#>  6 4602STDY701… 63523a… 27 months a8536b6a-… 5ddaeac7-0f… GENCODE 24
#>  7 4602STDY701… 63523a… 27 months a8536b6a-… 5ddaeac7-0f… GENCODE 24
#>  8 4602STDY701… 63523a… 27 months a8536b6a-… 5ddaeac7-0f… GENCODE 24
#>  9 4602STDY709… 63523a… 19 months 46318131-… 67178571-39… GENCODE 24
#> 10 4602STDY701… 63523a… 27 months a8536b6a-… 5ddaeac7-0f… GENCODE 24
#> # ℹ more rows
#> # ℹ abbreviated name: ¹​mapped_reference_annotation
#> # ℹ 11 more variables: sample_uuid <chr>, suspension_type <chr>,
#> #   suspension_uuid <chr>, author_cell_type <chr>, cell_state <chr>,
#> #   reported_diseases <chr>, Short_Sample <chr>, Project <chr>,
#> #   Experiment <chr>, compartment <chr>, broad_celltype <chr>
#>
#> [[2]]
#> # Source:   SQL [?? x 12]
#> # Database: DuckDB 1.4.1 [biocbuild@Linux 6.8.0-79-generic:R 4.5.1/:memory:]
#>    cell_ file_id      orig.ident nCount_RNA nFeature_RNA seurat_clusters Project
#>    <chr> <chr>        <chr>           <dbl> <chr>        <chr>           <chr>
#>  1 1069  8fee7b82-17… 4602STDY7…      16082 3997         25              Experi…
#>  2 1214  8fee7b82-17… 4602STDY7…       1037 606          25              Experi…
#>  3 2583  8fee7b82-17… 4602STDY7…       3028 1361         25              Experi…
#>  4 2655  8fee7b82-17… 4602STDY7…       1605 859          25              Experi…
#>  5 3609  8fee7b82-17… 4602STDY7…       1144 682          25              Experi…
#>  6 3624  8fee7b82-17… 4602STDY7…       1874 963          25              Experi…
#>  7 3946  8fee7b82-17… 4602STDY7…       1296 755          25              Experi…
#>  8 5163  8fee7b82-17… 4602STDY7…      11417 3255         25              Experi…
#>  9 5446  8fee7b82-17… 4602STDY7…       1769 946          19              Experi…
#> 10 6275  8fee7b82-17… 4602STDY7…       3750 1559         25              Experi…
#> # ℹ more rows
#> # ℹ 5 more variables: donor_id <chr>, compartment <chr>, broad_celltype <chr>,
#> #   author_cell_type <chr>, Sample <chr>
```

# Cell metadata

Dataset-specific columns (definitions available at cellxgene.cziscience.com)

`cell_count`, `collection_id`, `created_at.x`, `created_at.y`, `dataset_deployments`, `dataset_id`, `file_id`, `filename`, `filetype`, `is_primary_data.y`, `is_valid`, `linked_genesets`, `mean_genes_per_cell`, `name`, `published`, `published_at`, `revised_at`, `revision`, `s3_uri`, `schema_version`, `tombstone`, `updated_at.x`, `updated_at.y`, `user_submitted`, `x_normalization`

Sample-specific columns (definitions available at cellxgene.cziscience.com)

`sample_`, `sample_name`, `age_days`, `assay`, `assay_ontology_term_id`, `development_stage`, `development_stage_ontology_term_id`, `ethnicity`, `ethnicity_ontology_term_id`, `experiment___`, `organism`, `organism_ontology_term_id`, `sample_placeholder`, `sex`, `sex_ontology_term_id`, `tissue`, `tissue_harmonised`, `tissue_ontology_term_id`, `disease`, `disease_ontology_term_id`, `is_primary_data.x`

Cell-specific columns (definitions available at cellxgene.cziscience.com)

`cell_`, `cell_type`, `cell_type_ontology_term_idm`, `cell_type_harmonised`, `confidence_class`, `cell_annotation_azimuth_l2`, `cell_annotation_blueprint_singler`

Through harmonisation and curation we introduced custom column, not present in the original CELLxGENE metadata

* `tissue_harmonised`: a coarser tissue name for better filtering
* `age_days`: the number of days corresponding to the age
* `cell_type_harmonised`: the consensus call identity (for immune cells) using the original and three novel annotations using Seurat Azimuth and SingleR
* `confidence_class`: an ordinal class of how confident `cell_type_harmonised` is. 1 is complete consensus, 2 is 3 out of four and so on.
* `cell_annotation_azimuth_l2`: Azimuth cell annotation
* `cell_annotation_blueprint_singler`: SingleR cell annotation using Blueprint reference
* `cell_annotation_blueprint_monaco`: SingleR cell annotation using Monaco reference
* `sample_id_db`: Sample subdivision for internal use
* `file_id_db`: File subdivision for internal use
* `sample_`: Sample ID
* `.sample_name`: How samples were defined

# RNA abundance

The `raw` assay includes RNA abundance in the positive real scale (not transformed with non-linear functions, e.g. log sqrt). Originally CELLxGENE include a mix of scales and transformations specified in the `x_normalization` column.

The `cpm` assay includes counts per million.

# Session Info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] ggplot2_4.0.0            CuratedAtlasQueryR_1.8.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3              jsonlite_2.0.0
#>   [3] magrittr_2.0.4                  spatstat.utils_3.2-0
#>   [5] farver_2.1.2                    rmarkdown_2.30
#>   [7] vctrs_0.6.5                     ROCR_1.0-11
#>   [9] spatstat.explore_3.5-3          forcats_1.0.1
#>  [11] htmltools_0.5.8.1               S4Arrays_1.10.0
#>  [13] ttservice_0.5.3                 Rhdf5lib_1.32.0
#>  [15] SparseArray_1.10.0              rhdf5_2.54.0
#>  [17] sass_0.4.10                     sctransform_0.4.2
#>  [19] parallelly_1.45.1               KernSmooth_2.23-26
#>  [21] bslib_0.9.0                     htmlwidgets_1.6.4
#>  [23] ica_1.0-3                       plyr_1.8.9
#>  [25] plotly_4.11.0                   zoo_1.8-14
#>  [27] cachem_1.1.0                    igraph_2.2.1
#>  [29] mime_0.13                       lifecycle_1.0.4
#>  [31] pkgconfig_2.0.3                 Matrix_1.7-4
#>  [33] R6_2.6.1                        fastmap_1.2.0
#>  [35] MatrixGenerics_1.22.0           fitdistrplus_1.2-4
#>  [37] future_1.67.0                   shiny_1.11.1
#>  [39] digest_0.6.37                   patchwork_1.3.2
#>  [41] S4Vectors_0.48.0                rprojroot_2.1.1
#>  [43] Seurat_5.3.1                    tensor_1.5.1
#>  [45] RSpectra_0.16-2                 irlba_2.3.5.1
#>  [47] GenomicRanges_1.62.0            labeling_0.4.3
#>  [49] progressr_0.17.0                fansi_1.0.6
#>  [51] spatstat.sparse_3.1-0           httr_1.4.7
#>  [53] polyclip_1.10-7                 abind_1.4-8
#>  [55] compiler_4.5.1                  withr_3.0.2
#>  [57] S7_0.2.0                        DBI_1.2.3
#>  [59] fastDummies_1.7.5               HDF5Array_1.38.0
#>  [61] duckdb_1.4.1                    MASS_7.3-65
#>  [63] DelayedArray_0.36.0             tools_4.5.1
#>  [65] lmtest_0.9-40                   otel_0.2.0
#>  [67] httpuv_1.6.16                   future.apply_1.20.0
#>  [69] goftest_1.2-3                   glue_1.8.0
#>  [71] h5mread_1.2.0                   nlme_3.1-168
#>  [73] rhdf5filters_1.22.0             promises_1.4.0
#>  [75] grid_4.5.1                      Rtsne_0.17
#>  [77] cluster_2.1.8.1                 reshape2_1.4.4
#>  [79] generics_0.1.4                  gtable_0.3.6
#>  [81] spatstat.data_3.1-9             tidyr_1.3.1
#>  [83] data.table_1.17.8               utf8_1.2.6
#>  [85] sp_2.2-0                        XVector_0.50.0
#>  [87] BiocGenerics_0.56.0             spatstat.geom_3.6-0
#>  [89] RcppAnnoy_0.0.22                ggrepel_0.9.6
#>  [91] RANN_2.6.2                      pillar_1.11.1
#>  [93] stringr_1.5.2                   spam_2.11-1
#>  [95] RcppHNSW_0.6.0                  later_1.4.4
#>  [97] splines_4.5.1                   dplyr_1.1.4
#>  [99] lattice_0.22-7                  survival_3.8-3
#> [101] deldir_2.0-4                    tidyselect_1.2.1
#> [103] SingleCellExperiment_1.32.0     miniUI_0.1.2
#> [105] pbapply_1.7-4                   knitr_1.50
#> [107] gridExtra_2.3                   Seqinfo_1.0.0
#> [109] IRanges_2.44.0                  SummarizedExperiment_1.40.0
#> [111] scattermore_1.2                 stats4_4.5.1
#> [113] xfun_0.53                       Biobase_2.70.0
#> [115] matrixStats_1.5.0               stringi_1.8.7
#> [117] lazyeval_0.2.2                  yaml_2.3.10
#> [119] evaluate_1.0.5                  codetools_0.2-20
#> [121] tibble_3.3.0                    cli_3.6.5
#> [123] uwot_0.2.3                      xtable_1.8-4
#> [125] reticulate_1.44.0               jquerylib_0.1.4
#> [127] dichromat_2.0-0.1               Rcpp_1.1.0
#> [129] globals_0.18.0                  spatstat.random_3.4-2
#> [131] dbplyr_2.5.1                    png_0.1-8
#> [133] spatstat.univar_3.1-4           parallel_4.5.1
#> [135] ellipsis_0.3.2                  blob_1.2.4
#> [137] assertthat_0.2.1                dotCall64_1.2
#> [139] tidySingleCellExperiment_1.20.0 listenv_0.9.1
#> [141] viridisLite_0.4.2               scales_1.4.0
#> [143] ggridges_0.5.7                  crayon_1.5.3
#> [145] SeuratObject_5.2.0              purrr_1.1.0
#> [147] rlang_1.1.6                     cowplot_1.2.0
```