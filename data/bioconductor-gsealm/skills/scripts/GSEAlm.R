# Code example from 'GSEAlm' vignette. See references/ for full tutorial.

### R code from vignette source 'GSEAlm.Rnw'

###################################################
### code chunk number 1: load libs
###################################################
library("annotate")
library("GOstats")
library("graph")
#require("Rgraphviz", quietly=TRUE)
#library("Rgraphviz")
library("hgu95av2.db")
library("genefilter")
library("ALL")
library("lattice")
library("RColorBrewer")
HMcols = rev(brewer.pal(10,"RdBu"))
cols = brewer.pal(10, "BrBG")


###################################################
### code chunk number 2: GSEAlm.Rnw:145-146
###################################################
library("GSEAlm")


###################################################
### code chunk number 3: Dataset load and initial filtering
###################################################

data(ALL)

### Some filtering;
### see explanation below code
bcellIdx <- grep("^B", as.character(ALL$BT))
bcrOrNegIdx <- which(as.character(ALL$mol.biol)
                     %in% c("NEG", "BCR/ABL"))
esetA <- ALL[ , intersect(bcellIdx, bcrOrNegIdx)]
esetA$mol.biol = factor(esetA$mol.biol) # recode factor

### Non-specific filtering
esetASub <- nsFilter(esetA,var.cutoff=0.6,var.func=sd)$eset


###################################################
### code chunk number 4: ChromosomeMapping
###################################################

minBandSize = 5
haveMAP = sapply(mget(featureNames(esetASub), hgu95av2MAP),
                 function(x) !all(is.na(x)))
workingEset = esetASub[haveMAP, ]
entrezUniv = unlist(mget(featureNames(workingEset), hgu95av2ENTREZID))

### Creating incidence matrix and keeping the graph structure

AgraphChr=makeChrBandGraph("hgu95av2.db",univ=entrezUniv)
AmatChr = makeChrBandInciMat(AgraphChr)
AmatChr3 = AmatChr[rowSums(AmatChr)>=minBandSize,]

# Re-ordering incidence matrix columns

egIds = sapply(featureNames(workingEset), function(x) hgu95av2ENTREZID[[x]])
idx = match(egIds, colnames(AmatChr))
AmatChr3 = AmatChr3[, idx]
colnames(AmatChr3)=featureNames(workingEset)


# Updating our graph to include only the bands that actually
# appear in the matrix (doing it a bit carefully though...)

# AmatChr3 = AmatChr[!duplicated(AmatChr),]
AgraphChr3 = subGraph(c("ORGANISM:Homo sapiens",rownames(AmatChr3)),AgraphChr)
# AgraphChr3 = subGraph(rownames(AmatChr3),AgraphChr)



###################################################
### code chunk number 5: lmPhen
###################################################
lmPhen <- lmPerGene(workingEset,~mol.biol)

##fit the t-tests model
tobsChr <- rowttests(workingEset,"mol.biol")
## fit it via the linear-model interface
lmEsts = lmPhen$tstat[2,]

plot (tobsChr$stat,lmEsts,main="The t-test as a Linear Model",
xlab="T-test t-statistic",ylab="One-Factor Linear Model t-statistic")


### Re-leveling the factor

workingEset$mol.biol<-relevel(workingEset$mol.biol,ref="NEG")
lmPhen <- lmPerGene(workingEset,~mol.biol)
lmEsts = lmPhen$tstat[2,]



###################################################
### code chunk number 6: SimpleResBoxplot
###################################################

lmPhenRes <- getResidPerGene(lmPhen)
resplot(resmat=exprs(lmPhenRes),fac=workingEset$mol,cex.main=.7,cex.axis=.6,
horiz=TRUE,lims=c(-5,5),xname="",col=5,cex=.3)



###################################################
### code chunk number 7: GSEA Resids
###################################################
## now we are going to aggregate residuals over chromosome bands

stdrAchr=GSNormalize(exprs(lmPhenRes),AmatChr3)
#rAchr =  AmatChr3 %*% exprs(lmPhenRes)
#rAsqrSums = sqrt(rowSums(AmatChr3))
#stdrAchr = sweep(rAchr, 1, rAsqrSums, FUN="/")


###################################################
### code chunk number 8: rAExChrHmap
###################################################
# brColors <- ifelse(colnames(stdrAchr) %in% branch1,"brown", "grey")
# molColors <- ifelse(workingEset$mol=="BCR/ABL","brown", "grey")
kinetColors <- ifelse(workingEset$kinet=="hyperd.","brown", "grey")

 onecor=function(x) as.dist(1-cor(t(x))) # To get correlation-based heatmap

### In the heatmap we only use the lowest-level bands, or "leaves" of the graph

ChrLeaves=leaves(AgraphChr3,"out")
### for safety
ChrLeaves=ChrLeaves[ChrLeaves %in% rownames(AmatChr3)]

LeafGenes=which(colSums(AmatChr3[ChrLeaves,])>0)

bandHeatmap=heatmap(stdrAchr[ChrLeaves,],scale="row",col = HMcols,
          ColSideColors=kinetColors,keep.dendro=TRUE,distfun=onecor,
          labRow=FALSE,xlab="Sample",ylab="Chromosome band")


