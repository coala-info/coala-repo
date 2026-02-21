# Code example from 'EPICv1_and_450K' vignette. See references/ for full tutorial.

## ----bioconductor, message=FALSE, warning=FALSE, eval=FALSE-------------------
# if (!require("BiocManager"))
# 	install.packages("BiocManager")
# BiocManager::install("DMRcate")

## ----libr, message=FALSE, warning=FALSE---------------------------------------
library(DMRcate)

## ----tcells, message=FALSE----------------------------------------------------
library(ExperimentHub)
eh <- ExperimentHub()
FlowSorted.Blood.EPIC <- eh[["EH1136"]]  
tcell <- FlowSorted.Blood.EPIC[,colData(FlowSorted.Blood.EPIC)$CD4T==100 | 
                                 colData(FlowSorted.Blood.EPIC)$CD8T==100]

## ----detpnorm-----------------------------------------------------------------
detP <- detectionP(tcell)
remove <- apply(detP, 1, function (x) any(x > 0.01))
tcell <- preprocessFunnorm(tcell)
tcell <- tcell[seqnames(tcell) %in% "chr2",]
tcell <- tcell[!rownames(tcell) %in% names(which(remove)),]
tcellms <- getM(tcell)

## ----filter, message=FALSE----------------------------------------------------
nrow(tcellms)
tcellms.noSNPs <- rmSNPandCH(tcellms, dist=2, mafcut=0.05)
nrow(tcellms.noSNPs)

## ----avearrays----------------------------------------------------------------
tcell$Replicate
tcell$Replicate[tcell$Replicate==""] <- tcell$Sample_Name[tcell$Replicate==""]
tcellms.noSNPs <- limma::avearrays(tcellms.noSNPs, tcell$Replicate)
tcell <- tcell[,!duplicated(tcell$Replicate)]
tcell <- tcell[rownames(tcellms.noSNPs),]
colnames(tcellms.noSNPs) <- colnames(tcell)
assays(tcell)[["M"]] <- tcellms.noSNPs
assays(tcell)[["Beta"]] <- ilogit2(tcellms.noSNPs)

## ----annotate, message=FALSE--------------------------------------------------
type <- factor(tcell$CellType)
design <- model.matrix(~type) 
myannotation <- cpg.annotate("array", tcell, arraytype = "EPICv1",
                             analysis.type="differential", design=design, coef=2)

## ----showmyannotation---------------------------------------------------------
myannotation

## ----dmrcate, warning=FALSE---------------------------------------------------
dmrcoutput <- dmrcate(myannotation, lambda=1000, C=2)
dmrcoutput

## ----ranges, message=FALSE----------------------------------------------------
results.ranges <- extractRanges(dmrcoutput, genome = "hg19")
results.ranges

## ----plotting, message=FALSE--------------------------------------------------
groups <- c(CD8T="magenta", CD4T="forestgreen")
cols <- groups[as.character(type)]
cols

DMR.plot(ranges=results.ranges, dmr=1, CpGs=myannotation, what="Beta", 
         arraytype = "EPICv1", phen.col=cols, genome="hg19")

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

