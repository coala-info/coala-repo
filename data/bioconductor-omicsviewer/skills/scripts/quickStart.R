# Code example from 'quickStart' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("omicsViewer")
# BiocManager::install("omicsViewer")

## ----eval=FALSE---------------------------------------------------------------
# library(omicsViewer)
# path2data <- system.file("extdata", package = "omicsViewer")
# omicsViewer(path2data)

## ----simple_pipeline, results=FALSE, message=FALSE----------------------------
library(omicsViewer)
library(Biobase)
packdir <- system.file("extdata", package = "omicsViewer")

# reading expression
expr <- read.delim(file.path(packdir, "expressionMatrix.tsv"), stringsAsFactors = FALSE)
colnames(expr) <- make.names(colnames(expr))
rownames(expr) <- make.names(rownames(expr))

## ----dend,eval=TRUE-----------------------------------------------------------
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


## ----simple_pipeline_continue, results=FALSE, message=FALSE-------------------

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

## ----add_more_cols------------------------------------------------------------
expr <- exprs(d)
drugcor <- correlationAnalysis(expr, pheno = drugData[, 1:2])
d <- extendMetaData(d, drugcor, where = "fData")
# saveRDS(d, file = "dtest.RDS")
##  to open the viewer
# omicsViewer("./")

## -----------------------------------------------------------------------------
# server.R
library(shiny)
dir <- "/path/to/obj" # this should be changed 
server <- function(input, output, session) {
  callModule(omicsViewer::app_module, id = "app", dir = reactive(dir))
}

## -----------------------------------------------------------------------------
# ui.R
library(shiny)
ui <- fluidPage(
  omicsViewer::app_ui("app")
)

## ----deploy_inside_R,eval=FALSE-----------------------------------------------
# library(omicsViewer)
# omicsViewer("path/to/object")

## ----write extension_1,eval=TRUE----------------------------------------------
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

## ----write extension_2,eval=TRUE----------------------------------------------
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

## ----write extension_3,eval=TRUE----------------------------------------------
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

## ----session------------------------------------------------------------------
sessionInfo()

