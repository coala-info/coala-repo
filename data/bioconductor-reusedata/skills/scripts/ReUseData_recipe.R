# Code example from 'ReUseData_recipe' vignette. See references/ for full tutorial.

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

## ----load---------------------------------------------------------------------
suppressPackageStartupMessages(library(Rcwl))
library(ReUseData)

## -----------------------------------------------------------------------------
script <- '
input=$1
outfile=$2
echo "Print the input: $input" > $outfile.txt
'

## -----------------------------------------------------------------------------
script <- system.file("extdata", "echo_out.sh", package = "ReUseData")

## -----------------------------------------------------------------------------
rcp <- recipeMake(shscript = script,
                  paramID = c("input", "outfile"),
                  paramType = c("string", "string"),
                  outputID = "echoout",
                  outputGlob = "*.txt")
inputs(rcp)
outputs(rcp)

## -----------------------------------------------------------------------------
invisible(Rcwl::install_cwltool())

## -----------------------------------------------------------------------------
rcp$input <- "Hello World!"
rcp$outfile <- "outfile"
outdir <- file.path(tempdir(), "SharedData")
res <- getData(rcp,
               outdir = outdir,
               notes = c("echo", "hello", "world", "txt"))

## -----------------------------------------------------------------------------
res$out
readLines(res$out)

## ----eval=FALSE---------------------------------------------------------------
# shfile <- system.file("extdata", "gencode_transcripts.sh",
#                       package = "ReUseData")
# readLines(shfile)
# rcp <- recipeMake(shscript = shfile,
#                   paramID = c("species", "version"),
#                   paramType = c("string", "string"),
#                   outputID = "transcripts",
#                   outputGlob = "*.transcripts.fa*",
#                   requireTools = c("wget", "gzip", "samtools")
#                   )
# rcp$species <- "human"
# rcp$version <- "42"
# res <- getData(rcp,
#         outdir = outdir,
#         notes = c("gencode", "transcripts", "human", "42"),
#         conda = TRUE)
# res$output

## -----------------------------------------------------------------------------
## First time use
recipeUpdate(cachePath = "ReUseDataRecipe",
             force = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# recipeUpdate(remote = TRUE,
#              repos = "rworkflow/ReUseDataRecipe")  ## can be private repo

## -----------------------------------------------------------------------------
rh <- recipeUpdate()
is(rh)
rh[1]
recipeNames(rh)

## -----------------------------------------------------------------------------
recipeSearch()
recipeSearch("gencode")
recipeSearch(c("STAR", "index"))

## -----------------------------------------------------------------------------
rcp <- recipeLoad("STAR_index")

## -----------------------------------------------------------------------------
recipeLoad("STAR_index", return = FALSE)

## -----------------------------------------------------------------------------
identical(rcp, STAR_index)

## -----------------------------------------------------------------------------
recipeLoad(c("ensembl_liftover", "gencode_annotation"), return=FALSE)

## -----------------------------------------------------------------------------
inputs(STAR_index)
inputs(ensembl_liftover)
inputs(gencode_annotation)

## -----------------------------------------------------------------------------
sessionInfo()

