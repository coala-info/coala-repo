# Code example from 'ReUseData_quickStart' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install(c("ReUseData", "Rcwl"))

## -----------------------------------------------------------------------------
library(ReUseData)

## -----------------------------------------------------------------------------
recipeUpdate(cachePath = "ReUseDataRecipe", force = TRUE)
recipeSearch("echo")
echo_out <- recipeLoad("echo_out")

## -----------------------------------------------------------------------------
invisible(Rcwl::install_cwltool())

## -----------------------------------------------------------------------------
Rcwl::inputs(echo_out)
echo_out$input <- "Hello World!"
echo_out$outfile <- "outfile"
outdir <- file.path(tempdir(), "SharedData")
res <- getData(echo_out,
               outdir = outdir,
               notes = c("echo", "hello", "world", "txt"))
res$out
readLines(res$out)

## -----------------------------------------------------------------------------
script <- system.file("extdata", "echo_out.sh", package = "ReUseData")
rcp <- recipeMake(shscript = script,
                  paramID = c("input", "outfile"),
                  paramType = c("string", "string"),
                  outputID = "echoout",
                  outputGlob = "*.txt")
Rcwl::inputs(rcp)
Rcwl::outputs(rcp)

## -----------------------------------------------------------------------------
sessionInfo()

