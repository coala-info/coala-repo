# Code example from 'puma' vignette. See references/ for full tutorial.

### R code from vignette source 'puma.Rnw'

###################################################
### code chunk number 1: puma.Rnw:68-69
###################################################
options(width = 60)


###################################################
### code chunk number 2: puma.Rnw:115-118 (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("puma")


###################################################
### code chunk number 3: puma.Rnw:124-125
###################################################
library(puma)


###################################################
### code chunk number 4: puma.Rnw:129-131 (eval = FALSE)
###################################################
## help(pumaDE)
## ?pumaDE


###################################################
### code chunk number 5: puma.Rnw:135-136 (eval = FALSE)
###################################################
## help(package="puma")


###################################################
### code chunk number 6: puma.Rnw:145-154 (eval = FALSE)
###################################################
## library(oligo)
## estrogenFilenames<-list.celfiles()
## oligo.estrogen<-read.celfiles(celFiles)
## pData(oligo.estrogen) <- data.frame(
##     "estrogen"=c("absent","absent","present","present"
##         ,"absent","absent","present","present")
## ,   "time.h"=c("10","10","10","10","48","48","48","48")
## ,   row.names=rownames(pData(oligo.estrogen))
## )


###################################################
### code chunk number 7: puma.Rnw:159-161
###################################################
library(pumadata)
data(oligo.estrogen)


###################################################
### code chunk number 8: puma.Rnw:163-164
###################################################
show(oligo.estrogen)


###################################################
### code chunk number 9: puma.Rnw:168-169
###################################################
pData(oligo.estrogen)


###################################################
### code chunk number 10: puma.Rnw:178-180 (eval = FALSE)
###################################################
## eset_estrogen_mmgmos<-mmgmos(oligo.estrogen,gsnorm="none")
## eset_estrogen_rma<-rma(oligo.estrogen)


###################################################
### code chunk number 11: puma.Rnw:187-188
###################################################
data(eset_estrogen_mmgmos)


###################################################
### code chunk number 12: puma.Rnw:191-193 (eval = FALSE)
###################################################
## exprs(eset_estrogen_mmgmos)[1,]
## assayDataElement(eset_estrogen_mmgmos,"se.exprs")[1,]


###################################################
### code chunk number 13: puma.Rnw:200-201 (eval = FALSE)
###################################################
## write.reslts(eset_estrogen_mmgmos, file="eset_estrogen_mmgmos.rda")


###################################################
### code chunk number 14: puma.Rnw:208-209 (eval = FALSE)
###################################################
## eset_estrogen_pmmmgmos <- PMmmgmos(oligo.estrogen,gsnorm="none")


###################################################
### code chunk number 15: puma.Rnw:222-226 (eval = FALSE)
###################################################
## setwd(cel.path)   ## go to the directory where you put the CEL files.
## exonFilenames<-c("C0006.CEL","C021.CEL"
##                 ,"F023_NEG.CEL","F043_NEG.CEL") ## or you can use  exonFilenames<-list.celfiles()
## oligo.exon<-read.celfiles(exonFilenames)


###################################################
### code chunk number 16: puma.Rnw:231-232 (eval = FALSE)
###################################################
## eset_gmoExon<-gmoExon(oligo.exon,exontype="Human",gsnorm="none")


###################################################
### code chunk number 17: puma.Rnw:237-238
###################################################
data(eset_gmoExon)


###################################################
### code chunk number 18: puma.Rnw:241-245 (eval = FALSE)
###################################################
## exprs(eset_gmoExon$gene)[1,]
## assayDataElement(eset_gmoExon$gene,"se.exprs")[1,]
## exprs(eset_gmoExon$transcript)[1,]
## assayDataElement(eset_gmoExon$transcript,"se.exprs")[1,]


###################################################
### code chunk number 19: puma.Rnw:252-253 (eval = FALSE)
###################################################
## write.reslts(eset_gmoExon$gene, file="eset_gmoExon_gene")


###################################################
### code chunk number 20: puma.Rnw:262-263 (eval = FALSE)
###################################################
## write.reslts(eset_gmoExon$transcript, file="eset_gmoExon_transcript")


###################################################
### code chunk number 21: puma.Rnw:289-294 (eval = FALSE)
###################################################
## cel.path<-"cel.path"  ## for example  cel.path<-"/home/gao/celData"  
## SampleNameTable<-"SampleNameTable" 
## eset_igmoExon<-igmoExon(cel.path="cel.path",SampleNameTable="SampleNameTable"
##                        , exontype="Human"
##                        , gsnorm="none", condition="Yes")


###################################################
### code chunk number 22: puma.Rnw:305-310 (eval = FALSE)
###################################################
## setwd(cel.path)   ## go to the directory where you put the CEL files.
## library(puma)
## library(oligo)
## oligo.hta<-read.celfiles(celFiles)
## eset_gmhta<-gmhta(oligo.hta,gsnorm="none")


###################################################
### code chunk number 23: puma.Rnw:315-316
###################################################
data(eset_gmhta)


