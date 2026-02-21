# Interactive and explorative visualization of ExpressionSet using omicsViewer

#### Chen Meng

BayBioMS, TU Munich

#### 30 October, 2025

# 1 Introduction

“SummarizedExperiment” and the historical “ExpressionSet” are S4 objects storing high throughput omics data. The core component of the objects is an expression matrix, where the rows are features, such as genes, proteins, and columns are samples. The values in the matrix represent the abundance or presence/absence of features. The meta-information about features (rows) and samples (columns) are stored in *data.frames*-like object called “feature data” (or “row data”) and “phenotype data” (or "col data), respectively. More detailed instructions of *ExpressionSet* and *SummarizeExperiment* could be found [here](https://www.bioconductor.org/packages/release/bioc/vignettes/Biobase/inst/doc/ExpressionSetIntroduction.pdf) and [here](https://bioconductor.org/packages/release/bioc/vignettes/SummarizedExperiment/inst/doc/SummarizedExperiment.html).

omicsViewer visualizes ExpressionSet/SummarizedExperiment in an interactive way to facilitate data exploration. The object to be visualized needs to be prepared in R, usually, it contains all the necessary information for the data interpretation, e.g. functional annotation of features, meta information of samples, and the statistical results (See [Prepare the ExpressionSet](#prepare-the-expressionset)). Using R/Bioconductor in the data preparation stage guarantees maximum flexibility in the statistical analysis. Once the object is prepared, it can be visualized using the omicsViewer interface, implemented using shiny and plotly. At this stage, coding in R is not required, therefore, it can be shared with anyone who does not have experience with any programming knowledge.

Both features and samples could be selected from (data) tables or graphs (scatter plot/heatmap) in the omicsViewer. Different types of analyses, such as enrichment analysis (using Bioconductor package fgsea or fisher’s exact test) and STRING network analysis, will be performed on the fly when a subset of features is selected. The statistical results are visualized simultaneously. When a subset of samples and a phenotype variable is selected, a significance test on mean difference (t-test or ranked based test; when phenotype variable is quantitative) or test of independence (chi-square or fisher’s exact test; when phenotype data is categorical) will be performed to test the association between the phenotype of interest with the selected samples. Therefore, the immediate analyses and result visualization in omicsViewer greatly facilitates data exploration, many different hypotheses can be explored in a short time without the need for knowledge of R.

# 2 For the shiny-app user

## 2.1 Start the shinyapp inside R

Install the package from bioconductor:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("omicsViewer")
BiocManager::install("omicsViewer")
```

Let’s assume the object of ExpressionSet has been prepared (See [Prepare the ExpressionSet](#prepare-the-expressionset)), and the task now is to visualize the object using omicsViewer. Inside R, this can be done using：

```
library(omicsViewer)
path2data <- system.file("extdata", package = "omicsViewer")
omicsViewer(path2data)
```

Here *path2data* is the path to the folder containing the *.RDS* files to be visualized by omicsViewer. All the *.RDS* files will be listed in the text box on the top right corner. Select one of the datasets to load it into the viewer. A video introduction on how to use the viewer is [here](https://www.youtube.com/watch?v=0nirB-exquY&list=PLo2m88lJf-RRoLKMY8UEGqCpraKYrX5lk).

The example data is an object of *ExpressionSet*, storing the protein expression of 60 cell lines from 9 different tissues of origin. There are around 2700 proteins measured. The phenotype data contain the basic information about cell lines, such as tissue of origin (categorical), TP53 status (categorical), doubling time (quantitative), multi-drug resistance (quantitative), principal components (quantitative), drug sensitivity data (quantitative) and survival data (fake data for demonstrative purpose), etc. The feature data include the overall intensity of feature, t-test results comparing RE and ME (p-value, fold change, etc), and feature loading from principal component analysis, etc. All the information could be visualized in the omicsViewer and incorporated into the data interpretation interactively.

## 2.2 User interface

The viewer has a “Left and Right Halves Layout”. The left side is the “Eset” panel, where the ExpressionSet (feature data, phenotype data and expression matrix) is visualized. This panel also serves as a selector, i.e. a subset of features and samples could be selected from this panel, which will be passed to the “Analyst” panel. In the “Analyst” panel, different statistical analyses will be performed depending on the features or samples selected.

### 2.2.1 Tabs in Eset

The left side visualize the ExpressionSet, it contains the following tabs:

* **Feature** visualizes the feature data. It is usually a scatter plot or beeswarm plot, every point in the plot is a feature. The x- and y-axis could be selected by the user. A single or multiple features can be selected from the plot and passed to the “analyst” (right) panel. A video tutorial about how to work with the \*feature space":
* **Sample** visualizes the sample data. Like the feature space, usually, a scatter plot or a beeswarm plot is shown here. But every point in this tab is a sample. One or more samples could be selected from the figure. A video tutorial about the data:
* **Heatmap** shows the expression matrix as heatmap. Additionally, the information in phenotype and feature data could be added as side colors or used as variables to sort the rows and columns of the heatmap. Both features and samples could be selected from the heatmap. Video tutorial:

### 2.2.2 Tabs in Analyst

*Analyst* will perform analysis in response to the features and samples selected from the *eset* panel. Depending on the input data (see [here](#reskey)), these tabs are maybe shown:

* **Sample general** The selected samples from the left panel is shown here. If a second variable is selected as a contrast, a hypothesis test will be performed to test the association between the contrast variable with the selected samples. Depending on the type of contrast variable, the following test will be performed:

| contrast variable | Significance test | Visualization |
| --- | --- | --- |
| quantitative | t-test/Mann-Whitney U test | Beeswarm |
| categorical | fischer’s exact test/chi-sq test | Contingency table |
| Surv | log-rank test | KM-curve |

           Video tutorial:

* **feature general** The selected feature from the left panel is shown here. If a second variable is selected as a contrast, a hypothesis test will be performed to test the association between the contrast variable with the selected feature(s). Depending on the type of contrast variable, the following test will be done:

| contrast variable | Significance test | Visualization |
| --- | --- | --- |
| no | - | line chart/boxplot |
| quantitative | Pearson correlation analysis | Scatter plot |
| categorical | t-test/Mann-Whitney U test | Beeswarm |

           Video tutorial:

* **ORA** represents *Over-Representation Analysis*, this tab will be shown if the gene set information is given in the feature data. This tab shows which gene sets are over-represented in the selected features.
* **fGSEA** the results of [fGSEA](http://bioconductor.org/packages/release/bioc/html/fgsea.html). Please note the result of *fgsea* does not depend on the feature selected, instead, the user needs to give a ranking statistic, which is usually stored in the feature data.
* **StringDB** This tab appears when there is a column in the feature data that can be used to query [string database](https://string-db.org/). When a subset of features is selected from the left panel, these features will be used to query Enrichment analysis and network analysis will be performed.
* **Geneshot** [Geneshot](https://maayanlab.cloud/geneshot/) is web service used to retrieve genes related to a biomedical term. Unlike GSA, the term-related genes are RANKED, mainly according to the how frequently the gene is associated with a term in the literature.Therefore, this method may particularly useful in prioritizing the gene candidate in the data analysis.
* **gsList** The functional annotation of genes in a simple tabular format.
* **SeqLogo** This tab will only be shown when users give at least one column as the “sequence window” in the feature data. The column should contain the peptide sequence with the same length. SeqLogo will be drawn.

# 3 Prepare the ExpressionSet

## 3.1 Quick start

The back-end user needs to prepare the data to be visualized by ExpresssionSetViewer. There are functions defined in the package to perform the most basic analyses, such as principal component analysis and t-test. The results of these analyses will be integrated into the ExpressionSet in a format that is compatible with omicsViewer.

A simple example start with an expression matrix:

```
library(omicsViewer)
library(Biobase)
packdir <- system.file("extdata", package = "omicsViewer")

# reading expression
expr <- read.delim(file.path(packdir, "expressionMatrix.tsv"), stringsAsFactors = FALSE)
colnames(expr) <- make.names(colnames(expr))
rownames(expr) <- make.names(rownames(expr))
```

(Optional) When the expression matrix has thousands of rows, calculating the dendrogram of rows in shinyapp will be slow, we can also calculate the dendrograms in advance and store them as the “rowDendrogram” (or “colDendrogram” for columns) attribute of expression matrix. The “rowDendrogram” should be a named list, the suggested name is in the format like:

[distance measure]\_[linkage method]\_[imputed/noImpute]

Every element should be a list of length two:

* ord: the order of variables
* hcl: the dendrogram

An example:

```
# euclidean distance + complete linkage
hcl <- hclust(dist(expr))
dend <- as.dendrogram(hcl)
# correlation distance + ward.D linkage
hcl2 <- hclust(as.dist(1-cor(t(expr), use= "pair")), method = "ward.D")
dend2 <- as.dendrogram(hcl2)
# put two cluster results into one list and add it to the attributes of expression
dl <- list(
  euclidean_complete_imputed = list(ord = hcl$order, hcl = dend),
  pearson_ward.D_imputed = list(ord = hcl2$order, hcl = dend2)
)
attr(expr, "rowDendrogram") <- dl
```

Then we can continue to create the phenotypic and sample data:

```
# reading feature data
fd <- read.delim(file.path(packdir, "featureGeneral.tsv"), stringsAsFactors = FALSE)
# reading phenotype data
pd <- read.delim(file.path(packdir, "sampleGeneral.tsv"), stringsAsFactors = FALSE)

#  reading other datasets
drugData <- read.delim(file.path(packdir, "sampleDrug.tsv"))
# survival data
# this data is from cell line, the survival data are fake data to show how to use the survival data in omicsViewer
surv <- read.delim(file.path(packdir, "sampleSurv.tsv"))
# gene set information
genesets <- read_gmt(file.path(packdir, "geneset.gmt"), data.frame = TRUE)
gsannot <- gsAnnotIdList(idList = rownames(fd), gsIdMap = genesets, data.frame = FALSE)

# Define t-test to be done, a matrix nx3
# every row define a t-test, the format
# [column header] [group 1 in the test] [group 2 in the test]
tests <- rbind(
 c("Origin", "RE", "ME"),
 c("Origin", "RE", "LE"),
 c('TP53.Status', "MT", "WT")
 )

# prepare column for stringDB query
strid <- sapply(strsplit(fd$Protein.ID, ";|-"), "[", 1)

###
d <- prepOmicsViewer(
  expr = expr, pData = pd, fData = fd,
  PCA = TRUE, pca.fillNA = TRUE,
  t.test = tests, ttest.fillNA = FALSE,
  gs = gsannot, stringDB = strid, surv = surv,
  SummarizedExperiment = FALSE)

# feature space - default x axis
attr(d, "fx") <- "ttest|RE_vs_ME|mean.diff"
# feature space - default y axis
attr(d, "fy") <- "ttest|RE_vs_ME|log.fdr"
# sample space - default x axis
attr(d, "sx") <- "PCA|All|PC1("
# sample space - default y axis
attr(d, "sy") <- "PCA|All|PC2("

# saveRDS(d, file = "dtest.RDS")
##  to open the viewer
# omicsViewer("./")
```

Additional columns of phenotype data and feature data could be added using *extendMetaData* function. For example, if we can to correlate drug sensitivity data with our protein expression data

```
expr <- exprs(d)
drugcor <- correlationAnalysis(expr, pheno = drugData[, 1:2])
d <- extendMetaData(d, drugcor, where = "fData")
# saveRDS(d, file = "dtest.RDS")
##  to open the viewer
# omicsViewer("./")
```

## 3.2 Requirements on ExpressionSet

When you prepare the object by yourself, please note that to be compatible with omicsViewer, there are two extra requirements imposed on the object:

* The expression matrix should have unique row names and column names. The row names of feature data should be the same as the row names of the expression matrix. The row names of phenotype data should be the same as the column names of the expression matrix. It is also recommended to use meaningful names such as gene names because the names will be displayed in the expression viewer.
* The columns names of feature data and phenotype data should be in the format consisting of three elements:
  **Analysis|Subset|Variable**
  The first element is called *analysis*, such as “t-test”, “PCA”, which tells the front-end user from which analysis the result is. There are few *analysis* “keywords” reserved so the omicsViewer knows how to process/interpret it internally. Please see the next section for more information. The second element is *subset*, it often indicates which subset of samples/features was used in the analysis. For example, in an experiment with three groups *A, B* and *C*, a t-test was used to compare the group *A* and *B*, the first two elements could be “ttest|A\_vs\_B”. Alternatively, the *Subset* can be anything that helps to further narrow down the information given an “Analysis”. If nothing needs to give, a place holder (e.g. “All”) needs to be added to this position. The last elements are the variables returned by the analysis, for example, the “fold change” and (log-transformed) “p-value” could be given by header “ttest|A\_vs\_B|fold.change” and “ttest|A\_vs\_B|p.value”.

Any information could be added to the feature and sample data as long as they meet these requirements. The purpose of this rule for headers is to let the users quickly navigate through the potentially large number of columns in the phenotype and feature data. Once the data are prepared in this way, the information of interest can be selected using a three-step selector in the front-end.

### 3.2.1 The reserved headers

These keywords are reserved for the **Analysis** element in the headers. Users should avoid using them in cases other than the designated usage.

* **Surv** in *phenotype data*, indicating information used to create survival curves.
* **StringDB** in the *feature data*, which means the feature IDst that can be used to query [stringDB](https://string-db.org/). If this header exists, the *StringDB* tab will be shown in the *analyst* panel.
* **GS** in the *feature data*, storing the gene set information. If this header exists, the *ORA* and *fGSEA* will be shown.

## 3.3 Deployment

In addition to opening the viewer inside R, omicsViewer together with the data prepared, can be deployed via several other ways.

* **Docker**: Standalone version using [docker image](https://hub.docker.com/repository/docker/mengchen18/omicsviewer)

```
docker pull mengchen18/omicsviewer
```

* **Portable R:** To share the omicsViewer and data with users do not use docker, you can use portable R with xcmsViewer installed. The ready-to-use package could be access from [zenodo](https://zenodo.org/record/6025394).
* **Shiny server:** omicsViewer can also be deployed via shiny server. To do so, a *server.R* and *ui.R* file should be created and put into the shiny app directory in the shiny server. By doing this, any users who have accession to the shiny server will be able to explore the data and do not need to install anything. The example files of *server.R* and *ui.R* are

```
# server.R
library(shiny)
dir <- "/path/to/obj" # this should be changed
server <- function(input, output, session) {
  callModule(omicsViewer::app_module, id = "app", dir = reactive(dir))
}
```

```
# ui.R
library(shiny)
ui <- fluidPage(
  omicsViewer::app_ui("app")
)
```

* **Inside R**

Assume you have prepared an object for omicsViewer, you can open it in R using

```
library(omicsViewer)
omicsViewer("path/to/object")
```

The object could be loaded from the top-right corner.

## 3.4 Writing extensions

The users can also define their own analysis and plug it into the *Analyst* panel. To add a self-defined analysis/tab, users first need to create a list of four elements:

* **tabName** Tab name to be shown in the *Analyst* panel
* **moduleName** ID used when call modules
* **moduleUi** shiny module UI function
* **moduleServer** shiny module server function. The module function should a function with the following arguments:

  + input, output, session: argument required when call *callModule* function, usually are not used inside the function
  + pdata: phenotype data passed to the function
  + fdata: feature data passed to the function
  + expr: expression matrix passed to the function
  + feature\_selected: selected features, passed to the function
  + sample\_selected: selected samples, passed to the function
  + object: the original object loaded to the app, usually an ExpressionSet.

Then the four-element list should be wrapped by a parent list, which can store a single or multiple “four-element lists”, each representing an additional analysis/tab. Here is an example including a single additional tab:

```
library(omicsViewer)
ctxt <- function(x) paste(
  x[1:min(10, length(x))], collapse = ";"
)

### extra tab 1 -- feature selected ###
exampleCustomeUI_1 <- function(id) {
  ns <- NS(id)
  tagList(
    verbatimTextOutput(ns("txt"))
  )
}

exampleCustomeMoudule_1 <- function(
  input, output, session, pdata, fdata, expr, feature_selected, sample_selected, object
) {
  output$txt <- renderText({
    sprintf(
      "feature selected: %s ; index feature selected: %s",
      ctxt(feature_selected()),
      ctxt(match(feature_selected(), rownames(fdata())))
    )
  })
}

ll <- list(
  list(
    tabName = "CustomeAddOn",
    moduleName = "opt1",
    moduleUi = exampleCustomeUI_1,
    moduleServer  = exampleCustomeMoudule_1
  )
)

if (interactive())
  omicsViewer("Git/package/inst/extdata/", additionalTabs = ll)
```

When more tabs should be added, simply add more elements in to the list and pass it to the *additionalTabs* argument:

```
### continue from above : extra tab 2 -- sample selected ###
exampleCustomeUI_2 <- function(id) {
  ns <- NS(id)
  tagList(
    verbatimTextOutput(ns("txt"))
  )
}

exampleCustomeMoudule_2 <- function(
  input, output, session, pdata, fdata, expr, feature_selected, sample_selected, object
) {

  output$txt <- renderText({
    sprintf(
      "sample selected: %s ; colnames sample selected: %s",
      ctxt(sample_selected()),
      ctxt(match(sample_selected(), rownames(pdata())))
      )
  })
}

### use oiginal object ###
exampleCustomeUI_3 <- function(id) {
  ns <- NS(id)
  tagList(
    verbatimTextOutput(ns("txt"))
  )
}

exampleCustomeMoudule_3 <- function(
  input, output, session, pdata, fdata, expr, feature_selected, sample_selected, object
) {
  output$txt <- renderText({
    as.character(classVersion(object()))
  })
}

ll <- list(

  # first optional tab
  list(
    tabName = "Opt feature",
    moduleName = "opt-feature",
    moduleUi = exampleCustomeUI_1,
    moduleServer  = exampleCustomeMoudule_1
  ),

  # second optional tab
  list(
    tabName = "Opt sample",
    moduleName = "opt-sample",
    moduleUi = exampleCustomeUI_2,
    moduleServer  = exampleCustomeMoudule_2
  ),

  # third optional tab
  list(
    tabName = "Opt object",
    moduleName = "opt-object",
    moduleUi = exampleCustomeUI_3,
    moduleServer  = exampleCustomeMoudule_3
  )
)

if (interactive())
  omicsViewer("Git/package/inst/extdata/", additionalTabs = ll)
```

Include a “three-step selector” in the module:

```
selector_example_ui <- function(id) {
  ns <- NS(id)
  tagList(
    # select variable
    omicsViewer:::triselector_ui(ns("selector_id"))
  )
}

selector_example_module <- function(
  input, output, session, pdata, fdata, expr, feature_selected, sample_selected, object
  ) {
  ns <- session$ns
  # select stats from feature data
  triset <- reactive({
    fd <- fdata()
    cn <- colnames(fd)[sapply(fd, is.numeric) & !grepl("^GS\\|", colnames(fd))]
    str_split_fixed(cn, "\\|", n = 3)
  })
  v1 <- callModule(
    omicsViewer:::triselector_module, id = "selector_id", reactive_x = triset, label = "Label"
    )
}

ll <- list(
  list(
    tabName = "selector",
    moduleName = "selector-feature",
    moduleUi = selector_example_ui,
    moduleServer  = selector_example_module
  )
  )
if (interactive())
  omicsViewer("Git/package/inst/extdata/", additionalTabs = ll)
```

# 4 SessionInfo

```
sessionInfo()
```

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
## [1] shiny_1.11.1        Biobase_2.70.0      BiocGenerics_0.56.0
## [4] generics_0.1.4      omicsViewer_1.14.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
##   [3] magrittr_2.0.4              TH.data_1.1-4
##   [5] farver_2.1.2                rmarkdown_2.30
##   [7] vctrs_0.6.5                 ROCR_1.0-11
##   [9] memoise_2.0.1               rstatix_0.7.3
##  [11] htmltools_0.5.8.1           S4Arrays_1.10.0
##  [13] plotrix_3.8-4               curl_7.0.0
##  [15] broom_1.0.10                SparseArray_1.10.0
##  [17] Formula_1.2-5               sass_0.4.10
##  [19] bslib_0.9.0                 htmlwidgets_1.6.4
##  [21] fontawesome_0.5.3           plyr_1.8.9
##  [23] sandwich_3.1-1              plotly_4.11.0
##  [25] zoo_1.8-14                  cachem_1.1.0
##  [27] networkD3_0.4.1             igraph_2.2.1
##  [29] mime_0.13                   lifecycle_1.0.4
##  [31] pkgconfig_2.0.3             Matrix_1.7-4
##  [33] R6_2.6.1                    fastmap_1.2.0
##  [35] MatrixGenerics_1.22.0       digest_0.6.37
##  [37] S4Vectors_0.48.0            shinycssloaders_1.1.0
##  [39] shinybusy_0.3.3             crosstalk_1.2.2
##  [41] GenomicRanges_1.62.0        RSQLite_2.4.3
##  [43] ggpubr_0.6.2                km.ci_0.5-6
##  [45] httr_1.4.7                  abind_1.4-8
##  [47] compiler_4.5.1              bit64_4.6.0-1
##  [49] S7_0.2.0                    backports_1.5.0
##  [51] BiocParallel_1.44.0         carData_3.0-5
##  [53] DBI_1.2.3                   psych_2.5.6
##  [55] ggsignif_0.6.4              MASS_7.3-65
##  [57] drc_3.0-1                   DelayedArray_0.36.0
##  [59] gtools_3.9.5                tools_4.5.1
##  [61] otel_0.2.0                  beeswarm_0.4.0
##  [63] zip_2.3.3                   httpuv_1.6.16
##  [65] ggseqlogo_0.2               glue_1.8.0
##  [67] nlme_3.1-168                promises_1.4.0
##  [69] grid_4.5.1                  reshape2_1.4.4
##  [71] fgsea_1.36.0                gtable_0.3.6
##  [73] KMsurv_0.1-6                tidyr_1.3.1
##  [75] survminer_0.5.1             data.table_1.17.8
##  [77] car_3.1-3                   XVector_0.50.0
##  [79] pillar_1.11.1               stringr_1.5.2
##  [81] later_1.4.4                 splines_4.5.1
##  [83] dplyr_1.1.4                 lattice_0.22-7
##  [85] survival_3.8-3              bit_4.6.0
##  [87] tidyselect_1.2.1            knitr_1.50
##  [89] gridExtra_2.3               IRanges_2.44.0
##  [91] Seqinfo_1.0.0               SummarizedExperiment_1.40.0
##  [93] stats4_4.5.1                xfun_0.53
##  [95] matrixStats_1.5.0           DT_0.34.0
##  [97] stringi_1.8.7               lazyeval_0.2.2
##  [99] yaml_2.3.10                 shinyWidgets_0.9.0
## [101] evaluate_1.0.5              codetools_0.2-20
## [103] data.tree_1.2.0             tibble_3.3.0
## [105] cli_3.6.5                   shinythemes_1.2.0
## [107] xtable_1.8-4                jquerylib_0.1.4
## [109] survMisc_0.5.6              dichromat_2.0-0.1
## [111] Rcpp_1.1.0                  parallel_4.5.1
## [113] ggplot2_4.0.0               blob_1.2.4
## [115] flatxml_0.1.1               viridisLite_0.4.2
## [117] mvtnorm_1.3-3               scales_1.4.0
## [119] openxlsx_4.2.8              purrr_1.1.0
## [121] rlang_1.1.6                 cowplot_1.2.0
## [123] fastmatch_1.1-6             multcomp_1.4-29
## [125] mnormt_2.1.1                shinyjs_2.1.0
```