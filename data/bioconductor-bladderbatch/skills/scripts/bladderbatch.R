# Code example from 'bladderbatch' vignette. See references/ for full tutorial.

### R code from vignette source 'bladderbatch.Rnw'

###################################################
### code chunk number 1: bladderbatch.Rnw:5-6
###################################################
options(width=65)


###################################################
### code chunk number 2: input
###################################################
library(bladderbatch)
data(bladderdata)

# Get the expression data
edata = exprs(bladderEset)

# Get the pheno data
pdata = pData(bladderEset)


