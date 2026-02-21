# Code example from 'finemap' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup, eval=FALSE--------------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("MouseFM")

## -----------------------------------------------------------------------------
library(MouseFM)

## -----------------------------------------------------------------------------
avail_strains()

## -----------------------------------------------------------------------------
res = finemap(chr="chr7",
              strain1=c("C57BL_6J","C57L_J","CBA_J","NZB_B1NJ"),
              strain2=c("C3H_HEJ","MOLF_EiJ","NZW_LacJ","WSB_EiJ","SPRET_EiJ"),
              impact=c("HIGH", "MODERATE", "LOW"))

res[1:10,]

## -----------------------------------------------------------------------------
comment(res)

## ----eval=FALSE---------------------------------------------------------------
# cons = annotate_consequences(res, "mouse")

## ----eval=FALSE---------------------------------------------------------------
# genes = annotate_mouse_genes(res, flanking = 50000)

## -----------------------------------------------------------------------------
sessionInfo()

