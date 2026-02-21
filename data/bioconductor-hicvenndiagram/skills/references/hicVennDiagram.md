# hicVennDiagram Vignette: overview

#### Jianhong Ou

#### 30 October 2025

# Introduction

When comparing samples, it is common to perform the task of identifying overlapping loops among two or more sets of genomic interactions. Traditionally, this is achieved through the use of visualizations such as `vennDiagram` or `UpSet` plots. However, it is frequently observed that the total count displayed in these plots does not match the original counts for each individual list. The reason behind this discrepancy is that a single overlap may encompass multiple interactions for one or more samples. This issue is extensively discussed in the realm of overlapping caller for ChIP-Seq peaks.

The *hicVennDiagram* aims to provide a easy to use tool for overlapping interactions calculation and proper visualization methods. The *hicVennDiagram* generates plots specifically crafted to eliminate the deceptive visual representation caused by the counts method.

# Quick start

Here is an example using *hicVennDiagram* with 3 files in `BEDPE` format.

## Installation

First, install *hicVennDiagram* and other packages required to run the examples.

```
library(BiocManager)
BiocManager::install("hicVennDiagram")
```

## Load library

```
library(hicVennDiagram)
library(ggplot2)
```

```
# list the BEDPE files
file_folder <- system.file("extdata",
                           package = "hicVennDiagram",
                           mustWork = TRUE)
file_list <- dir(file_folder, pattern = ".bedpe", full.names = TRUE)
names(file_list) <- sub(".bedpe", "", basename(file_list))
basename(file_list)
```

```
## [1] "group1.bedpe" "group2.bedpe" "group3.bedpe"
```

```
venn <- vennCount(file_list)
## upset plot
## temp fix for https://github.com/krassowski/complex-upset/pull/212
upset_themes_fix <- list(
    intersections_matrix=list(
      ggplot2::theme_minimal(),
      ggplot2::theme(
        # hide intersections
        axis.text.x=ggplot2::element_blank(),
        axis.ticks.x=ggplot2::element_blank(),
        # hide group title
        axis.title.y=ggplot2::element_blank()
      )
    ),
    'Intersection size'=list(
      ggplot2::theme_minimal(),
      ggplot2::theme(
        axis.text.x=ggplot2::element_blank(),
        axis.title.x=ggplot2::element_blank()
      )
    ),
    overall_sizes=list(
      ggplot2::theme_minimal(),
      ggplot2::theme(
        # hide groups
        axis.title.y=ggplot2::element_blank(),
        axis.text.y=ggplot2::element_blank(),
        axis.ticks.y=ggplot2::element_blank()
      )
    ),
    default=list(
      ggplot2::theme_minimal(),
      ggplot2::theme(
        axis.text.x=ggplot2::element_blank(),
        axis.title.x=ggplot2::element_blank()
      )
    )
  )
upsetPlot(venn, themes = upset_themes_fix)
```

![](data:image/png;base64...)

```
## venn plot
vennPlot(venn)
```

![](data:image/png;base64...)

```
## use browser to adjust the text position, and shape colors.
browseVenn(vennPlot(venn))
```

# Details about `vennCount`

The `vennCount` function borrows the power of `InteractionSet:findOverlaps` to calculate the overlaps and then summarizes the results for each category. Users may want to try different combinations of `maxgap` and `minoverlap` parameters to calculate the overlapping loops.

```
venn <- vennCount(file_list, maxgap=50000, FUN = max) # by default FUN = min
upsetPlot(venn, label_all=list(
                          na.rm = TRUE,
                          color = 'black',
                          alpha = .9,
                          label.padding = unit(0.1, "lines")
                      ),
          themes = upset_themes_fix)
```

![](data:image/png;base64...)

# Plot for overlapping peaks output by `ChIPpeakAnno`

```
library(ChIPpeakAnno)
bed <- system.file("extdata", "MACS_output.bed", package="ChIPpeakAnno")
gr1 <- toGRanges(bed, format="BED", header=FALSE)
gff <- system.file("extdata", "GFF_peaks.gff", package="ChIPpeakAnno")
gr2 <- toGRanges(gff, format="GFF", header=FALSE, skip=3)
ol <- findOverlapsOfPeaks(gr1, gr2)
overlappingPeaksToVennTable <- function(.ele){
    .venn <- .ele$venn_cnt
    k <- which(colnames(.venn)=="Counts")
    rownames(.venn) <- apply(.venn[, seq.int(k-1)], 1, paste, collapse="")
    colnames(.venn) <- sub("count.", "", colnames(.venn))
    vennTable(combinations=.venn[, seq.int(k-1)],
              counts=.venn[, k],
              vennCounts=.venn[, seq.int(ncol(.venn))[-seq.int(k)]])
}
venn <- overlappingPeaksToVennTable(ol)
vennPlot(venn)
```

