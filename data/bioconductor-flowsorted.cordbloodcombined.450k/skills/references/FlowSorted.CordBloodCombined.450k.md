# FlowSorted.CordBloodCombined.450k

#### Lucas A Salas

#### 2025-11-04

The FlowSorted.CordBloodCombined.450k package contains data derived from Illumina HumanMethylation450K and Illumina HumanMethylationEPIC DNA methylation microarrays (Gervin K, Salas LA et al. 2018), consisting of 263 blood cell references and 26 umbilical cord blood samples, formatted as an RGChannelSet object for integration and normalization using most of the existing Bioconductor packages. This is more than a combination of the original datasets, the package has a rigorous curation that allows a better usage of the information.

This package contains cleaned data from four different umbilical cord blood references similar to the FlowSorted.CordBlood.450K package consisting of data from umbilical cord blood samples generated from healthy newborns. However, when using the cleaned dataset (eliminating potential cell cross contamination) and using the IDOL procedure compared to minfi estimates the cell type composition obtained through FlowSorted.CordBlood.450k package were less precise and biased compared to actual cell counts. Hence, this package consists of appropriate data for deconvolution of umbilical cord blood samples used in for example EWAS relying in both 450K and EPIC technology.

Researchers may find this package useful as these samples represent different cellular populations ( T lymphocytes (CD4+ and CD8+), B cells (CD19+), monocytes (CD14+), NK cells (CD56+) and Granulocytes of cell sorted umbilical cord blood. The estimates were contrasted versus FACS proportions in 22 samples, and validated using 197 umbilical cord blood samples. These data can be integrated with the minfi Bioconductor package to estimate cellular composition in users’ umbilical cord blood Illumina 450K and EPIC samples using a modified version of the algorithm constrained projection/quadratic programming described in Houseman et al. 2012. However, for more accurate estimations we suggests that the user prefers IDOL over minfi automatic estimations, using the function estimateCellCounts2 from the package FlowSorted.Blood.EPIC which allows using customized sets of probes from IDOL.

**Objects included:**
1. *FlowSorted.CordBloodCombined.450k* is the RGChannelSet object containing the reference library

```
if (memory.limit()>8000){
FlowSorted.CordBloodCombined.450k<-
    libraryDataGet('FlowSorted.CordBloodCombined.450k')
FlowSorted.CordBloodCombined.450k
}
#> class: RGChannelSet
#> dim: 575719 289
#> metadata(0):
#> assays(2): Green Red
#> rownames(575719): 10600322 10600328 ... 74810485 74810492
#> rowData names(0):
#> colnames(289): 3999984027_R02C01 3999984027_R06C01 ...
#>   200705360098_R08C01 200705360110_R03C01
#> colData names(13): Sample_Name Subject.ID ... CellType_original
#>   Reclassified
#> Annotation
#>   array: IlluminaHumanMethylation450k
#>   annotation: ilmn12.hg19
```

The raw dataset is hosted in Bioconductor ExperimentHub

2. *IDOLOptimizedCpGsCordBlood* the IDOL L-DMR library for deconvolution

```
data("IDOLOptimizedCpGsCordBlood")
head(IDOLOptimizedCpGsCordBlood)
```

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
#> [1] parallel  stats4    stats     graphics  grDevices utils     datasets
#> [8] methods   base
#>
#> other attached packages:
#>  [1] FlowSorted.CordBloodCombined.450k_1.26.0
#>  [2] ExperimentHub_3.0.0
#>  [3] AnnotationHub_4.0.0
#>  [4] BiocFileCache_3.0.0
#>  [5] dbplyr_2.5.1
#>  [6] minfi_1.56.0
#>  [7] bumphunter_1.52.0
#>  [8] locfit_1.5-9.12
#>  [9] iterators_1.0.14
#> [10] foreach_1.5.2
#> [11] Biostrings_2.78.0
#> [12] XVector_0.50.0
#> [13] SummarizedExperiment_1.40.0
#> [14] Biobase_2.70.0
#> [15] MatrixGenerics_1.22.0
#> [16] matrixStats_1.5.0
#> [17] GenomicRanges_1.62.0
#> [18] Seqinfo_1.0.0
#> [19] IRanges_2.44.0
#> [20] S4Vectors_0.48.0
#> [21] BiocGenerics_0.56.0
#> [22] generics_0.1.4
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3
#>   [2] jsonlite_2.0.0
#>   [3] magrittr_2.0.4
#>   [4] GenomicFeatures_1.62.0
#>   [5] rmarkdown_2.30
#>   [6] BiocIO_1.20.0
#>   [7] vctrs_0.6.5
#>   [8] multtest_2.66.0
#>   [9] memoise_2.0.1
#>  [10] Rsamtools_2.26.0
#>  [11] DelayedMatrixStats_1.32.0
#>  [12] RCurl_1.98-1.17
#>  [13] askpass_1.2.1
#>  [14] htmltools_0.5.8.1
#>  [15] S4Arrays_1.10.0
#>  [16] curl_7.0.0
#>  [17] Rhdf5lib_1.32.0
#>  [18] SparseArray_1.10.1
#>  [19] rhdf5_2.54.0
#>  [20] sass_0.4.10
#>  [21] nor1mix_1.3-3
#>  [22] bslib_0.9.0
#>  [23] plyr_1.8.9
#>  [24] httr2_1.2.1
#>  [25] cachem_1.1.0
#>  [26] IlluminaHumanMethylation450kanno.ilmn12.hg19_0.6.1
#>  [27] GenomicAlignments_1.46.0
#>  [28] lifecycle_1.0.4
#>  [29] IlluminaHumanMethylationEPICanno.ilm10b4.hg19_0.6.0
#>  [30] pkgconfig_2.0.3
#>  [31] Matrix_1.7-4
#>  [32] R6_2.6.1
#>  [33] fastmap_1.2.0
#>  [34] digest_0.6.37
#>  [35] siggenes_1.84.0
#>  [36] reshape_0.8.10
#>  [37] AnnotationDbi_1.72.0
#>  [38] RSQLite_2.4.3
#>  [39] base64_2.0.2
#>  [40] filelock_1.0.3
#>  [41] httr_1.4.7
#>  [42] abind_1.4-8
#>  [43] compiler_4.5.1
#>  [44] beanplot_1.3.1
#>  [45] rngtools_1.5.2
#>  [46] withr_3.0.2
#>  [47] bit64_4.6.0-1
#>  [48] BiocParallel_1.44.0
#>  [49] DBI_1.2.3
#>  [50] HDF5Array_1.38.0
#>  [51] MASS_7.3-65
#>  [52] openssl_2.3.4
#>  [53] rappdirs_0.3.3
#>  [54] DelayedArray_0.36.0
#>  [55] rjson_0.2.23
#>  [56] tools_4.5.1
#>  [57] rentrez_1.2.4
#>  [58] glue_1.8.0
#>  [59] quadprog_1.5-8
#>  [60] h5mread_1.2.0
#>  [61] restfulr_0.0.16
#>  [62] nlme_3.1-168
#>  [63] rhdf5filters_1.22.0
#>  [64] grid_4.5.1
#>  [65] tzdb_0.5.0
#>  [66] preprocessCore_1.72.0
#>  [67] tidyr_1.3.1
#>  [68] data.table_1.17.8
#>  [69] hms_1.1.4
#>  [70] xml2_1.4.1
#>  [71] BiocVersion_3.22.0
#>  [72] pillar_1.11.1
#>  [73] limma_3.66.0
#>  [74] genefilter_1.92.0
#>  [75] splines_4.5.1
#>  [76] dplyr_1.1.4
#>  [77] lattice_0.22-7
#>  [78] survival_3.8-3
#>  [79] rtracklayer_1.70.0
#>  [80] bit_4.6.0
#>  [81] GEOquery_2.78.0
#>  [82] annotate_1.88.0
#>  [83] tidyselect_1.2.1
#>  [84] knitr_1.50
#>  [85] xfun_0.54
#>  [86] scrime_1.3.5
#>  [87] statmod_1.5.1
#>  [88] yaml_2.3.10
#>  [89] evaluate_1.0.5
#>  [90] codetools_0.2-20
#>  [91] cigarillo_1.0.0
#>  [92] tibble_3.3.0
#>  [93] BiocManager_1.30.26
#>  [94] cli_3.6.5
#>  [95] xtable_1.8-4
#>  [96] jquerylib_0.1.4
#>  [97] Rcpp_1.1.0
#>  [98] png_0.1-8
#>  [99] XML_3.99-0.19
#> [100] readr_2.1.5
#> [101] blob_1.2.4
#> [102] mclust_6.1.2
#> [103] doRNG_1.8.6.2
#> [104] sparseMatrixStats_1.22.0
#> [105] bitops_1.0-9
#> [106] illuminaio_0.52.0
#> [107] purrr_1.1.0
#> [108] crayon_1.5.3
#> [109] rlang_1.1.6
#> [110] KEGGREST_1.50.0
```

**References**

K Gervin, LA Salas et al. (2019) Systematic evaluation and validation of references and library selection methods for deconvolution of cord blood DNA methylation data}. Clin Epigenetics 11,125. doi: [10.1186/s13148-019-0717-y] (<https://dx.doi.org/10.1186/s13148-019-0717-y>).

KM Bakulski, et al. (2016) DNA methylation of cord blood cell types: Applications for mixed cell birth studies. Epigenetics 11:5. doi: [10.1080/15592294.2016.1161875] (<https://dx.doi.org/10.1080/15592294.2016.1161875>).

K Gervin, et al. (2016) Cell type specific DNA methylation in cord blood: A 450K-reference data set and cell count-based validation of estimated cell type composition. Epigenetics 11:690–8. doi: [10.1080/15592294.2016.1214782] (<https://dx.doi.org/10.1080/15592294.2016.1214782>).

OM de Goede, et al. (2015) Nucleated red blood cells impact DNA methylation and expression analyses of cord blood hematopoietic cells. Clin Epigenetics. 7:95. doi: [10.1186/s13148-015-0129-6](https://dx.doi.org/10.1186/s13148-015-0129-6).

X Lin, et al. (2018) Cell type-specific DNA methylation in neonatal cord tissue and cord blood: A 850K-reference panel and comparison of cell-types. Epigenetics. 13:941–58. doi: [10.1080/15592294.2018.1522929] (<https://dx.doi.org/10.1080/15592294.2018.1522929>).

LA Salas et al. (2018). An optimized library for reference-based deconvolution of whole-blood biospecimens assayed using the Illumina HumanMethylationEPIC BeadArray. Genome Biology 19, 64. doi: [10.1186/s13059-018-1448-7](https://dx.doi.org/10.1186/s13059-018-1448-7).

DC Koestler et al. (2016). Improving cell mixture deconvolution by identifying optimal DNA methylation libraries (IDOL). BMC bioinformatics. 17, 120. doi: [10.1186/s12859-016-0943-7](https://dx.doi.org/10.1186/s12859-016-0943-7).

EA Houseman et al. (2012) DNA methylation arrays as surrogate measures of cell mixture distribution. BMC Bioinformatics 13, 86. doi: [10.1186/1471-2105-13-86](https://dx.doi.org/10.1186/1471-2105-13-86).

[minfi](http://bioconductor.org/packages/release/bioc/html/minfi.html) Tools to analyze & visualize Illumina Infinium methylation arrays.