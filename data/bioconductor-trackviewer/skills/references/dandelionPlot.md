# trackViewer Vignette: dandelionPlot

#### Jianhong Ou, Lihua Julie Zhu

#### 30 October 2025

Abstract

Visualize high dense methylation or mutation data along with annotation as track layers via Dandelion Plot.

# Dandelion Plot

Sometimes, there are as many as hundreds of SNPs invoved in one gene. Dandelion plot can be used to depict such dense SNPs. Please note that the height of the dandelion indicates the desity of the SNPs.

```
library(trackViewer)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(org.Hs.eg.db)
library(rtracklayer)
methy <- import(system.file("extdata", "methy.bed", package="trackViewer"), "BED")
gr <- GRanges("chr22", IRanges(50968014, 50970514, names="TYMP"))
trs <- geneModelFromTxdb(TxDb.Hsapiens.UCSC.hg19.knownGene,
                         org.Hs.eg.db,
                         gr=gr)
features <- c(range(trs[[1]]$dat), range(trs[[5]]$dat))
names(features) <- c(trs[[1]]$name, trs[[5]]$name)
features$fill <- c("lightblue", "mistyrose")
features$height <- c(.02, .04)
dandelion.plot(methy, features, ranges=gr, type="pin")
```

![](data:image/png;base64...)

## Change the type of Dandelion plot

There are one more type for dandelion plot, i.e., type “fan”. The area of the fan indicates the percentage of methylation or rate of mutation.

```
methy$color <- 3
methy$border <- "gray"
## Score info is required and the score must be a number in [0, 1]
m <- max(methy$score)
methy$score <- methy$score/m
dandelion.plot(methy, features, ranges=gr, type="fan")
```

![](data:image/png;base64...)

```
methy$color <- rep(list(c(3, 5)), length(methy))
methy$score2 <- (max(methy$score) - methy$score)/m
legends <- list(list(labels=c("s1", "s2"), fill=c(3, 5)))
dandelion.plot(methy, features, ranges=gr, type="pie", legend=legends)
```

![](data:image/png;base64...)

## Change the number of dandelions

```
## Less dandelions
dandelion.plot(methy, features, ranges=gr, type="circle", maxgaps=1/10)
```

![](data:image/png;base64...)

```
## More dandelions
dandelion.plot(methy, features, ranges=gr, type="circle", maxgaps=1/100)
```

![](data:image/png;base64...)

Users can also specify the maximum distance between neighboring dandelions by setting the maxgaps as a GRanges object.

```
maxgaps <- tile(gr, n = 10)[[1]]
dandelion.plot(methy, features, ranges=gr, type="circle", maxgaps=maxgaps)
```

![](data:image/png;base64...)

## Add y-axis (yaxis)

Set yaxis to TRUE to add y-axis, and set `heightMethod`=`mean` to use the mean score as the height.

```
dandelion.plot(methy, features, ranges=gr, type="pie",
               maxgaps=1/100, yaxis = TRUE, heightMethod = mean,
               ylab='mean of methy scores')
```

![](data:image/png;base64...)

```
yaxis = c(0, 0.5, 1)
dandelion.plot(methy, features, ranges=gr, type="pie",
               maxgaps=1/100, yaxis = yaxis, heightMethod = mean,
               ylab='mean of methy scores')
```

![](data:image/png;base64...)

# Session Info

```
sessionInfo()
```

R version 4.5.1 Patched (2025-08-23 r88802) Platform: x86\_64-pc-linux-gnu Running under: Ubuntu 24.04.3 LTS

Matrix products: default BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so LAPACK: /usr/lib/x86\_64-linux-gnu/lapack/liblapack.so.3.12.0 LAPACK version 3.12.0

locale: [1] LC\_CTYPE=en\_US.UTF-8 LC\_NUMERIC=C
[3] LC\_TIME=en\_GB LC\_COLLATE=C
[5] LC\_MONETARY=en\_US.UTF-8 LC\_MESSAGES=en\_US.UTF-8
[7] LC\_PAPER=en\_US.UTF-8 LC\_NAME=C
[9] LC\_ADDRESS=C LC\_TELEPHONE=C
[11] LC\_MEASUREMENT=en\_US.UTF-8 LC\_IDENTIFICATION=C

time zone: America/New\_York tzcode source: system (glibc)

attached base packages: [1] grid stats4 stats graphics grDevices utils datasets [8] methods base

