# Code example from 'vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'vignette.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: vignette.Rnw:27-28
###################################################
library(rfPred)


###################################################
### code chunk number 3: vignette.Rnw:31-33
###################################################
data(variant_list_Y)
print(variant_list_Y)


###################################################
### code chunk number 4: vignette.Rnw:36-40
###################################################
result=rfPred_scores(variant_list=variant_list_Y,
                     data=system.file("extdata/chrY_rfPred.txtz", package="rfPred"), 
                     index=system.file("extdata/chrY_rfPred.txtz.tbi", package="rfPred"))
print(result)


###################################################
### code chunk number 5: vignette.Rnw:45-49
###################################################
result2=rfPred_scores(variant_list=variant_list_Y[,1:4],
                      data=system.file("extdata/chrY_rfPred.txtz", package="rfPred"),
                      index=system.file("extdata/chrY_rfPred.txtz.tbi", package="rfPred"))
print(result2)


###################################################
### code chunk number 6: vignette.Rnw:59-63
###################################################
result3=rfPred_scores(variant_list=variant_list_Y,
                      data=system.file("extdata/chrY_rfPred.txtz", package="rfPred"), 
                      index=system.file("extdata/chrY_rfPred.txtz.tbi", package="rfPred"),
                      file.export="results.csv")


