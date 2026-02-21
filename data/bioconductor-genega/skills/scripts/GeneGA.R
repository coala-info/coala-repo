# Code example from 'GeneGA' vignette. See references/ for full tutorial.

### R code from vignette source 'GeneGA.Rnw'

###################################################
### code chunk number 1: GeneGA.Rnw:68-82
###################################################
library(GeneGA)
seqfile=system.file("sequence", "EGFP.fasta", package="GeneGA")
aa=read.fasta(seqfile)
rscu=uco(unlist(aa), index="rscu")
w_value=rscu # w_value is the w table we need computing
names(w_value)=names(rscu)
names=sapply(names(rscu), function(x) translate(s2c(x)))
amino=hash()
for(i in unique(names)){
	amino[[i]]=max(rscu[which(names==i)])
}
for(i in 1:length(names)){
	w_value[i]=rscu[[names(rscu)[i]]]/amino[[translate(s2c(names(rscu)[i]))]]
}


###################################################
### code chunk number 2: GeneGA.Rnw:88-90
###################################################
seqfile=system.file("sequence", "EGFP.fasta", package="GeneGA")
seq=unlist(getSequence(read.fasta(seqfile), as.string=TRUE))


###################################################
### code chunk number 3: GeneGA.Rnw:93-94
###################################################
GeneGA.result=GeneGA(sequence=seq, popSize=40, iters=150, crossoverRate=0.3, mutationChance=0.05, region=c(1,60), organism="ec", showGeneration=FALSE)


###################################################
### code chunk number 4: GeneGA.Rnw:97-98
###################################################
show(GeneGA.result)


###################################################
### code chunk number 5: GeneGA.Rnw:101-102
###################################################
plotGeneGA(GeneGA.result, type=1)


###################################################
### code chunk number 6: GeneGA.Rnw:107-108
###################################################
plotGeneGA(GeneGA.result, type=2)


###################################################
### code chunk number 7: GeneGA.Rnw:113-114
###################################################
plotGeneGA(GeneGA.result, type=3)


