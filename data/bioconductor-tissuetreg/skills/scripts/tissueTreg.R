# Code example from 'tissueTreg' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----dependencies, warning=FALSE, message=FALSE-------------------------------
library(ExperimentHub)
library(bsseq)

## ----loading------------------------------------------------------------------
eh <- ExperimentHub()
BS.obj.ex.fit <- eh[["EH1072"]]

## ----granges------------------------------------------------------------------
regions <- GRanges(
  seqnames = c("X"),
  ranges = IRanges(start = c(7579676),
                   end = c(7595243)
  )
)

## ----plotRegion---------------------------------------------------------------
plotRegion(BS.obj.ex.fit, region=regions[1,], extend = 2000)

## ----check_order--------------------------------------------------------------
colnames(BS.obj.ex.fit)

## ----plotRegionColor----------------------------------------------------------
pData <- pData(BS.obj.ex.fit)
pData$col <- rep(c("red", "blue", "green", "yellow", "orange"), rep(3,5))
pData(BS.obj.ex.fit) <- pData
plotRegion(BS.obj.ex.fit, region=regions[1,], extend = 2000)

## ----loading_group------------------------------------------------------------
BS.obj.ex.fit.combined <- eh[["EH1073"]]

## ----check_order_group--------------------------------------------------------
colnames(BS.obj.ex.fit.combined)

## ----plotRegionColor_group----------------------------------------------------
pData <- pData(BS.obj.ex.fit.combined)
pData$col <- c("red", "blue", "yellow", "orange", "green")
pData(BS.obj.ex.fit.combined) <- pData
plotRegion(BS.obj.ex.fit.combined, region=regions[1,], extend = 2000)

## ----RNA-seq_loading----------------------------------------------------------
se_rpkms <- eh[["EH1074"]]

## ----RNA-seq_structure--------------------------------------------------------
head(assay(se_rpkms))
head(rowData(se_rpkms))

## ----RNA-seq_foxp3------------------------------------------------------------
assay(se_rpkms)[rowData(se_rpkms)$id_symbol=="Foxp3",]

## ----RNA-seq_foxp3_colData----------------------------------------------------
head(colData(se_rpkms))

## ----RNA-seq_foxp3_vis--------------------------------------------------------
library(ggplot2)
library(reshape2)
foxp3_rpkm <- assay(se_rpkms)[rowData(se_rpkms)$id_symbol=="Foxp3",]
foxp3_rpkm_molten <- melt(foxp3_rpkm)
ggplot(data=foxp3_rpkm_molten, aes(x=rownames(foxp3_rpkm_molten), y=value, fill=colData(se_rpkms)$tissue_cell)) +
    geom_bar(stat="identity") +
    theme(axis.text.x=element_text(angle=45, hjust=1)) +
    xlab("Sample") +
    ylab("RPKM") +
    ggtitle("FoxP3 expression") +
    guides(fill=guide_legend(title="tissue / cell type"))

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