###################################################
### code chunk number 24: puma.Rnw:319-323 (eval = FALSE)
###################################################
## exprs(eset_gmhta$gene)[2,]
## se.exprs(eset_gmhta$gene)[2,]
## exprs(eset_gmhta$transcript)[2,]
## se.exprs(eset_gmhta$transcript)[2,]


###################################################
### code chunk number 25: puma.Rnw:330-331 (eval = FALSE)
###################################################
## write.reslts(eset_gmhta$gene, file="eset_gmhta_gene")


###################################################
### code chunk number 26: puma.Rnw:340-341 (eval = FALSE)
###################################################
## write.reslts(eset_gmhta$transcript, file="eset_gmhta_transcript")


###################################################
### code chunk number 27: puma.Rnw:357-358 (eval = FALSE)
###################################################
## pumapca_estrogen <- pumaPCA(eset_estrogen_mmgmos)


###################################################
### code chunk number 28: puma.Rnw:360-363
###################################################
data(pumapca_estrogen)
data(eset_estrogen_rma)
data(eset_estrogen_mmgmos)


###################################################
### code chunk number 29: puma.Rnw:368-369
###################################################
pca_estrogen <- prcomp(t(exprs(eset_estrogen_rma)))


###################################################
### code chunk number 30: puma.Rnw:375-385
###################################################
par(mfrow=c(1,2))
plot(pumapca_estrogen,legend1pos="right",legend2pos="top",main="pumaPCA")
plot(
	pca_estrogen$x
,	xlab="Component 1"
,	ylab="Component 2"
,	pch=unclass(as.factor(pData(eset_estrogen_rma)[,1]))
,	col=unclass(as.factor(pData(eset_estrogen_rma)[,2]))
,	main="Standard PCA"
)


###################################################
### code chunk number 31: puma.Rnw:398-399 (eval = FALSE)
###################################################
## write.reslts(pumapca_estrogen, file="pumapca_estrogen")


###################################################
### code chunk number 32: puma.Rnw:407-410
###################################################
par(mfrow=c(1,2))
boxplot(data.frame(exprs(eset_estrogen_mmgmos)),main="mmgMOS - No norm")
boxplot(data.frame(exprs(eset_estrogen_rma)),main="Standard RMA")


###################################################
### code chunk number 33: puma.Rnw:424-427
###################################################
eset_estrogen_mmgmos_normd <- pumaNormalize(eset_estrogen_mmgmos)
boxplot(data.frame(exprs(eset_estrogen_mmgmos_normd))
    , main="mmgMOS - median scaling")


###################################################
### code chunk number 34: puma.Rnw:444-445 (eval = FALSE)
###################################################
## eset_estrogen_comb <- pumaComb(eset_estrogen_mmgmos_normd)


###################################################
### code chunk number 35: puma.Rnw:447-448
###################################################
data(eset_estrogen_comb)


###################################################
### code chunk number 36: puma.Rnw:453-454
###################################################
colnames(createContrastMatrix(eset_estrogen_comb))


###################################################
### code chunk number 37: puma.Rnw:463-464 (eval = FALSE)
###################################################
## write.reslts(eset_estrogen_comb, file="eset_estrogen_comb")


###################################################
### code chunk number 38: puma.Rnw:469-471
###################################################
pumaDERes <- pumaDE(eset_estrogen_comb)
limmaRes <- calculateLimma(eset_estrogen_rma)


###################################################
### code chunk number 39: puma.Rnw:476-477 (eval = FALSE)
###################################################
## write.reslts(pumaDERes, file="pumaDERes")


###################################################
### code chunk number 40: puma.Rnw:484-486
###################################################
topLimmaIntGene <- topGenes(limmaRes, contrast=7)
toppumaDEIntGene <- topGenes(pumaDERes, contrast=7)


###################################################
### code chunk number 41: puma.Rnw:494-495
###################################################
plotErrorBars(eset_estrogen_rma, topLimmaIntGene)


###################################################
### code chunk number 42: puma.Rnw:510-511
###################################################
plotErrorBars(eset_estrogen_mmgmos_normd, topLimmaIntGene)


###################################################
### code chunk number 43: puma.Rnw:524-525
###################################################
plotErrorBars(eset_estrogen_mmgmos_normd, toppumaDEIntGene)


###################################################
### code chunk number 44: puma.Rnw:548-551
###################################################
data(eset_mmgmos)
eset_mmgmos_100 <- eset_mmgmos[1:100,]
pumaCombImproved <- pumaCombImproved(eset_mmgmos_100)


###################################################
### code chunk number 45: puma.Rnw:556-557
###################################################
colnames(createContrastMatrix(pumaCombImproved))


###################################################
### code chunk number 46: puma.Rnw:564-565
###################################################
write.reslts(pumaCombImproved,file="eset_mmgmo_combimproved")


###################################################
### code chunk number 47: puma.Rnw:570-572
###################################################

pumaDEResImproved <- pumaDE(pumaCombImproved)


###################################################
### code chunk number 48: puma.Rnw:577-578
###################################################
write.reslts(pumaDEResImproved,file="pumaDEResImproved")


