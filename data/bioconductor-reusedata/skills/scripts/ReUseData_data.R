# Code example from 'ReUseData_data' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----install, eval=FALSE------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("ReUseData")

## ----installDevel, eval=FALSE-------------------------------------------------
# BiocManager::install("ReUseData", version = "devel")

## ----Load---------------------------------------------------------------------
suppressPackageStartupMessages(library(Rcwl))
library(ReUseData)

## -----------------------------------------------------------------------------
## set cache in tempdir for test
Sys.setenv(cachePath = file.path(tempdir(), "cache"))

recipeUpdate()
recipeSearch("echo")
echo_out <- recipeLoad("echo_out")
inputs(echo_out)

## -----------------------------------------------------------------------------
invisible(Rcwl::install_cwltool())

## -----------------------------------------------------------------------------
echo_out$input <- "Hello World!"
echo_out$outfile <- "outfile"
outdir <- file.path(tempdir(), "SharedData")
res <- getData(echo_out,
               outdir = outdir,
               notes = c("echo", "hello", "world", "txt"))

## -----------------------------------------------------------------------------
res$output

## -----------------------------------------------------------------------------
list.files(outdir, pattern = "echo")

## -----------------------------------------------------------------------------
readLines(res$yml)

## -----------------------------------------------------------------------------
(dh <- dataUpdate(dir = outdir))

## -----------------------------------------------------------------------------
dh[1]
## dh["BFC1"]
dh[dataNames(dh) == "outfile.txt"]
dataNames(dh)
dataParams(dh)
dataNotes(dh)
dataTags(dh)
dataYml(dh)

## -----------------------------------------------------------------------------
(dh1 <- dataSearch(c("echo", "hello", "world")))
toList(dh1, listNames = c("input_file"))
toList(dh1, format = "yaml", listNames = c("input_file"))
toList(dh1, format = "json", file = file.path(tempdir(), "data.json"))

## -----------------------------------------------------------------------------
dataSearch()
dataTags(dh[1]) <- "#gatk"
dataSearch("#gatk")

## -----------------------------------------------------------------------------
exp_data <- file.path(tempdir(), "exp_data")
dir.create(exp_data)

## -----------------------------------------------------------------------------
annData(exp_data, notes = c("experiment data"))
dataUpdate(exp_data)

## -----------------------------------------------------------------------------
dataSearch("experiment")

## -----------------------------------------------------------------------------
gcpdir <- file.path(tempdir(), "gcpData")
dataUpdate(gcpdir, cloud=TRUE)

## -----------------------------------------------------------------------------
(dh <- dataSearch(c("ensembl", "GRCh38")))
getCloudData(dh[1], outdir = gcpdir)

## -----------------------------------------------------------------------------
dataUpdate(gcpdir)  ## Update local data cache (without cloud data)
dataSearch()  ## data is available locally!!!

## -----------------------------------------------------------------------------
mt <- meta_data(outdir)
head(mt)

## -----------------------------------------------------------------------------
sessionInfo()

