# Code example from 'Mulder2012-Vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'Mulder2012-Vignette.Rnw'

###################################################
### code chunk number 1: Ropts
###################################################
options(width=70)


###################################################
### code chunk number 2: install (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install(c("PANR", "RedeR", "pvclust", "HTSanalyzeR", 
## "org.Hs.eg.db", "KEGG.db"))


###################################################
### code chunk number 3: setup
###################################################
library(Mulder2012)
library(HTSanalyzeR)
library(PANR)


###################################################
### code chunk number 4: loadRawScreens
###################################################
data(Mulder2012.rawScreenData, package="Mulder2012")
dim(rawScreenData)
colnames(rawScreenData)


###################################################
### code chunk number 5: RNAiPreprocessing
###################################################
data(Mulder2012.rawScreenAnnotation, package="Mulder2012")
Mulder2012<-Mulder2012.RNAiPre(rawScreenData, rawScreenAnnotation)


###################################################
### code chunk number 6: showMulder2012
###################################################
dim(Mulder2012)
colnames(Mulder2012)


###################################################
### code chunk number 7: NULLfitting1 (eval = FALSE)
###################################################
## bm_Mulder2012<-new("BetaMixture", pheno=Mulder2012, 
## metric="cosine", order=1, model="global")
## bm_Mulder2012<-fitNULL(bm_Mulder2012, nPerm=100, 
## thetaNULL=c(alphaNULL=4, betaNULL=4), sumMethod="median", 
## permMethod="keepRep", verbose=TRUE)


###################################################
### code chunk number 8: NULLfitting2
###################################################
data(bm_Mulder2012)


###################################################
### code chunk number 9: NULLfitting3
###################################################
view(bm_Mulder2012, what="fitNULL")


###################################################
### code chunk number 10: BMfitting1 (eval = FALSE)
###################################################
## bm_Mulder2012<-fitBM(bm_Mulder2012, para=list(zInit=NULL, 
## thetaInit=c(alphaNeg=2, betaNeg=4, 
## alphaNULL=bm_Mulder2012@result$fitNULL$thetaNULL[["alphaNULL"]], 
## betaNULL=bm_Mulder2012@result$fitNULL$thetaNULL[["betaNULL"]], 
## alphaPos=4, betaPos=2), gamma=NULL), 
## ctrl=list(fitNULL=FALSE, tol=1e-3), verbose=TRUE)


###################################################
### code chunk number 11: BMfitting
###################################################
view(bm_Mulder2012, what="fitBM")


###################################################
### code chunk number 12: PPIrun (eval = FALSE)
###################################################
## PPI<-Mulder2012.PPIPre()
## Mulder2012.PPIenrich(pheno=Mulder2012, PPI=PPI$PPI, 
## bm=bm_Mulder2012)


###################################################
### code chunk number 13: modules (eval = FALSE)
###################################################
## labels<-c("A", "B", "C")
## names(labels)<-c("neg", "none", "pos")
## for(i in c("neg", "none", "pos")) {
## pdf(file=file.path("rslt", paste("fig5", labels[i], ".pdf",sep="")), 
## width=8, height=6)
## GSEARandomWalkFig(Mulder2012, PPI, bm_Mulder2012, i)
## graphics.off()
## }


###################################################
### code chunk number 14: bm_ext (eval = FALSE)
###################################################
## bm_ext<-new("BetaMixture", pheno=Mulder2012, 
## metric="cosine", order=1, model="stratified")
## bm_ext<-fitNULL(bm_ext, nPerm=100, 
## thetaNULL=c(alphaNULL=4, betaNULL=4), 
## sumMethod="median", permMethod="keepRep", verbose=TRUE)
## bm_ext<-fitBM(bm_ext, para=list(zInit=NULL, 
## thetaInit=c(alphaNeg=2, betaNeg=4, 
## alphaNULL=bm@result$fitNULL$thetaNULL[["alphaNULL"]], 
## betaNULL=bm@result$fitNULL$thetaNULL[["betaNULL"]], 
## alphaPos=4, betaPos=2), gamma=NULL), 
## ctrl=list(fitNULL=FALSE, tol=1e-3), verbose=TRUE)


###################################################
### code chunk number 15: loadbm_ext
###################################################
data(bm_ext_Mulder2012)
bm_ext<-bm_ext_Mulder2012