![](data:image/png;base64...)

```
## or you can simply try vennPlot(vennCount(c(bed, gff)))
upsetPlot(venn, themes = upset_themes_fix)
```

![](data:image/png;base64...)

```
## change the font size of labels and numbers
updated_theme <- list(
    intersections_matrix=list(
      ggplot2::theme_minimal(),
      ggplot2::theme(
        # hide intersections
        axis.text.x=ggplot2::element_blank(),
        axis.ticks.x=ggplot2::element_blank(),
        # hide group title
        axis.title.y=ggplot2::element_blank(),
        ## font size of label: gr1/gr2
        axis.text.y=ggplot2::element_text(size=24),
        ## font size of label `group`
        axis.title.x=ggplot2::element_text(size=24)
      )
    ),
    'Intersection size'=list(
      ggplot2::theme_minimal(),
      ggplot2::theme(
          ## font size of y-axis 0-150
          axis.text=ggplot2::element_text(size=20),
          ## font size of y-label `Intersection size`
          axis.title=ggplot2::element_text(size=16),
          axis.text.x=ggplot2::element_blank(),
          axis.title.x=ggplot2::element_blank()
      )
    ),
    overall_sizes=list(
      ggplot2::theme_minimal(),
      ggplot2::theme(
        ## font size of x-axis 0-200
        axis.text=ggplot2::element_text(size=12),
        ## font size of x-label `Set size`
        axis.title=ggplot2::element_text(size=18),
        # hide groups
        axis.title.y=ggplot2::element_blank(),
        axis.text.y=ggplot2::element_blank(),
        axis.ticks.y=ggplot2::element_blank()
      )
    ),
    default=list(
      ggplot2::theme_minimal(),
      ggplot2::theme(
        axis.text.x=ggplot2::element_blank(),
        axis.title.x=ggplot2::element_blank()
      )
    )
  )

# The following code will work after the merging of https://github.com/krassowski/complex-upset/pull/212
# updated_theme <- ComplexUpset::upset_modify_themes(
#               ## get help by vignette('Examples_R', package = 'ComplexUpset')
#               list('intersections_matrix'=
#                        ggplot2::theme(
#                            ## font size of label: gr1/gr2
#                            axis.text.y=ggplot2::element_text(size=24),
#                            ## font size of label `group`
#                            axis.title.x=ggplot2::element_text(size=24)),
#                    'overall_sizes'=
#                        ggplot2::theme(
#                            ## font size of x-axis 0-200
#                            axis.text=ggplot2::element_text(size=12),
#                            ## font size of x-label `Set size`
#                            axis.title=ggplot2::element_text(size=18)),
#                    'Intersection size'=
#                        ggplot2::theme(
#                            ## font size of y-axis 0-150
#                            axis.text=ggplot2::element_text(size=20),
#                            ## font size of y-label `Intersection size`
#                            axis.title=ggplot2::element_text(size=16)
#                        ),
#                    'default'=ggplot2::theme_minimal())
#               )
# updated_theme <- lapply(updated_theme, function(.ele){
#     lapply(.ele, function(.e){
#         do.call(theme, .e[names(.e) %in% names(formals(theme))])
#     })
# })
upsetPlot(venn,
          label_all=list(na.rm = TRUE, color = 'gray30', alpha = .7,
                         label.padding = unit(0.1, "lines"),
                         size = 8 #control the font size of the individual num
                         ),
          base_annotations=list('Intersection size'=
                                    ComplexUpset::intersection_size(
                                        ## font size of counts in the bar-plot
                                        text = list(size=6)
                                        )),
          themes = updated_theme
          )
```

![](data:image/png;base64...)

# GLEAM test

Genomic Loops Enrichment Analysis Method (GLEAM) do enrichment analysis like GREAT (Genomic Regions Enrichment of Annotations Tool) for the interactions.

```
pd <- system.file("extdata", package = "hicVennDiagram", mustWork = TRUE)
fs <- dir(pd, pattern = ".bedpe", full.names = TRUE)
fs <- fs[!grepl('group1', fs)] # make the test data smaller
set.seed(123)
background <- createGIbackground(fs)
gleamTest(fs, background = background, method = 'binom')
```

