# clustifyrdatahub

Rui Fu

#### 2025-11-04

# 1 clustifyrdatahub

clustifyrdatahub provides external reference data
sets for cell-type assignment with
[clustifyr](https://rnabioco.github.io/clustifyr).

## 1.1 Installation

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("clustifyrdatahub")
```

## 1.2 Available references include

```
knitr::kable(dplyr::select(
  read.csv(system.file("extdata", "metadata.csv", package = "clustifyrdatahub")),
  c(1, 9, 2:7)))
```

| Title | Species | Description | RDataPath | BiocVersion | Genome | SourceType | SourceUrl |
| --- | --- | --- | --- | --- | --- | --- | --- |
| ref\_MCA | Mus musculus | Mouse Cell Atlas | clustifyrdatahub/ref\_MCA.rda | 3.12 | mm10 | Zip | <https://ndownloader.figshare.com/files/10756795> |
| ref\_tabula\_muris\_drop | Mus musculus | Tabula Muris (10X) | clustifyrdatahub/ref\_tabula\_muris\_drop.rda | 3.12 | mm10 | Zip | <https://ndownloader.figshare.com/articles/5821263> |
| ref\_tabula\_muris\_facs | Mus musculus | Tabula Muris (SmartSeq2) | clustifyrdatahub/ref\_tabula\_muris\_facs.rda | 3.12 | mm10 | Zip | <https://ndownloader.figshare.com/articles/5821263> |
| ref\_mouse.rnaseq | Mus musculus | Mouse RNA-seq from 28 cell types | clustifyrdatahub/ref\_mouse.rnaseq.rda | 3.12 | mm10 | RDA | <https://github.com/dviraran/SingleR/tree/master/data> |
| ref\_moca\_main | Mus musculus | Mouse Organogenesis Cell Atlas (main cell types) | clustifyrdatahub/ref\_moca\_main.rda | 3.12 | mm10 | RDA | <https://oncoscape.v3.sttrcancer.org/atlas.gs.washington.edu.mouse.rna/downloads> |
| ref\_immgen | Mus musculus | Mouse sorted immune cells | clustifyrdatahub/ref\_immgen.rda | 3.12 | mm10 | RDA | <https://github.com/dviraran/SingleR/tree/master/data> |
| ref\_hema\_microarray | Homo sapiens | Human hematopoietic cell microarray | clustifyrdatahub/ref\_hema\_microarray.rda | 3.12 | hg38 | TXT | <https://ftp.ncbi.nlm.nih.gov/geo/series/GSE24nnn/GSE24759/matrix/GSE24759_series_matrix.txt.gz> |
| ref\_cortex\_dev | Homo sapiens | Human cortex development scRNA-seq | clustifyrdatahub/ref\_cortex\_dev.rda | 3.12 | hg38 | TSV | <https://cells.ucsc.edu/cortex-dev/exprMatrix.tsv.gz> |
| ref\_pan\_indrop | Homo sapiens | Human pancreatic cell scRNA-seq (inDrop) | clustifyrdatahub/ref\_pan\_indrop.rda | 3.12 | hg38 | RDA | <https://scrnaseq-public-datasets.s3.amazonaws.com/scater-objects/baron-human.rds> |
| ref\_pan\_smartseq2 | Homo sapiens | Human pancreatic cell scRNA-seq (SmartSeq2) | clustifyrdatahub/ref\_pan\_smartseq2.rda | 3.12 | hg38 | RDA | <https://scrnaseq-public-datasets.s3.amazonaws.com/scater-objects/segerstolpe.rds> |
| ref\_mouse\_atlas | Mus musculus | Mouse Atlas scRNA-seq from 321 cell types | clustifyrdatahub/ref\_mouse\_atlas.rda | 3.12 | mm10 | RDA | <https://github.com/rnabioco/scRNA-seq-Cell-Ref-Matrix/blob/master/atlas/musMusculus/MouseAtlas.rda> |

## 1.3 To use `clustifyrdatahub`

```
library(ExperimentHub)
eh <- ExperimentHub()

## query
refs <- query(eh, "clustifyrdatahub")
refs
#> ExperimentHub with 11 records
#> # snapshotDate(): 2025-10-29
#> # $dataprovider: figshare, S3, GitHub, GEO, washington.edu, UCSC
#> # $species: Mus musculus, Homo sapiens
#> # $rdataclass: data.frame
#> # additional mcols(): taxonomyid, genome, description,
#> #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
#> #   rdatapath, sourceurl, sourcetype
#> # retrieve records with, e.g., 'object[["EH3444"]]'
#>
#>            title
#>   EH3444 | ref_MCA
#>   EH3445 | ref_tabula_muris_drop
#>   EH3446 | ref_tabula_muris_facs
#>   EH3447 | ref_mouse.rnaseq
#>   EH3448 | ref_moca_main
#>   ...      ...
#>   EH3450 | ref_hema_microarray
#>   EH3451 | ref_cortex_dev
#>   EH3452 | ref_pan_indrop
#>   EH3453 | ref_pan_smartseq2
#>   EH3779 | ref_mouse_atlas
## either by index or id
ref_hema_microarray <- refs[[7]]         ## load the first resource in the list
ref_hema_microarray <- refs[["EH3450"]]  ## load by EH id

## or list and load
refs <- listResources(eh, "clustifyrdatahub")
ref_hema_microarray <- loadResources(
    eh,
    "clustifyrdatahub",
    "ref_hema_microarray"
    )[[1]]

## use for classification of cell types
res <- clustifyr::clustify(
    input = clustifyr::pbmc_matrix_small,
    metadata = clustifyr::pbmc_meta$classified,
    ref_mat = ref_hema_microarray,
    query_genes = clustifyr::pbmc_vargenes
)
```

```
## or load refs by function name (after loading hub library)
library(clustifyrdatahub)
ref_hema_microarray()[1:5, 1:5]           ## data are loaded
#>        Basophils CD4+ Central Memory CD4+ Effector Memory CD8+ Central Memory
#> DDR1    6.084244            5.967502             5.933039            6.005278
#> RFC2    6.280044            6.028615             6.047005            5.992979
#> HSPA6   6.535444            5.811475             5.746326            5.928349
#> PAX8    6.669153            5.896401             6.118577            6.270870
#> GUCA1A  5.239230            5.232116             5.206960            5.227415
#>        CD8+ Effector Memory
#> DDR1               5.895926
#> RFC2               5.942426
#> HSPA6              5.942670
#> PAX8               6.323922
#> GUCA1A             5.090882
ref_hema_microarray(metadata = TRUE)      ## only metadata
#> ExperimentHub with 1 record
#> # snapshotDate(): 2025-10-29
#> # names(): EH3450
#> # package(): clustifyrdatahub
#> # $dataprovider: GEO
#> # $species: Homo sapiens
#> # $rdataclass: data.frame
#> # $rdatadateadded: 2020-05-14
#> # $title: ref_hema_microarray
#> # $description: Human hematopoietic cell microarray
#> # $taxonomyid: 9606
#> # $genome: hg38
#> # $sourcetype: TXT
#> # $sourceurl: https://ftp.ncbi.nlm.nih.gov/geo/series/GSE24nnn/GSE24759/matr...
#> # $sourcesize: NA
#> # $tags: c("SingleCellData", "SequencingData", "MicroarrayData",
#> #   "ExperimentHub")
#> # retrieve record with 'object[["EH3450"]]'
```

# 2 session info

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
#> [1] clustifyrdatahub_1.20.0 ExperimentHub_3.0.0     AnnotationHub_4.0.0
#> [4] BiocFileCache_3.0.0     dbplyr_2.5.1            BiocGenerics_0.56.0
#> [7] generics_0.1.4          BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1            dplyr_1.1.4
#>  [3] farver_2.1.2                blob_1.2.4
#>  [5] filelock_1.0.3              Biostrings_2.78.0
#>  [7] S7_0.2.0                    fastmap_1.2.0
#>  [9] SingleCellExperiment_1.32.0 digest_0.6.37
#> [11] dotCall64_1.2               lifecycle_1.0.4
#> [13] SeuratObject_5.2.0          KEGGREST_1.50.0
#> [15] RSQLite_2.4.3               magrittr_2.0.4
#> [17] clustifyr_1.22.0            compiler_4.5.1
#> [19] rlang_1.1.6                 sass_0.4.10
#> [21] tools_4.5.1                 yaml_2.3.10
#> [23] data.table_1.17.8           knitr_1.50
#> [25] S4Arrays_1.10.0             bit_4.6.0
#> [27] sp_2.2-0                    curl_7.0.0
#> [29] DelayedArray_0.36.0         RColorBrewer_1.1-3
#> [31] BiocParallel_1.44.0         abind_1.4-8
#> [33] withr_3.0.2                 purrr_1.1.0
#> [35] grid_4.5.1                  stats4_4.5.1
#> [37] future_1.67.0               progressr_0.17.0
#> [39] ggplot2_4.0.0               globals_0.18.0
#> [41] scales_1.4.0                SummarizedExperiment_1.40.0
#> [43] dichromat_2.0-0.1           cli_3.6.5
#> [45] rmarkdown_2.30              crayon_1.5.3
#> [47] future.apply_1.20.0         httr_1.4.7
#> [49] DBI_1.2.3                   cachem_1.1.0
#> [51] parallel_4.5.1              AnnotationDbi_1.72.0
#> [53] BiocManager_1.30.26         XVector_0.50.0
#> [55] matrixStats_1.5.0           vctrs_0.6.5
#> [57] Matrix_1.7-4                jsonlite_2.0.0
#> [59] bookdown_0.45               IRanges_2.44.0
#> [61] S4Vectors_0.48.0            bit64_4.6.0-1
#> [63] listenv_0.10.0              tidyr_1.3.1
#> [65] jquerylib_0.1.4             glue_1.8.0
#> [67] parallelly_1.45.1           spam_2.11-1
#> [69] codetools_0.2-20            cowplot_1.2.0
#> [71] gtable_0.3.6                BiocVersion_3.22.0
#> [73] GenomicRanges_1.62.0        tibble_3.3.0
#> [75] pillar_1.11.1               rappdirs_0.3.3
#> [77] htmltools_0.5.8.1           Seqinfo_1.0.0
#> [79] fgsea_1.36.0                entropy_1.3.2
#> [81] R6_2.6.1                    httr2_1.2.1
#> [83] evaluate_1.0.5              lattice_0.22-7
#> [85] Biobase_2.70.0              png_0.1-8
#> [87] memoise_2.0.1               bslib_0.9.0
#> [89] fastmatch_1.1-6             Rcpp_1.1.0
#> [91] SparseArray_1.10.1          xfun_0.54
#> [93] MatrixGenerics_1.22.0       pkgconfig_2.0.3
```