# Code example from 'ChIPComp' vignette. See references/ for full tutorial.

### R code from vignette source 'ChIPComp.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex(use.unsrturl=FALSE)


###################################################
### code chunk number 2: ChIPComp.Rnw:57-61
###################################################
library(ChIPComp)
confs=makeConf(system.file("extdata", "conf.csv", package="ChIPComp"))
conf=confs$conf
design=confs$design


###################################################
### code chunk number 3: ChIPComp.Rnw:64-76
###################################################
conf=data.frame(
SampleID=1:4,
condition=c("Helas3","Helas3","K562","K562"),
factor=c("H3k27ac","H3k27ac","H3k27ac","H3k27ac"),
ipReads=system.file("extdata",c("Helas3.ip1.bed","Helas3.ip2.bed","K562.ip1.bed","K562.ip2.bed"),package="ChIPComp"),
ctReads=system.file("extdata",c("Helas3.ct.bed","Helas3.ct.bed","K562.ct.bed","K562.ct.bed"),package="ChIPComp"),
peaks=system.file("extdata",c("Helas3.peak.bed","Helas3.peak.bed","K562.peak.bed","K562.peak.bed"),package="ChIPComp")
)
conf$condition=factor(conf$condition)
conf$factor=factor(conf$factor)
design=as.data.frame(lapply(conf[,c("condition","factor")],as.numeric))-1
design=as.data.frame(model.matrix(~condition,design))


###################################################
### code chunk number 4: ChIPComp.Rnw:80-81
###################################################
countSet=makeCountSet(conf,design,filetype="bed", species="hg19",binsize=1000)


###################################################
### code chunk number 5: figureexample
###################################################
plot(countSet)


###################################################
### code chunk number 6: ChIPComp.Rnw:91-93
###################################################
countSet=ChIPComp(countSet)
print(countSet)


###################################################
### code chunk number 7: ChIPComp.Rnw:97-98
###################################################
data(seqData)


###################################################
### code chunk number 8: sessionInfo
###################################################
toLatex(sessionInfo())