###################################################
### code chunk number 16: viewbm_ext
###################################################
view(bm_ext, "fitBM")


###################################################
### code chunk number 17: inferFullPAN
###################################################
pan_ext<-new("PAN", bm1=bm_ext)
pan_ext<-infer(pan_ext, para=
list(type="SNR", log=TRUE, sign=TRUE, 
cutoff=log(10)), filter=FALSE, verbose=TRUE)


###################################################
### code chunk number 18: buildPAN
###################################################
pan_ext<-buildPAN(pan_ext, engine="RedeR", 
para=list(nodeSumCols=1:3, nodeSumMethod="average", 
hideNeg=TRUE))


###################################################
### code chunk number 19: pan (eval = FALSE)
###################################################
## library(RedeR)
## viewPAN(pan_ext, what="graph")


###################################################
### code chunk number 20: pan (eval = FALSE)
###################################################
## library(snow)
## ##initiate a cluster
## options(cluster=makeCluster(4, "SOCK"))


###################################################
### code chunk number 21: hackPvclust (eval = FALSE)
###################################################
## ns<-getNamespace("pvclust")
## en<-as.environment("package:pvclust")
## assignInNamespace("dist.pvclust", dist.pvclust4PAN, 
## ns="pvclust", envir=ns)
## dist.pvclust<-getFromNamespace("dist.pvclust", 
## ns=getNamespace("pvclust"))
## unlockBinding("parPvclust", ns)
## assignInNamespace("parPvclust", parPvclust4PAN, 
## ns="pvclust", envir=ns)
## lockBinding("parPvclust", ns)
## parPvclust<-getFromNamespace("parPvclust", ns)
## if(is(getOption("cluster"), "cluster") && 
## "package:snow" %in% search()) {		
## clusterCall(getOption("cluster"), assignInNamespace, 
## x="dist.pvclust", value=dist.pvclust4PAN, ns=ns)
## clusterCall(getOption("cluster"), unlockBinding, 
## sym="parPvclust", env=ns)
## clusterCall(getOption("cluster"), assignInNamespace, 
## x="parPvclust", value=parPvclust4PAN, ns=ns)
## clusterCall(getOption("cluster"), lockBinding, 
## sym="parPvclust", env=ns)
## }


###################################################
### code chunk number 22: pvclust (eval = FALSE)
###################################################
## pan_ext<-pvclustModule(pan=pan_ext, nboot=10000, 
## metric="cosine2", hclustMethod="average", filter=FALSE)
## ##stop the cluster
## stopCluster(getOption("cluster"))
## options(cluster=NULL)


###################################################
### code chunk number 23: pan_visualize (eval = FALSE)
###################################################
## rdp <- RedPort('MyPort')
## calld(rdp)
## Mulder2012.module.visualize(rdp, pan_ext, mod.pval.cutoff=0.05, 
## mod.size.cutoff=4, avg.degree.cutoff=0.5)


###################################################
### code chunk number 24: analysesPipeline (eval = FALSE)
###################################################
## Mulder2012.pipeline(
## par4BM=list(model="global", metric="cosine", nPerm=20),
## par4PAN=list(type="SNR", log=TRUE, sign=TRUE, 
## cutoff=log(10), filter=FALSE),
## par4ModuleSearch=list(nboot=10000, metric="cosine2",
## hclustMethod="average", filter=FALSE)
## )


###################################################
### code chunk number 25: figures (eval = FALSE)
###################################################
## Mulder2012.fig(what="ALL")


###################################################
### code chunk number 26: arora_loadScreens
###################################################
data(Arora2010, package="Mulder2012")
dim(Arora2010)
colnames(Arora2010)


###################################################
### code chunk number 27: arora_NULLfitting1 (eval = FALSE)
###################################################
## bm_Arora2010<-new("BetaMixture", pheno=Arora2010, 
## metric="cosine", order=1, model="global")
## bm_Arora2010<-fitNULL(bm_Arora2010, nPerm=20, 
## thetaNULL=c(alphaNULL=4, betaNULL=4), sumMethod="median", 
## permMethod="keepRep", verbose=TRUE)


###################################################
### code chunk number 28: arora_NULLfitting2
###################################################
data(bm_Arora2010)


###################################################
### code chunk number 29: arora_NULLfitting3
###################################################
view(bm_Arora2010, what="fitNULL")


