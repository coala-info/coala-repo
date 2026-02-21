# Code example from 'UsingMCRestimate' vignette. See references/ for full tutorial.

### R code from vignette source 'UsingMCRestimate.Rnw'

###################################################
### code chunk number 1: arguments
###################################################
library(MCRestimate)
library(randomForest)
library(golubEsets)
data(Golub_Train)
class.colum <- "ALL.AML"


###################################################
### code chunk number 2: the functions
###################################################
savepdf =function(x,file,w=10,h=5){pdf(file=file,width=w,height=w);x;dev.off()}
options(width=50)


###################################################
### code chunk number 3: METHOD CHOISE
###################################################
Preprocessingfunctions        <- c("varSel.highest.var")
list.of.poss.parameter        <- list(var.numbers=c(250,1000))


###################################################
### code chunk number 4: METHOD CHOISE
###################################################
class.function                    <- "RF.wrap"


###################################################
### code chunk number 5: PLOT PARAMETER
###################################################
plot.label               <- "Samples"


###################################################
### code chunk number 6: ARGUMENTS FOR CROSS-VALIDSATION
###################################################
cross.outer        <- 2
cross.repeat       <- 3
cross.inner        <- 2


###################################################
### code chunk number 7: RF.make
###################################################
RF.estimate <- MCRestimate(Golub_Train,
                        class.colum,
                        classification.fun="RF.wrap",
                        thePreprocessingMethods=Preprocessingfunctions,
                        poss.parameters=list.of.poss.parameter,
                        cross.outer=cross.outer,
                        cross.inner=cross.inner,
                        cross.repeat=cross.repeat,
                        plot.label=plot.label)


###################################################
### code chunk number 8: rf.show
###################################################
class(RF.estimate)


###################################################
### code chunk number 9: RF (eval = FALSE)
###################################################
## plot(RF.estimate,rownames.from.object=TRUE, main="Random Forest")


###################################################
### code chunk number 10: rf.save
###################################################
savepdf(plot(RF.estimate,rownames.from.object=TRUE, main="Random Forest"),"RF.pdf")


###################################################
### code chunk number 11: UsingMCRestimate.Rnw:157-163
###################################################
RF.classifier <- ClassifierBuild (Golub_Train, 
                                 class.colum,
                                 classification.fun="RF.wrap",
				 thePreprocessingMethods=Preprocessingfunctions,
                                 poss.parameters=list.of.poss.parameter,
                                 cross.inner=cross.inner)


###################################################
### code chunk number 12: UsingMCRestimate.Rnw:167-168
###################################################
names(RF.classifier)


###################################################
### code chunk number 13: test
###################################################
data(Golub_Test)
RF.classifier$classifier.for.exprSet(Golub_Test)