###################################################
### code chunk number 49: puma.Rnw:588-589
###################################################
pumaClust_estrogen <- pumaClust(eset_estrogen_mmgmos, clusters=7)


###################################################
### code chunk number 50: puma.Rnw:594-596
###################################################
summary(as.factor(pumaClust_estrogen$cluster))
pumaClust_estrogen$centers


###################################################
### code chunk number 51: puma.Rnw:598-599 (eval = FALSE)
###################################################
## write.csv(pumaClust_estrogen$cluster, file="pumaClust_clusters.csv")


###################################################
### code chunk number 52: puma.Rnw:610-618
###################################################
data(Clustii.exampleE)
data(Clustii.exampleStd)
  r<-vector(mode="integer",0)
  for (i in c(1:20))
    for (j in c(1:4))
      r<-c(r,i)
cl<-pumaClustii(Clustii.exampleE,Clustii.exampleStd,
                mincls=6,maxcls=6,conds=20,reps=r,eps=1e-3)


###################################################
### code chunk number 53: puma.Rnw:636-637 (eval = FALSE)
###################################################
## oligo.estrogen<-read.celfiles(celFiles,pkgname="pd.hg.u95a")


###################################################
### code chunk number 54: puma.Rnw:644-645
###################################################
table(table(oligo::probeNames(oligo.estrogen)))


###################################################
### code chunk number 55: puma.Rnw:678-681 (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("snow")


###################################################
### code chunk number 56: puma.Rnw:688-690 (eval = FALSE)
###################################################
## library(snow)
## cl <- makeCluster(c("node01", "node02", "node03", "node04"), type = "SOCK")


###################################################
### code chunk number 57: puma.Rnw:695-704 (eval = FALSE)
###################################################
## library(puma)
## data(affybatch.estrogen)
## pData(affybatch.estrogen) <- data.frame(
## 	"level"=c("twenty","twenty","ten")
## ,	"batch"=c("A","B","A")
## ,	row.names=rownames(pData(affybatch.example)))
## eset_mmgmos <- mmgmos(oligo.estrogen)
## system.time(eset_comb_1 <- pumaComb(eset_mmgmos))
## system.time(eset_comb_4 <- pumaComb(eset_mmgmos, cl=cl))


###################################################
### code chunk number 58: puma.Rnw:708-710 (eval = FALSE)
###################################################
## library(snow)
## cl <- makeCluster(c("localhost", "localhost"), type = "SOCK")


###################################################
### code chunk number 59: puma.Rnw:717-720 (eval = FALSE)
###################################################
## library(snow)
## cl <- makeCluster(c("node01", "node01", "node02", "node02"
## , "node03", "node03", "node04", "node04"), type = "SOCK")


###################################################
### code chunk number 60: puma.Rnw:727-729 (eval = FALSE)
###################################################
## library(snow)
## cl<-makeCluster(c("node01","node02","node03","node04"),type = "SOCK")


###################################################
### code chunk number 61: puma.Rnw:734-738 (eval = FALSE)
###################################################
## library(puma)
## library(oligo)
## object<-read.celfiles("filename.CEL")
## eset<-gmoExon(object,exontype="Human",GT="gene",gsnorm="none",cl=cl)


###################################################
### code chunk number 62: puma.Rnw:743-745 (eval = FALSE)
###################################################
## ibrary(snow)
## cl<-makeCluster(c("loaclhost","localhost"),type = "SOCK")


###################################################
### code chunk number 63: puma.Rnw:750-753 (eval = FALSE)
###################################################
## library(snow)
## cl<-makeCluster(c("node01","node01","node02" ,"node02"
## ,"node03" ,"node03" ,"node04" ,"node04"), type = "SOCK")


###################################################
### code chunk number 64: puma.Rnw:760-762 (eval = FALSE)
###################################################
## library(snow)
## cl<-makeCluster(c("node01","node02","node03","node04"),type = "SOCK")


###################################################
### code chunk number 65: puma.Rnw:767-771 (eval = FALSE)
###################################################
## library(puma)
## library(oligo)
## object<-read.celfiles("filename.CEL")
## eset<-gmhta(object,gsnorm="none",cl=cl)


###################################################
### code chunk number 66: puma.Rnw:776-778 (eval = FALSE)
###################################################
## ibrary(snow)
## cl<-makeCluster(c("loaclhost","localhost"),type = "SOCK")


###################################################
### code chunk number 67: puma.Rnw:783-786 (eval = FALSE)
###################################################
## library(snow)
## cl<-makeCluster(c("node01","node01","node02" ,"node02"
## ,"node03" ,"node03" ,"node04" ,"node04"), type = "SOCK")


###################################################
### code chunk number 68: puma.Rnw:807-811 (eval = FALSE)
###################################################
## library(Rmpi)
## library(snow)
## cl <- makeCluster(4)
## clusterEvalQ(cl, library(puma))


###################################################
### code chunk number 69: puma.Rnw:821-822
###################################################
sessionInfo()


