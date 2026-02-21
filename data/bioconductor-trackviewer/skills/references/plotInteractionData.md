# trackViewer Vignette: plot interaction data

#### Jianhong Ou, Lihua Julie Zhu

#### 30 October 2025

Abstract

Visualize chromatin interactions along with annotation as track layers. The interactions can be compared by back to back heatmaps. The interactions can be plot as heatmap and links.

# Introduction

The chromatin interactions is involved in precise quantitative and spatiotemporal control of gene expression. The development of high-throughput experimental techniques, such as HiC-seq, HiCAR-seq, and InTAC-seq, for analyzing both the higher-order structure of chromatin and the interactions between protein and their nearby and remote regulatory elements has been developed to reveal how gene expression is controlled in genome-wide.

The interaction data will be saved in the format of paired genome coordinates with the interaction score. The popular format are `.validPairs`, `.hic`, and `.cool`. The `trackViewer` package can be used to handle those data to plot the heatmap or the interaction links.

# Plot chromatin interactions data in linear layout

Plot chromatin interactions tracks as heatmap.

```
library(trackViewer)
library(InteractionSet)
gi <- readRDS(system.file("extdata", "nij.chr6.51120000.53200000.gi.rds", package="trackViewer"))
head(gi)
```

```
## GInteractions object with 6 interactions and 1 metadata column:
##       seqnames1           ranges1     seqnames2           ranges2 |     score
##           <Rle>         <IRanges>         <Rle>         <IRanges> | <numeric>
##   [1]      chr6 51120000-51160000 ---      chr6 51120000-51160000 |   45.1227
##   [2]      chr6 51120000-51160000 ---      chr6 51160000-51200000 |   35.0006
##   [3]      chr6 51120000-51160000 ---      chr6 51200000-51240000 |   44.7322
##   [4]      chr6 51120000-51160000 ---      chr6 51240000-51280000 |   29.3507
##   [5]      chr6 51120000-51160000 ---      chr6 51280000-51320000 |   38.8417
##   [6]      chr6 51120000-51160000 ---      chr6 51320000-51360000 |   31.7063
##   -------
##   regions: 53 ranges and 0 metadata columns
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

```
## hicexplorer:hicConvertFormat tool can be used to convert other formats into GInteractions
## eg: hicConvertFormat -m mESC_rep.hic --inputFormat hic --outputFormat cool -o mESC_rep.mcool
##     hicConvertFormat -m mESC_rep.mcool::resolutions/10000 --inputFormat cool --outputFormat ginteractions -o mESC_rep.ginteractions --resolutions 10000
## please note that metadata:score is used for plot.
gi$border_color <- NA ## highlight some regions
gi$border_color[sample(seq_along(gi), 20)] <- sample(1:7, 20, replace=TRUE)
## The TADs will be drawn as lines at points start(first), center point, end(second).
tads <- GInteractions(
  GRanges("chr6",
          IRanges(c(51130001, 51130001, 51450001, 52210001), width = 20000)),
  GRanges("chr6",
          IRanges(c(51530001, 52170001, 52210001, 53210001), width = 20000)))
range <- GRanges("chr6", IRanges(51120000, 53200000))
heatmap <- gi2track(gi)
ctcf <- readRDS(system.file("extdata", "ctcf.sample.rds", package="trackViewer"))
viewTracks(trackList(ctcf, heatmap, heightDist = c(1, 3)),
           gr=range, autoOptimizeStyle = TRUE)
## add TAD information
addInteractionAnnotation(tads, "heatmap", grid.lines, gp=gpar(col="#E69F00", lwd=3, lty=3))
## add highlight interested regions
gi_sub <- gi[order(gi$score, decreasing = TRUE)]
gi_sub <- head(gi_sub[distance(first(gi_sub), second(gi_sub))>200000], n=5)
start(regions(gi_sub)) <- start(regions(gi_sub))-40000
end(regions(gi_sub)) <- end(regions(gi_sub))+40000
addInteractionAnnotation(gi_sub, "heatmap", grid.polygon, gp=gpar(col="red", lwd=2, lty=2, fill=NA))
## add interesting anchor at giving coordinate.
addInteractionAnnotation(52900000, "heatmap", gp=gpar(col="blue", lwd=3))
addInteractionAnnotation(-52900000, "heatmap", gp=gpar(col="cyan", lwd=3, lty=4))
```

![](data:image/png;base64...)

```
## view the interaction data back to back.
## Please make sure the data are normalized.
gi2 <- gi
set.seed(123)
gi2$score <- gi$score + rnorm(length(gi), sd = sd(gi$score))
back2back <- gi2track(gi, gi2)
## change the color
setTrackStyleParam(back2back, "breaks",
                   c(seq(from=0, to=50, by=10), 200))
setTrackStyleParam(back2back, "color",
                   c("lightblue", "yellow", "red"))
## chang the lim of y-axis (by default, [0, 1])
setTrackStyleParam(back2back, "ylim", c(0, .5))
viewTracks(trackList(ctcf, back2back, heightDist=c(1, 5)),
           gr=range, autoOptimizeStyle = TRUE)
