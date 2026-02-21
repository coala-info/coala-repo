# Code example from 'AGDEX' vignette. See references/ for full tutorial.

### R code from vignette source 'AGDEX.rnw'

###################################################
### code chunk number 1: options
###################################################
options(width=60)


###################################################
### code chunk number 2: Load AGDEX package and data
###################################################
library(AGDEX)
data(human.data)              # Load the human.data ExpressionSet object
head(exprs(human.data)[,1:5]) # Preview the human expression data
head(pData(human.data))       # Preview the human phenotype data 
table(pData(human.data)$grp)  # See number in each group
all(rownames(pData(human.data))==colnames(exprs(human.data)))  # Check that expression data and phenotype data have samples in the same order
data(gset.data)  # A GeneSetCollection for human.data

# Now the same for the mouse.data
data(mouse.data)              
head(exprs(mouse.data)[,1:5]) 
head(pData(mouse.data))       
table(pData(mouse.data)$grp)  
all(colnames(exprs(mouse.data))==rownames(pData(mouse.data)))



###################################################
### code chunk number 3: prepare dex.set object
###################################################


# Create dex.set for human.comparison
dex.set.human <- make.dex.set.object(Eset.data= human.data,                            
                                     comp.var=2,                                       
                                     comp.def="human.tumor.typeD-other.human.tumors",  
                                     gset.collection=gset.data)                        
dex.set.mouse <- make.dex.set.object(mouse.data,
                                     comp.var=2,
                                     comp.def="mouse.tumor-mouse.control",
                                     gset.collection=NULL)                                      



###################################################
### code chunk number 4: Illustrate Structure of map.data Object
###################################################
data(map.data)
names(map.data)
head(map.data$probe.map)
map.data$map.Aprobe.col
map.data$map.Bprobe.col


###################################################
### code chunk number 5: AGDEX Analysis
###################################################
agdex.res<-agdex(dex.setA=dex.set.human,
                 dex.setB=dex.set.mouse,
                 map.data=map.data,
                 min.nperms=5,
                 max.nperms=10)


###################################################
### code chunk number 6: AGDEX Result Object
###################################################
names(agdex.res)
agdex.res$dex.compA                # echoes comp.def of dex.setA
agdex.res$dex.compB                # echoes comp.def of dex.setB
head(agdex.res$dex.asgnA)          # echoes group-labels from dex.setA
head(agdex.res$dex.asgnB)          # echoes group-labels from dex.setB


###################################################
### code chunk number 7: Differential Expression Analysis Results
###################################################
head(agdex.res$dex.resA) # Human results, difference of means and p-values
head(agdex.res$dex.resB) # Mouse Results, difference of means and p-values


###################################################
### code chunk number 8: Meta-Analysis Results
###################################################
head(agdex.res$meta.dex.res)


###################################################
### code chunk number 9: AGDEX.rnw:203-204
###################################################
 agdex.scatterplot(agdex.res, gset.id=NULL)


###################################################
### code chunk number 10: Genome-Wide Result
###################################################
agdex.res$gwide.agdex.res


###################################################
### code chunk number 11: Gene-Set Results
###################################################
head(agdex.res$gset.res)


###################################################
### code chunk number 12: get result of gene-sets details
###################################################
gset.res.stats<-get.gset.result.details(agdex.res, gset.ids = NULL, alpha=0.01)
names(gset.res.stats)
head(gset.res.stats$enrichA.details)
head(gset.res.stats$agdex.details)
dna.cat.process.gset.res<-get.gset.result.details(agdex.res, gset.ids="DNA_CATABOLIC_PROCESS")
head(dna.cat.process.gset.res$agdex.details)


