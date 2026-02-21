# Code example from 'lgrc_data' vignette. See references/ for full tutorial.

### R code from vignette source 'lgrc_data.Rnw'

###################################################
### code chunk number 1: lgrc_data.Rnw:33-38
###################################################
library(COPDSexualDimorphism.data)
`%+%` <- function(x,y) paste(x,y,sep="")

data(lgrc.meta)
head(meta)


###################################################
### code chunk number 2: lgrc_data.Rnw:45-50
###################################################
data(lgrc.expr)
data(lgrc.expr.meta)

dim(expr)
head(expr.meta)


###################################################
### code chunk number 3: lgrc_data.Rnw:55-57
###################################################
data(lgrc.genes)
head(lgrc.genes)


###################################################
### code chunk number 4: lgrc_data.Rnw:64-66
###################################################
data(lgrc.methp)
methp[1:5, c("name","ave.mad","length","num.probes")]


###################################################
### code chunk number 5: lgrc_data.Rnw:71-72
###################################################
sessionInfo()