other attached packages: [1] httr\_1.4.7
[2] VariantAnnotation\_1.56.0
[3] Rsamtools\_2.26.0
[4] Biostrings\_2.78.0
[5] XVector\_0.50.0
[6] SummarizedExperiment\_1.40.0
[7] MatrixGenerics\_1.22.0
[8] matrixStats\_1.5.0
[9] org.Hs.eg.db\_3.22.0
[10] TxDb.Hsapiens.UCSC.hg19.knownGene\_3.22.1 [11] GenomicFeatures\_1.62.0
[12] AnnotationDbi\_1.72.0
[13] Biobase\_2.70.0
[14] Gviz\_1.54.0
[15] rtracklayer\_1.70.0
[16] trackViewer\_1.46.0
[17] GenomicRanges\_1.62.0
[18] Seqinfo\_1.0.0
[19] IRanges\_2.44.0
[20] S4Vectors\_0.48.0
[21] BiocGenerics\_0.56.0
[22] generics\_0.1.4

loaded via a namespace (and not attached): [1] RColorBrewer\_1.1-3 strawr\_0.0.92 rstudioapi\_0.17.1
[4] jsonlite\_2.0.0 magrittr\_2.0.4 farver\_2.1.2
[7] rmarkdown\_2.30 BiocIO\_1.20.0 vctrs\_0.6.5
[10] memoise\_2.0.1 RCurl\_1.98-1.17 base64enc\_0.1-3
[13] htmltools\_0.5.8.1 S4Arrays\_1.10.0 progress\_1.2.3
[16] curl\_7.0.0 Rhdf5lib\_1.32.0 SparseArray\_1.10.0
[19] Formula\_1.2-5 rhdf5\_2.54.0 sass\_0.4.10
[22] bslib\_0.9.0 htmlwidgets\_1.6.4 httr2\_1.2.1
[25] cachem\_1.1.0 GenomicAlignments\_1.46.0 lifecycle\_1.0.4
[28] pkgconfig\_2.0.3 Matrix\_1.7-4 R6\_2.6.1
[31] fastmap\_1.2.0 digest\_0.6.37 colorspace\_2.1-2
[34] Hmisc\_5.2-4 RSQLite\_2.4.3 filelock\_1.0.3
[37] abind\_1.4-8 compiler\_4.5.1 bit64\_4.6.0-1
[40] htmlTable\_2.4.3 S7\_0.2.0 backports\_1.5.0
[43] BiocParallel\_1.44.0 DBI\_1.2.3 biomaRt\_2.66.0
[46] rappdirs\_0.3.3 DelayedArray\_0.36.0 rjson\_0.2.23
[49] tools\_4.5.1 foreign\_0.8-90 nnet\_7.3-20
[52] glue\_1.8.0 restfulr\_0.0.16 InteractionSet\_1.38.0
[55] rhdf5filters\_1.22.0 checkmate\_2.3.3 cluster\_2.1.8.1
[58] gtable\_0.3.6 BSgenome\_1.78.0 ensembldb\_2.34.0
[61] data.table\_1.17.8 hms\_1.1.4 pillar\_1.11.1
[64] stringr\_1.5.2 dplyr\_1.1.4 BiocFileCache\_3.0.0
[67] lattice\_0.22-7 bit\_4.6.0 deldir\_2.0-4
[70] biovizBase\_1.58.0 tidyselect\_1.2.1 knitr\_1.50
[73] gridExtra\_2.3 ProtGenerics\_1.42.0 xfun\_0.53
[76] stringi\_1.8.7 UCSC.utils\_1.6.0 lazyeval\_0.2.2
[79] yaml\_2.3.10 evaluate\_1.0.5 codetools\_0.2-20
[82] cigarillo\_1.0.0 interp\_1.1-6 tibble\_3.3.0
[85] BiocManager\_1.30.26 cli\_3.6.5 rpart\_4.1.24
[88] jquerylib\_0.1.4 dichromat\_2.0-0.1 Rcpp\_1.1.0
[91] GenomeInfoDb\_1.46.0 grImport\_0.9-7 dbplyr\_2.5.1
[94] png\_0.1-8 XML\_3.99-0.19 parallel\_4.5.1
[97] ggplot2\_4.0.0 blob\_1.2.4 prettyunits\_1.2.0
[100] latticeExtra\_0.6-31 jpeg\_0.1-11 AnnotationFilter\_1.34.0 [103] bitops\_1.0-9 txdbmaker\_1.6.0 scales\_1.4.0
[106] crayon\_1.5.3 BiocStyle\_2.38.0 rlang\_1.1.6
[109] KEGGREST\_1.50.0