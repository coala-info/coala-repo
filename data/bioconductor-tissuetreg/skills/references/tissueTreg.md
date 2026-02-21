# tissueTreg data package

Charles Imbusch

#### 2025-11-04

# Contents

* [1 TWGBS data](#twgbs-data)
  + [1.1 Per sample](#per-sample)
  + [1.2 Per tissue / cell type](#per-tissue-cell-type)
* [2 RNA-seq data](#rna-seq-data)
  + [2.1 Per sample](#per-sample-1)
* [3 sessionInfo()](#sessioninfo)

# 1 TWGBS data

The DNA methylation data have been stored as rds files and are bsseq objects.
They contain the raw counts for each CpG position in the mm10 reference genome
as well the preprocessed smoothed values for each sample. In addition there is
a second file containing DNA methylation profiles per tissue, e.g. the
replicates from the same tissue have been collapsed. Also here the smoothed
values have been precomputed and are directly available.

## 1.1 Per sample

We first load necessary libraries and data:

```
library(ExperimentHub)
library(bsseq)
```

```
eh <- ExperimentHub()
BS.obj.ex.fit <- eh[["EH1072"]]
#> see ?tissueTreg and browseVignettes('tissueTreg') for documentation
#> loading from cache
```

For example to visually inspect the DNA methylation state of the FoxP3 gene in
the CNS2 region we first specify a single region:

```
regions <- GRanges(
  seqnames = c("X"),
  ranges = IRanges(start = c(7579676),
                   end = c(7595243)
  )
)
```

We can then directly use the plotRegion function from the bsseq package for
visualization based on smoothed values:

```
plotRegion(BS.obj.ex.fit, region=regions[1,], extend = 2000)
```

![](data:image/png;base64...)

We assume that the three sample with higher DNA methylation in CNS2 are the
T conventional samples. To check that visually we can color the samples by
tissue and cell type.

We check the order in the object first:

```
colnames(BS.obj.ex.fit)
#>  [1] "Fat-Treg-R1"     "Fat-Treg-R2"     "Fat-Treg-R3"     "Liver-Treg-R1"
#>  [5] "Liver-Treg-R2"   "Liver-Treg-R3"   "Skin-Treg-R1"    "Skin-Treg-R2"
#>  [9] "Skin-Treg-R3"    "Lymph-N-Tcon-R1" "Lymph-N-Tcon-R2" "Lymph-N-Tcon-R3"
#> [13] "Lymph-N-Treg-R1" "Lymph-N-Treg-R2" "Lymph-N-Treg-R3"
```

And assign the colors:

```
pData <- pData(BS.obj.ex.fit)
pData$col <- rep(c("red", "blue", "green", "yellow", "orange"), rep(3,5))
pData(BS.obj.ex.fit) <- pData
plotRegion(BS.obj.ex.fit, region=regions[1,], extend = 2000)
```

![](data:image/png;base64...)

This plot is confirming our assumption but we don’t have to plot all samples
since they seem to be already consistent. We would now like to do the same
region using smoothed values for each group.

## 1.2 Per tissue / cell type

The smoothed data has already been precomputed and stored in a another rds
file which we first need to load:

```
BS.obj.ex.fit.combined <- eh[["EH1073"]]
#> see ?tissueTreg and browseVignettes('tissueTreg') for documentation
#> loading from cache
```

```
colnames(BS.obj.ex.fit.combined)
#> [1] "Fat-Treg"     "Liver-Treg"   "Lymph-N-Tcon" "Lymph-N-Treg" "Skin-Treg"
```

We now only have the tissue and cell type instead of the replicates. We assign
the same colors:

```
pData <- pData(BS.obj.ex.fit.combined)
pData$col <- c("red", "blue", "yellow", "orange", "green")
pData(BS.obj.ex.fit.combined) <- pData
plotRegion(BS.obj.ex.fit.combined, region=regions[1,], extend = 2000)
```

![](data:image/png;base64...)

# 2 RNA-seq data

## 2.1 Per sample

The RNA-seq experiments are available and as a SummarizedExperiment object.
Two objects are available for usage: RPKM values and htseq counts. We will use
the RPKM values and would like to look up the expression of FoxP3:

We load the SummarizedExperiment object:

```
se_rpkms <- eh[["EH1074"]]
#> see ?tissueTreg and browseVignettes('tissueTreg') for documentation
#> loading from cache
```

EnsemblIDs are given as well as gene symbols:

```
head(assay(se_rpkms))
#>                    Fat-Treg-R1 Fat-Treg-R2 Fat-Treg-R3 Liver-Treg-R1
#> ENSMUSG00000030105          29          11          19             6
#> ENSMUSG00000042428           0           0           0             0
#> ENSMUSG00000096054           2           1           3             1
#> ENSMUSG00000046532           5           5           3             0
#> ENSMUSG00000020495           2           0           2             1
#> ENSMUSG00000058979           2           4           4             7
#>                    Liver-Treg-R2 Liver-Treg-R3 Lymph-N-Tcon-R1 Lymph-N-Tcon-R2
#> ENSMUSG00000030105            11            16              12              19
#> ENSMUSG00000042428             0             0               0               0
#> ENSMUSG00000096054             1             2               1               1
#> ENSMUSG00000046532             0             0               2               1
#> ENSMUSG00000020495             2             2               2               3
#> ENSMUSG00000058979            14             7               8               8
#>                    Lymph-N-Tcon-R3 Lymph-N-Treg-R1 Lymph-N-Treg-R2
#> ENSMUSG00000030105              19              18              22
#> ENSMUSG00000042428               0               0               0
#> ENSMUSG00000096054               1               1               2
#> ENSMUSG00000046532               1               0               0
#> ENSMUSG00000020495               2               3               2
#> ENSMUSG00000058979              14               8               8
#>                    Lymph-N-Treg-R3 Skin-Treg-R1 Skin-Treg-R2 Skin-Treg-R3
#> ENSMUSG00000030105              21           16           19           24
#> ENSMUSG00000042428               0            0            0            0
#> ENSMUSG00000096054               1            1            2            3
#> ENSMUSG00000046532               0            0            1            1
#> ENSMUSG00000020495               2            1            1            1
#> ENSMUSG00000058979              10            6            3            8
head(rowData(se_rpkms))
#> DataFrame with 6 rows and 1 column
#>                      id_symbol
#>                    <character>
#> ENSMUSG00000030105       Arl8b
#> ENSMUSG00000042428       Mgat3
#> ENSMUSG00000096054       Syne1
#> ENSMUSG00000046532          Ar
#> ENSMUSG00000020495        Smg8
#> ENSMUSG00000058979       Cecr5
```

We can for example obtain the RPKM values for Foxp3 in this way:

```
assay(se_rpkms)[rowData(se_rpkms)$id_symbol=="Foxp3",]
#>     Fat-Treg-R1     Fat-Treg-R2     Fat-Treg-R3   Liver-Treg-R1   Liver-Treg-R2
#>              14              16              20              13              14
#>   Liver-Treg-R3 Lymph-N-Tcon-R1 Lymph-N-Tcon-R2 Lymph-N-Tcon-R3 Lymph-N-Treg-R1
#>              18               1               1               1              15
#> Lymph-N-Treg-R2 Lymph-N-Treg-R3    Skin-Treg-R1    Skin-Treg-R2    Skin-Treg-R3
#>              13              15              25              14              21
```

colData() also contains information about the tissue and cell type the
replicate belongs to:

```
head(colData(se_rpkms))
#> DataFrame with 6 rows and 1 column
#>               tissue_cell
#>               <character>
#> Fat-Treg-R1      Fat-Treg
#> Fat-Treg-R2      Fat-Treg
#> Fat-Treg-R3      Fat-Treg
#> Liver-Treg-R1  Liver-Treg
#> Liver-Treg-R2  Liver-Treg
#> Liver-Treg-R3  Liver-Treg
```

We can put this information together and visualize a simple barplot:

```
library(ggplot2)
library(reshape2)
foxp3_rpkm <- assay(se_rpkms)[rowData(se_rpkms)$id_symbol=="Foxp3",]
foxp3_rpkm_molten <- melt(foxp3_rpkm)
ggplot(data=foxp3_rpkm_molten, aes(x=rownames(foxp3_rpkm_molten), y=value, fill=colData(se_rpkms)$tissue_cell)) +
    geom_bar(stat="identity") +
    theme(axis.text.x=element_text(angle=45, hjust=1)) +
    xlab("Sample") +
    ylab("RPKM") +
    ggtitle("FoxP3 expression") +
    guides(fill=guide_legend(title="tissue / cell type"))
```

![](data:image/png;base64...)

# 3 sessionInfo()

```
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
#>  [1] reshape2_1.4.4              ggplot2_4.0.0
#>  [3] tissueTreg_1.30.0           bsseq_1.46.0
#>  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [7] MatrixGenerics_1.22.0       matrixStats_1.5.0
#>  [9] GenomicRanges_1.62.0        Seqinfo_1.0.0
#> [11] IRanges_2.44.0              S4Vectors_0.48.0
#> [13] ExperimentHub_3.0.0         AnnotationHub_4.0.0
#> [15] BiocFileCache_3.0.0         dbplyr_2.5.1
#> [17] BiocGenerics_0.56.0         generics_0.1.4
#> [19] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] DBI_1.2.3                 bitops_1.0-9
#>   [3] httr2_1.2.1               permute_0.9-8
#>   [5] rlang_1.1.6               magrittr_2.0.4
#>   [7] compiler_4.5.1            RSQLite_2.4.3
#>   [9] DelayedMatrixStats_1.32.0 png_0.1-8
#>  [11] vctrs_0.6.5               stringr_1.5.2
#>  [13] pkgconfig_2.0.3           crayon_1.5.3
#>  [15] fastmap_1.2.0             magick_2.9.0
#>  [17] XVector_0.50.0            labeling_0.4.3
#>  [19] Rsamtools_2.26.0          rmarkdown_2.30
#>  [21] tinytex_0.57              purrr_1.1.0
#>  [23] bit_4.6.0                 xfun_0.54
#>  [25] cachem_1.1.0              beachmat_2.26.0
#>  [27] cigarillo_1.0.0           jsonlite_2.0.0
#>  [29] blob_1.2.4                rhdf5filters_1.22.0
#>  [31] DelayedArray_0.36.0       Rhdf5lib_1.32.0
#>  [33] BiocParallel_1.44.0       parallel_4.5.1
#>  [35] R6_2.6.1                  stringi_1.8.7
#>  [37] bslib_0.9.0               RColorBrewer_1.1-3
#>  [39] limma_3.66.0              rtracklayer_1.70.0
#>  [41] jquerylib_0.1.4           Rcpp_1.1.0
#>  [43] bookdown_0.45             knitr_1.50
#>  [45] R.utils_2.13.0            Matrix_1.7-4
#>  [47] tidyselect_1.2.1          dichromat_2.0-0.1
#>  [49] abind_1.4-8               yaml_2.3.10
#>  [51] codetools_0.2-20          curl_7.0.0
#>  [53] plyr_1.8.9                lattice_0.22-7
#>  [55] tibble_3.3.0              S7_0.2.0
#>  [57] withr_3.0.2               KEGGREST_1.50.0
#>  [59] evaluate_1.0.5            Biostrings_2.78.0
#>  [61] pillar_1.11.1             BiocManager_1.30.26
#>  [63] filelock_1.0.3            RCurl_1.98-1.17
#>  [65] BiocVersion_3.22.0        sparseMatrixStats_1.22.0
#>  [67] scales_1.4.0              gtools_3.9.5
#>  [69] glue_1.8.0                tools_4.5.1
#>  [71] BiocIO_1.20.0             data.table_1.17.8
#>  [73] BSgenome_1.78.0           locfit_1.5-9.12
#>  [75] GenomicAlignments_1.46.0  XML_3.99-0.19
#>  [77] rhdf5_2.54.0              grid_4.5.1
#>  [79] AnnotationDbi_1.72.0      HDF5Array_1.38.0
#>  [81] restfulr_0.0.16           cli_3.6.5
#>  [83] rappdirs_0.3.3            S4Arrays_1.10.0
#>  [85] dplyr_1.1.4               gtable_0.3.6
#>  [87] R.methodsS3_1.8.2         sass_0.4.10
#>  [89] digest_0.6.37             SparseArray_1.10.1
#>  [91] rjson_0.2.23              farver_2.1.2
#>  [93] R.oo_1.27.1               memoise_2.0.1
#>  [95] htmltools_0.5.8.1         lifecycle_1.0.4
#>  [97] h5mread_1.2.0             httr_1.4.7
#>  [99] statmod_1.5.1             bit64_4.6.0-1
```