# Code example from 'CoSIA_Intro' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("CoSIA")

## ----setup, warning=FALSE, message=FALSE--------------------------------------
library(CoSIA)
load("../inst/extdata/proccessed/monogenic_kidney_genes.rda")


# downsampling data for figure
set.seed(42)
monogenic_kid_sample <- dplyr::sample_n(monogenic_kidney_genes, 20)


## ----getTissues_1, warning=FALSE, message=FALSE, eval=FALSE-------------------
# CoSIA::getTissues("d_rerio")

## ----getTissues_2, warning=FALSE, message=FALSE-------------------------------
CoSIA::getTissues(c("m_musculus", "r_norvegicus"))

## ----CoSIAnObj----------------------------------------------------------------
CoSIAn_Obj <- CoSIA::CoSIAn(
    gene_set = unique(monogenic_kid_sample$Gene),
    i_species = "h_sapiens",
    o_species = c(
        "h_sapiens",
        "r_norvegicus"
    ),
    input_id = "Symbol",
    output_ids = "Ensembl_id",
    map_species = c(
        "h_sapiens",
        "r_norvegicus"
    ),
    map_tissues = c(
        "adult mammalian kidney",
        "heart"
    ),
    mapping_tool = "annotationDBI",
    ortholog_database = "HomoloGene",
    metric_type = "CV_Species"
)

str(CoSIAn_Obj)

## ----use1,  message=FALSE, warning=FALSE--------------------------------------
CoSIAn_Obj_convert <- CoSIA::getConversion(CoSIAn_Obj)

head(CoSIA::viewCoSIAn(CoSIAn_Obj_convert, "converted_id"))

## ----use2_1,  message=FALSE, warning=FALSE, eval=FALSE------------------------
# CoSIAn_Obj_gex <- CoSIA::getGEx(CoSIAn_Obj_convert)
# 
# head(CoSIA::viewCoSIAn(CoSIAn_Obj_gex, "gex"), 5)

## ----plotSpeciesGEx, fig.small=TRUE, fig.cap = "Gene Expression of TACO1 in Kidney Across Species", message=FALSE, warning=FALSE, eval=FALSE----
# CoSIAn_Obj_gexplot <- CoSIA::plotSpeciesGEx(CoSIAn_Obj_gex, "adult mammalian kidney", "ENSG00000136463")
# 
# CoSIAn_Obj_gexplot

## ----plotCVGEx, dpi=200, fig.height=13, fig.width=6, fig.cap = "Gene Expression Variability Across Species in Kidney Tissue", fig.wide=TRUE, message=FALSE, warning=FALSE, eval=FALSE----
# 
# CoSIAn_Obj_CV <- CoSIA::getGExMetrics(CoSIAn_Obj_convert)
# 
# CoSIAn_Obj_CVplot <- CoSIA::plotCVGEx(CoSIAn_Obj_CV)
# 
# CoSIAn_Obj_CVplot

## ----use4, message=FALSE, warning=FALSE, eval=FALSE---------------------------
# CoSIAn_Obj_DS <- CoSIA::CoSIAn(
#     gene_set = unique(monogenic_kid_sample$Gene),
#     i_species = "h_sapiens",
#     o_species = c("h_sapiens", "r_norvegicus"),
#     input_id = "Symbol",
#     output_ids = "Ensembl_id",
#     map_species = c("h_sapiens", "r_norvegicus"),
#     map_tissues = c("adult mammalian kidney", "heart"),
#     mapping_tool = "annotationDBI",
#     ortholog_database = "HomoloGene",
#     metric_type = "DS_Tissue"
# )
# 
# CoSIAn_Obj_DS <- CoSIA::getConversion(CoSIAn_Obj_DS)
# 
# CoSIAn_Obj_DS <- CoSIA::getGExMetrics(CoSIAn_Obj_DS)
# 
# CoSIAn_Obj_DSplot <- CoSIA::plotDSGEx(CoSIAn_Obj_DS)
# 
# CoSIAn_Obj_DSplot

## -----------------------------------------------------------------------------
sessionInfo()

