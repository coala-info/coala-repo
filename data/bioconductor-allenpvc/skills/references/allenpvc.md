# Overview of the allenpvc data set

Diogo P. P. Branco

#### *2018-11-01*

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Pre-processing and summary](#pre-processing-and-summary)
* [4 Data format and metadata](#data-format-and-metadata)
* [5 Spike-in genes](#spike-in-genes)
* [6 sessionInfo()](#sessioninfo)
* [7 References](#references)

# 1 Introduction

The `allenpvc` data set is the supplementary data of
[GSE71585](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE71585)
encapsulated in a `SingleCellExperiment` object. It is a celular taxonomy of the
primary visual cortex in adult mice based on single cell RNA-sequencing from
[Tasic et al. 2016](https://www.nature.com/articles/nn.4216)
performed by the Allen Institute for Brain Science. In said study 49
transcriptomic cell types are identified.

# 2 Installation

The package can be installed using the chunk below.

```
BiocManager::install("allenpvc")
```

# 3 Pre-processing and summary

The supplementary files were downloaded from the NCBI website. Those are *csv*
files with count, RPKM, and TPM gene expression data for each cell. They were
processed using R and were encapsulated in a `SingleCellExperiment` (SCE) data.

The original data had a small cell name mis-formatting that was easily
corrected. Lastly, the expression for spike-in genes were available only in
RPKM and counts, but not in TPM. Since this information was included in the SCE,
the expression for those genes in the TPM matrix were filled with NAs.

# 4 Data format and metadata

This data set can be downloaded from the ExperimentHub.

```
library(allenpvc)
```

```
## Loading required package: AnnotationHub
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: parallel
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:parallel':
##
##     clusterApply, clusterApplyLB, clusterCall, clusterEvalQ,
##     clusterExport, clusterMap, parApply, parCapply, parLapply,
##     parLapplyLB, parRapply, parSapply, parSapplyLB
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, append,
##     as.data.frame, basename, cbind, colMeans, colSums, colnames,
##     dirname, do.call, duplicated, eval, evalq, get, grep, grepl,
##     intersect, is.unsorted, lapply, lengths, mapply, match, mget,
##     order, paste, pmax, pmax.int, pmin, pmin.int, rank, rbind,
##     rowMeans, rowSums, rownames, sapply, setdiff, sort, table,
##     tapply, union, unique, unsplit, which, which.max, which.min
```

```
## Loading required package: ExperimentHub
```

```
## Loading required package: SingleCellExperiment
```

```
## Loading required package: SummarizedExperiment
```

```
## Loading required package: GenomicRanges
```

```
## Loading required package: stats4
```

```
## Loading required package: S4Vectors
```

```
##
## Attaching package: 'S4Vectors'
```

```
## The following object is masked from 'package:base':
##
##     expand.grid
```

```
## Loading required package: IRanges
```

```
## Loading required package: GenomeInfoDb
```

```
## Loading required package: Biobase
```

```
## Welcome to Bioconductor
##
##     Vignettes contain introductory material; view with
##     'browseVignettes()'. To cite Bioconductor, see
##     'citation("Biobase")', and for packages 'citation("pkgname")'.
```

```
##
## Attaching package: 'Biobase'
```

```
## The following object is masked from 'package:ExperimentHub':
##
##     cache
```

```
## The following object is masked from 'package:AnnotationHub':
##
##     cache
```

```
## Loading required package: DelayedArray
```

```
## Loading required package: matrixStats
```

```
##
## Attaching package: 'matrixStats'
```

```
## The following objects are masked from 'package:Biobase':
##
##     anyMissing, rowMedians
```

```
## Loading required package: BiocParallel
```

```
##
## Attaching package: 'DelayedArray'
```

```
## The following objects are masked from 'package:matrixStats':
##
##     colMaxs, colMins, colRanges, rowMaxs, rowMins, rowRanges
```

```
## The following objects are masked from 'package:base':
##
##     aperm, apply
```

```
apvc <- allenpvc()
```

```
## snapshotDate(): 2018-10-31
```

```
## see ?allenpvc and browseVignettes('allenpvc') for documentation
```

```
## downloading 0 resources
```

```
## loading from cache
##     '/home/biocbuild//.ExperimentHub/1433'
```

The gene expression data can be retrieved using the `assay` construct. The
chunk below retrieves the count matrix, if you wish to retrieve the RPKM or the
TPM matrix just replace the `"counts"` argument of `assay` with `"rpkm"` or
`"tpm"`.

```
head(assay(apvc, "counts")[, 1:5])
```

```
##               Calb2_tdTpositive_cell_1 Calb2_tdTpositive_cell_2
## 0610005C13Rik                     0.00                     0.00
## 0610007C21Rik                   992.00                  2287.02
## 0610007L01Rik                     2.57                   177.00
## 0610007N19Rik                     0.00                     0.00
## 0610007P08Rik                     0.00                     0.00
## 0610007P14Rik                     0.00                   816.00
##               Calb2_tdTpositive_cell_3 Calb2_tdTpositive_cell_4
## 0610005C13Rik                     0.00                     0.00
## 0610007C21Rik                   491.78                  1932.00
## 0610007L01Rik                     0.00                     1.00
## 0610007N19Rik                     0.00                     0.00
## 0610007P08Rik                     0.00                     0.00
## 0610007P14Rik                    84.00                  1662.18
##               Calb2_tdTpositive_cell_5
## 0610005C13Rik                     0.00
## 0610007C21Rik                  1425.00
## 0610007L01Rik                     2.00
## 0610007N19Rik                     0.00
## 0610007P08Rik                     0.00
## 0610007P14Rik                  2825.15
```

This data set also contains some important metadata, including cell type
annotation of the samples and whether they passed the QC check performed in
[Tasic et al.](https://www.nature.com/articles/nn.4216). As well as many other
useful information such as the Cre line driver and the neuron broad type.

```
head(colData(apvc))
```

```
## DataFrame with 6 rows and 12 columns
##                          mouse_line   cre_driver_1 cre_driver_2
##                            <factor>       <factor>     <factor>
## Calb2_tdTpositive_cell_1      Calb2 Calb2-IRES-Cre
## Calb2_tdTpositive_cell_2      Calb2 Calb2-IRES-Cre
## Calb2_tdTpositive_cell_3      Calb2 Calb2-IRES-Cre
## Calb2_tdTpositive_cell_4      Calb2 Calb2-IRES-Cre
## Calb2_tdTpositive_cell_5      Calb2 Calb2-IRES-Cre
## Calb2_tdTpositive_cell_6      Calb2 Calb2-IRES-Cre
##                            cre_reporter dissection tdTomato pass_qc_checks
##                                <factor>   <factor> <factor>       <factor>
## Calb2_tdTpositive_cell_1 RCL-tdT (Ai14)        All positive              Y
## Calb2_tdTpositive_cell_2 RCL-tdT (Ai14)        All positive              Y
## Calb2_tdTpositive_cell_3 RCL-tdT (Ai14)        All positive              Y
## Calb2_tdTpositive_cell_4 RCL-tdT (Ai14)        All positive              Y
## Calb2_tdTpositive_cell_5 RCL-tdT (Ai14)        All positive              Y
## Calb2_tdTpositive_cell_6 RCL-tdT (Ai14)        All positive              Y
##                                    broad_type core_intermediate primary_type
##                                      <factor>          <factor>     <factor>
## Calb2_tdTpositive_cell_1    GABA-ergic Neuron              core   Vip Mybpc1
## Calb2_tdTpositive_cell_2    GABA-ergic Neuron              core    Vip Parm1
## Calb2_tdTpositive_cell_3 Glutamatergic Neuron              core     L4 Ctxn3
## Calb2_tdTpositive_cell_4    GABA-ergic Neuron              core     Vip Chat
## Calb2_tdTpositive_cell_5    GABA-ergic Neuron              core    Vip Parm1
## Calb2_tdTpositive_cell_6 Glutamatergic Neuron              core   L2/3 Ptgs2
##                          secondary_type aibs_vignette_id
##                                <factor>         <factor>
## Calb2_tdTpositive_cell_1                          A200_V
## Calb2_tdTpositive_cell_2                          A201_V
## Calb2_tdTpositive_cell_3                          A202_V
## Calb2_tdTpositive_cell_4                          A203_V
## Calb2_tdTpositive_cell_5                          A204_V
## Calb2_tdTpositive_cell_6                          A205_V
```

Primary (cell) type of the first 20 cells.

```
head(apvc$primary_type, 20)
```

```
##  Calb2_tdTpositive_cell_1  Calb2_tdTpositive_cell_2
##                Vip Mybpc1                 Vip Parm1
##  Calb2_tdTpositive_cell_3  Calb2_tdTpositive_cell_4
##                  L4 Ctxn3                  Vip Chat
##  Calb2_tdTpositive_cell_5  Calb2_tdTpositive_cell_6
##                 Vip Parm1                L2/3 Ptgs2
##  Calb2_tdTpositive_cell_7  Calb2_tdTpositive_cell_8
##                    L2 Ngb                L2/3 Ptgs2
##  Calb2_tdTpositive_cell_9 Calb2_tdTpositive_cell_10
##                  L4 Ctxn3                    L2 Ngb
## Calb2_tdTpositive_cell_11 Calb2_tdTpositive_cell_12
##                Pvalb Gpx3                L2/3 Ptgs2
## Calb2_tdTpositive_cell_13 Calb2_tdTpositive_cell_14
##                  Vip Chat                L2/3 Ptgs2
## Calb2_tdTpositive_cell_15 Calb2_tdTpositive_cell_16
##                 Vip Parm1               Ndnf Cxcl14
## Calb2_tdTpositive_cell_17 Calb2_tdTpositive_cell_18
##                  Vip Gpc3                  Vip Chat
## Calb2_tdTpositive_cell_19 Calb2_tdTpositive_cell_20
##                  Vip Chat                  Vip Gpc3
## 50 Levels: Astro Gja1 Endo Myl9 Endo Tbc1d4 Igtp L2/3 Ptgs2 ... Vip Sncg
```

Broad type of the first 20 cells.

```
head(apvc$broad_type, 20)
```

```
##  Calb2_tdTpositive_cell_1  Calb2_tdTpositive_cell_2
##         GABA-ergic Neuron         GABA-ergic Neuron
##  Calb2_tdTpositive_cell_3  Calb2_tdTpositive_cell_4
##      Glutamatergic Neuron         GABA-ergic Neuron
##  Calb2_tdTpositive_cell_5  Calb2_tdTpositive_cell_6
##         GABA-ergic Neuron      Glutamatergic Neuron
##  Calb2_tdTpositive_cell_7  Calb2_tdTpositive_cell_8
##      Glutamatergic Neuron      Glutamatergic Neuron
##  Calb2_tdTpositive_cell_9 Calb2_tdTpositive_cell_10
##      Glutamatergic Neuron      Glutamatergic Neuron
## Calb2_tdTpositive_cell_11 Calb2_tdTpositive_cell_12
##         GABA-ergic Neuron      Glutamatergic Neuron
## Calb2_tdTpositive_cell_13 Calb2_tdTpositive_cell_14
##         GABA-ergic Neuron      Glutamatergic Neuron
## Calb2_tdTpositive_cell_15 Calb2_tdTpositive_cell_16
##         GABA-ergic Neuron         GABA-ergic Neuron
## Calb2_tdTpositive_cell_17 Calb2_tdTpositive_cell_18
##         GABA-ergic Neuron         GABA-ergic Neuron
## Calb2_tdTpositive_cell_19 Calb2_tdTpositive_cell_20
##         GABA-ergic Neuron         GABA-ergic Neuron
## 8 Levels: Astrocyte Endothelial Cell ... Unclassified
```

Any metadata information can be accessed through the `$` operator
directly from the SCE object. But in the chunk below we are subsetting more than
one column, thus, we must reference `colData`. The output shows the Cre line and
QC check flag of some cells.

```
head(colData(apvc)[, c("cre_driver_1", "pass_qc_checks")])
```

```
## DataFrame with 6 rows and 2 columns
##                            cre_driver_1 pass_qc_checks
##                                <factor>       <factor>
## Calb2_tdTpositive_cell_1 Calb2-IRES-Cre              Y
## Calb2_tdTpositive_cell_2 Calb2-IRES-Cre              Y
## Calb2_tdTpositive_cell_3 Calb2-IRES-Cre              Y
## Calb2_tdTpositive_cell_4 Calb2-IRES-Cre              Y
## Calb2_tdTpositive_cell_5 Calb2-IRES-Cre              Y
## Calb2_tdTpositive_cell_6 Calb2-IRES-Cre              Y
```

# 5 Spike-in genes

This data set has information on the expression of spike-in genes. In the study
ERCC spike-ins were used as well as the tdTomato. These genes are included in
the same matrices as the endogenous genes, hence, it might be desirable to split
the assay matrix.

The chunk below shows an example of splitting the count matrix. As previously
mentioned, the spike-in expression for TPM is not available in the original
supplementary data and, for said assay, is filled with NAs.

```
apvc_endo <- apvc[!isSpike(apvc),]
apvc_endo
```

```
## class: SingleCellExperiment
## dim: 24057 1809
## metadata(0):
## assays(3): counts tpm rpkm
## rownames(24057): 0610005C13Rik 0610007C21Rik ... mt_X57779 mt_X57780
## rowData names(0):
## colnames(1809): Calb2_tdTpositive_cell_1 Calb2_tdTpositive_cell_2
##   ... Rbp4_CTX_250ng_2 Trib2_CTX_250ng_1
## colData names(12): mouse_line cre_driver_1 ... secondary_type
##   aibs_vignette_id
## reducedDimNames(0):
## spikeNames(2): ERCC tdTomato
```

```
apvc_spike <- apvc[isSpike(apvc),]
apvc_spike
```

```
## class: SingleCellExperiment
## dim: 93 1809
## metadata(0):
## assays(3): counts tpm rpkm
## rownames(93): ERCC-00002 ERCC-00003 ... ERCC-00171 tdTomato
## rowData names(0):
## colnames(1809): Calb2_tdTpositive_cell_1 Calb2_tdTpositive_cell_2
##   ... Rbp4_CTX_250ng_2 Trib2_CTX_250ng_1
## colData names(12): mouse_line cre_driver_1 ... secondary_type
##   aibs_vignette_id
## reducedDimNames(0):
## spikeNames(2): ERCC tdTomato
```

# 6 sessionInfo()

```
## R version 3.5.1 Patched (2018-07-12 r74967)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 16.04.5 LTS
##
## Matrix products: default
## BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats4    parallel  stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] allenpvc_1.0.0              SingleCellExperiment_1.4.0
##  [3] SummarizedExperiment_1.12.0 DelayedArray_0.8.0
##  [5] BiocParallel_1.16.0         matrixStats_0.54.0
##  [7] Biobase_2.42.0              GenomicRanges_1.34.0
##  [9] GenomeInfoDb_1.18.0         IRanges_2.16.0
## [11] S4Vectors_0.20.0            ExperimentHub_1.8.0
## [13] AnnotationHub_2.14.0        BiocGenerics_0.28.0
## [15] BiocStyle_2.10.0
##
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.12.19                  XVector_0.22.0
##  [3] compiler_3.5.1                BiocManager_1.30.3
##  [5] later_0.7.5                   zlibbioc_1.28.0
##  [7] bitops_1.0-6                  tools_3.5.1
##  [9] digest_0.6.18                 bit_1.1-14
## [11] lattice_0.20-35               RSQLite_2.1.1
## [13] evaluate_0.12                 memoise_1.1.0
## [15] pkgconfig_2.0.2               Matrix_1.2-14
## [17] shiny_1.1.0                   DBI_1.0.0
## [19] curl_3.2                      yaml_2.2.0
## [21] xfun_0.4                      GenomeInfoDbData_1.2.0
## [23] stringr_1.3.1                 httr_1.3.1
## [25] knitr_1.20                    grid_3.5.1
## [27] rprojroot_1.3-2               bit64_0.9-7
## [29] R6_2.3.0                      AnnotationDbi_1.44.0
## [31] rmarkdown_1.10                bookdown_0.7
## [33] blob_1.1.1                    magrittr_1.5
## [35] backports_1.1.2               promises_1.0.1
## [37] htmltools_0.3.6               mime_0.6
## [39] interactiveDisplayBase_1.20.0 xtable_1.8-3
## [41] httpuv_1.4.5                  stringi_1.2.4
## [43] RCurl_1.95-4.11
```

# 7 References

Tasic, Bosiljka, et al. “Adult mouse cortical cell taxonomy revealed by single
cell transcriptomics.” Nature neuroscience 19.2 (2016): 335.