addInteractionAnnotation(tads, "back2back", grid.lines,
                         gp=gpar(col="cyan", lwd=3, lty=2))
addInteractionAnnotation(-52208000, "back2back", gp=gpar(col="blue", lwd=3),
                         panel="top")
addInteractionAnnotation(51508000, "back2back", gp=gpar(col="gray", lwd=3, lty=2),
                         panel="bottom")
```

![](data:image/png;base64...)

Plot chromatin interactions track as links.

```
setTrackStyleParam(heatmap, "tracktype", "link")
setTrackStyleParam(heatmap, "breaks",
                   c(seq(from=0, to=50, by=10), 200))
setTrackStyleParam(heatmap, "color",
                   c("lightblue", "yellow", "red"))
## filter the links to simulate the real data
keep <- distance(heatmap$dat, heatmap$dat2) > 5e5 & heatmap$dat$score>20
heatmap$dat <- heatmap$dat[keep]
heatmap$dat2 <- heatmap$dat2[keep]
viewTracks(trackList(heatmap), gr=range, autoOptimizeStyle = TRUE)
```

![](data:image/png;base64...)

Plot links with heatmap.

```
heatmapLinks <- gi2track(gi, gi2[keep])
## change the color
setTrackStyleParam(heatmapLinks, "breaks",
                   c(seq(from=0, to=50, by=10), 200))
setTrackStyleParam(heatmapLinks, "color",
                   c("lightblue", "yellow", "red"))
## chang the lim of y-axis (by default, [0, 1])
setTrackStyleParam(heatmapLinks, "ylim", c(0, .5))
setTrackStyleParam(heatmapLinks, "tracktype", c("heatmap", "link"))
setTrackStyleParam(heatmapLinks, "ysplit", 0.75) # heatmap space 75% of height
viewTracks(trackList(heatmapLinks), gr=range, autoOptimizeStyle = TRUE)
addInteractionAnnotation(tads, "heatmapLinks", grid.lines,
                         gp=gpar(col="cyan", lwd=3, lty=2), panel='top')
addInteractionAnnotation(-52208000, "heatmapLinks", gp=gpar(col="blue", lwd=3),
                         panel="top")
```

![](data:image/png;base64...)

To import interactions data from “.hic” (reference to the script of [hic-straw](https://github.com/aidenlab/straw) and the [documentation](https://www.cell.com/cms/10.1016/j.cels.2016.07.002/attachment/ce39448c-9a11-4b4e-a03f-45882b7b1d9d/mmc2.xlsx)). The function `importGInteractions` (trackViewer version>=1.27.6) can be used to import data from `.hic` format file.

```
hic <- system.file("extdata", "test_chr22.hic", package = "trackViewer",
                    mustWork=TRUE)
if(.Platform$OS.type!="windows"){
importGInteractions(file=hic, format="hic",
                    ranges=GRanges("22", IRanges(50000000, 100000000)),
                    out = "GInteractions")
}
```

```
## GInteractions object with 70 interactions and 1 metadata column:
##        seqnames1           ranges1     seqnames2           ranges2 |     score
##            <Rle>         <IRanges>         <Rle>         <IRanges> | <numeric>
##    [1]        22 50000001-50100000 ---        22 50000001-50100000 |        26
##    [2]        22 50000001-50100000 ---        22 50100001-50200000 |         2
##    [3]        22 50100001-50200000 ---        22 50100001-50200000 |        22
##    [4]        22 50100001-50200000 ---        22 50200001-50300000 |         7
##    [5]        22 50200001-50300000 ---        22 50200001-50300000 |        31
##    ...       ...               ... ...       ...               ... .       ...
##   [66]        22 50400001-50500000 ---        22 51200001-51300000 |         1
##   [67]        22 50500001-50600000 ---        22 51200001-51300000 |         2
##   [68]        22 50800001-50900000 ---        22 51200001-51300000 |         2
##   [69]        22 51100001-51200000 ---        22 51200001-51300000 |         3
##   [70]        22 51200001-51300000 ---        22 51200001-51300000 |         5
##   -------
##   regions: 13 ranges and 0 metadata columns
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

