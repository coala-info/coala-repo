# Code example from 'pathVar' vignette. See references/ for full tutorial.

### R code from vignette source 'pathVar.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: pathVar.Rnw:25-27
###################################################
 options(width=80)
 library(pathVar)


###################################################
### code chunk number 2: pathVar.Rnw:89-93
###################################################
samp.id <- colnames(bock) 
cell.id <- character(length(samp.id))
cell.id[grep("hES", samp.id)] <- "esc"
cell.id[grep("hiPS", samp.id)] <- "ips"


###################################################
### code chunk number 3: pathVar.Rnw:96-98
###################################################
qc.esc <- apply(bock[,cell.id == "esc"], 1, function(x,ct){ sum(x >= ct) }, ct=1)
bock.esc <- bock[qc.esc >= .75*sum(cell.id == "esc"),]


###################################################
### code chunk number 4: pathVar.Rnw:102-105
###################################################
qc.ips <- apply(bock[,cell.id == "ips"], 1, function(x,ct){ sum(x >= ct) }, ct=1)
bock.esc_ips <- bock[qc.esc >= .75*sum(cell.id == "esc") &
 qc.ips >= .75*sum(cell.id == "ips"),]


###################################################
### code chunk number 5: diagnostics
###################################################
diagnosticsVarPlots(bock.esc)


###################################################
### code chunk number 6: diagnosticsTwoSamp
###################################################
diagnosticsVarPlotsTwoSample(bock.esc_ips[1:5000,], groups=as.factor(c(rep(1,10),rep(2,10))))


###################################################
### code chunk number 7: pathVar.Rnw:145-146
###################################################
resOneSam=pathVarOneSample(bock.esc,pways.kegg,test="chisq",varStat="sd")


###################################################
### code chunk number 8: pathVar.Rnw:149-150
###################################################
resOneSam@tablePway[1:3]


###################################################
### code chunk number 9: pathVar.Rnw:154-155
###################################################
resOneSam@NAPways[1:3]


###################################################
### code chunk number 10: pathVar.Rnw:159-160
###################################################
resOneSam@numOfClus


###################################################
### code chunk number 11: pathVar.Rnw:165-167
###################################################
intersect(names(resOneSam@genesInPway[["Staphylococcus aureus infection"]]),
names(resOneSam@genesInPway[["Asthma"]]))


###################################################
### code chunk number 12: pathVar.Rnw:172-173
###################################################
sigOneSam=sigPway(resOneSam,0.05)


###################################################
### code chunk number 13: pathVar.Rnw:177-178
###################################################
sigOneSam@genesInSigPways1[1]


###################################################
### code chunk number 14: pathVar.Rnw:183-184
###################################################
names(which(unlist(lapply(sigOneSam@sigCatPerPway,function(x) 4%in% x))))


###################################################
### code chunk number 15: hist_1
###################################################
plotPway(resOneSam,"ECM-receptor interaction",sigOneSam)


###################################################
### code chunk number 16: pathVar.Rnw:216-219
###################################################
grp=c(rep(1, sum(cell.id == "esc")), rep(2, sum(cell.id == "ips")))
set.seed(1)
resTwoSam=pathVarTwoSamplesCont(bock.esc_ips,pways.kegg,groups=as.factor(grp),varStat="sd")


###################################################
### code chunk number 17: pathVar.Rnw:222-223
###################################################
resTwoSam@tablePway[1:3]


###################################################
### code chunk number 18: pathVar.Rnw:227-230
###################################################
sigTwoSam=sigPway(resTwoSam,0.1)
rbind(resTwoSam@var1[sigTwoSam@genesInSigPways1[["Oxidative phosphorylation"]]]
,resTwoSam@var2[sigTwoSam@genesInSigPways1[["Oxidative phosphorylation"]]])[,1:5]


###################################################
### code chunk number 19: dens_1
###################################################
plotPway(resTwoSam,"Oxidative phosphorylation",sigTwoSam)


###################################################
### code chunk number 20: pathVar.Rnw:246-248
###################################################
genes=getGenes(resTwoSam,"Oxidative phosphorylation",c(0.25,0.6))
setdiff(genes@genes1,genes@genes2)


###################################################
### code chunk number 21: pathVar.Rnw:267-269
###################################################
resTwoSamDisc=pathVarTwoSamplesDisc(bock.esc_ips,pways.kegg,groups=as.factor(grp),
test="exact",varStat="sd")


###################################################
### code chunk number 22: pathVar.Rnw:272-273
###################################################
resTwoSamDisc@tablePway[1:3]


###################################################
### code chunk number 23: pathVar.Rnw:278-279
###################################################
sigTwoSamDisc=sigPway(resTwoSamDisc,0.01)


###################################################
### code chunk number 24: 2SamDisc_1
###################################################
plotPway(resTwoSamDisc,"Ribosome",sigTwoSamDisc)


###################################################
### code chunk number 25: 2SamDisc2
###################################################
plotAllTwoSampleDistributionCounts(bock.esc_ips, resTwoSamDisc, 
perc=c(1/3,2/3), pvalue=0.05, NULL)


###################################################
### code chunk number 26: 2SamDisc2
###################################################
plotAllTwoSampleDistributionCounts(bock.esc_ips, resTwoSamDisc, 
perc=c(1/3,2/3), pvalue=0.05, NULL)


