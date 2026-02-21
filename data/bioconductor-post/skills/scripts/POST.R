# Code example from 'POST' vignette. See references/ for full tutorial.

### R code from vignette source 'POST.Rnw'

###################################################
### code chunk number 1: options
###################################################
options(width=60)


###################################################
### code chunk number 2: Load POST package and data
###################################################
library(POST)
data(sampExprSet)
data(sampGeneSet)


###################################################
### code chunk number 3: POST logistic regression
###################################################
 test<-POSTglm(exprSet=sampExprSet,                         
               geneSet=sampGeneSet,                         
               lamda=0.95,                      
               seed=13,                        
               nboots=100,                      
               model='Group ~ ',   
               family=binomial(link = "logit")) 


###################################################
### code chunk number 4: Gene Level Result
###################################################
test


###################################################
### code chunk number 5: POST Cox proportional hazard regression
###################################################
 test2<-POSTcoxph(exprSet=sampExprSet,                         
               geneSet=sampGeneSet,                         
               lamda=0.95,                                            
               nboots=100,                      
               model="Surv(time, censor) ~ ",
               seed=13) 


###################################################
### code chunk number 6: Gene set result
###################################################
test2


