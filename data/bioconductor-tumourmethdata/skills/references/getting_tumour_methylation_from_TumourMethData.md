# Getting Tumour Methylation Data with TumourMethData

```
library(TumourMethData)
```

## Introduction

DNA methylation is a repressive epigenetic modification involving the addition of methyl groups to DNA and occurs almost exclusively at CpG dinucleotides in mammals. Altered DNA methylation plays a profound role in the development and progression of cancer. However, much of our knowledge of DNA methylation in cancer has been garnered from methylation microarrays which measure methylation at only a small subset (generally <1%) of the almost 30 million CpG sites in humans, mostly those located close to gene promoters. Thus, whole genome bisulfite sequenicng (WGBS) studies in tumours which measure DNA methylation across the entire genome provide an invaluable resource for gaining a comprehensive understanding of DNA methylation changes in cancer, especially at regulatory regions located far from genes.

While packages such as `curatedTCGAData` provide DNA methylation data generated with microarrays for a range of different cancer types,
`TumourMethData` provides a collection of whole genome DNA methylation datasets for several different cancers (primary prostate cancer, prostate cancer metastases, esophageal cancer and rhabdoid tumour at present) as well as matching normal samples where available.

These whole genome methylation datasets are provided as `RangedSummarizedExperiments`, facilitating easy download of the data and extraction of methylation values for regions of interest.

Furthermore, RNA-seq transcripts counts are also provided for several of the datasets, enabling thorough analysis of how DNA methylation is associated with transcription and how this relationship is perturbed in cancer.

## Downloading data

We can view the available datasets with `TumourMethDatasets`.

```
# Show available methylation datasets
data("TumourMethDatasets", package = "TumourMethData")
print(TumourMethDatasets)
#>                dataset_name cancer_type technology genome_build
#> 1           cpgea_wgbs_hg38    prostate       WGBS         hg38
#> 2            tcga_wgbs_hg38     various       WGBS         hg38
#> 3           mcrpc_wgbs_hg38    prostate       WGBS         hg38
#> 4     mcrpc_wgbs_hg38_chr11    prostate       WGBS         hg38
#> 5  cao_esophageal_wgbs_hg19  esophageal       WGBS         hg19
#> 6 target_rhabdoid_wgbs_hg19    rhabdoid       WGBS         hg19
#>   number_tumour_samples number_normal_samples wgbs_coverage_available
#> 1                   187                   187                   FALSE
#> 2                    39                     8                   FALSE
#> 3                   100                     0                    TRUE
#> 4                   100                     0                    TRUE
#> 5                    10                     9                   FALSE
#> 6                    69                     0                   FALSE
#>   dataset_size_gb transcript_counts_available
#> 1           40.00                        TRUE
#> 2            5.40                        TRUE
#> 3           16.00                        TRUE
#> 4            0.76                        TRUE
#> 5            2.00                        TRUE
#> 6            4.50                        TRUE
#>                                                                                                                                                                                                                                                                                                                                                                              notes
#> 1
#> 2
#> 3
#> 4                                                                                                                                                                                                                                                                                                     This dataset is a subset of the data in mcrpc_wgbs_hg38 for example purposes
#> 5
#> 6 Methylation values are not as precise as in other datasets. The original \n    methylation values were integers between 0 and 10 with separate values for the C and G positions of each CpG site.\n    The mean of these values was divided by 10 to produce the methylation values here, \n    with CpG sites missing methylation values for either to C or G given an NA value
#>                                                                                                                              original_publication
#> 1                                                            A genomic and epigenomic atlas of prostate cancer in Asian populations; Nature; 2020
#> 2                                      DNA methylation loss in late-replicating domains is linked to mitotic cell division; Nature genetics; 2018
#> 3                                                                The DNA methylation landscape of advanced prostate cancer; Nature genetics; 2020
#> 4                                                                The DNA methylation landscape of advanced prostate cancer; Nature genetics; 2020
#> 5              Multi-faceted epigenetic dysregulation of gene expression promotes esophageal squamous cell carcinoma; Nature communications; 2020
#> 6 Genome-Wide Profiles of Extra-cranial Malignant Rhabdoid Tumors Reveal Heterogeneity and Dysregulated Developmental Pathways; Cancer Cell; 2016
```

We use `download_meth_dataset` to download the methylation dataset we are interested in using mcrpc\_wgbs\_hg38\_chr11 as an example.

```
# Download esophageal WGBS data
mcrpc_wgbs_hg38_chr11 = download_meth_dataset(dataset = "mcrpc_wgbs_hg38_chr11")
#> see ?TumourMethData and browseVignettes('TumourMethData') for documentation
#> loading from cache
#> require("rhdf5")
print(mcrpc_wgbs_hg38_chr11)
#> class: RangedSummarizedExperiment
#> dim: 1333114 100
#> metadata(5): genome is_h5 ref_CpG chrom_sizes descriptive_stats
#> assays(2): beta cov
#> rownames: NULL
#> rowData names(0):
#> colnames(100): DTB_003 DTB_005 ... DTB_265 DTB_266
#> colData names(4): metastatis_site subtype age sex
```

## SessionInfo

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
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] rhdf5_2.54.0                TumourMethData_1.8.0
#>  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [7] IRanges_2.44.0              S4Vectors_0.48.0
#>  [9] BiocGenerics_0.56.0         generics_0.1.4
#> [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
#>
#> loaded via a namespace (and not attached):
#>  [1] KEGGREST_1.50.0      xfun_0.54            bslib_0.9.0
#>  [4] httr2_1.2.1          lattice_0.22-7       rhdf5filters_1.22.0
#>  [7] vctrs_0.6.5          tools_4.5.1          curl_7.0.0
#> [10] tibble_3.3.0         AnnotationDbi_1.72.0 RSQLite_2.4.3
#> [13] blob_1.2.4           pkgconfig_2.0.3      Matrix_1.7-4
#> [16] dbplyr_2.5.1         lifecycle_1.0.4      compiler_4.5.1
#> [19] Biostrings_2.78.0    htmltools_0.5.8.1    sass_0.4.10
#> [22] yaml_2.3.10          pillar_1.11.1        crayon_1.5.3
#> [25] jquerylib_0.1.4      DelayedArray_0.36.0  cachem_1.1.0
#> [28] abind_1.4-8          ExperimentHub_3.0.0  AnnotationHub_4.0.0
#> [31] tidyselect_1.2.1     digest_0.6.37        purrr_1.1.0
#> [34] dplyr_1.1.4          BiocVersion_3.22.0   fastmap_1.2.0
#> [37] grid_4.5.1           cli_3.6.5            SparseArray_1.10.1
#> [40] magrittr_2.0.4       S4Arrays_1.10.0      h5mread_1.2.0
#> [43] withr_3.0.2          filelock_1.0.3       rappdirs_0.3.3
#> [46] bit64_4.6.0-1        rmarkdown_2.30       XVector_0.50.0
#> [49] httr_1.4.7           bit_4.6.0            png_0.1-8
#> [52] HDF5Array_1.38.0     memoise_2.0.1        evaluate_1.0.5
#> [55] knitr_1.50           BiocFileCache_3.0.0  rlang_1.1.6
#> [58] glue_1.8.0           DBI_1.2.3            BiocManager_1.30.26
#> [61] jsonlite_2.0.0       Rhdf5lib_1.32.0      R6_2.6.1
```