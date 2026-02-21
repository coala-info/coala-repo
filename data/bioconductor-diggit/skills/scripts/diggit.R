# Code example from 'diggit' vignette. See references/ for full tutorial.

### R code from vignette source 'diggit.Rnw'

###################################################
### code chunk number 1: diggit.Rnw:14-16
###################################################
# Initialization
cores <- 3*(Sys.info()[1]!="Windows")+1


###################################################
### code chunk number 2: diggit.Rnw:37-40 (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install(c("diggitdata", "diggit"))


###################################################
### code chunk number 3: diggit.Rnw:49-50
###################################################
library(diggit)


###################################################
### code chunk number 4: diggit.Rnw:65-69
###################################################
data(gbm.expression, package="diggitdata")
data(gbm.cnv, package="diggitdata")
data(gbm.aracne, package="diggitdata")
data(gbm.mindy, package="diggitdata")


###################################################
### code chunk number 5: diggit.Rnw:73-75
###################################################
genes <- intersect(rownames(gbmExprs), rownames(gbmCNV))[1:1000]
gbmCNV <- gbmCNV[match(genes, rownames(gbmCNV)), ]


###################################################
### code chunk number 6: diggit.Rnw:83-85
###################################################
dobj <- diggitClass(expset=gbmExprs, cnv=gbmCNV, regulon=gbmTFregulon, mindy=gbmMindy)
dobj


###################################################
### code chunk number 7: diggit.Rnw:92-95
###################################################
dobj <- fCNV(dobj, method="spearman", verbose=FALSE)
diggitFcnv(dobj)[1:5]
head(dobj, 5)$fcnv


###################################################
### code chunk number 8: diggit.Rnw:98-106
###################################################
RNGkind("L'Ecuyer-CMRG")
set.seed(1)
#if(tools:::.OStype() == "unix") {
#    mc.reset.stream()
#}
dobj <- fCNV(dobj, method="mi", cores=cores, verbose=FALSE)
diggitFcnv(dobj)[1:5]
head(dobj, 5)$fcnv


###################################################
### code chunk number 9: fcnv
###################################################
tmp.cnv <- diggitCNV(dobj)
tmp.exp <- exprs(exprs(dobj))
samp <- intersect(colnames(tmp.cnv), colnames(tmp.exp))
tmp.cnv <- tmp.cnv[, match(samp, colnames(tmp.cnv))]
tmp.exp <- tmp.exp[, match(samp, colnames(tmp.exp))]
res.cor <- diggitFcnv(fCNV(dobj, method="spearman"))
par(mfrow=c(1, 2))
plot(tmp.cnv["KLHL9", ], tmp.exp["KLHL9", ], pch=20, cex=.8, xlab="KLHL9 CNV", ylab="KLHL9 Expression", main=paste("Correlation: ", signif(res.cor["KLHL9"], 2), ",   MI: ", signif(diggitFcnv(dobj)["KLHL9"], 2), sep=""), cex.lab=1.2, font.lab=2)
abline(v=0, lty=3)
plot(tmp.cnv["CEBPD", ], tmp.exp["CEBPD", ], pch=20, cex=.8, xlab="CEBPD CNV", ylab="CEBPD Expression", main=paste("Correlation: ", signif(res.cor["CEBPD"], 2), ",   MI: ", signif(diggitFcnv(dobj)["CEBPD"], 2), sep=""), cex.lab=1.2, font.lab=2)
abline(v=0, lty=3)


###################################################
### code chunk number 10: diggit.Rnw:140-147
###################################################
set.seed(1)
library(parallel)
#if(tools:::.OStype() == "unix") {
#    mc.reset.stream()
#}
dobj <- marina(dobj, pheno="subtype", group1="MES", group2="PN", cores=cores, verbose=FALSE)
head(dobj, 5)$mr


###################################################
### code chunk number 11: diggit.Rnw:157-163
###################################################
set.seed(1)
#if(tools:::.OStype() == "unix") {
#mc.reset.stream()
#}
dobj <- aqtl(dobj, mr=c("CEBPD", "STAT3"), method="mi", cores=cores, verbose=FALSE)
head(dobj, 5)$aqtl


###################################################
### code chunk number 12: diggit.Rnw:173-175
###################################################
data(gbm.cnv.normal, package="diggitdata")
cnvthr <- quantile(as.vector(gbmCNVnormal), c(.025, .975), na.rm=TRUE)


###################################################
### code chunk number 13: diggit.Rnw:179-182
###################################################
dobj <- conditional(dobj, pheno="subtype", group1="MES", group2="PN", mr="STAT3",
                    cnv=cnvthr, cores=cores, verbose=FALSE)
dobj


###################################################
### code chunk number 14: conditional
###################################################
plot(dobj, "STAT3", cluster="2")
summary(dobj)


###################################################
### code chunk number 15: diggit.Rnw:204-212
###################################################
set.seed(1)
#if(tools:::.OStype() == "unix") {
#    mc.reset.stream()
#}
dobj <- aqtl(dobj, mr=c("CEBPD", "STAT3"), method="mi", mindy=TRUE, cores=cores, verbose=FALSE)
dobj <- conditional(dobj, pheno="subtype", group1="MES", group2="PN", mr="STAT3",
                    cnv=cnvthr, verbose=FALSE)
summary(dobj)


###################################################
### code chunk number 16: diggit.Rnw:216-217
###################################################
sessionInfo()


