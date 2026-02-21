# Code example from 'GOFunction' vignette. See references/ for full tutorial.

### R code from vignette source 'GOFunction.Rnw'

###################################################
### code chunk number 1: Example
###################################################
library("GOFunction")
data(exampledata)
sigTerm <- GOFunction(interestGenes, refGenes, organism="org.Hs.eg.db", 
            ontology="BP", fdrmethod="BY", fdrth=0.05, ppth=0.05, pcth=0.05, 
            poth=0.05, peth=0.05, bmpSize=2000, filename="sigTerm")


