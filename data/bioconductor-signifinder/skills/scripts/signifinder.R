# Code example from 'signifinder' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, fig.wide = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("signifinder")

## ----message=FALSE------------------------------------------------------------
# loading packages
library(SummarizedExperiment)
library(signifinder)
library(dplyr)
data(ovse)
ovse

## -----------------------------------------------------------------------------
availSigns <- availableSignatures()

## ----echo=FALSE---------------------------------------------------------------
knitr::kable(t(availSigns[1,]))

## -----------------------------------------------------------------------------
ovary_signatures <- availableSignatures(tissue = "ovary", description = FALSE)

## ----echo=FALSE---------------------------------------------------------------
knitr::kable(
    ovary_signatures, 
    caption = 'Signatures developed for ovary collected in signifinder.') %>% 
    kableExtra::kable_paper() %>% 
    kableExtra::scroll_box(width = "81%", height = "870px")

## -----------------------------------------------------------------------------
ovse <- ferroptosisSign(dataset = ovse, inputType = "rnaseq")

## -----------------------------------------------------------------------------
ovse <- EMTSign(dataset = ovse, inputType = "rnaseq", author = "Miow")

## -----------------------------------------------------------------------------
ovse <- multipleSign(dataset = ovse, inputType = "rnaseq",
                     tissue = c("ovary", "pan-tissue"))

## -----------------------------------------------------------------------------
ovse <- multipleSign(dataset = ovse, inputType = "rnaseq",
                     tissue = c("ovary", "pan-tissue"), 
                     topic = "immune system")

## -----------------------------------------------------------------------------
ovse <- multipleSign(dataset = ovse, inputType = "rnaseq",
                     whichSign = c("EMT_Miow", "IPSOV_Shen"))

## -----------------------------------------------------------------------------
getSignGenes("VEGF_Hu")
getSignGenes("Pyroptosis_Ye")
getSignGenes("EMT_Thompson")

## ----fig.height=7, fig.width=12-----------------------------------------------
evaluationSignPlot(data = ovse)

## ----fig.height=3, fig.wide=FALSE---------------------------------------------
geneHeatmapSignPlot(data = ovse, whichSign = "LipidMetabolism_Zheng", 
                    logCount = TRUE)

## -----------------------------------------------------------------------------
set.seed(21)
geneHeatmapSignPlot(data = ovse, whichSign = c("IFN_Ayers", "Tinflam_Ayers"), 
                    logCount = TRUE)

## ----fig.wide=FALSE-----------------------------------------------------------
oneSignPlot(data = ovse, whichSign = "Hypoxia_Buffa")

## -----------------------------------------------------------------------------
sign_cor <- correlationSignPlot(data = ovse)
highest_correlated <- unique(unlist(
    sign_cor$data[(sign_cor$data$cor>0.95 & sign_cor$data$cor<1),c(1,2)]))

## ----fig.height=8, fig.wide=FALSE---------------------------------------------
heatmapSignPlot(data = ovse)

## ----fig.height=2.5, fig.wide=FALSE-------------------------------------------
heatmapSignPlot(data = ovse, whichSign = highest_correlated)

## ----fig.height=3.5-----------------------------------------------------------
set.seed(21)
heatmapSignPlot(data = ovse, whichSign = highest_correlated, 
                clusterBySign = paste0("ConsensusOV_Chen_", c("IMR","DIF","PRO","MES")),
                sampleAnnot = ovse$OV_subtype, signAnnot = "topic")

## -----------------------------------------------------------------------------
mysurvData <- cbind(ovse$os, ovse$status)
rownames(mysurvData) <- rownames(colData(ovse))
head(mysurvData)

## -----------------------------------------------------------------------------
survivalSignPlot(data = ovse, survData = mysurvData, 
                 whichSign = "Pyroptosis_Ye", cutpoint = "optimal")

## -----------------------------------------------------------------------------
ridgelineSignPlot(data = ovse, whichSign = highest_correlated)
ridgelineSignPlot(data = ovse, whichSign = highest_correlated, 
                  groupByAnnot = ovse$OV_subtype)

## ----echo=FALSE, out.width = "100%"-------------------------------------------
knitr::include_graphics("figures/vignette_sc.png")
# <img src=./figures/vignette_sc.png class="center" />

## ----echo=FALSE, fig.wide=FALSE-----------------------------------------------
knitr::include_graphics("figures/vignette_st.png")
# <img src=./figures/vignette_st.png class="center" />

## -----------------------------------------------------------------------------
sessionInfo()

