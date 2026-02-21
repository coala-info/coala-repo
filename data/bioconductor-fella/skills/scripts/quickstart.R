# Code example from 'quickstart' vignette. See references/ for full tutorial.

## ----warning=FALSE, message=FALSE---------------------------------------------
library(FELLA)

data("FELLA.sample")
class(FELLA.sample)
show(FELLA.sample)

## ----warning=FALSE, message=FALSE---------------------------------------------
data("input.sample")
input.full <- c(input.sample, paste0("intruder", 1:10))

show(input.full)

## ----warning=TRUE, message=TRUE-----------------------------------------------
myAnalysis <- defineCompounds(
    compounds = input.full, 
    data = FELLA.sample)

## ----warning=TRUE, message=TRUE-----------------------------------------------
getInput(myAnalysis)

## ----warning=TRUE, message=TRUE-----------------------------------------------
getExcluded(myAnalysis)

## ----warning=FALSE, message=FALSE, error=TRUE---------------------------------
try({
input.fail <- paste0(" ", input.full)
defineCompounds(
    compounds = input.fail, 
    data = FELLA.sample)
})

## ----warning=TRUE, message=TRUE-----------------------------------------------
myAnalysis <- enrich(
    compounds = input.full, 
    method = "diffusion", 
    approx = "normality", 
    data = FELLA.sample)

## ----warning=TRUE, message=TRUE-----------------------------------------------
show(new("FELLA.USER"))

## ----warning=TRUE, message=TRUE-----------------------------------------------
show(myAnalysis)

## ----warning=FALSE, message=FALSE---------------------------------------------
myAnalysis <- enrich(
    compounds = input.full, 
    method = listMethods(), 
    approx = "normality", 
    data = FELLA.sample)

show(myAnalysis)

## ----warning=FALSE, message=TRUE----------------------------------------------
myAnalysis_bis <- runDiffusion(
    object = myAnalysis, 
    approx = "normality", 
    data = FELLA.sample)
show(myAnalysis_bis)

## ----warning=FALSE, message=TRUE, fig.width=8, fig.height=8-------------------
plot(
    x = myAnalysis, 
    method = "hypergeom", 
    main = "My first enrichment using the hypergeometric test in FELLA", 
    threshold = 1, 
    data = FELLA.sample)

## ----warning=FALSE, message=TRUE, fig.width=8, fig.height=8-------------------
plot(
    x = myAnalysis, 
    method = "diffusion", 
    main = "My first enrichment using the diffusion analysis in FELLA", 
    threshold = 0.1, 
    data = FELLA.sample)

## ----warning=FALSE, message=TRUE, fig.width=8, fig.height=8-------------------
plot(
    x = myAnalysis, 
    method = "pagerank", 
    main = "My first enrichment using the PageRank analysis in FELLA", 
    threshold = 0.1, 
    data = FELLA.sample)

## ----warning=FALSE, message=TRUE, results='asis'------------------------------
myTable <- generateResultsTable(
    object = myAnalysis, 
    method = "diffusion", 
    threshold = 0.1, 
    data = FELLA.sample)

knitr::kable(head(myTable, 20))

## ----warning=FALSE, message=TRUE----------------------------------------------
myGraph <- generateResultsGraph(
    object = myAnalysis, 
    method = "diffusion", 
    threshold = 0.1, 
    data = FELLA.sample)

show(myGraph)

## ----warning=FALSE, message=TRUE, results='asis'------------------------------
myTempDir <- tempdir()
myExp_csv <- paste0(myTempDir, "/table.csv")
exportResults(
    format = "csv", 
    file = myExp_csv, 
    method = "pagerank", 
    threshold = 0.1, 
    object = myAnalysis, 
    data = FELLA.sample)

test <- read.csv(file = myExp_csv)
knitr::kable(head(test))

## ----warning=FALSE, message=TRUE, results='asis'------------------------------
myExp_graph <- paste0(myTempDir, "/graph.RData")
exportResults(
    format = "igraph", 
    file = myExp_graph, 
    method = "pagerank", 
    threshold = 0.1, 
    object = myAnalysis, 
    data = FELLA.sample)

stopifnot("graph.RData" %in% list.files(myTempDir))

## ----warning=FALSE, message=TRUE, results='asis'------------------------------
myExp_pajek <- paste0(myTempDir, "/graph.pajek")
exportResults(
    format = "pajek", 
    file = myExp_pajek, 
    method = "diffusion", 
    threshold = 0.1, 
    object = myAnalysis, 
    data = FELLA.sample)

stopifnot("graph.pajek" %in% list.files(myTempDir))

## -----------------------------------------------------------------------------
sessionInfo()

