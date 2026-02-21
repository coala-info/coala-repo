# Code example from 'BiocCheck' vignette. See references/ for full tutorial.

## ----biocstyle_load, include=FALSE,results="hide",message=FALSE,warning=FALSE----
library(BiocStyle)

## ----libs, include=TRUE,results="hide",message=FALSE,warning=FALSE------------
library(BiocCheck)

## ----usage, eval=FALSE--------------------------------------------------------
# BiocCheck("<packageDirOrTarball>")

## ----install, eval = FALSE----------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("BiocCheck")

## ----reformat_code, eval = FALSE----------------------------------------------
# ## Install styler if necessary
# if (!requireNamespace("styler", quietly = TRUE)) {
#     install.packages("styler")
# }
# ## Automatically re-format the R code in your package
# styler::style_pkg(transformers = styler::tidyverse_style(indent_by = 4))

## ----BiocCheckGitClone_usage, eval=FALSE--------------------------------------
# BiocCheckGitClone("packageDir")

## ----hidden_files_exts--------------------------------------------------------
BiocCheck:::.HIDDEN_FILE_EXTS

## ----citation_example---------------------------------------------------------
library(utils)
readCitationFile(
    system.file("CITATION", package = "GenomicRanges")
)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

