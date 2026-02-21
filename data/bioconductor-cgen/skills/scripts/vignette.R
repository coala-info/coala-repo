# Code example from 'vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'vignette.Rnw'

###################################################
### code chunk number 1: start
###################################################
library(CGEN)


###################################################
### code chunk number 2: load data
###################################################
data(Xdata, package="CGEN")
Xdata[1:5, ]


###################################################
### code chunk number 3: dummy vars
###################################################
for (a in unique(Xdata[, "age.group"])) {
  dummyVar <- paste("age.group_", a, sep="")
  Xdata[, dummyVar] <- 0
  temp <- Xdata[, "age.group"] == a
  if (any(temp)) Xdata[temp, dummyVar] <- 1
}


###################################################
### code chunk number 4: table
###################################################
table(Xdata[, "case.control"], Xdata[, "age.group"], exclude=NULL)


###################################################
### code chunk number 5: snp.logistic
###################################################
mainVars <- c("oral.years", "n.children", "age.group_1",
              "age.group_2", "age.group_3", "age.group_5")
fit <- snp.logistic(Xdata, "case.control", "BRCA.status",
                     main.vars=mainVars, 
                     int.vars=c("oral.years", "n.children"), 
                     strata.var="ethnic.group")


###################################################
### code chunk number 6: summary table
###################################################
getSummary(fit)


###################################################
### code chunk number 7: Wald test
###################################################
getWaldTest(fit, c("BRCA.status", "BRCA.status:oral.years", "BRCA.status:n.children"))


###################################################
### code chunk number 8: print table
###################################################
table(Xdata$case.control, Xdata$ethnic.group)


###################################################
### code chunk number 9: getMatchedSets
###################################################
library("cluster")
size <- ifelse(Xdata$ethnic.group == 3, 3, 4)
d <- daisy(Xdata[,c("age.group_1","gynSurgery.history","BRCA.history")])
mx <- getMatchedSets(d, CC=TRUE, NN=TRUE, ccs.var = Xdata$case.control, 
	  strata.var = Xdata$ethnic.group, size = size, fixed = TRUE)


###################################################
### code chunk number 10: Xdata
###################################################
mx$CC[1:10]
mx$tblCC
Xdata <- cbind(Xdata, CCStrat = mx$CC, NNStrat = mx$NN)
Xdata[1:5,]


###################################################
### code chunk number 11: snp.matched
###################################################

intVars <- ~ oral.years + n.children
snpVars <- ~ BRCA.status
fit <- snp.matched(Xdata, "case.control", snp.vars=snpVars,
                     main.vars=intVars, int.vars=intVars, 
                     cc.var="CCStrat", nn.var="NNStrat") 


###################################################
### code chunk number 12: summary table 2
###################################################
getSummary(fit, method = c("CLR", "CCL"))


###################################################
### code chunk number 13: Wald test 2
###################################################
getWaldTest(fit$HCL, c( "BRCA.status" , "BRCA.status:oral.years" , "BRCA.status:n.children"))


###################################################
### code chunk number 14: sessionInfo
###################################################
sessionInfo()