```
##                                         proportions query_events
## group2.bedpe_enriched_with_group3.bedpe   0.7517782         5621
##                                         overlapping_events expected_events
## group2.bedpe_enriched_with_group3.bedpe               2737        4225.745
##                                         pvalue
## group2.bedpe_enriched_with_group3.bedpe      1
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

attached base packages: [1] stats4 stats graphics grDevices utils datasets methods
[8] base

other attached packages: [1] ChIPpeakAnno\_3.44.0
[2] ggplot2\_4.0.0
[3] TxDb.Hsapiens.UCSC.hg38.knownGene\_3.22.0 [4] GenomicFeatures\_1.62.0
[5] AnnotationDbi\_1.72.0
[6] Biobase\_2.70.0
[7] GenomicRanges\_1.62.0
[8] Seqinfo\_1.0.0
[9] IRanges\_2.44.0
[10] S4Vectors\_0.48.0
[11] BiocGenerics\_0.56.0
[12] generics\_0.1.4
[13] hicVennDiagram\_1.8.0

loaded via a namespace (and not attached): [1] eulerr\_7.0.4 RColorBrewer\_1.1-3
[3] jsonlite\_2.0.0 magrittr\_2.0.4
[5] farver\_2.1.2 rmarkdown\_2.30
[7] BiocIO\_1.20.0 ragg\_1.5.0
[9] vctrs\_0.6.5 multtest\_2.66.0
[11] memoise\_2.0.1 Rsamtools\_2.26.0
[13] RCurl\_1.98-1.17 htmltools\_0.5.8.1
[15] S4Arrays\_1.10.0 progress\_1.2.3
[17] lambda.r\_1.2.4 curl\_7.0.0
[19] ComplexUpset\_1.3.3 SparseArray\_1.10.0
[21] sass\_0.4.10 bslib\_0.9.0
[23] htmlwidgets\_1.6.4 plyr\_1.8.9
[25] httr2\_1.2.1 futile.options\_1.0.1
[27] cachem\_1.1.0 GenomicAlignments\_1.46.0
[29] lifecycle\_1.0.4 pkgconfig\_2.0.3
[31] Matrix\_1.7-4 R6\_2.6.1
[33] fastmap\_1.2.0 MatrixGenerics\_1.22.0
[35] digest\_0.6.37 colorspace\_2.1-2
[37] patchwork\_1.3.2 regioneR\_1.42.0
[39] textshaping\_1.0.4 RSQLite\_2.4.3
[41] filelock\_1.0.3 labeling\_0.4.3
[43] httr\_1.4.7 polyclip\_1.10-7
[45] abind\_1.4-8 compiler\_4.5.1
[47] bit64\_4.6.0-1 withr\_3.0.2
[49] S7\_0.2.0 BiocParallel\_1.44.0
[51] DBI\_1.2.3 biomaRt\_2.66.0
[53] MASS\_7.3-65 rappdirs\_0.3.3
[55] DelayedArray\_0.36.0 rjson\_0.2.23
[57] tools\_4.5.1 glue\_1.8.0
[59] VennDiagram\_1.7.3 restfulr\_0.0.16
[61] InteractionSet\_1.38.0 grid\_4.5.1
[63] polylabelr\_0.3.0 reshape2\_1.4.4
[65] BSgenome\_1.78.0 gtable\_0.3.6
[67] tidyr\_1.3.1 ensembldb\_2.34.0
[69] data.table\_1.17.8 hms\_1.1.4
[71] XVector\_0.50.0 pillar\_1.11.1
[73] stringr\_1.5.2 splines\_4.5.1
[75] dplyr\_1.1.4 BiocFileCache\_3.0.0
[77] lattice\_0.22-7 survival\_3.8-3
[79] rtracklayer\_1.70.0 bit\_4.6.0
[81] universalmotif\_1.28.0 tidyselect\_1.2.1
[83] RBGL\_1.86.0 Biostrings\_2.78.0
[85] knitr\_1.50 ProtGenerics\_1.42.0
[87] SummarizedExperiment\_1.40.0 svglite\_2.2.2
[89] futile.logger\_1.4.3 xfun\_0.53
[91] matrixStats\_1.5.0 stringi\_1.8.7
[93] UCSC.utils\_1.6.0 lazyeval\_0.2.2
[95] yaml\_2.3.10 evaluate\_1.0.5
[97] codetools\_0.2-20 cigarillo\_1.0.0
[99] tibble\_3.3.0 BiocManager\_1.30.26
[101] graph\_1.88.0 cli\_3.6.5
[103] systemfonts\_1.3.1 jquerylib\_0.1.4
[105] dichromat\_2.0-0.1 Rcpp\_1.1.0
[107] GenomeInfoDb\_1.46.0 dbplyr\_2.5.1
[109] png\_0.1-8 XML\_3.99-0.19
[111] parallel\_4.5.1 blob\_1.2.4
[113] prettyunits\_1.2.0 AnnotationFilter\_1.34.0
[115] bitops\_1.0-9 pwalign\_1.6.0
[117] scales\_1.4.0 purrr\_1.1.0
[119] crayon\_1.5.3 BiocStyle\_2.38.0
[121] rlang\_1.1.6 KEGGREST\_1.50.0
[123] formatR\_1.14