Another widely used genomic interaction data format is `.cool` files and the cooler index contains analyzed HiC data for hg19 and mm9 from many different sources. Those files can be used as data resources for visualizations and annotations (see [ChIPpeakAnno::findEnhancers](https://rdrr.io/bioc/ChIPpeakAnno/man/findEnhancers.html)). The `importGInteractions` function can also be used to import data from `.cool` format (trackViewer version>=1.27.6).

```
cool <- system.file("extdata", "test.mcool", package = "trackViewer",
                     mustWork=TRUE)
importGInteractions(file=cool, format="cool",
                    resolution = 2,
                    ranges=GRanges("chr1", IRanges(10, 28)),
                    out = "GInteractions")
```

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

other attached packages: [1] InteractionSet\_1.38.0
[2] motifStack\_1.54.0
[3] httr\_1.4.7
[4] VariantAnnotation\_1.56.0
[5] Rsamtools\_2.26.0
[6] Biostrings\_2.78.0
[7] XVector\_0.50.0
[8] SummarizedExperiment\_1.40.0
[9] MatrixGenerics\_1.22.0
[10] matrixStats\_1.5.0
[11] org.Hs.eg.db\_3.22.0
[12] TxDb.Hsapiens.UCSC.hg19.knownGene\_3.22.1 [13] GenomicFeatures\_1.62.0
[14] AnnotationDbi\_1.72.0
[15] Biobase\_2.70.0
[16] Gviz\_1.54.0
[17] rtracklayer\_1.70.0
[18] trackViewer\_1.46.0
[19] GenomicRanges\_1.62.0
[20] Seqinfo\_1.0.0
[21] IRanges\_2.44.0
[22] S4Vectors\_0.48.0
[23] BiocGenerics\_0.56.0
[24] generics\_0.1.4

loaded via a namespace (and not attached): [1] RColorBrewer\_1.1-3 strawr\_0.0.92
[3] rstudioapi\_0.17.1 jsonlite\_2.0.0
[5] magrittr\_2.0.4 farver\_2.1.2
[7] rmarkdown\_2.30 BiocIO\_1.20.0
[9] vctrs\_0.6.5 Cairo\_1.7-0
[11] memoise\_2.0.1 RCurl\_1.98-1.17
[13] base64enc\_0.1-3 htmltools\_0.5.8.1
[15] S4Arrays\_1.10.0 progress\_1.2.3
[17] curl\_7.0.0 Rhdf5lib\_1.32.0
[19] SparseArray\_1.10.0 Formula\_1.2-5
[21] rhdf5\_2.54.0 sass\_0.4.10
[23] bslib\_0.9.0 htmlwidgets\_1.6.4
[25] httr2\_1.2.1 cachem\_1.1.0
[27] GenomicAlignments\_1.46.0 lifecycle\_1.0.4
[29] pkgconfig\_2.0.3 Matrix\_1.7-4
[31] R6\_2.6.1 fastmap\_1.2.0
[33] digest\_0.6.37 TFMPvalue\_0.0.9
[35] colorspace\_2.1-2 Hmisc\_5.2-4
[37] RSQLite\_2.4.3 seqLogo\_1.76.0
[39] filelock\_1.0.3 abind\_1.4-8
[41] compiler\_4.5.1 bit64\_4.6.0-1
[43] htmlTable\_2.4.3 S7\_0.2.0
[45] backports\_1.5.0 BiocParallel\_1.44.0
[47] DBI\_1.2.3 biomaRt\_2.66.0
[49] MASS\_7.3-65 rappdirs\_0.3.3
[51] DelayedArray\_0.36.0 rjson\_0.2.23
[53] gtools\_3.9.5 caTools\_1.18.3
[55] tools\_4.5.1 foreign\_0.8-90
[57] nnet\_7.3-20 glue\_1.8.0
[59] restfulr\_0.0.16 rhdf5filters\_1.22.0
[61] checkmate\_2.3.3 ade4\_1.7-23
[63] cluster\_2.1.8.1 TFBSTools\_1.48.0
[65] gtable\_0.3.6 BSgenome\_1.78.0
[67] ensembldb\_2.34.0 data.table\_1.17.8
[69] hms\_1.1.4 pillar\_1.11.1
[71] stringr\_1.5.2 dplyr\_1.1.4
[73] BiocFileCache\_3.0.0 lattice\_0.22-7
[75] bit\_4.6.0 deldir\_2.0-4
[77] biovizBase\_1.58.0 DirichletMultinomial\_1.52.0 [79] tidyselect\_1.2.1 knitr\_1.50
[81] gridExtra\_2.3 grImport2\_0.3-3
[83] ProtGenerics\_1.42.0 xfun\_0.53
[85] stringi\_1.8.7 UCSC.utils\_1.6.0
[87] lazyeval\_0.2.2 yaml\_2.3.10
[89] evaluate\_1.0.5 codetools\_0.2-20
[91] cigarillo\_1.0.0 interp\_1.1-6
[93] tibble\_3.3.0 BiocManager\_1.30.26
[95] cli\_3.6.5 rpart\_4.1.24
[97] jquerylib\_0.1.4 dichromat\_2.0-0.1
[99] Rcpp\_1.1.0 GenomeInfoDb\_1.46.0
[101] grImport\_0.9-7 dbplyr\_2.5.1
[103] png\_0.1-8 XML\_3.99-0.19
[105] parallel\_4.5.1 ggplot2\_4.0.0
[107] blob\_1.2.4 prettyunits\_1.2.0
[109] latticeExtra\_0.6-31 jpeg\_0.1-11
[111] AnnotationFilter\_1.34.0 bitops\_1.0-9
[113] pwalign\_1.6.0 txdbmaker\_1.6.0
[115] scales\_1.4.0 crayon\_1.5.3
[117] BiocStyle\_2.38.0 rlang\_1.1.6
[119] KEGGREST\_1.50.0