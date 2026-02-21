# Code example from 'charm' vignette. See references/ for full tutorial.

### R code from vignette source 'charm.Rnw'

###################################################
### code chunk number 1: setup
###################################################
options(width=60)
options(continue=" ")
options(prompt="R> ")


###################################################
### code chunk number 2: loadCharm
###################################################
library(charm)
library(charmData)


###################################################
### code chunk number 3: dataDir
###################################################
dataDir <- system.file("data", package="charmData")
dataDir


###################################################
### code chunk number 4: phenodata
###################################################
phenodataDir <- system.file("extdata", package="charmData")
pd <- read.delim(file.path(phenodataDir, "phenodata.txt"))
phenodataDir
pd


###################################################
### code chunk number 5: validatePd
###################################################
res <- validatePd(pd)


###################################################
### code chunk number 6: readData
###################################################
rawData <- readCharm(files=pd$filename, path=dataDir, sampleKey=pd, 
                     sampleNames=pd$sampleID)
rawData


###################################################
### code chunk number 7: qc
###################################################
qual <- qcReport(rawData, file="qcReport.pdf")
qual


###################################################
### code chunk number 8: Remove low-quality samples
###################################################
qc.min = 78
##Remove arrays with quality scores below qc.min:
rawData=rawData[,qual$pmSignal>=qc.min]
qual=qual[qual$pmSignal>=qc.min,]
pd=pd[pd$sampleID%in%rownames(qual),]
pData(rawData)$qual=qual$pmSignal


###################################################
### code chunk number 9: pmQuality
###################################################
pmq = pmQuality(rawData)
rmpmq = rowMeans(pmq)
okqc = which(rmpmq>75)


###################################################
### code chunk number 10: getControlIndex
###################################################
library(BSgenome.Hsapiens.UCSC.hg18)
ctrlIdx <- getControlIndex(rawData, subject=Hsapiens, noCpGWindow=600)


###################################################
### code chunk number 11: controlQC
###################################################
cqc = controlQC(rawData=rawData, controlIndex=ctrlIdx, IDcol="sampleID", 
          expcol="tissue", ylimits=c(-6,8),
          outfile="boxplots_check.pdf", height=7, width=9)
cqc


###################################################
### code chunk number 12: oligo_functions
###################################################
chr = pmChr(rawData)
pns = probeNames(rawData)
pos = pmPosition(rawData)
seq = pmSequence(rawData)
pd  = pData(rawData)


###################################################
### code chunk number 13: methp_density
###################################################
p <- methp(rawData, controlIndex=ctrlIdx, 
	   plotDensity="density.pdf", plotDensityGroups=pd$tissue) 
head(p)


###################################################
### code chunk number 14: cmdsplot
###################################################
cmdsplot(labcols=c("red","black","blue"), expcol="tissue", 
         rawData=rawData, p=p, okqc=okqc, noXorY=TRUE, 
         outfile="cmds_topN.pdf", topN=c(100000,1000))


###################################################
### code chunk number 15: select_probes
###################################################
Index = setdiff(which(rmpmq>75),ctrlIdx)
Index = Index[order(chr[Index], pos[Index])]
p0 = p #save for pipeline 2 example
p = p[Index,]
seq = seq[Index]
chr = chr[Index]
pos = pos[Index]
pns = pns[Index]
pns = clusterMaker(chr,pos) 


###################################################
### code chunk number 16: mods
###################################################
mod0 = matrix(1,nrow=nrow(pd),ncol=1)
mod  = model.matrix(~1 +factor(pd$tissue,levels=c("liver","colon","spleen")))


###################################################
### code chunk number 17: dmrFind
###################################################
library(corpcor)
thedmrs = dmrFind(p=p, mod=mod, mod0=mod0, coeff=2, pns=pns, chr=chr, pos=pos)


###################################################
### code chunk number 18: qval
###################################################
withq = qval(p=p, dmr=thedmrs, numiter=3, verbose=FALSE, mc=1)


###################################################
### code chunk number 19: plotDMRs
###################################################
con <- gzcon(url(paste("http://hgdownload.soe.ucsc.edu/goldenPath/hg18/database/","cpgIslandExt.txt.gz", sep="")))
txt <- readLines(con)
cpg.cur <- read.delim(textConnection(txt), header=FALSE, as.is=TRUE)
cpg.cur <- cpg.cur[,1:3]
colnames(cpg.cur) <- c("chr","start","end")
cpg.cur <- cpg.cur[order(cpg.cur[,"chr"],cpg.cur[,"start"]),]

plotDMRs(dmrs=thedmrs, Genome=Hsapiens, cpg.islands=cpg.cur, exposure=pd$tissue, 
         outfile="./colon-liver.pdf", which_plot=c(1), 
         which_points=c("colon","liver"), smoo="loess", ADD=3000, 
         cols=c("black","red","blue"))