###################################################
### code chunk number 30: arora_BMfitting1 (eval = FALSE)
###################################################
## bm_Arora2010<-fitBM(bm_Arora2010, para=list(zInit=NULL, 
## thetaInit=c(alphaNeg=2, betaNeg=4, 
## alphaNULL=bm_Arora2010@result$fitNULL$thetaNULL[["alphaNULL"]], 
## betaNULL=bm_Arora2010@result$fitNULL$thetaNULL[["betaNULL"]], 
## alphaPos=4, betaPos=2), gamma=NULL), 
## ctrl=list(fitNULL=FALSE, tol=1e-3), verbose=TRUE)


###################################################
### code chunk number 31: arora_BMfitting2
###################################################
view(bm_Arora2010, what="fitBM")


###################################################
### code chunk number 32: arora_inferFullPAN
###################################################
pan_Arora2010<-new("PAN", bm1=bm_Arora2010)
pan_Arora2010<-infer(pan_Arora2010, para=
list(type="SNR", log=TRUE, sign=TRUE, 
cutoff=log(10)), filter=FALSE, verbose=TRUE)


###################################################
### code chunk number 33: arora_buildPAN
###################################################
pan_Arora2010<-buildPAN(pan_Arora2010, engine="RedeR", 
para=list(nodeSumCols=1:2, nodeSumMethod="average", 
hideNeg=TRUE))


###################################################
### code chunk number 34: arora_pan (eval = FALSE)
###################################################
## viewPAN(pan_Arora2010, what="graph")


###################################################
### code chunk number 35: pan_arora (eval = FALSE)
###################################################
## library(snow)
## ##initiate a cluster
## options(cluster=makeCluster(4, "SOCK"))
## pan_Arora2010<-pvclustModule(pan_Arora2010, nboot=10000, 
## metric="consine2", hclustMethod="average", filter=TRUE, 
## verbose=TRUE, r=c(6:12/8))
## ##stop the cluster
## stopCluster(getOption("cluster"))
## options(cluster=NULL)


###################################################
### code chunk number 36: pan_arora_viz (eval = FALSE)
###################################################
## rdp <- RedPort('MyPort')
## calld(rdp)
## Arora2010.module.visualize(rdp, pan_Arora2010, mod.pval.cutoff=
## 0.05, mod.size.cutoff=4, avg.degree.cutoff=0.5)


###################################################
### code chunk number 37: pw_arora (eval = FALSE)
###################################################
## pw.Arora2010<-Arora2010.hypergeo(pan_Arora2010, mod.pval.cutoff=0.05, 
## mod.size.cutoff=4, avg.degree.cutoff=0.5)
## pw.Arora2010<-pw.Arora2010[[1]]
## obs.exp<-as.numeric(pw.Arora2010[, 4])
## names(obs.exp)<-paste(as.character(pw.Arora2010[, 6]), "  (", 
## format(pw.Arora2010[, 5], scientific=TRUE, digits=3), ")", sep="")
## par(mar=c(4, 16, 1, 1), cex=0.8)
## barplot((obs.exp), horiz=TRUE, las=2, xlab="Observed/Expected Hits", 
## cex.axis=0.8)


###################################################
### code chunk number 38: pw_arora_plot
###################################################
data(Arora2010.pathway)
pw.Arora2010<-pw.rslt[[1]]
obs.exp<-as.numeric(pw.Arora2010[, 4])
names(obs.exp)<-paste(as.character(pw.Arora2010[, 6]), "  (", 
format(pw.Arora2010[, 5], scientific=TRUE, digits=3), ")", sep="")
par(mar=c(4, 16, 1, 1), cex=0.8)
barplot((obs.exp), horiz=TRUE, las=2, xlab="Observed/Expected Hits", 
cex.axis=0.8)


###################################################
### code chunk number 39: arora_analysesPipeline (eval = FALSE)
###################################################
## Arora2010.pipeline(
## par4BM=list(model="global", metric="cosine", nPerm=20),
## par4PAN=list(type="SNR", log=TRUE, sign=TRUE, 
## cutoff=log(10), filter=FALSE),
## par4ModuleSearch=list(nboot=10000, metric="cosine2", 
## hclustMethod="average", filter=FALSE)
## )


###################################################
### code chunk number 40: arora_figures (eval = FALSE)
###################################################
## Arora.fig(what="ALL")


###################################################
### code chunk number 41: sessionInfo
###################################################
toLatex(sessionInfo())


