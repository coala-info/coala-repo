# Code example from 'PCpheno' vignette. See references/ for full tutorial.

### R code from vignette source 'PCpheno.Rnw'

###################################################
### code chunk number 1: load library
###################################################
library(PCpheno)
data(DudleyPhenoM)
##Number of genes sensitive at each condition
colSums(DudleyPhenoM)
##Retrieve the name of the sensitive genes in each condition
DudleyPhenoL <- apply(DudleyPhenoM,2,function(x) names(which(x==1)))
DudleyPhenoL[1]


###################################################
### code chunk number 2: KEGG
###################################################
library(org.Sc.sgd.db) ## new YEAST annotation package
##library(annotate)
KeggMat <- PWAmat("org.Sc.sgd") 
KeggMat[1:5, 1:5]


###################################################
### code chunk number 3: ScISI
###################################################
library(ScISI)
data(ScISIC)
ScISIC[1:5, 1:5]


###################################################
### code chunk number 4: PCpheno.Rnw:175-178
###################################################
perm <- 10 
paraquat <- DudleyPhenoL[["Paraq"]]
parDensity <- densityEstimate(genename=paraquat, interactome=ScISIC, perm=perm) 


###################################################
### code chunk number 5: PCpheno.Rnw:185-186
###################################################
plot(parDensity, main="Effect of paraquat on S. cerevisiae genes")


###################################################
### code chunk number 6: PCpheno.Rnw:215-216
###################################################
parGraph <- graphTheory(genename=paraquat, interactome=ScISIC, perm=perm) 


###################################################
### code chunk number 7: PCpheno.Rnw:224-225
###################################################
plot(parGraph, main="Effect of paraquat S. cerevisiae genes")


###################################################
### code chunk number 8: PCpheno.Rnw:245-254
###################################################
params <- new("CoHyperGParams",
              geneIds=paraquat, 
              universeGeneIds=rownames(ScISIC),
              annotation="org.Sc.sgd",
              categoryName="ScISIC",
              pvalueCutoff=0.01,
              testDirection="over")

paraquat.complex <- hyperGTest(params)


###################################################
### code chunk number 9: PCpheno.Rnw:260-261
###################################################
summary(paraquat.complex)[,1:6]


###################################################
### code chunk number 10: PCpheno.Rnw:266-273
###################################################
status <- complexStatus(data=paraquat.complex,
                              phenotype=paraquat,
                              interactome=ScISIC, threshold=0.01)

descr <- getDescr(status$A, database= c("GO","MIPS"))

data.frame( descr,"pvalues"=paraquat.complex@pvalues[status$A])


