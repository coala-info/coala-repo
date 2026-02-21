# Code example from 'simpleAffy' vignette. See references/ for full tutorial.

### R code from vignette source 'simpleAffy.Rnw'

###################################################
### code chunk number 1: simpleAffy.Rnw:61-63
###################################################
library(simpleaffy) ##the affy package also gets loaded
library(affy)


###################################################
### code chunk number 2: simpleAffy.Rnw:121-123
###################################################
library(simpleaffy) ##load the simpleaffy package 
                    ##(which loads the affy package too)


###################################################
### code chunk number 3: simpleAffy.Rnw:227-228
###################################################
data(qcs)


###################################################
### code chunk number 4: simpleAffy.Rnw:234-245
###################################################
ratios(qcs)
avbg(qcs)
maxbg(qcs)
minbg(qcs)
spikeInProbes(qcs)
qcProbes(qcs)
percent.present(qcs)
plot(qcs)
sfs(qcs)
target(qcs)
ratios(qcs)


###################################################
### code chunk number 5: simpleAffy.Rnw:258-259
###################################################
 plot(qcs)


###################################################
### code chunk number 6: simpleAffy.Rnw:676-677
###################################################
cleancdfname("HGU_133_plus_2")


