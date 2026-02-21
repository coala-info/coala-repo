# Code example from 'Clonal_decomposition_by_Clomial' vignette. See references/ for full tutorial.

### R code from vignette source 'Clonal_decomposition_by_Clomial.Rnw'

###################################################
### code chunk number 1: example
###################################################
library(Clomial)
set.seed(1)
data(breastCancer)
Dc <- breastCancer$Dc
Dt <- breastCancer$Dt
Clomial2 <-Clomial(Dc=Dc,Dt=Dt,maxIt=20,C=4,binomTryNum=2)


###################################################
### code chunk number 2: model1
###################################################
model1 <- Clomial2$models[[1]]
## The clonal frequencies:
round(model1$P,digits=2)
## Similarly, the genotypes is given by round(model1$Mu).


###################################################
### code chunk number 3: model1
###################################################
data(Clomial1000)
models <- Clomial1000$models
## Number of trained models:
length(models)


###################################################
### code chunk number 4: model1
###################################################
chosen <- choose.best(models=models, doTalk=TRUE)
M1 <- chosen$bestModel
print("Genotypes according to the best model:")
round(M1$Mu)
print("Clone frequencies in the first sample:")
round(M1$P[,1],digits=2)