###################################################
### code chunk number 9: FakeHmap
###################################################
colbase=rexp(79,rate=3)*sample(c(-1,1),size=79,replace=T)
randres=sweep(matrix(rnorm(length(ChrLeaves)*79),ncol=79),2,colbase)
heatmap(randres, scale="row",col = HMcols,
          ColSideColors=kinetColors,keep.dendro=TRUE,distfun=onecor,
          ,labRow=FALSE,xlab="Sample",ylab="Chromosome band")


###################################################
### code chunk number 10: lm3FacImpute
###################################################

sampleIDs=rownames(pData(workingEset))
imputeEset=workingEset
imputeEset$sex[is.na(workingEset$sex)] <- 'M'
imputeEset$kinet[is.na(workingEset$kinet)] <- 'dyploid'

### This is the questionable sample; try once as diploid
### (by skipping the following line), and once as hyperdiploid
imputeEset$kinet[which(sampleIDs=="25006")]<-'hyperd.'


###################################################
### code chunk number 11: lm3FacRun
###################################################

lmExpand <- lmPerGene(workingEset,~mol.biol+sex+kinet)
lmExpandRes <- getResidPerGene(lmExpand,type="extStudent")
lmExpandTees <- t(lmExpand$tstat[2:4,])
lmExpandBandTees<-GSNormalize(lmExpandTees,AmatChr3)

GSresidExpand=GSNormalize(exprs(lmExpandRes),AmatChr3)


###################################################
### code chunk number 12: lm3FacHeatmap
###################################################
kinetColors2 <- ifelse(lmExpandRes$kinet=="hyperd.","brown", "grey")
bandHeatmapExp=heatmap(GSresidExpand[ChrLeaves,], scale="row",col = HMcols,
          ColSideColors=kinetColors2,keep.dendro=TRUE,distfun=onecor,
          labRow=FALSE,xlab="Sample",ylab="Chromosome band")


###################################################
### code chunk number 13: lm3FacInferencePrep
###################################################
nperm=125
flagp=0.01


###################################################
### code chunk number 14: lm3FacInfPhenotype
###################################################
pvalsExpand=gsealmPerm(workingEset[LeafGenes,],~mol.biol+sex+kinet,AmatChr3[ChrLeaves,LeafGenes],nperm=nperm,removeShift=TRUE)

pvalsExpand[pvalsExpand[,1]<flagp,1]
pvalsExpand[pvalsExpand[,2]<flagp,2]


###################################################
### code chunk number 15: lm3FacInfHyper
###################################################

chrNames=c(as.character(1:22),"X")
pvalsHyper=gsealmPerm(workingEset,~kinet+mol.biol+sex,AmatChr3[chrNames,],nperm=nperm)

pvalsHyper[pvalsHyper[,2]<flagp,2] ### over-expressed list for hyperdiploids

# browser()

# oldflags=c(table(pvals[,1]<flagp)[2],table(pvals[,2]<flagp)[2])
# newflags=c(table(pvals.Exp[,1]<flagp)[2],table(pvals.Exp[,2]<flagp)[2])

#downtable=table(pvals[,1]<flagp,pvals.Exp[,1]<flagp)
#uptable=table(pvals[,2]<flagp,pvals.Exp[,2]<flagp)


###################################################
### code chunk number 16: hyperdiploidHeatmap
###################################################

GSChromeResid=GSresidExpand[chrNames,]
hyperHmap=heatmap(GSChromeResid[pvalsHyper[,2]<0.1,lmExpandRes$kinet=="hyperd."],
scale="row",col = HMcols,keep.dendro=TRUE,distfun=onecor,xlab="Sample ID",ylab="Chromosome")


###################################################
### code chunk number 17: CooksDplot
###################################################
cookie1=CooksDPerGene(lmPhen)
cookie3=CooksDPerGene(lmExpand)

BandCooks1=GSNormalize(cookie1,AmatChr3,fun2=identity)
BandCooks3=GSNormalize(cookie3,AmatChr3,fun2=identity)

BandCooks1Base=BandCooks1[ChrLeaves,]
BandCooks3Base=BandCooks3[ChrLeaves,]
layout(1:2)
boxplot(sqrt(BandCooks1Base)~col(BandCooks1Base),names=sampleIDs,pch='+',
        cex=.2,las=3,cex.axis=.4,
        main="Influence by sample and Chromosome Band: 1-Factor Model",
        xlab="Sample ID",ylab="Cook's D (Band Root-Mean)",boxwex=.5,
        cex.main=0.8,cex.lab=0.7,col=5)
boxplot(sqrt(BandCooks3Base)~col(BandCooks3Base),
        names=sampleIDs[!is.na(workingEset$kinet)],pch='+',
        cex=.2,las=3,cex.axis=.4,
        main="Influence by Sample and Chromosome Band: 3-Factor Model",
        xlab="Sample ID",ylab="Cook's D (Band Root-Mean)",boxwex=.5,
        cex.main=0.8,cex.lab=0.7,col=5,ylim=c(0,0.4))


###################################################
### code chunk number 18: sessionInfo
###################################################
toLatex(sessionInfo())


