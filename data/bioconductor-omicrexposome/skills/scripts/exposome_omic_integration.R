# Code example from 'exposome_omic_integration' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
BiocStyle::markdown()
knitr::opts_chunk$set(echo = TRUE, warnings=FALSE, crop = NULL)

## ----eval=FALSE---------------------------------------------------------------
# devtools::install_github("isglobal-brge/omicRexposome")

## ----load_omicRexposome, message=FALSE----------------------------------------
library(omicRexposome)
library(MultiDataSet)

## ----expos_data, cache=FALSE--------------------------------------------------
data("brge_expo", package = "brgedata")
class(brge_expo)

## ----gexp_data, cache=FALSE---------------------------------------------------
data("brge_gexp", package = "brgedata")

## ----gexp_analysis, message=FALSE, warning=FALSE------------------------------
mds <- createMultiDataSet()
mds <- add_genexp(mds, brge_gexp)
mds <- add_exp(mds, brge_expo)

gexp <- association(mds, formula=~Sex+Age, 
    expset = "exposures", omicset = "expression")

## ----gexp_tables--------------------------------------------------------------
hit <- tableHits(gexp, th=0.001)
lab <- tableLambda(gexp)
merge(hit, lab, by="exposure")

## ----gexp_analysis_sva, message=FALSE, warning=FALSE--------------------------
gexp <- association(mds, formula=~Sex+Age, 
    expset = "exposures", omicset = "expression", sva = "fast")

## ----gexp_tables_sva----------------------------------------------------------
hit <- tableHits(gexp, th=0.001)
lab <- tableLambda(gexp)
merge(hit, lab, by="exposure")

## ----gexp_plot_qq-------------------------------------------------------------
gridExtra::grid.arrange(
    plotAssociation(gexp, rid="Ben_p", type="qq") + 
        ggplot2::ggtitle("Transcriptome - Pb Association"),
    plotAssociation(gexp, rid="BPA_p", type="qq") + 
        ggplot2::ggtitle("Transcriptome - THM Association"),
    ncol=2
)

## ----gexp_plot_volcano--------------------------------------------------------
gridExtra::grid.arrange(
    plotAssociation(gexp, rid="Ben_p", type="volcano", tPV=-log10(1e-04)) + 
        ggplot2::ggtitle("Transcriptome - Pb Association"),
    plotAssociation(gexp, rid="BPA_p", type="volcano", tPV=-log10(1e-04)) + 
        ggplot2::ggtitle("Transcriptome - THM Association"),
    ncol=2
)

## ----prot_data, cache=FALSE---------------------------------------------------
data("brge_prot", package="brgedata")
brge_prot

## ----prot_analysis, message=FALSE, warning=FALSE------------------------------
mds <- createMultiDataSet()
mds <- add_eset(mds, brge_prot, dataset.type  ="proteome")
mds <- add_exp(mds, brge_expo)

prot <- association(mds, formula=~Sex+Age,
    expset = "exposures", omicset = "proteome")

## ----prot_hits----------------------------------------------------------------
tableHits(prot, th=0.001)

## ----prot_plot_volcano--------------------------------------------------------
gridExtra::grid.arrange(
    plotAssociation(prot, rid="Ben_p", type="protein") + 
        ggplot2::ggtitle("Proteome - Cd Association") +
        ggplot2::geom_hline(yintercept = 1, color = "LightPink"),
    plotAssociation(prot, rid="NO2_p", type="protein") + 
        ggplot2::ggtitle("Proteome - Cotinine Association") +
        ggplot2::geom_hline(yintercept = 1, color = "LightPink"),
    ncol=2
)

## ----rm_asc, echo=FALSE, message=FALSE----------------------------------------
rm(prot, gexp)
gc()

## ----missing_exp, message=FALSE-----------------------------------------------
library(rexposome)
plotMissings(brge_expo, set = "exposures")

## ----impute_exp, message=FALSE------------------------------------------------
brge_expo <- imputation(brge_expo)

## ----crossomics_mcia, message=FALSE, warning=FALSE----------------------------
mds <- createMultiDataSet()
mds <- add_genexp(mds, brge_gexp)
mds <- add_eset(mds, brge_prot, dataset.type = "proteome")
mds <- add_exp(mds, brge_expo)

cr_mcia <- crossomics(mds, method = "mcia", verbose = TRUE)
cr_mcia

## ----crossomics_mcca, message=FALSE, warning=FALSE, results='hide'------------
cr_mcca <- crossomics(mds, method = "mcca", permute=c(4, 2))
cr_mcca

## ----integration_colors-------------------------------------------------------
colors <- c("green", "blue", "red")
names(colors) <- names(mds)

## ----plot_pe_mcia, messages=FALSE, warnings=FALSE-----------------------------
plotIntegration(cr_mcia, colors=colors)

## ----plot_pe_mcca, messages=FALSE, warnings=FALSE, fig.height=8, fig.width=9----
plotIntegration(cr_mcca, colors=colors)

## ----rm_crs-------------------------------------------------------------------
rm(cr_mcia, cr_mcca)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

