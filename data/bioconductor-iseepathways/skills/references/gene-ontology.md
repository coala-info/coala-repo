Code

* Show All Code
* Hide All Code

# Working with the Gene Ontology

Kevin Rue-Albrecht1\*

1University of Oxford

\*kevin.rue-albrecht@imm.ox.ac.uk

#### 30 October 2025

#### Package

iSEEpathways 1.8.0

# 1 Scenario

In this vignette, we demonstrate how one may use the package *[GO.db](https://bioconductor.org/packages/3.22/GO.db)* to dynamically display additional information about selected pathways in the interactive user interface.

# 2 Demonstration

## 2.1 Example data

First, we generate pathway analysis results for simulated data using *[fgsea](https://bioconductor.org/packages/3.22/fgsea)*.

In particular, we use the package *[org.Hs.eg.db](https://bioconductor.org/packages/3.22/org.Hs.eg.db)* to fetch real gene sets.
To reduce memory footprint, we retain only the gene sets associated with 15 to 500 genes.

Then, we simulate a score for each of the gene present in any of those remaining gene sets.
In practice, that score could be the log2 fold-change of the gene in a differential expression analysis (among other possibilities).

Finally, we perform an FGSEA on the simulated data.

```
library("org.Hs.eg.db")
library("fgsea")

# Example data ----

## Pathways
pathways <- select(org.Hs.eg.db, keys(org.Hs.eg.db, "SYMBOL"), c("GOALL"), keytype = "SYMBOL")
pathways <- subset(pathways, ONTOLOGYALL == "BP")
pathways <- unique(pathways[, c("SYMBOL", "GOALL")])
pathways <- split(pathways$SYMBOL, pathways$GOALL)
len_pathways <- lengths(pathways)
pathways <- pathways[len_pathways > 15 & len_pathways < 500]

## Features
set.seed(1)
# simulate a score for all genes found across all pathways
feature_stats <- rnorm(length(unique(unlist(pathways))))
names(feature_stats) <- unique(unlist(pathways))
# arbitrarily select a pathway to simulate enrichment
pathway_id <- "GO:0046324"
pathway_genes <- pathways[[pathway_id]]
# increase score of genes in the selected pathway to simulate enrichment
feature_stats[pathway_genes] <- feature_stats[pathway_genes] + 1

# fgsea ----

set.seed(42)
fgseaRes <- fgsea(pathways = pathways,
                  stats    = feature_stats,
                  minSize  = 15,
                  maxSize  = 500)
head(fgseaRes[order(pval), ])
#>       pathway         pval         padj   log2err        ES      NES  size
#>        <char>        <num>        <num>     <num>     <num>    <num> <int>
#> 1: GO:0046324 2.877432e-14 1.413682e-10 0.9653278 0.6962957 2.869088    60
#> 2: GO:0046323 1.341951e-11 3.296503e-08 0.8753251 0.5952200 2.611058    83
#> 3: GO:0010827 9.103586e-11 1.490864e-07 0.8390889 0.5885634 2.546631    80
#> 4: GO:1904659 1.998163e-09 2.454243e-06 0.7749390 0.5058836 2.316851   112
#> 5: GO:0034219 3.194402e-09 2.654387e-06 0.7749390 0.4736754 2.230708   134
#> 6: GO:0008645 3.749262e-09 2.654387e-06 0.7614608 0.4851657 2.237710   119
#>     leadingEdge
#>          <list>
#> 1: CLTCL1, ....
#> 2: CLTCL1, ....
#> 3: CLTCL1, ....
#> 4: CLTCL1, ....
#> 5: CLTCL1, ....
#> 6: CLTCL1, ....
```

Then, we embed the *[fgsea](https://bioconductor.org/packages/3.22/fgsea)* results in a *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)* object.

In this case, we create an empty `?SummarizedExperiment-class` object, without any simulated count data nor metadata, as we will not be using any of those data in this example.

We then embed the pathway analysis results in the newly created `?SummarizedExperiment-class` object.

But first, we reorder the results by increasing p-value.
Although not essential, this implicitly defines the default ordering of the table in the live app.

```
library("SummarizedExperiment")
library("iSEEpathways")
se <- SummarizedExperiment()
fgseaRes <- fgseaRes[order(pval), ]
se <- embedPathwaysResults(fgseaRes, se, name = "fgsea", class = "fgsea", pathwayType = "GO")
```

## 2.2 Pathway information

In this example, we configure the app option `PathwaysTable.select.details` to define a function that,
given the identifier of the GO term currently selected in a panel,
displays information about that GO term.

Although not essential, this is a user-friendly and immediate way to ‘translate’ machine-friendly database identifiers into human-friendly descriptions.

```
library("iSEE")
library("GO.db")
library("shiny")
go_details <- function(x) {
    info <- select(GO.db, x, c("TERM", "ONTOLOGY", "DEFINITION"), "GOID")
    html <- list(p(strong(info$GOID), ":", info$TERM, paste0("(", info$ONTOLOGY, ")")))
    if (!is.na(info$DEFINITION)) {
        html <- append(html, list(p(info$DEFINITION)))
    }
    tagList(html)
}
se <- registerAppOptions(se, PathwaysTable.select.details = go_details)
```

## 2.3 Live app

Finally, we configure the app initial state and launch the live app.

```
app <- iSEE(se, initial = list(
  PathwaysTable(ResultName="fgsea", Selected = "GO:0046324", PanelWidth = 12L)
))

if (interactive()) {
  shiny::runApp(app)
}
```

![](data:image/png;base64...)

# 3 Reproducibility

The *[iSEEpathways](https://bioconductor.org/packages/3.22/iSEEpathways)* package (Rue-Albrecht and Soneson, 2025) was made possible thanks to:

* R (R Core Team, 2025)
* *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
* *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2025)
* *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017)
* *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux, McPherson, Luraschi, Ushey, Atkins, Wickham, Cheng, Chang, and Iannone, 2025)
* *[sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo)* (Wickham, Chang, Flight, Müller, and Hester, 2025)
* *[testthat](https://CRAN.R-project.org/package%3Dtestthat)* (Wickham, 2011)

This package was developed using *[biocthis](https://bioconductor.org/packages/3.22/biocthis)*.

Code for creating the vignette

```
## Create the vignette
library("rmarkdown")
system.time(render("gene-ontology.Rmd", "BiocStyle::html_document"))

## Extract the R code
library("knitr")
knit("gene-ontology.Rmd", tangle = TRUE)
```

Date the vignette was generated.

```
#> [1] "2025-10-30 00:40:19 EDT"
```

Wallclock time spent generating the vignette.

```
#> Time difference of 55.557 secs
```

`R` session information.

```
#> ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-10-30
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
#>  package              * version date (UTC) lib source
#>  abind                  1.4-8   2024-09-12 [2] CRAN (R 4.5.1)
#>  AnnotationDbi        * 1.72.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  backports              1.5.0   2024-05-23 [2] CRAN (R 4.5.1)
#>  bibtex                 0.5.1   2023-01-26 [2] CRAN (R 4.5.1)
#>  Biobase              * 2.70.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics         * 0.56.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocManager            1.30.26 2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocParallel           1.44.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocStyle            * 2.38.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Biostrings             2.78.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bit                    4.6.0   2025-03-06 [2] CRAN (R 4.5.1)
#>  bit64                  4.6.0-1 2025-01-16 [2] CRAN (R 4.5.1)
#>  blob                   1.2.4   2023-03-17 [2] CRAN (R 4.5.1)
#>  bookdown               0.45    2025-10-03 [2] CRAN (R 4.5.1)
#>  bslib                  0.9.0   2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem                 1.1.0   2024-05-16 [2] CRAN (R 4.5.1)
#>  circlize               0.4.16  2024-02-20 [2] CRAN (R 4.5.1)
#>  cli                    3.6.5   2025-04-23 [2] CRAN (R 4.5.1)
#>  clue                   0.3-66  2024-11-13 [2] CRAN (R 4.5.1)
#>  cluster                2.1.8.1 2025-03-12 [3] CRAN (R 4.5.1)
#>  codetools              0.2-20  2024-03-31 [3] CRAN (R 4.5.1)
#>  colorspace             2.1-2   2025-09-22 [2] CRAN (R 4.5.1)
#>  colourpicker           1.3.0   2023-08-21 [2] CRAN (R 4.5.1)
#>  ComplexHeatmap         2.26.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  cowplot                1.2.0   2025-07-07 [2] CRAN (R 4.5.1)
#>  crayon                 1.5.3   2024-06-20 [2] CRAN (R 4.5.1)
#>  data.table             1.17.8  2025-07-10 [2] CRAN (R 4.5.1)
#>  DBI                    1.2.3   2024-06-02 [2] CRAN (R 4.5.1)
#>  DelayedArray           0.36.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  dichromat              2.0-0.1 2022-05-02 [2] CRAN (R 4.5.1)
#>  digest                 0.6.37  2024-08-19 [2] CRAN (R 4.5.1)
#>  doParallel             1.0.17  2022-02-07 [2] CRAN (R 4.5.1)
#>  dplyr                  1.1.4   2023-11-17 [2] CRAN (R 4.5.1)
#>  DT                     0.34.0  2025-09-02 [2] CRAN (R 4.5.1)
#>  evaluate               1.0.5   2025-08-27 [2] CRAN (R 4.5.1)
#>  farver                 2.1.2   2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap                1.2.0   2024-05-15 [2] CRAN (R 4.5.1)
#>  fastmatch              1.1-6   2024-12-23 [2] CRAN (R 4.5.1)
#>  fgsea                * 1.36.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  fontawesome            0.5.3   2024-11-16 [2] CRAN (R 4.5.1)
#>  foreach                1.5.2   2022-02-02 [2] CRAN (R 4.5.1)
#>  generics             * 0.1.4   2025-05-09 [2] CRAN (R 4.5.1)
#>  GenomicRanges        * 1.62.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  GetoptLong             1.0.5   2020-12-15 [2] CRAN (R 4.5.1)
#>  ggplot2                4.0.0   2025-09-11 [2] CRAN (R 4.5.1)
#>  ggrepel                0.9.6   2024-09-07 [2] CRAN (R 4.5.1)
#>  GlobalOptions          0.1.2   2020-06-10 [2] CRAN (R 4.5.1)
#>  glue                   1.8.0   2024-09-30 [2] CRAN (R 4.5.1)
#>  GO.db                * 3.22.0  2025-10-08 [2] Bioconductor
#>  gtable                 0.3.6   2024-10-25 [2] CRAN (R 4.5.1)
#>  htmltools              0.5.8.1 2024-04-04 [2] CRAN (R 4.5.1)
#>  htmlwidgets            1.6.4   2023-12-06 [2] CRAN (R 4.5.1)
#>  httpuv                 1.6.16  2025-04-16 [2] CRAN (R 4.5.1)
#>  httr                   1.4.7   2023-08-15 [2] CRAN (R 4.5.1)
#>  igraph                 2.2.1   2025-10-27 [2] CRAN (R 4.5.1)
#>  IRanges              * 2.44.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  iSEE                 * 2.22.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  iSEEpathways         * 1.8.0   2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>  iterators              1.0.14  2022-02-05 [2] CRAN (R 4.5.1)
#>  jquerylib              0.1.4   2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite               2.0.0   2025-03-27 [2] CRAN (R 4.5.1)
#>  KEGGREST               1.50.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  knitr                  1.50    2025-03-16 [2] CRAN (R 4.5.1)
#>  later                  1.4.4   2025-08-27 [2] CRAN (R 4.5.1)
#>  lattice                0.22-7  2025-04-02 [3] CRAN (R 4.5.1)
#>  lifecycle              1.0.4   2023-11-07 [2] CRAN (R 4.5.1)
#>  listviewer             4.0.0   2023-09-30 [2] CRAN (R 4.5.1)
#>  lubridate              1.9.4   2024-12-08 [2] CRAN (R 4.5.1)
#>  magrittr               2.0.4   2025-09-12 [2] CRAN (R 4.5.1)
#>  Matrix                 1.7-4   2025-08-28 [3] CRAN (R 4.5.1)
#>  MatrixGenerics       * 1.22.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  matrixStats          * 1.5.0   2025-01-07 [2] CRAN (R 4.5.1)
#>  memoise                2.0.1   2021-11-26 [2] CRAN (R 4.5.1)
#>  mgcv                   1.9-3   2025-04-04 [3] CRAN (R 4.5.1)
#>  mime                   0.13    2025-03-17 [2] CRAN (R 4.5.1)
#>  miniUI                 0.1.2   2025-04-17 [2] CRAN (R 4.5.1)
#>  nlme                   3.1-168 2025-03-31 [3] CRAN (R 4.5.1)
#>  org.Hs.eg.db         * 3.22.0  2025-10-08 [2] Bioconductor
#>  otel                   0.2.0   2025-08-29 [2] CRAN (R 4.5.1)
#>  pillar                 1.11.1  2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgconfig              2.0.3   2019-09-22 [2] CRAN (R 4.5.1)
#>  plyr                   1.8.9   2023-10-02 [2] CRAN (R 4.5.1)
#>  png                    0.1-8   2022-11-29 [2] CRAN (R 4.5.1)
#>  promises               1.4.0   2025-10-22 [2] CRAN (R 4.5.1)
#>  R6                     2.6.1   2025-02-15 [2] CRAN (R 4.5.1)
#>  RColorBrewer           1.1-3   2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp                   1.1.0   2025-07-02 [2] CRAN (R 4.5.1)
#>  RefManageR           * 1.4.0   2022-09-30 [2] CRAN (R 4.5.1)
#>  rintrojs               0.3.4   2024-01-11 [2] CRAN (R 4.5.1)
#>  rjson                  0.2.23  2024-09-16 [2] CRAN (R 4.5.1)
#>  rlang                  1.1.6   2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown              2.30    2025-09-28 [2] CRAN (R 4.5.1)
#>  RSQLite                2.4.3   2025-08-20 [2] CRAN (R 4.5.1)
#>  S4Arrays               1.10.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Vectors            * 0.48.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S7                     0.2.0   2024-11-07 [2] CRAN (R 4.5.1)
#>  sass                   0.4.10  2025-04-11 [2] CRAN (R 4.5.1)
#>  scales                 1.4.0   2025-04-24 [2] CRAN (R 4.5.1)
#>  Seqinfo              * 1.0.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  sessioninfo          * 1.2.3   2025-02-05 [2] CRAN (R 4.5.1)
#>  shape                  1.4.6.1 2024-02-23 [2] CRAN (R 4.5.1)
#>  shiny                * 1.11.1  2025-07-03 [2] CRAN (R 4.5.1)
#>  shinyAce               0.4.4   2025-02-03 [2] CRAN (R 4.5.1)
#>  shinydashboard         0.7.3   2025-04-21 [2] CRAN (R 4.5.1)
#>  shinyjs                2.1.0   2021-12-23 [2] CRAN (R 4.5.1)
#>  shinyWidgets           0.9.0   2025-02-21 [2] CRAN (R 4.5.1)
#>  SingleCellExperiment * 1.32.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  SparseArray            1.10.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  stringi                1.8.7   2025-03-27 [2] CRAN (R 4.5.1)
#>  stringr                1.5.2   2025-09-08 [2] CRAN (R 4.5.1)
#>  SummarizedExperiment * 1.40.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  tibble                 3.3.0   2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyselect             1.2.1   2024-03-11 [2] CRAN (R 4.5.1)
#>  timechange             0.3.0   2024-01-18 [2] CRAN (R 4.5.1)
#>  vctrs                  0.6.5   2023-12-01 [2] CRAN (R 4.5.1)
#>  vipor                  0.4.7   2023-12-18 [2] CRAN (R 4.5.1)
#>  viridisLite            0.4.2   2023-05-02 [2] CRAN (R 4.5.1)
#>  xfun                   0.53    2025-08-19 [2] CRAN (R 4.5.1)
#>  xml2                   1.4.1   2025-10-27 [2] CRAN (R 4.5.1)
#>  xtable                 1.8-4   2019-04-21 [2] CRAN (R 4.5.1)
#>  XVector                0.50.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml                   2.3.10  2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmpDpXsPn/Rinst12017346528164
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

# 4 Bibliography

This vignette was generated using *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
with *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2025) and *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux et al., 2025) running behind the scenes.

Citations made with *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017).

[[1]](#cite-allaire2025rmarkdown)
J. Allaire, Y. Xie, C. Dervieux, et al.
*rmarkdown: Dynamic Documents for R*.
R package version 2.30.
2025.
URL: <https://github.com/rstudio/rmarkdown>.

[[2]](#cite-mclean2017refmanager)
M. W. McLean.
“RefManageR: Import and Manage BibTeX and BibLaTeX References in R”.
In: *The Journal of Open Source Software* (2017).
DOI: [10.21105/joss.00338](https://doi.org/10.21105/joss.00338).

[[3]](#cite-ole2025biocstyle)
A. Oleś.
*BiocStyle: Standard styles for vignettes and other Bioconductor documents*.
R package version 2.38.0.
2025.
DOI: [10.18129/B9.bioc.BiocStyle](https://doi.org/10.18129/B9.bioc.BiocStyle).
URL: <https://bioconductor.org/packages/BiocStyle>.

[[4]](#cite-2025language)
R Core Team.
*R: A Language and Environment for Statistical Computing*.
R Foundation for Statistical Computing.
Vienna, Austria, 2025.
URL: <https://www.R-project.org/>.

[[5]](#cite-ruealbrecht2025iseepathways)
K. Rue-Albrecht and C. Soneson.
*iSEEpathways: iSEE extension for panels related to pathway analysis*.
R package version 1.8.0.
2025.
DOI: [10.18129/B9.bioc.iSEEpathways](https://doi.org/10.18129/B9.bioc.iSEEpathways).
URL: <https://bioconductor.org/packages/iSEEpathways>.

[[6]](#cite-wickham2011testthat)
H. Wickham.
“testthat: Get Started with Testing”.
In: *The R Journal* 3 (2011), pp. 5–10.
URL: <https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf>.

[[7]](#cite-wickham2025sessioninfo)
H. Wickham, W. Chang, R. Flight, et al.
*sessioninfo: R Session Information*.
R package version 1.2.3.
2025.
DOI: [10.32614/CRAN.package.sessioninfo](https://doi.org/10.32614/CRAN.package.sessioninfo).
URL: [https://CRAN.R-project.org/package=sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo).

[[8]](#cite-xie2025knitr)
Y. Xie.
*knitr: A General-Purpose Package for Dynamic Report Generation in R*.
R package version 1.50.
2025.
URL: <https://yihui.org/knitr/>.