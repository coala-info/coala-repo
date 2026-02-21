# Code example from 'Qtlizer' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup, eval=FALSE--------------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("Qtlizer")

## -----------------------------------------------------------------------------
library(Qtlizer)

## -----------------------------------------------------------------------------
# Call get_qtls with a variant as a single query term
get_qtls("rs4284742")

## -----------------------------------------------------------------------------
# Call get_qtls with multiple query terms in single string
df = get_qtls("rs4284742, rs2070901")

## -----------------------------------------------------------------------------
# Call get_qtls with multiple query terms as vector
df = get_qtls(c("rs4284742", "DEFA1"))

## -----------------------------------------------------------------------------
# Use parameters corr and ld_method
df = get_qtls(c("rs4284742", "DEFA1"), corr = 0.8, ld_method = "r2")

## -----------------------------------------------------------------------------
# View meta info
df = get_qtls("rs4284742")
comment(df)

## -----------------------------------------------------------------------------
# Return result as GRange object with ref_version hg38
granges = get_qtls("rs4284742", return_obj = "granges", ref_version = "hg38")

## -----------------------------------------------------------------------------
sessionInfo()

