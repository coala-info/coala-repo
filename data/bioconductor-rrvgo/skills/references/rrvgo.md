# Using the rrvgo package

Sergi Sayols

#### 2025-10-30

# Contents

* [1 Introduction to rrvgo](#introduction-to-rrvgo)
* [2 Using rrvgo](#using-rrvgo)
  + [2.1 Getting started](#getting-started)
  + [2.2 Calculating the similarity matrix and reducing GO terms](#calculating-the-similarity-matrix-and-reducing-go-terms)
  + [2.3 Plotting and interpretation](#plotting-and-interpretation)
    - [2.3.1 Similarity matrix heatmap](#similarity-matrix-heatmap)
    - [2.3.2 Scatter plot depicting groups and distance between terms](#scatter-plot-depicting-groups-and-distance-between-terms)
    - [2.3.3 Treemap plot](#treemap-plot)
    - [2.3.4 Word cloud](#word-cloud)
  + [2.4 Shiny app](#shiny-app)
* [3 Currently supported](#currently-supported)
  + [3.1 Similarity methods](#similarity-methods)
  + [3.2 Organisms](#organisms)
  + [3.3 Gene Ontologies](#gene-ontologies)
* [4 Demo data](#demo-data)
* [5 Citing rrvgo](#citing-rrvgo)
  + [5.1 Reporting problems or bugs](#reporting-problems-or-bugs)
  + [5.2 Session info](#session-info)

# 1 Introduction to rrvgo

Gene Ontologies (GO) are often used to guide the interpretation of high-throughput
omics experiments, with lists of differentially regulated genes being summarized
into sets of genes with a common functional representation. Due to the hierachical
nature of Gene Ontologies, the resulting lists of enriched sets are usually
redundant and difficult to interpret.

`rrvgo` aims at simplifying the redundance of GO sets by grouping similar terms
based on their semantic similarity. It also provides some plots to help with
interpreting the summarized terms.

This software is heavily influenced by [REVIGO](http://revigo.irb.hr/). It mimics
a good part of its core functionality, and even some of the outputs are similar.
Without aims to compete, `rrvgo` tries to offer a programatic interface using
available annotation databases and semantic similarity methods implemented in the
Bioconductor project.

# 2 Using rrvgo

## 2.1 Getting started

Starting with a list of genes of interest (eg. coming from a differential expression
analysis), apply any method for the identification of eneriched GO terms (see
[GOStats](https://www.bioconductor.org/packages/release/bioc/html/GOstats.html) or
[GSEA](https://www.gsea-msigdb.org/gsea/index.jsp%5D)).

`rrvgo` does not care about genes, but GO terms. The input is a vector of enriched
GO terms, along with (recommended, but not mandatory) a vector of scores. If scores
are not provided, `rrvgo` takes the GO term (set) size as a score, thus favoring
*broader* terms.

## 2.2 Calculating the similarity matrix and reducing GO terms

First step is to get the similarity matrix between terms. The function `calculateSimMatrix`
takes a list of GO terms for which the semantic simlarity is to be calculated,
an `OrgDb` object for an organism, the ontology of interest and the method to
calculate the similarity scores.

```
library(rrvgo)
go_analysis <- read.delim(system.file("extdata/example.txt", package="rrvgo"))
simMatrix <- calculateSimMatrix(go_analysis$ID,
                                orgdb="org.Hs.eg.db",
                                ont="BP",
                                method="Rel")
```

The `semdata` parameter (see `?calculateSimMatrix`) is not mandatory as it is
calculated on demand. If the function needs to run several times with the same
organism, it’s advisable to save the `GOSemSim::godata(orgdb, ont=ont)` object,
in order to reuse it between calls and speedup the calculation of the similarity
matrix.

From the similarity matrix one can group terms based on similarity. `rrvgo`
provides the `reduceSimMatrix` function for that. It takes as arguments i) the
similarity matrix, ii) an optional *named* vector of scores associated to each
GO term, iii) a similarity threshold used for grouping terms, and iv) an orgdb
object.

```
scores <- setNames(-log10(go_analysis$qvalue), go_analysis$ID)
reducedTerms <- reduceSimMatrix(simMatrix,
                                scores,
                                threshold=0.7,
                                orgdb="org.Hs.eg.db")
```

`reduceSimMatrix` groups terms which are at least within a similarity below
`threshold`, and selects as the group representative the term with the higher
score within the group. In case the vector of scores is not available,
`reduceSimMatrix` can either use the *uniqueness* of a term (default), or the
GO term *size*. In the case of *size*, `rrvgo` will fetch the GO term size from
the `OrgDb` object and use it as the score, thus favoring broader terms.
**Please note that scores are interpreted in the direction that higher are
better**, therefore if you use p-values as scores, minus log-transform them
before.

**NOTE:**`rrvgo` uses the similarity between pairs of terms to compute a distance
matrix, defined as `(1-simMatrix)`. The terms are then hierarchically clustered
using complete linkage, and the tree is cut at the desired threshold, picking
the term with the highest score as the representative of each group.
Therefore, higher thresholds lead to fewer groups, and the threshold should be
read as the minimum similarity between group representatives.

## 2.3 Plotting and interpretation

`rrvgo` provides several methods for plotting and interpreting the results.

### 2.3.1 Similarity matrix heatmap

Plot similarity matrix as a heatmap, with clustering of columns of rows turned
on by default (thus arranging together similar terms).

```
heatmapPlot(simMatrix,
            reducedTerms,
            annotateParent=TRUE,
            annotationLabel="parentTerm",
            fontsize=6)
```

![](data:image/png;base64...)

The function internally uses [`pheatmap`](https://cran.r-project.org/web/packages/pheatmap/index.html),
and further parameters can be passed to this function.

### 2.3.2 Scatter plot depicting groups and distance between terms

Plot GO terms as scattered points. Distances between points represent the
similarity between terms, and axes are the first 2 components of applying a PCoA
to the (di)similarity matrix. Size of the point represents the provided scores
or, in its absence, the number of genes the GO term contains.

```
scatterPlot(simMatrix, reducedTerms)
```

![](data:image/png;base64...)

### 2.3.3 Treemap plot

Treemaps are space-filling visualization of hierarchical structures. The terms
are grouped (colored) based on their parent, and the space used by the term is
proportional to the score. Treemaps can help with the interpretation of the
summarized results and also comparing differents sets of GO terms.

```
treemapPlot(reducedTerms)
```

![](data:image/png;base64...)

treemap

The function internally uses [`treemap`](https://cran.r-project.org/web/packages/treemap/index.html),
and further parameters can be passed to this function.

### 2.3.4 Word cloud

Word clouds are visualizations which reproduce a text putting emphasis to words
which appear frequently in a text. They can help to identify processes and
functions that happen more commonly in a set of enriched GO terms, as well as
comparing between different sets.

```
wordcloudPlot(reducedTerms, min.freq=1, colors="black")
```

![](data:image/png;base64...)

The function internally uses [`wrodcloud`](https://cran.r-project.org/web/packages/wordcloud/index.html),
and further parameters can be passed to this function.

## 2.4 Shiny app

To make the software more accessible to a non-technical audience, `rrvgo`
packages a shiny app which can be accessed calling the `shiny_rrvgo()` function
from the R console.

```
rrvgo::shiny_rrvgo()
```

![](data:image/png;base64...)

shiny\_app

The app offers *interactive* access to the plots and tables calculated by `rrvgo`.

# 3 Currently supported

## 3.1 Similarity methods

All similarity measures available are those implemented in the
[GOSemSim package](https://www.bioconductor.org/packages/release/bioc/html/GOSemSim.html),
namely the Resnik, Lin, Relevance, Jiang and Wang methods. See the
[Semantic Similarity Measurement Based on GO](https://www.bioconductor.org/packages/release/bioc/vignettes/GOSemSim/inst/doc/GOSemSim.html#semantic-similarity-measurement-based-on-go)
section from the GOSeSim documentation for more details.

## 3.2 Organisms

Bioconductor current provides `OrgDb` objects for [20 species](https://www.bioconductor.org/packages/release/BiocViews.html#___OrgDb)
provided by the following packages:

| Package | Organism |
| --- | --- |
| org.Ag.eg.db | Anopheles |
| org.At.tair.db | Arabidopsis |
| org.Bt.eg.db | Bovine |
| org.Ce.eg.db | Worm |
| org.Cf.eg.db | Canine |
| org.Dm.eg.db | Fly |
| org.Dr.eg.db | Zebrafish |
| org.EcK12.eg.db | E coli strain K12 |
| org.EcSakai.eg.db | E coli strain Sakai |
| org.Gg.eg.db | Chicken |
| org.Hs.eg.db | Human |
| org.Mm.eg.db | Mouse |
| org.Mmu.eg.db | Rhesus |
| org.Mxanthus.db | Myxococcus xanthus DK 1622 |
| org.Pf.plasmo.db | Malaria |
| org.Pt.eg.db | Chimp |
| org.Rn.eg.db | Rat |
| org.Sc.sgd.db | Yeast |
| org.Ss.eg.db | Pig |
| org.Xl.eg.db | Xenopus |

If the organism is not supported in Bioconductor, you can still build your own
`OrgDb` object usign the [`AnnotationForge`](https://bioconductor.org/packages/release/bioc/html/AnnotationForge.html)
package and rendering the necessary data for semantic similarity using the
`GOSemSim` package with:

```
my_new_fancy_orgdb_object <- 'org.Zz.eg.db'
hsGO <- GOSemSim::godata(my_new_fancy_orgdb_object, ont="MF")
```

## 3.3 Gene Ontologies

One of *Biologiocal Process* (BP), *Molecular Function* (MF) or *Cellular Compartment* (CC).

# 4 Demo data

Taken as is from the [DOSE package](https://www.bioconductor.org/packages/release/bioc/html/DOSE.html),
which was derived from the R package [breastCancerMAINZ](https://www.bioconductor.org/packages/release/bioc/html/breastCancerMAINZ.html).
It contains 200 samples with breast cancer at different grades (I, II and III).
The dataset basically contains log2 ratios of the geometric means of grade III
vs. grade I samples ( 34 vs. 29 repectively).

# 5 Citing rrvgo

Please consider citing rrvgo if used in support of your own research:

```
citation("rrvgo")
```

```
## To cite package 'rrvgo' in publications use:
##
##   Sayols, S (2023). rrvgo: a Bioconductor package for interpreting
##   lists of Gene Ontology terms. microPublication Biology.
##   10.17912/micropub.biology.000811
##
## A BibTeX entry for LaTeX users is
##
##   @Article{,
##     title = {rrvgo: a Bioconductor package to reduce and visualize Gene Ontology terms},
##     author = {Sergi Sayols},
##     year = {2023},
##     journal = {microPublication Biology},
##     doi = {10.17912/micropub.biology.000811},
##     url = {https://www.micropublication.org/journals/biology/micropub-biology-000811},
##   }
```

## 5.1 Reporting problems or bugs

If you run into problems using rrvgo, the [Bioconductor Support site](https://support.bioconductor.org/) is a good first place to ask for help. If you think there is a bug or an unreported feature, you can report it using the [rrvgo github site](https://github.com/ssayols/rrvgo/).

## 5.2 Session info

The following package and versions were used in the production of this vignette.

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] rrvgo_1.22.0     knitr_1.50       BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1     gridBase_0.4-7       dplyr_1.1.4
##  [4] farver_2.1.2         blob_1.2.4           R.utils_2.13.0
##  [7] Biostrings_2.78.0    S7_0.2.0             fastmap_1.2.0
## [10] treemap_2.4-4        promises_1.4.0       digest_0.6.37
## [13] mime_0.13            lifecycle_1.0.4      NLP_0.3-2
## [16] KEGGREST_1.50.0      RSQLite_2.4.3        magrittr_2.0.4
## [19] compiler_4.5.1       rlang_1.1.6          sass_0.4.10
## [22] tools_4.5.1          wordcloud_2.6        igraph_2.2.1
## [25] yaml_2.3.10          data.table_1.17.8    labeling_0.4.3
## [28] askpass_1.2.1        bit_4.6.0            reticulate_1.44.0
## [31] xml2_1.4.1           RColorBrewer_1.1-3   withr_3.0.2
## [34] BiocGenerics_0.56.0  R.oo_1.27.1          grid_4.5.1
## [37] stats4_4.5.1         GOSemSim_2.36.0      xtable_1.8-4
## [40] tm_0.7-16            colorspace_2.1-2     GO.db_3.22.0
## [43] ggplot2_4.0.0        scales_1.4.0         tinytex_0.57
## [46] dichromat_2.0-0.1    cli_3.6.5            rmarkdown_2.30
## [49] crayon_1.5.3         generics_0.1.4       otel_0.2.0
## [52] umap_0.2.10.0        RSpectra_0.16-2      httr_1.4.7
## [55] DBI_1.2.3            cachem_1.1.0         parallel_4.5.1
## [58] AnnotationDbi_1.72.0 BiocManager_1.30.26  XVector_0.50.0
## [61] yulab.utils_0.2.1    vctrs_0.6.5          Matrix_1.7-4
## [64] jsonlite_2.0.0       slam_0.1-55          bookdown_0.45
## [67] IRanges_2.44.0       S4Vectors_0.48.0     bit64_4.6.0-1
## [70] ggrepel_0.9.6        magick_2.9.0         jquerylib_0.1.4
## [73] glue_1.8.0           codetools_0.2-20     gtable_0.3.6
## [76] later_1.4.4          tibble_3.3.0         pillar_1.11.1
## [79] rappdirs_0.3.3       htmltools_0.5.8.1    Seqinfo_1.0.0
## [82] openssl_2.3.4        R6_2.6.1             lattice_0.22-7
## [85] evaluate_1.0.5       shiny_1.11.1         Biobase_2.70.0
## [88] R.methodsS3_1.8.2    png_0.1-8            pheatmap_1.0.13
## [91] memoise_2.0.1        httpuv_1.6.16        bslib_0.9.0
## [94] Rcpp_1.1.0           org.Hs.eg.db_3.22.0  xfun_0.53
## [97] fs_1.6.6             pkgconfig_2.0.3
```