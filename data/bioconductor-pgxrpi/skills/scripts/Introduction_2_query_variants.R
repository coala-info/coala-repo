# Code example from 'Introduction_2_query_variants' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(pgxRpi)
library(SummarizedExperiment) # for pgxmatrix data

## -----------------------------------------------------------------------------
# get 2 samples for demonstration
biosamples <- pgxLoader(type="biosamples", filters = "NCIT:C3512", limit=2)

biosample_id <- biosamples$biosample_id

biosample_id

## -----------------------------------------------------------------------------
variant_1 <- pgxLoader(type="g_variants", biosample_id = biosample_id)
head(variant_1)

## -----------------------------------------------------------------------------
variant_2 <- pgxLoader(type="g_variants", biosample_id = "cellzbs-kftvksak", domain = "cancercelllines.org", entry_point="beacon")
head(variant_2)

## -----------------------------------------------------------------------------
variant_3 <- pgxLoader(type="g_variants", biosample_id = biosample_id,output = "pgxseg")
head(variant_3)

## -----------------------------------------------------------------------------
variant_4 <- pgxLoader(type="g_variants", biosample_id = biosample_id,output = "seg")
head(variant_4)

## ----eval=FALSE---------------------------------------------------------------
# pgxLoader(type="g_variants", output="pgxseg", biosample_id=biosample_id, save_file=TRUE,
#           filename="~/Downloads/variants.pgxseg")

## ----eval=FALSE---------------------------------------------------------------
# pgxLoader(type="g_variants", output="seg", biosample_id=biosample_id, save_file=TRUE,
#           filename="~/Downloads/variants.seg")

## -----------------------------------------------------------------------------
cnv_fraction <- pgxLoader(type="cnv_fraction", filters = "NCIT:C2948")

## -----------------------------------------------------------------------------
names(cnv_fraction)

## -----------------------------------------------------------------------------
head(cnv_fraction$arm_cnv_frac)[,c(1:4, 49:52)]

## -----------------------------------------------------------------------------
head(cnv_fraction$genome_cnv_frac)

## -----------------------------------------------------------------------------
cnvfrac_matrix <- pgxLoader(type="cnv_fraction", output="pgxmatrix", filters = "NCIT:C2948")

## -----------------------------------------------------------------------------
cnvfrac_matrix

## -----------------------------------------------------------------------------
rowRanges(cnvfrac_matrix)

## -----------------------------------------------------------------------------
assay(cnvfrac_matrix)[1:3,1:3]

## -----------------------------------------------------------------------------
colData(cnvfrac_matrix)

## ----echo = FALSE-------------------------------------------------------------
sessionInfo()

