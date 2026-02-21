# Code example from 'Rtpca' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("Rtpca")

## ----Load, message=FALSE------------------------------------------------------
library(Rtpca)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(TPP)

## -----------------------------------------------------------------------------
data("hdacTR_smallExample")

## -----------------------------------------------------------------------------
set.seed(123)
random_proteins <- sample(hdacTR_data[[1]]$gene_name, 300)

## -----------------------------------------------------------------------------
hdacTR_data_fil <- lapply(hdacTR_data, function(temp_df){
    filter(temp_df, gene_name %in% random_proteins)
})

## -----------------------------------------------------------------------------
trData <- tpptrImport(configTable = hdacTR_config, data = hdacTR_data_fil)

## -----------------------------------------------------------------------------
data("string_ppi_df")
string_ppi_df

## -----------------------------------------------------------------------------
string_ppi_cs_950_df <- string_ppi_df %>% 
    filter(combined_score >= 950 )

vehTPCA <- runTPCA(
    objList = trData,
    ppiAnno = string_ppi_cs_950_df
)

## -----------------------------------------------------------------------------
data("ori_et_al_complexes_df")
ori_et_al_complexes_df

## -----------------------------------------------------------------------------
vehComplexTPCA <- runTPCA(
    objList = trData,
    complexAnno = ori_et_al_complexes_df,
    minCount = 2
)

## -----------------------------------------------------------------------------
plotPPiRoc(vehTPCA, computeAUC = TRUE)

## -----------------------------------------------------------------------------
plotComplexRoc(vehComplexTPCA, computeAUC = TRUE)


## -----------------------------------------------------------------------------
diffTPCA <- 
    runDiffTPCA(
        objList = trData[1:2], 
        contrastList = trData[3:4],
        ctrlCondName = "DMSO",
        contrastCondName = "Panobinostat",
        ppiAnno = string_ppi_cs_950_df)

## -----------------------------------------------------------------------------
plotDiffTpcaVolcano(
    diffTPCA,
    setXLim = TRUE,
    xlimit = c(-0.5, 0.5))

## -----------------------------------------------------------------------------
head(diffTpcaResultTable(diffTPCA) %>% 
         arrange(p_value) %>% 
        dplyr::select(pair, rssC1_rssC2, f_stat, p_value, p_adj))

## -----------------------------------------------------------------------------
plotPPiProfiles(diffTPCA, pair = c("KPNA6", "KPNB1"))

## -----------------------------------------------------------------------------
sessionInfo()

