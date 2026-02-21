# miRmine dataset as RangedSummarizedExperiment

Dusan Randjelovic

dusan.randjelovic@sbgenomics.com

#### *30 October 2018*

#### Abstract

miRmine is data package built for easier use of miRmine dataset
(Panwar et al (2017) miRmine: A Database of Human miRNA Expression.
Bioinformatics, btx019. doi: 10.1093/bioinformatics/btx019).
In it’s current version miRmine contains 304 publicly available
experiments from NCBI SRA. Annotations used are from miRBase v21
(miRBase: Annotating high confidence microRNAs using deep sequencing data.
Kozomara A, Griffiths-Jones S. NAR 2014 42:D68-D73).

#### Package

miRmine 1.4.0

# Contents

* [1 Data preparation](#data-preparation)
* [2 Usage](#usage)
* [Session info](#session-info)

# 1 Data preparation

miRmine dataset contains rich metadata around 304 selected publicly available,
miRNA-Seq experiments. Authors’ processed the data with miRdeep2 using
annotation files from miRBase v21. Mentioned metadata is used as colData
and miRBase annotations as GRanges are used as rowRanges while preparing
this dataset as RangedSummarizedExperiment. Data used for preprocessing and
constructing the `miRmine` RangedSummarizedExperiment are available in
`extdata` folder. Details of this proccess could be followed in
data help file: `?miRmine`.

```
#library(GenomicRanges)
#library(rtracklayer)
#library(SummarizedExperiment)
#library(Biostrings)
#library(Rsamtools)

ext.data <- system.file("extdata", package = "miRmine")
list.files(ext.data)
```

```
## [1] "hsa.gff3"               "mature.fa"
## [3] "mature.fa.fai"          "miRmine-cell-lines.csv"
## [5] "miRmine-info.txt"       "miRmine-tissues.csv"
```

Number of ranges from miRBase GFF and number of features output
by miRdeep2 are not the same (2813 vs. 2822). After closer look it turns out
that 2 rows from either **tissues** or **cell.lines** data are duplicated
(with same mature miRNA and same precursor miRNA) and 7 rows don’t correspond
to mirna/precursor combination existing in miRBase v21. These rows were
removed for all samples, as seen in `?miRmine`.

# 2 Usage

To load this dataset use:

```
library("miRmine")
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
data(miRmine)
miRmine
```

```
## class: RangedSummarizedExperiment
## dim: 2813 304
## metadata(0):
## assays(1): counts
## rownames(2813): hsa-let-7a-2-3p.hsa-let-7a-2
##   hsa-let-7a-3p.hsa-let-7a-1 ... hsa-miR-99b-3p.hsa-mir-99b
##   hsa-miR-99b-5p.hsa-mir-99b
## rowData names(10): source type ... UniqueName mirna_seq
## colnames(304): DRX003170..Lung. DRX003171..Lung. ...
##   SRX666573..C8166. SRX666574..C8166.
## colData names(17): Experiment.Accession Tissue ... Total.RUNs
##   Total.Bases
```

You may want to further subset data on some of many colData features
(Tissue, Cell Line, Disease, Sex, Instrument) or output some specifics of
particular experiment(s) (Accession #, Description, Publication):

```
adenocarcinoma = miRmine[ , miRmine$Disease %in% c("Adenocarcinoma")]
adenocarcinoma
```

```
## class: RangedSummarizedExperiment
## dim: 2813 30
## metadata(0):
## assays(1): counts
## rownames(2813): hsa-let-7a-2-3p.hsa-let-7a-2
##   hsa-let-7a-3p.hsa-let-7a-1 ... hsa-miR-99b-3p.hsa-mir-99b
##   hsa-miR-99b-5p.hsa-mir-99b
## rowData names(10): source type ... UniqueName mirna_seq
## colnames(30): ERX358444..Hair.follicle. ERX358445..Hair.follicle.
##   ... SRX290601..Pancreas. SRX290617..Pancreas.
## colData names(17): Experiment.Accession Tissue ... Total.RUNs
##   Total.Bases
```

```
as.character(adenocarcinoma$Sample.Accession)
```

```
##  [1] "DRS016321" "DRS016322" "DRS016297" "DRS016298" "DRS016299" "DRS016300"
##  [7] "DRS016301" "DRS016302" "DRS016303" "DRS016304" "DRS016305" "DRS016306"
## [13] "DRS016307" "DRS016308" "DRS016309" "DRS016310" "DRS016311" "DRS016312"
## [19] "DRS016313" "DRS016314" "DRS016315" "DRS016316" "DRS016317" "DRS016318"
## [25] "DRS016319" "DRS016320" "DRS016289" "DRS016289" "DRS016293" "DRS016293"
```

rowRanges data is also rich in metadata, containing all the features from
miRBase hsa.gff3, with addition of actual miRNA sequence as DNAString
instance. For example to read the sequence of top expressed miRNA over
a subset of samples:

```
top.mirna = names(sort(rowSums(assays(adenocarcinoma)$counts))[1])
rowRanges(adenocarcinoma)$mirna_seq[[top.mirna]]
```

```
## Loading required package: Biostrings
```

```
## Loading required package: XVector
```

```
##
## Attaching package: 'Biostrings'
```

```
## The following object is masked from 'package:DelayedArray':
##
##     type
```

```
## The following object is masked from 'package:base':
##
##     strsplit
```

```
##   16-letter "DNAString" instance
## seq: CAAGCCCGACAAGCGC
```

`miRmine` could be directly used in DESeq2
(note that expression values are RPM not raw reads):

```
library("DESeq2")

mirmine.subset = miRmine[, miRmine$Tissue %in% c("Lung", "Saliva")]
mirmine.subset = SummarizedExperiment(
    assays = SimpleList(counts=ceiling(assays(mirmine.subset)$counts)),
    colData=colData(mirmine.subset),
    rowRanges=rowRanges(mirmine.subset),
    rowData=NULL
)

ddsSE <- DESeqDataSet(mirmine.subset, design = ~ Tissue)
```

```
## converting counts to integer mode
```

```
## factor levels were dropped which had no samples
```

```
ddsSE <- ddsSE[ rowSums(counts(ddsSE)) > 1, ]

dds <- DESeq(ddsSE)
```

```
## estimating size factors
```

```
## estimating dispersions
```

```
## gene-wise dispersion estimates
```

```
## mean-dispersion relationship
```

```
## final dispersion estimates
```

```
## fitting model and testing
```

```
res <- results(dds)
res
```

```
## log2 fold change (MLE): Tissue Saliva vs Lung
## Wald test p-value: Tissue Saliva vs Lung
## DataFrame with 1110 rows and 6 columns
##                                    baseMean     log2FoldChange
##                                   <numeric>          <numeric>
## hsa-let-7a-3p.hsa-let-7a-1 1.36878225121224  -5.06121692525049
## hsa-let-7a-3p.hsa-let-7a-3 1.36878225121224  -5.06121692525049
## hsa-let-7a-5p.hsa-let-7a-1 70832.4152362289  -6.66070394820764
## hsa-let-7a-5p.hsa-let-7a-2 70816.3802786825  -6.68915844432708
## hsa-let-7a-5p.hsa-let-7a-3 70796.4538181454   -6.6970658032693
## ...                                     ...                ...
## hsa-miR-98-3p.hsa-mir-98   2.74944147887468  -6.06706594334606
## hsa-miR-98-5p.hsa-mir-98   147.192905249397  -2.99953300228544
## hsa-miR-99a-5p.hsa-mir-99a 44.5105030263479   3.34660728353674
## hsa-miR-99b-3p.hsa-mir-99b 11.6648163870668 -0.850214803129576
## hsa-miR-99b-5p.hsa-mir-99b 213.017809065176   1.56034696799802
##                                        lfcSE               stat
##                                    <numeric>          <numeric>
## hsa-let-7a-3p.hsa-let-7a-1  4.40771665321255   -1.1482627681073
## hsa-let-7a-3p.hsa-let-7a-3  4.40771665321255   -1.1482627681073
## hsa-let-7a-5p.hsa-let-7a-1 0.905381321837467  -7.35679407952638
## hsa-let-7a-5p.hsa-let-7a-2 0.910761724424877  -7.34457571605911
## hsa-let-7a-5p.hsa-let-7a-3 0.907304190176289  -7.38127948242812
## ...                                      ...                ...
## hsa-miR-98-3p.hsa-mir-98    4.10433386746395  -1.47820965332308
## hsa-miR-98-5p.hsa-mir-98    1.45189465107018  -2.06594397195038
## hsa-miR-99a-5p.hsa-mir-99a   2.1654459571011   1.54545869526888
## hsa-miR-99b-3p.hsa-mir-99b  3.00398623730122 -0.283028860975544
## hsa-miR-99b-5p.hsa-mir-99b 0.923541384927293   1.68952576837784
##                                          pvalue                 padj
##                                       <numeric>            <numeric>
## hsa-let-7a-3p.hsa-let-7a-1    0.250860104234839                   NA
## hsa-let-7a-3p.hsa-let-7a-3    0.250860104234839                   NA
## hsa-let-7a-5p.hsa-let-7a-1 1.88379602439939e-13 5.44588305235459e-12
## hsa-let-7a-5p.hsa-let-7a-2 2.06412818772954e-13 5.70776316259124e-12
## hsa-let-7a-5p.hsa-let-7a-3 1.56775513668902e-13 4.74805841397246e-12
## ...                                         ...                  ...
## hsa-miR-98-3p.hsa-mir-98      0.139351670880805     0.22783460843237
## hsa-miR-98-5p.hsa-mir-98     0.0388337702361007   0.0886429971509379
## hsa-miR-99a-5p.hsa-mir-99a    0.122235352389183    0.211830201960546
## hsa-miR-99b-3p.hsa-mir-99b    0.777154713281173    0.836328930028471
## hsa-miR-99b-5p.hsa-mir-99b   0.0911187179612673    0.168954823974828
```

# Session info

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
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] DESeq2_1.22.0               Biostrings_2.50.0
##  [3] XVector_0.22.0              miRmine_1.4.0
##  [5] SummarizedExperiment_1.12.0 DelayedArray_0.8.0
##  [7] BiocParallel_1.16.0         matrixStats_0.54.0
##  [9] Biobase_2.42.0              GenomicRanges_1.34.0
## [11] GenomeInfoDb_1.18.0         IRanges_2.16.0
## [13] S4Vectors_0.20.0            BiocGenerics_0.28.0
## [15] BiocStyle_2.10.0
##
## loaded via a namespace (and not attached):
##  [1] bit64_0.9-7            splines_3.5.1          Formula_1.2-3
##  [4] assertthat_0.2.0       BiocManager_1.30.3     latticeExtra_0.6-28
##  [7] blob_1.1.1             GenomeInfoDbData_1.2.0 yaml_2.2.0
## [10] RSQLite_2.1.1          pillar_1.3.0           backports_1.1.2
## [13] lattice_0.20-35        glue_1.3.0             digest_0.6.18
## [16] RColorBrewer_1.1-2     checkmate_1.8.5        colorspace_1.3-2
## [19] htmltools_0.3.6        Matrix_1.2-14          plyr_1.8.4
## [22] XML_3.98-1.16          pkgconfig_2.0.2        genefilter_1.64.0
## [25] bookdown_0.7           zlibbioc_1.28.0        xtable_1.8-3
## [28] purrr_0.2.5            scales_1.0.0           annotate_1.60.0
## [31] tibble_1.4.2           htmlTable_1.12         ggplot2_3.1.0
## [34] nnet_7.3-12            lazyeval_0.2.1         survival_2.43-1
## [37] magrittr_1.5           crayon_1.3.4           memoise_1.1.0
## [40] evaluate_0.12          foreign_0.8-71         data.table_1.11.8
## [43] tools_3.5.1            stringr_1.3.1          locfit_1.5-9.1
## [46] munsell_0.5.0          cluster_2.0.7-1        AnnotationDbi_1.44.0
## [49] bindrcpp_0.2.2         compiler_3.5.1         rlang_0.3.0.1
## [52] grid_3.5.1             RCurl_1.95-4.11        rstudioapi_0.8
## [55] htmlwidgets_1.3        bitops_1.0-6           base64enc_0.1-3
## [58] rmarkdown_1.10         gtable_0.2.0           DBI_1.0.0
## [61] R6_2.3.0               gridExtra_2.3          knitr_1.20
## [64] dplyr_0.7.7            bit_1.1-14             bindr_0.1.1
## [67] Hmisc_4.1-1            rprojroot_1.3-2        stringi_1.2.4
## [70] Rcpp_0.12.19           geneplotter_1.60.0     rpart_4.1-13
## [73] acepack_1.4.1          tidyselect_0.2.5       xfun_0.4
```