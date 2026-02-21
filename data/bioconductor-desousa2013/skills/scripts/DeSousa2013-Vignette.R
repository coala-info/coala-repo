# Code example from 'DeSousa2013-Vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'DeSousa2013-Vignette.Rnw'

###################################################
### code chunk number 1: Ropts
###################################################
options(width=75)


###################################################
### code chunk number 2: install (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("DeSousa2013")


###################################################
### code chunk number 3: setup
###################################################
library(DeSousa2013)


###################################################
### code chunk number 4: pipelinefun (eval = FALSE)
###################################################
## data(AMC)
## CRCPipeLine(celpath=".", AMC_sample_head, AMC_CRC_clinical, 
## preprocess=FALSE, gap.ntops = c(2, 4, 8, 12, 16, 20)*1000, 
## gap.K.max = 6, gap.nboot = 100, MADth=0.5, conClust.maxK=12, 
## conClust.reps=1000, diffG.pvalth=0.01, diffG.aucth=0.9, 
## savepath=".")


###################################################
### code chunk number 5: geneExpPre (eval = FALSE)
###################################################
## data(AMC)
## ge.pre <- geneExpPre(celpath, AMC_sample_head)
## ge.all <- ge.pre[["ge.all"]]
## selPbs <- ge.pre[["selPbs"]]
## ge.CRC <- ge.all[selPbs, ]


###################################################
### code chunk number 6: loadData
###################################################
data(ge.CRC, package="DeSousa2013")
ge.CRC <- ge.all[selPbs, ]


###################################################
### code chunk number 7: showData
###################################################
length(selPbs)
dim(ge.CRC)


###################################################
### code chunk number 8: gaps_analysis (eval = FALSE)
###################################################
## gaps <- compGapStats(ge.CRC, ntops=c(2, 4, 8, 12, 16, 20)*1000, 
## K.max=6, nboot=100)
## gapsmat <- gaps[["gapsmat"]]
## gapsSE <- gaps[["gapsSE"]]


###################################################
### code chunk number 9: gaps_load
###################################################
data(gaps, package="DeSousa2013")


###################################################
### code chunk number 10: gaps_plot
###################################################
figGAP(gapsmat, gapsSE)


###################################################
### code chunk number 11: selTopVG (eval = FALSE)
###################################################
## sdat <- selTopVarGenes(ge.CRC, MADth=0.5)


###################################################
### code chunk number 12: loadTopVG
###################################################
data("dat", package="DeSousa2013")


###################################################
### code chunk number 13: showTopVG
###################################################
dim(sdat)


###################################################
### code chunk number 14: conclust_analysis (eval = FALSE)
###################################################
## clus <- conClust(sdat, maxK=12, reps=1000)


###################################################
### code chunk number 15: loadConClust
###################################################
data(conClust, package="DeSousa2013")


###################################################
### code chunk number 16: showConClust
###################################################
clus


###################################################
### code chunk number 17: pbs_clps2_genes (eval = FALSE)
###################################################
## uniGenes <- pbs2unigenes(ge.CRC, sdat)


###################################################
### code chunk number 18: loadpbs2genes
###################################################
data(uniGenes, package="DeSousa2013")


###################################################
### code chunk number 19: showpbs2genes
###################################################
length(uniGenes)
print(uniGenes[1:20])


###################################################
### code chunk number 20: silh_amc_analysis (eval = FALSE)
###################################################
## samp.f <- filterSamples(sdat, uniGenes, clus)
## silh <- samp.f[["silh"]]
## sdat.f <- samp.f[["sdat.f"]]
## clus.f <- samp.f[["clus.f"]]


###################################################
### code chunk number 21: load_silh_amc_analysis
###################################################
data(silh, package="DeSousa2013")


###################################################
### code chunk number 22: show_silh_amc_analysis
###################################################
dim(sdat.f)
rownames(sdat.f)[1:20]


###################################################
### code chunk number 23: silh_plot
###################################################
figSilh(silh)


###################################################
### code chunk number 24: sam_amc_analysis (eval = FALSE)
###################################################
## diffGenes <- findDiffGenes(sdat.f, clus.f, pvalth=0.01)


###################################################
### code chunk number 25: load_sam_amc_analysis
###################################################
data(diffGenes, package="DeSousa2013")


###################################################
### code chunk number 26: show_sam_amc_analysis
###################################################
length(diffGenes)


###################################################
### code chunk number 27: auc_amc_analysis (eval = FALSE)
###################################################
## diffGenes.f <- filterDiffGenes(sdat.f, clus.f, diffGenes, aucth=0.9)


###################################################
### code chunk number 28: load_auc_amc_analysis
###################################################
data(diffGenes.f, package="DeSousa2013")


###################################################
### code chunk number 29: show_auc_amc_analysis
###################################################
length(diffGenes.f)


###################################################
### code chunk number 30: build_pam_analysis (eval = FALSE)
###################################################
## sigMat <- sdat.f[diffGenes.f, names(clus.f)]
## classifier <- buildClassifier(sigMat, clus.f, nfold=10, nboot=100)
## signature <- classifier[["signature"]]
## pam.rslt <- classifier[["pam.rslt"]]
## thresh <- classifier[["thresh"]]
## err <- classifier[["err"]]


###################################################
### code chunk number 31: load_pam_rslt
###################################################
data(classifier, package="DeSousa2013")


###################################################
### code chunk number 32: cv_pam_plot
###################################################
figPAMCV(err)


###################################################
### code chunk number 33: cls_pam_analysis (eval = FALSE)
###################################################
## datsel <- sdat[names(uniGenes), ]
## rownames(datsel) <- uniGenes	
## datsel <- datsel[diffGenes.f, ]
## pamcl <- pamClassify(datsel, signature, pam.rslt, thresh, postRth=1)
## sdat.sig <- pamcl[["sdat.sig"]]
## pred <- pamcl[["pred"]]
## clu.pred <- pamcl[["clu.pred"]]
## nam.ord <- pamcl[["nam.ord"]]
## gclu.f <- pamcl[["gclu.f"]]


###################################################
### code chunk number 34: load_cls_amc
###################################################
data(AMC, package="DeSousa2013")
data(predAMC, package="DeSousa2013")


###################################################
### code chunk number 35: cls_amc_plot
###################################################
figClassify(AMC_CRC_clinical, pred, clu.pred, sdat.sig, gclu.f, nam.ord)


###################################################
### code chunk number 36: surv_amc_analysis
###################################################
prog <- progAMC(AMC_CRC_clinical, AMC_sample_head, clu.pred)
surv <- prog[["surv"]]
survstats <- prog[["survstats"]]


###################################################
### code chunk number 37: load_surv_amc
###################################################
data(survival, package="DeSousa2013")


###################################################
### code chunk number 38: surv_amc_plot
###################################################
figKM(surv, survstats)


###################################################
### code chunk number 39: sessionInfo
###################################################
toLatex(sessionInfo())


