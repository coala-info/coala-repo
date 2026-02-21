# Code example from 'etec16s' vignette. See references/ for full tutorial.

### R code from vignette source 'etec16s.Rnw'

###################################################
### code chunk number 1: loading_dataset
###################################################
suppressMessages(library(metagenomeSeq))
library(etec16s)
data(etec16s)


###################################################
### code chunk number 2: examining_data
###################################################
etec16s


###################################################
### code chunk number 3: pheno_data
###################################################
phenoData(etec16s)
head(pData(etec16s))


###################################################
### code chunk number 4: feature_data
###################################################
featureData(etec16s)
head(fData(etec16s))


###################################################
### code chunk number 5: counts
###################################################
head(MRcounts(etec16s[,1:10]))


###################################################
### code chunk number 6: subsetting
###################################################
etec16s_day84 = etec16s[,which(pData(etec16s)$Day == 84)]
etec16s_day84