###################################################
### code chunk number 20: panel3_G
###################################################
dat0 = spatialAdjust(rawData, copy=FALSE)
dat0 = bgAdjust(dat0, copy=FALSE)
G = pm(dat0)[,,1] #from oligo
G = G[Index,]
plotDMRs(dmrs=thedmrs, Genome=Hsapiens, cpg.islands=cpg.cur, exposure=pd$tissue, 
         outfile="./colon-liver2.pdf", which_plot=c(1), 
         which_points=c("colon","liver"), smoo="loess", ADD=3000, 
         cols=c("black","red","blue"), panel3="G", G=G, seq=seq)


###################################################
### code chunk number 21: continuous
###################################################
pd$x = c(1,2,3,4,5,6)
mod0 = matrix(1,nrow=nrow(pd),ncol=1)
mod  = model.matrix(~1 +pd$x)
coeff = 2
thedmrs2 = dmrFind(p=p, mod=mod, mod0=mod0, coeff=coeff, pns=pns, chr=chr, pos=pos)


###################################################
### code chunk number 22: plotcat
###################################################
groups = as.numeric(cut(mod[,coeff],c(-Inf,2,4,Inf))) #You can change these cutpoints.
pd$groups = c("low","medium","high")[groups]
plotDMRs(dmrs=thedmrs2, Genome=Hsapiens, cpg.islands=cpg.cur, exposure=pd$groups, 
         outfile="./test.pdf", which_plot=c(1), smoo="loess", ADD=3000, 
         cols=c("black","red","blue"))


###################################################
### code chunk number 23: plotcor
###################################################
plotDMRs(dmrs=thedmrs2, Genome=Hsapiens, cpg.islands=cpg.cur, exposure=pd$x, 
         outfile="./x.pdf", which_plot=c(1), smoo="loess", ADD=3000, 
         cols=c("black","red","blue"))


###################################################
### code chunk number 24: regionMatch
###################################################
ov = regionMatch(thedmrs$dmrs,thedmrs2$dmrs)
head(ov)


###################################################
### code chunk number 25: plotRegions
###################################################
mytable = thedmrs$dmrs[,c("chr","start","end")]
mytable[2,] = c("chr1",1,1000) #not on array
mytable$start = as.numeric(mytable$start)
mytable$end = as.numeric(mytable$end)
plotRegions(thetable=mytable[c(1),], cleanp=thedmrs$cleanp, chr=chr, 
            pos=pos, Genome=Hsapiens, cpg.islands=cpg.cur, outfile="myregions.pdf", 
            exposure=pd$tissue, exposure.continuous=FALSE)


###################################################
### code chunk number 26: dmrFinder
###################################################
dmr <- dmrFinder(rawData, p=p0, groups=pd$tissue, 
	compare=c("colon", "liver","colon", "spleen"),
        removeIf=expression(nprobes<4 | abs(diff)<.05 | abs(maxdiff)<.05))


###################################################
### code chunk number 27: headDmr
###################################################
names(dmr)
names(dmr$tabs)
head(dmr$tabs[[1]])


###################################################
### code chunk number 28: dmrPlot
###################################################
dmrPlot(dmr=dmr, which.table=1, which.plot=c(1), legend.size=1, 
        all.lines=TRUE, all.points=FALSE, colors.l=c("blue","black","red"), 
        colors.p=c("blue","black"), outpath=".", cpg.islands=cpg.cur, Genome=Hsapiens)


###################################################
### code chunk number 29: regionPlot
###################################################
mytab = data.frame(chr=as.character(dmr$tabs[[1]]$chr[1]), 
                   start=as.numeric(c(dmr$tabs[[1]]$start[1])), 
                   end=as.numeric(c(dmr$tabs[[1]]$end[1])), stringsAsFactors=FALSE)
regionPlot(tab=mytab, dmr=dmr, cpg.islands=cpg.cur, Genome=Hsapiens, 
           outfile="myregions.pdf", which.plot=1:5, plot.these=c("liver","colon"), 
           cl=c("blue","black"), legend.size=1, buffer=3000)



###################################################
### code chunk number 30: paired
###################################################
pData(rawData)$pair = c(1,1,2,2,1,2)
dmr2 <- dmrFinder(rawData, p=p0, groups=pd$tissue, 
	compare=c("colon", "liver","colon", "spleen"),
        removeIf=expression(nprobes<4 | abs(diff)<.05 | abs(maxdiff)<.05),
        paired=TRUE, pairs=pData(rawData)$pair, cutoff=0.95)


###################################################
### code chunk number 31: dmrPlot for paired analysis
###################################################
dmrPlot(dmr=dmr2, which.table=1, which.plot=c(3), legend.size=1, all.lines=TRUE, 
        all.points=FALSE, colors.l=c("blue","black"), colors.p=c("blue","black"), 
        outpath=".", cpg.islands=cpg.cur, Genome=Hsapiens)


###################################################
### code chunk number 32: regionPlot for paired analysis
###################################################
regionPlot(tab=mytab, dmr=dmr2, cpg.islands=cpg.cur, Genome=Hsapiens, 
           outfile="myregions_paired.pdf", which.plot=1:5, 
           plot.these=c("colon-liver"), cl=c("black"), legend.size=1, buffer=3000)


###################################################
### code chunk number 33: charm.Rnw:386-387
###################################################
sessionInfo()


