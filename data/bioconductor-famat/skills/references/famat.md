# famat

Emilie Secherre

#### 26 January 2026

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 path\_enrich](#path_enrich)
* [4 interactions](#interactions)
* [5 compl\_data](#compl_data)
* [6 rshiny](#rshiny)
* [7 Conclusion: how to use famat](#conclusion-how-to-use-famat)
* [8 References](#references)
* **Appendix**
* [A Session Info](#session-info)

# 1 Introduction

The aim of *famat* is to allow users to determine functional
links between metabolites and genes. These metabolites and genes lists may
be related to a specific experiment/study, but *famat* only
needs a gene symbols list and a Kegg Compound ids list. Using these lists,
*famat* performs pathway enrichment analysis, direct interactions
between elements inside pathways extraction, GO terms enrichment analysis,
calculation of user’s elements centrality (number of direct interactions
between an element and others inside a pathway) and extraction of information
related to user’s elements.

Functions available are:

* path\_enrich : pathways enrichment analysis
* interactions : direct interactions and centrality
* compl\_data : GO terms enrichment analysis and user’s elements data
  extraction
* rshiny : use of previous function’s data in a shiny interface

# 2 Installation

Run this command line to install *famat*.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("famat")
```

Then, load *famat* using library.

```
library(famat)
library(mgcv)
```

# 3 path\_enrich

This function uses the metabolite list and the gene list provided by user to
perform pathway enrichment analysis. Metabolites ids need to be Kegg compound
ids, and genes ids need to be gene symbols. Three pathway databases are
available: Kegg (“KEGG”), Wikipathways (“WP”) and Reactome (“REAC”).

```
data(genes)
data(meta)

listr=path_enrich("REAC", meta, genes)
```

```
##
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
## Loading required package: org.Hs.eg.db
```

```
## Loading required package: AnnotationDbi
```

```
## Loading required package: stats4
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: generics
```

```
##
## Attaching package: 'generics'
```

```
## The following objects are masked from 'package:base':
##
##     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
##     setequal, union
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
##     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
##     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
##     unsplit, which.max, which.min
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
## Loading required package: IRanges
```

```
## Loading required package: S4Vectors
```

```
##
## Attaching package: 'S4Vectors'
```

```
## The following object is masked from 'package:utils':
##
##     findMatches
```

```
## The following objects are masked from 'package:base':
##
##     I, expand.grid, unname
```

```
##
## Attaching package: 'IRanges'
```

```
## The following object is masked from 'package:nlme':
##
##     collapse
```

```
## your input componentList have 2 components in background
```

```
## your input componentList have 2 components in network
```

Results are then stored into a list. This list must be used in “interactions”
function.
Pathways enrichment analysis is performed on genes using
*[gprofiler2](https://CRAN.R-project.org/package%3Dgprofiler2)* and on metabolites using *[MPINet](https://CRAN.R-project.org/package%3DMPINet)*.

# 4 interactions

“Interactions” find all direct interactions between genes and metabolites of
user’s lists in pathways obtained through pathways enrichment analysis,
performed on KEGG, Reactome and Wikipathways pathways. So, this function
needs results of “path\_enrich” function performed on all these databases.
Using direct interactions, centrality of a user’s element inside a pathway
is calculated.

```
data(listk)
data(listr)
data(listw)
data(all_compounds_chebi)
interactions_result = interactions(listk, listr, listw)
```

Results are then stored into a list. This list must be used in “compl\_data”
function.
Direct interactions were collected from BioPax, KGML and GPML files parsed
with *[PaxtoolsR](https://bioconductor.org/packages/3.22/PaxtoolsR)*, *[graphite](https://bioconductor.org/packages/3.22/graphite)* and author’s parsers.
“Interactions” just get interactions of enriched pathways from this direct
interactions list.

# 5 compl\_data

This function complete information about elements and pathway obtained with
“path\_enrich” and “interactions”. A GO term enrichment analysis is performed
on genes, pathways obtained through pathways enrichment analysis are filtered
(they must contain at least 1/5 elements in user’s lists or a direct
interaction between user’s elements) and a hierarchy parent-child is built
with pathways and enriched GO terms. GO terms enrichment analysis is performed
using *[clusterProfiler](https://bioconductor.org/packages/3.22/clusterProfiler)*. Then, dataframes containing information
about elements, interactions and GO terms are created, with an heatmap showing
which user’s elements are in which pathways.

```
data(interactions_result)

compl_data_result <- compl_data(interactions_result)
```

Results are then stored into a list. This list must be used in “rshiny”
function.

# 6 rshiny

All results obtained with the three previous functions can be visualized using
“rshiny” function. *[shiny](https://CRAN.R-project.org/package%3Dshiny)* is a R package allowing to create
interfaces.

```
data(compl_data_result)

rshiny(compl_data_result)
```

After using this command line, the *[shiny](https://CRAN.R-project.org/package%3Dshiny)* interface appear.

![test](data:image/png;base64...)
Interface’s tabs are:

* Elements : Genes, metabolites, interactions, and information related
  to these elements. Also, filters can be applied to get pathways/enriched
  GO terms containing (or not) only certain elements.
* Pathways : Heatmap showing pathways hierarchies and user’s elements
  in these pathways. Filters can be applied to get pathways corresponding
  to certain pathways or interactions types, or to filter genes by their type
  or enriched GO terms. Also, the heatmap can be colored using interactions
  types or centrality. Finally, click on a heatmap’s cell makes a pop up
  appear, with information about the pathway selected.
* GO Molecular Function : Enriched GO MF terms hierarchies with
  information about them. Click on a GO term makes a pop up appear with data
  about the GO term selected.
* GO Biological Process : Enriched GO BP terms hierarchies with
  information about them. Click on a GO term makes a pop up appear with data
  about the GO term selected.
* History : Every time a filter is applied, new results are saved in
  history. So, user can go back if a mistake was done.
* Elements not in pathways : some user’s elements may not be in pathways
  obtained by pathways enrichment analysis and filtered by compl\_data
  function. So, they are printed in this tab to show they were taken into
  account.

Finally, a “Reset” button was made to go back to the initial results.

# 7 Conclusion: how to use famat

To conclude, *famat* has four important functions which have to
be used one after another:

```
data(genes)
data(meta)
data(all_compounds_chebi)

listk <- path_enrich("KEGG", meta, genes)
listr <- path_enrich("REAC", meta, genes)
listw <- path_enrich("WP", meta, genes)

interactions_result <- interactions(listk, listr, listw)

compl_data_result <- compl_data(interactions_result)

rshiny(compl_data_result)
```

# 8 References

# Appendix

* Yanjun Xu, Chunquan Li and Xia Li (2013). MPINet: The package can
  implement the network-based metabolite pathway identification of pathways..
  R package version 1.0. [https://CRAN.R-project.org/package=MPINet](https://CRAN.R-project.org/package%3DMPINet)
* Liis Kolberg and Uku Raudvere (2020). gprofiler2: Interface to the
  ‘g:Profiler’ Toolset. R package version 0.2.0.
  [https://CRAN.R-project.org/package=gprofiler2](https://CRAN.R-project.org/package%3Dgprofiler2)
* Luna, A., Babur, O., Aksoy, A. B, Demir, E., Sander, C. (2015).
  “PaxtoolsR: Pathway Analysis in R Using Pathway Commons.”
  Bioinformatics.
* Sales G, Calura E, Cavalieri D, Romualdi C (2012). “graphite - a
  Bioconductor package to convert pathway topology to gene network.” BMC
  Bioinformatics. <https://bmcbioinformatics.biomedcentral.com/articles/10> .
  1186/1471-2105-13-20.
* Guangchuang Yu, Li-Gen Wang, Yanyan Han and Qing-Yu He.clusterProfiler:
  an R package for comparing biological themes among gene clusters. OMICS:
  A Journal of Integrative Biology 2012, 16(5):284-287

# A Session Info

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] org.Hs.eg.db_3.22.0  AnnotationDbi_1.72.0 IRanges_2.44.0
##  [4] S4Vectors_0.48.0     Biobase_2.70.0       BiocGenerics_0.56.0
##  [7] generics_0.1.4       mgcv_1.9-4           nlme_3.1-168
## [10] famat_1.20.3         BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3      jsonlite_2.0.0          tidydr_0.0.6
##   [4] magrittr_2.0.4          ggtangle_0.1.1          farver_2.1.2
##   [7] rmarkdown_2.30          fs_1.6.6                vctrs_0.7.1
##  [10] memoise_2.0.1           ggtree_4.0.4            htmltools_0.5.9
##  [13] gridGraphics_0.5-1      sass_0.4.10             bslib_0.10.0
##  [16] htmlwidgets_1.6.4       plyr_1.8.9              cachem_1.1.0
##  [19] igraph_2.2.1            lifecycle_1.0.5         pkgconfig_2.0.3
##  [22] Matrix_1.7-4            R6_2.6.1                fastmap_1.2.0
##  [25] gson_0.1.0              digest_0.6.39           aplot_0.2.9
##  [28] enrichplot_1.30.4       ggnewscale_0.5.2        patchwork_1.3.2
##  [31] RSQLite_2.4.5           httr_1.4.7              polyclip_1.10-7
##  [34] compiler_4.5.2          bit64_4.6.0-1           fontquiver_0.2.1
##  [37] withr_3.0.2             S7_0.2.1                graphite_1.56.0
##  [40] BiocParallel_1.44.0     viridis_0.6.5           DBI_1.2.3
##  [43] ggforce_0.5.0           R.utils_2.13.0          MASS_7.3-65
##  [46] rappdirs_0.3.4          tools_4.5.2             otel_0.2.0
##  [49] ape_5.8-1               scatterpie_0.2.6        R.oo_1.27.1
##  [52] glue_1.8.0              GOSemSim_2.36.0         grid_4.5.2
##  [55] cluster_2.1.8.1         reshape2_1.4.5          fgsea_1.36.2
##  [58] gtable_0.3.6            R.methodsS3_1.8.2       tidyr_1.3.2
##  [61] data.table_1.18.0       tidygraph_1.3.1         XVector_0.50.0
##  [64] ggrepel_0.9.6           pillar_1.11.1           stringr_1.6.0
##  [67] yulab.utils_0.2.3       splines_4.5.2           dplyr_1.1.4
##  [70] tweenr_2.0.3            treeio_1.34.0           lattice_0.22-7
##  [73] bit_4.6.0               tidyselect_1.2.1        fontLiberation_0.1.0
##  [76] GO.db_3.22.0            Biostrings_2.78.0       reactome.db_1.95.0
##  [79] knitr_1.51              fontBitstreamVera_0.1.1 gridExtra_2.3
##  [82] bookdown_0.46           Seqinfo_1.0.0           xfun_0.56
##  [85] graphlayouts_1.2.2      stringi_1.8.7           lazyeval_0.2.2
##  [88] ggfun_0.2.0             yaml_2.3.12             ReactomePA_1.54.0
##  [91] evaluate_1.0.5          codetools_0.2-20        ggraph_2.2.2
##  [94] gdtools_0.4.4           tibble_3.3.1            qvalue_2.42.0
##  [97] BiocManager_1.30.27     graph_1.88.1            ggplotify_0.1.3
## [100] cli_3.6.5               ontologyIndex_2.12      systemfonts_1.3.1
## [103] jquerylib_0.1.4         dichromat_2.0-0.1       Rcpp_1.1.1
## [106] png_0.1-8               parallel_4.5.2          ggplot2_4.0.1
## [109] blob_1.3.0              clusterProfiler_4.18.4  DOSE_4.4.0
## [112] viridisLite_0.4.2       tidytree_0.4.7          ggiraph_0.9.3
## [115] scales_1.4.0            purrr_1.2.1             crayon_1.5.3
## [118] rlang_1.1.7             cowplot_1.2.0           fastmatch_1.1-8
## [121] KEGGREST_1.50.0
```